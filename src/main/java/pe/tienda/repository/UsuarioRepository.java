package pe.tienda.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.tienda.usuario.Usuario;

@Repository
public class UsuarioRepository implements UsuarioDAO {

    private final JdbcTemplate db;

    public UsuarioRepository(JdbcTemplate db) {
        this.db = db;
    }

    private Usuario map(ResultSet r, int n) throws SQLException {
        return new Usuario(r.getLong("id_usuario"), r.getString("nombres"), r.getString("apellidos"),
                r.getString("correo"), r.getString("telefono"), r.getString("tipo_usuario"),
                r.getString("estado"), r.getString("contrasena"),
                hora(r, "hora_entrada"), hora(r, "hora_salida"));
    }

    private LocalTime hora(ResultSet resultado, String columna)
            throws SQLException {
        if (resultado.getTime(columna) == null) {
            return null;
        }
        return resultado.getTime(columna).toLocalTime();
    }

    @Override
    public Usuario porCorreo(String correo) {
        String sql = "SELECT * FROM usuario WHERE correo = ? AND estado = 'ACTIVO'";
        List<Usuario> usuarios = db.query(sql, this::map, correo);

        if (usuarios.isEmpty()) {
            return null;
        }

        return usuarios.get(0);
    }

    @Override
    public Usuario porId(long id) {
        List<Usuario> usuarios = db.query(
                "SELECT * FROM usuario WHERE id_usuario = ?", this::map, id);

        if (usuarios.isEmpty()) {
            return null;
        }

        return usuarios.get(0);
    }

    @Override
    public int registrarCliente(String nombres, String apellidos, String correo, String contrasena, String telefono) {
        return db.update("INSERT INTO usuario "
                        + "(nombres, apellidos, correo, contrasena, telefono, tipo_usuario) "
                        + "VALUES (?, ?, ?, ?, ?, 'CLIENTE')",
                nombres, apellidos, correo, contrasena, telefono);
    }

    @Override
    public boolean existeCorreo(String correo) {
        String sql = "SELECT COUNT(*) > 0 FROM usuario WHERE LOWER(correo) = LOWER(?)";
        return Boolean.TRUE.equals(db.queryForObject(sql, Boolean.class, correo));
    }

    @Override
    public int registrarEmpleado(String nombres, String apellidos, String correo,
                                 String contrasena, String telefono,
                                 LocalTime entrada, LocalTime salida) {
        String sql = "INSERT INTO usuario "
                + "(nombres, apellidos, correo, contrasena, telefono, tipo_usuario, "
                + "estado, hora_entrada, hora_salida) "
                + "VALUES (?, ?, ?, ?, ?, 'EMPLEADO', 'ACTIVO', ?, ?)";
        return db.update(sql, nombres, apellidos, correo, contrasena, telefono, entrada, salida);
    }

    @Override
    public int actualizarPerfil(long id, String nombres, String apellidos, String correo, String telefono) {
        return db.update("UPDATE usuario SET nombres=?, apellidos=?, correo=?, telefono=? "
                + "WHERE id_usuario=?", nombres, apellidos, correo, telefono, id);
    }
}
