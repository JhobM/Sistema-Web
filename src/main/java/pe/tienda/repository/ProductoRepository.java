package pe.tienda.repository;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.tienda.producto.Producto;

@Repository
public class ProductoRepository implements ProductoDAO {

    private final JdbcTemplate db;

    public ProductoRepository(JdbcTemplate db) {
        this.db = db;
    }

    private Producto map(ResultSet r, int n) throws SQLException {
        return new Producto(r.getLong("id_producto"), r.getString("nombre"), r.getString("descripcion"),
                r.getLong("id_categoria"), r.getBigDecimal("precio"), r.getInt("stock"),
                r.getString("estado"), r.getLong("id_usuario_responsable"));
    }

    public List<Producto> listarDisponibles() {
        return db.query("SELECT * FROM producto WHERE estado='ACTIVO' AND stock>0 ORDER BY nombre", this::map);
    }

    public List<Producto> buscarDisponibles(String texto, Long categoria) {
        boolean buscarTexto = texto != null && !texto.trim().isEmpty();

        if (buscarTexto && categoria != null) {
            String sql = "SELECT * FROM producto "
                    + "WHERE estado = 'ACTIVO' AND stock > 0 "
                    + "AND LOWER(nombre) LIKE ? AND id_categoria = ? "
                    + "ORDER BY nombre";
            return db.query(sql, this::map, "%" + texto.toLowerCase() + "%", categoria);
        }

        if (buscarTexto) {
            String sql = "SELECT * FROM producto "
                    + "WHERE estado = 'ACTIVO' AND stock > 0 "
                    + "AND LOWER(nombre) LIKE ? ORDER BY nombre";
            return db.query(sql, this::map, "%" + texto.toLowerCase() + "%");
        }

        if (categoria != null) {
            String sql = "SELECT * FROM producto "
                    + "WHERE estado = 'ACTIVO' AND stock > 0 "
                    + "AND id_categoria = ? ORDER BY nombre";
            return db.query(sql, this::map, categoria);
        }

        String sql = "SELECT * FROM producto "
                + "WHERE estado = 'ACTIVO' AND stock > 0 ORDER BY nombre";
        return db.query(sql, this::map);
    }

    public List<Producto> listarTodos() {
        return db.query("SELECT * FROM producto ORDER BY id_producto", this::map);
    }

    public Producto buscar(long id) {
        List<Producto> productos = db.query(
                "SELECT * FROM producto WHERE id_producto = ?", this::map, id);

        if (productos.isEmpty()) {
            return null;
        }

        return productos.get(0);
    }

    public int insertar(String nombre, String descripcion, long categoria,
                        BigDecimal precio, int stock, long responsable) {
        String sql = "INSERT INTO producto "
                + "(nombre, descripcion, id_categoria, precio, stock, id_usuario_responsable) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        return db.update(sql, nombre, descripcion, categoria, precio, stock, responsable);
    }

    public int actualizar(long id, String nombre, String descripcion, long categoria,
                          BigDecimal precio, int stock) {
        return db.update("UPDATE producto SET nombre=?, descripcion=?, id_categoria=?, precio=?, stock=? "
                        + "WHERE id_producto=?",
                nombre, descripcion, categoria, precio, stock, id);
    }

    public int desactivar(long id) {
        return db.update("UPDATE producto SET estado='INACTIVO' WHERE id_producto=?", id);
    }

    public boolean descontarStock(long id, int cantidad) {
        String sql = "UPDATE producto SET stock = stock - ? "
                + "WHERE id_producto = ? AND estado = 'ACTIVO' AND stock >= ?";
        return db.update(sql, cantidad, id, cantidad) == 1;
    }
}
