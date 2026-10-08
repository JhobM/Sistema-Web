package pe.tienda.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.tienda.categoria.Categoria;

@Repository
public class CategoriaRepository implements CategoriaDAO {

    private final JdbcTemplate db;

    public CategoriaRepository(JdbcTemplate db) {
        this.db = db;
    }

    private Categoria map(ResultSet result, int row) throws SQLException {
        return new Categoria(
                result.getLong("id_categoria"),
                result.getString("nombre"),
                result.getString("descripcion"),
                result.getString("estado"),
                result.getLong("id_usuario_responsable"));
    }

    public List<Categoria> listar() {
        return db.query("SELECT * FROM categoria ORDER BY nombre", this::map);
    }

    public List<Categoria> listarActivas() {
        return db.query("SELECT * FROM categoria WHERE estado = 'ACTIVA' ORDER BY nombre", this::map);
    }

    public Categoria buscar(long id) {
        List<Categoria> categorias = db.query(
                "SELECT * FROM categoria WHERE id_categoria = ?", this::map, id);

        if (categorias.isEmpty()) {
            return null;
        }

        return categorias.get(0);
    }

    public int insertar(String nombre, String descripcion, long responsable) {
        String sql = "INSERT INTO categoria (nombre, descripcion, id_usuario_responsable) "
                + "VALUES (?, ?, ?)";
        return db.update(sql, nombre, descripcion, responsable);
    }

    public int actualizar(long id, String nombre, String descripcion) {
        return db.update("UPDATE categoria SET nombre = ?, descripcion = ? WHERE id_categoria = ?",
                nombre, descripcion, id);
    }

    public int desactivar(long id) {
        return db.update("UPDATE categoria SET estado = 'INACTIVA' WHERE id_categoria = ?", id);
    }
}
