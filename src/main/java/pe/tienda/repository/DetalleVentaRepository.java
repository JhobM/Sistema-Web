package pe.tienda.repository;

import java.math.BigDecimal;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DetalleVentaRepository implements DetalleVentaDAO {

    private final JdbcTemplate db;

    public DetalleVentaRepository(JdbcTemplate db) {
        this.db = db;
    }

    public int registrar(long ventaId, long productoId, int cantidad,
                         BigDecimal precioUnitario, BigDecimal subtotal) {
        String sql = "INSERT INTO detalle_venta "
                + "(id_venta, id_producto, cantidad, precio_unitario, subtotal) "
                + "VALUES (?, ?, ?, ?, ?)";
        return db.update(sql, ventaId, productoId, cantidad, precioUnitario, subtotal);
    }
}
