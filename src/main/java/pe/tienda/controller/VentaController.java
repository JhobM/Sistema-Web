package pe.tienda.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pe.tienda.service.ProductoService;
import pe.tienda.venta.ItemVenta;
import pe.tienda.producto.Producto;
import pe.tienda.service.VentaService;

@Controller
@RequestMapping("/Venta")
public class VentaController {

    private final VentaService ventaService;
    private final ProductoService productoService;

    public VentaController(VentaService ventaService, ProductoService productoService) {
        this.ventaService = ventaService;
        this.productoService = productoService;
    }

    @GetMapping("/carrito")
    public String carrito(HttpSession session, Model model) {
        Map<Long, Integer> carrito = obtenerCarrito(session);
        List<Map<String, Object>> lineas = new ArrayList<>();

        if (carrito != null) {
            for (Map.Entry<Long, Integer> item : carrito.entrySet()) {
                Producto producto = productoService.detalle(item.getKey());
                BigDecimal subtotal = producto.getPrecio()
                        .multiply(BigDecimal.valueOf(item.getValue()));

                Map<String, Object> linea = new LinkedHashMap<>();
                linea.put("producto", producto);
                linea.put("cantidad", item.getValue());
                linea.put("subtotal", subtotal);
                lineas.add(linea);
            }
        }

        model.addAttribute("lineas", lineas);
        model.addAttribute("resumen", ventaService.calcularResumen(aItems(carrito)));
        return "IntPr/carrito";
    }

    @PostMapping("/carrito/agregar")
    public String agregar(@RequestParam long idProducto,
                          @RequestParam int cantidad,
                          HttpSession session) {
        Producto producto = productoService.detalle(idProducto);

        if (cantidad < 1 || cantidad > producto.getStock()
                || !"ACTIVO".equals(producto.getEstado())) {
            throw new IllegalArgumentException("Cantidad inválida o stock insuficiente.");
        }

        Map<Long, Integer> carrito = obtenerCarrito(session);
        if (carrito == null) {
            carrito = new LinkedHashMap<>();
        }

        int nuevaCantidad = cantidad;

        if (carrito.containsKey(idProducto)) {
            nuevaCantidad = carrito.get(idProducto) + cantidad;
        }
        if (nuevaCantidad > producto.getStock()) {
            throw new IllegalArgumentException("La cantidad supera el stock disponible.");
        }

        carrito.put(idProducto, nuevaCantidad);
        session.setAttribute("carrito", carrito);
        return "redirect:/Venta/carrito";
    }

    @PostMapping("/carrito/quitar")
    public String quitar(@RequestParam long idProducto, HttpSession session) {
        Map<Long, Integer> carrito = obtenerCarrito(session);
        if (carrito != null) {
            carrito.remove(idProducto);
        }
        return "redirect:/Venta/carrito";
    }

    @GetMapping("/mis-compras")
    public String compras(HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("compras", ventaService.compras(usuarioId));
        return "Venta/mis-compras";
    }

    @GetMapping("/detalle-venta")
    public String detalle(@RequestParam long id, HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("detalles", ventaService.detalle(id, usuarioId));
        return "Venta/detalle-venta";
    }

    @GetMapping("/realizar-pago")
    public String pago(HttpSession session, Model model) {
        model.addAttribute("resumen", ventaService.calcularResumen(aItems(obtenerCarrito(session))));
        return "Pago/realizar-pago";
    }

    @PostMapping("/realizar-pago")
    public String procesar(HttpSession session) {
        Long usuarioId = (Long) session.getAttribute("usuarioId");
        Map<Long, Integer> carrito = obtenerCarrito(session);

        if (usuarioId == null || carrito == null || carrito.isEmpty()) {
            throw new IllegalArgumentException("Inicia sesión y agrega productos al carrito.");
        }

        long ventaId = ventaService.procesar(usuarioId, aItems(carrito));
        session.removeAttribute("carrito");
        return "redirect:/Venta/detalle-venta?id=" + ventaId;
    }

    private Map<Long, Integer> obtenerCarrito(HttpSession session) {
        return (Map<Long, Integer>) session.getAttribute("carrito");
    }

    private List<ItemVenta> aItems(Map<Long, Integer> carrito) {
        if (carrito == null) {
            return new ArrayList<>();
        }

        List<ItemVenta> items = new ArrayList<>();
        for (Map.Entry<Long, Integer> item : carrito.entrySet()) {
            items.add(new ItemVenta(item.getKey(), item.getValue()));
        }
        return items;
    }
}
