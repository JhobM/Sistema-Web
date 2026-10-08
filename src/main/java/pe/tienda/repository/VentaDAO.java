package pe.tienda.repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface VentaDAO {

    long crear(long usuarioId, BigDecimal subtotal, BigDecimal descuento,
               BigDecimal total);

    List<Map<String, Object>> comprasDe(long usuarioId);

    List<Map<String, Object>> ventasDesde(LocalDateTime fechaInicio);

    List<Map<String, Object>> detalle(long ventaId, long usuarioId);
}
