package pe.tienda.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Locale;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import pe.tienda.producto.Producto;
import pe.tienda.repository.DetalleVentaDAO;
import pe.tienda.repository.PagoDAO;
import pe.tienda.repository.ProductoDAO;
import pe.tienda.repository.VentaDAO;
import pe.tienda.venta.ItemVenta;
import pe.tienda.venta.ResumenCompra;

@Service
public class VentaServiceImpl implements VentaService {

    private final VentaDAO ventaDAO;
    private final DetalleVentaDAO detalleDAO;
    private final PagoDAO pagoDAO;
    private final ProductoDAO productoDAO;

    private static final String METODO_PAGO = "Yape";
    private static final String PRODUCTO_PROMOCION = "Polera negra";
    private static final String FECHA_ESPECIAL = "2026-10-10";
    private static final BigDecimal PORCENTAJE_ESPECIAL = new BigDecimal("0.20");
    private static final int CANTIDAD_MINIMA = 5;
    private static final BigDecimal PORCENTAJE_CANTIDAD = new BigDecimal("0.10");

    public VentaServiceImpl(VentaDAO ventaDAO,
                            DetalleVentaDAO detalleDAO,
                            PagoDAO pagoDAO,
                            ProductoDAO productoDAO) {
        this.ventaDAO = ventaDAO;
        this.detalleDAO = detalleDAO;
        this.pagoDAO = pagoDAO;
        this.productoDAO = productoDAO;
    }

    public ResumenCompra calcularResumen(List<ItemVenta> items) {
        if (items == null || items.isEmpty()) {
            return new ResumenCompra(BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO);
        }

        int unidades = 0;
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal descuentoEspecial = BigDecimal.ZERO;

        for (ItemVenta item : items) {
            if (item.getCantidad() <= 0) {
                throw new IllegalArgumentException("La cantidad debe ser positiva.");
            }

            Producto producto = productoDAO.buscar(item.getIdProducto());
            if (producto == null) {
                throw new IllegalArgumentException("Producto no encontrado.");
            }
            if (!"ACTIVO".equals(producto.getEstado()) || producto.getStock() < item.getCantidad()) {
                throw new IllegalArgumentException(
                        "Producto inactivo o stock insuficiente: " + producto.getNombre());
            }

            unidades += item.getCantidad();
            BigDecimal subtotalLinea = producto.getPrecio()
                    .multiply(BigDecimal.valueOf(item.getCantidad()));
            subtotal = subtotal.add(subtotalLinea);

            if (tienePromocionEspecial(producto)) {
                descuentoEspecial = descuentoEspecial.add(
                        subtotalLinea.multiply(PORCENTAJE_ESPECIAL));
            }
        }

        BigDecimal descuentoCantidad = BigDecimal.ZERO;
        if (CANTIDAD_MINIMA > 0 && unidades >= CANTIDAD_MINIMA) {
            descuentoCantidad = subtotal.multiply(PORCENTAJE_CANTIDAD);
        }

        BigDecimal descuento = descuentoEspecial.add(descuentoCantidad)
                .setScale(2, RoundingMode.HALF_UP)
                .min(subtotal);
        BigDecimal monto = subtotal.setScale(2, RoundingMode.HALF_UP);
        BigDecimal total = monto.subtract(descuento).setScale(2, RoundingMode.HALF_UP);
        return new ResumenCompra(monto, descuento, total);
    }

    private boolean tienePromocionEspecial(Producto producto) {
        return LocalDate.now().toString().equals(FECHA_ESPECIAL)
                && producto.getNombre().equalsIgnoreCase(PRODUCTO_PROMOCION);
    }

    public long procesar(long usuarioId, List<ItemVenta> items) {
        if (usuarioId <= 0 || items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Carrito vacío o datos de pago inválidos.");
        }

        ResumenCompra resumen = calcularResumen(items);
        long ventaId = ventaDAO.crear(usuarioId, resumen.getSubtotal(),
                resumen.getDescuento(), resumen.getTotal());

        for (ItemVenta item : items) {
            guardarDetalleYDescontarStock(ventaId, item);
        }

        pagoDAO.registrar(ventaId, resumen.getTotal(), METODO_PAGO);
        return ventaId;
    }

    private void guardarDetalleYDescontarStock(long ventaId, ItemVenta item) {
        Producto producto = productoDAO.buscar(item.getIdProducto());
        if (producto == null) {
            throw new IllegalArgumentException("Producto no encontrado.");
        }

        BigDecimal subtotal = producto.getPrecio()
                .multiply(BigDecimal.valueOf(item.getCantidad()))
                .setScale(2, RoundingMode.HALF_UP);

        detalleDAO.registrar(ventaId, producto.getId(), item.getCantidad(),
                producto.getPrecio(), subtotal);
        if (!productoDAO.descontarStock(producto.getId(), item.getCantidad())) {
            throw new IllegalArgumentException(
                    "El stock cambió durante la compra; vuelve a intentarlo.");
        }
    }

    public List<Map<String, Object>> compras(long usuarioId) {
        return ventaDAO.comprasDe(usuarioId);
    }

    public List<Map<String, Object>> metricas() {
        LocalDate hoy = LocalDate.now();
        LocalDate primerMes = YearMonth.from(hoy).minusMonths(7).atDay(1);
        List<Map<String, Object>> ventas = ventaDAO.ventasDesde(primerMes.atStartOfDay());
        List<Map<String, Object>> resultado = new ArrayList<>();

        resultado.add(crearMetrica("Ventas por día - últimos 7 días",
                crearSerieDiaria(ventas, hoy, false)));
        resultado.add(crearMetrica("Monto vendido por día (S/.) - últimos 7 días",
                crearSerieDiaria(ventas, hoy, true)));
        resultado.add(crearMetrica("Ventas por semana - últimas 8 semanas",
                crearSerieSemanal(ventas, hoy)));
        resultado.add(crearMetrica("Ventas por mes - últimos 8 meses",
                crearSerieMensual(ventas, hoy, false)));
        resultado.add(crearMetrica("Monto vendido por mes (S/.) - últimos 8 meses",
                crearSerieMensual(ventas, hoy, true)));

        return resultado;
    }

    private List<Map<String, Object>> crearSerieDiaria(
            List<Map<String, Object>> ventas, LocalDate hoy, boolean mostrarMonto) {
        List<Map<String, Object>> puntos = new ArrayList<>();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM");

        for (int diasAntes = 6; diasAntes >= 0; diasAntes--) {
            LocalDate dia = hoy.minusDays(diasAntes);
            String etiqueta = dia.format(formato);
            puntos.add(crearPunto(ventas, etiqueta, dia.atStartOfDay(),
                    dia.plusDays(1).atStartOfDay(), mostrarMonto));
        }

        return puntos;
    }

    private List<Map<String, Object>> crearSerieSemanal(
            List<Map<String, Object>> ventas, LocalDate hoy) {
        List<Map<String, Object>> puntos = new ArrayList<>();
        LocalDate lunes = hoy.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM");

        for (int semanasAntes = 7; semanasAntes >= 0; semanasAntes--) {
            LocalDate inicio = lunes.minusWeeks(semanasAntes);
            LocalDate fin = inicio.plusWeeks(1);
            String etiqueta = inicio.format(formato);
            puntos.add(crearPunto(ventas, etiqueta, inicio.atStartOfDay(),
                    fin.atStartOfDay(), false));
        }

        return puntos;
    }

    private List<Map<String, Object>> crearSerieMensual(
            List<Map<String, Object>> ventas, LocalDate hoy, boolean mostrarMonto) {
        List<Map<String, Object>> puntos = new ArrayList<>();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("MMM-yy", new Locale("es", "PE"));

        for (int mesesAntes = 7; mesesAntes >= 0; mesesAntes--) {
            YearMonth mes = YearMonth.from(hoy).minusMonths(mesesAntes);
            LocalDate inicio = mes.atDay(1);
            LocalDate fin = mes.plusMonths(1).atDay(1);
            puntos.add(crearPunto(ventas, mes.format(formato), inicio.atStartOfDay(),
                    fin.atStartOfDay(), mostrarMonto));
        }

        return puntos;
    }

    private Map<String, Object> crearPunto(List<Map<String, Object>> ventas,
                                           String etiqueta,
                                           LocalDateTime inicio,
                                           LocalDateTime fin,
                                           boolean mostrarMonto) {
        int cantidadVentas = 0;
        BigDecimal monto = BigDecimal.ZERO;

        for (Map<String, Object> venta : ventas) {
            Timestamp fecha = (Timestamp) venta.get("fecha");
            LocalDateTime fechaVenta = fecha.toLocalDateTime();

            if (!fechaVenta.isBefore(inicio) && fechaVenta.isBefore(fin)) {
                cantidadVentas++;
                monto = monto.add((BigDecimal) venta.get("monto"));
            }
        }

        Map<String, Object> punto = new LinkedHashMap<>();
        punto.put("etiqueta", etiqueta);
        if (mostrarMonto) {
            punto.put("valor", monto.setScale(0, RoundingMode.HALF_UP));
            punto.put("numero", monto.doubleValue());
        } else {
            punto.put("valor", cantidadVentas);
            punto.put("numero", (double) cantidadVentas);
        }

        return punto;
    }

    private Map<String, Object> crearMetrica(String titulo, List<Map<String, Object>> puntos) {
        double maximo = 0;
        for (Map<String, Object> punto : puntos) {
            double numero = (double) punto.get("numero");
            if (numero > maximo) {
                maximo = numero;
            }
        }

        for (Map<String, Object> punto : puntos) {
            double numero = (double) punto.get("numero");
            int altura = 0;
            if (maximo > 0) {
                altura = (int) Math.round(numero * 100 / maximo);
            }
            punto.put("altura", altura);
        }

        StringBuilder linea = new StringBuilder();
        for (int i = 0; i < puntos.size(); i++) {
            Map<String, Object> punto = puntos.get(i);
            int x = puntos.size() > 1 ? i * 100 / (puntos.size() - 1) : 50;
            int y = 40 - (int) punto.get("altura") * 30 / 100;
            punto.put("x", x);
            punto.put("y", y);

            if (linea.length() > 0) {
                linea.append(' ');
            }
            linea.append(x).append(',').append(y);
        }

        Map<String, Object> metrica = new LinkedHashMap<>();
        metrica.put("titulo", titulo);
        metrica.put("puntos", puntos);
        metrica.put("linea", linea.toString());
        return metrica;
    }

    public List<Map<String, Object>> detalle(long ventaId, long usuarioId) {
        List<Map<String, Object>> filas = ventaDAO.detalle(ventaId, usuarioId);
        if (filas.isEmpty()) {
            throw new IllegalArgumentException("Compra no encontrada.");
        }
        return filas;
    }
}
