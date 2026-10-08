package pe.tienda.service;

import java.util.List;
import java.util.Map;
import pe.tienda.venta.ItemVenta;
import pe.tienda.venta.ResumenCompra;

public interface VentaService {

    ResumenCompra calcularResumen(List<ItemVenta> items);

    long procesar(long usuarioId, List<ItemVenta> items);

    List<Map<String, Object>> compras(long usuarioId);

    List<Map<String, Object>> metricas();

    List<Map<String, Object>> detalle(long ventaId, long usuarioId);
}
