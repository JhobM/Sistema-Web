package pe.tienda.repository;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

@Repository
public class VentaRepository implements VentaDAO {

    private final JdbcTemplate db;

    public VentaRepository(JdbcTemplate db) {
        this.db = db;
    }

    public long crear(long usuarioId, BigDecimal subtotal, BigDecimal descuento, BigDecimal total) {
        KeyHolder key = new GeneratedKeyHolder();
        String sql = "INSERT INTO venta (id_usuario, subtotal, descuento, total, estado) "
                + "VALUES (?, ?, ?, ?, 'PAGADA')";

        db.update(connection -> {
            PreparedStatement statement = connection.prepareStatement(sql, new String[]{"id_venta"});
            statement.setLong(1, usuarioId);
            statement.setBigDecimal(2, subtotal);
            statement.setBigDecimal(3, descuento);
            statement.setBigDecimal(4, total);
            return statement;
        }, key);

        return key.getKey().longValue();
    }

    public List<Map<String, Object>> comprasDe(long usuarioId) {
        String sql = "SELECT id_venta AS \"id_venta\", fecha_venta AS \"fecha_venta\", "
                + "subtotal AS \"subtotal\", descuento AS \"descuento\", "
                + "total AS \"total\", estado AS \"estado\" "
                + "FROM venta WHERE id_usuario = ? ORDER BY fecha_venta DESC";
        return db.queryForList(sql, usuarioId);
    }

    public List<Map<String, Object>> ventasDesde(LocalDateTime fechaInicio) {
        String sql = "SELECT fecha_venta AS \"fecha\", total AS \"monto\" "
                + "FROM venta WHERE estado = 'PAGADA' AND fecha_venta >= ? "
                + "ORDER BY fecha_venta";
        return db.queryForList(sql, Timestamp.valueOf(fechaInicio));
    }

    public List<Map<String, Object>> detalle(long ventaId, long usuarioId) {
        String sql = "SELECT v.id_venta AS \"id_venta\", v.fecha_venta AS \"fecha_venta\", "
                + "v.subtotal AS \"total_parcial\", v.descuento AS \"descuento\", "
                + "v.total AS \"total\", v.estado AS \"estado\", "
                + "d.cantidad AS \"cantidad\", d.precio_unitario AS \"precio_unitario\", "
                + "d.subtotal AS \"subtotal_linea\", p.nombre AS \"producto\" "
                + "FROM venta v "
                + "JOIN detalle_venta d ON d.id_venta = v.id_venta "
                + "JOIN producto p ON p.id_producto = d.id_producto "
                + "WHERE v.id_venta = ? AND v.id_usuario = ?";
        return db.queryForList(sql, ventaId, usuarioId);
    }
}
