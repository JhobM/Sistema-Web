package pe.tienda.repository;

import java.math.BigDecimal;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PagoRepository implements PagoDAO {

    private final JdbcTemplate db;

    public PagoRepository(JdbcTemplate db) {
        this.db = db;
    }

    @Override
    public int registrar(long ventaId, BigDecimal monto, String metodo) {
        String sql = "INSERT INTO pago (id_venta, monto, metodo_pago, estado) "
                + "VALUES (?, ?, ?, 'APROBADO')";
        return db.update(sql, ventaId, monto, metodo);
    }
}
