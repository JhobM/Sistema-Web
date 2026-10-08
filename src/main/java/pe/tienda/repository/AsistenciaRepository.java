package pe.tienda.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.tienda.asistencia.Asistencia;

@Repository
public class AsistenciaRepository implements AsistenciaDAO {

    private final JdbcTemplate db;

    public AsistenciaRepository(JdbcTemplate db) {
        this.db = db;
    }

    public boolean esEmpleado(long usuarioId) {
        String sql = "SELECT COUNT(*) > 0 FROM usuario "
                + "WHERE id_usuario = ? AND tipo_usuario = 'EMPLEADO' AND estado = 'ACTIVO'";
        return Boolean.TRUE.equals(db.queryForObject(sql, Boolean.class, usuarioId));
    }

    public LocalTime horaEntradaEsperada(long usuarioId) {
        String sql = "SELECT hora_entrada FROM usuario "
                + "WHERE id_usuario = ? AND tipo_usuario = 'EMPLEADO' AND estado = 'ACTIVO'";
        return db.queryForObject(sql, (result, row) -> {
            if (result.getTime(1) == null) {
                return null;
            }
            return result.getTime(1).toLocalTime();
        }, usuarioId);
    }

    public int registrar(long usuarioId, LocalDate fecha, LocalTime entrada,
                         LocalTime salida, String estado) {
        String sql = "INSERT INTO asistencia "
                + "(id_usuario, fecha, hora_entrada, hora_salida, estado) "
                + "VALUES (?, ?, ?, ?, ?)";
        return db.update(sql, usuarioId, fecha, entrada, salida, estado);
    }

    private Asistencia map(ResultSet result, int row) throws SQLException {
        return new Asistencia(
                result.getLong("id_asistencia"),
                result.getLong("id_usuario"),
                result.getDate("fecha").toLocalDate(),
                result.getTime("hora_entrada").toLocalTime(),
                result.getTime("hora_salida").toLocalTime(),
                result.getString("estado"));
    }

    public List<Asistencia> historial(long usuarioId) {
        return db.query(
                "SELECT * FROM asistencia WHERE id_usuario = ? ORDER BY fecha DESC",
                this::map,
                usuarioId);
    }

    public Asistencia detalle(long asistenciaId, long usuarioId) {
        String sql = "SELECT * FROM asistencia WHERE id_asistencia = ? AND id_usuario = ?";
        List<Asistencia> asistencias = db.query(sql, this::map, asistenciaId, usuarioId);

        if (asistencias.isEmpty()) {
            return null;
        }
        return asistencias.get(0);
    }
}
