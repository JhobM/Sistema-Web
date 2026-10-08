package pe.tienda.repository;

import java.math.BigDecimal;

public interface DetalleVentaDAO {

    int registrar(long ventaId, long productoId, int cantidad,
                  BigDecimal precioUnitario, BigDecimal subtotal);
}
