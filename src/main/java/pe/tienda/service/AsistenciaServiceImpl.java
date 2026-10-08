package pe.tienda.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import org.springframework.stereotype.Service;
import pe.tienda.asistencia.Asistencia;
import pe.tienda.repository.AsistenciaDAO;

@Service
public class AsistenciaServiceImpl implements AsistenciaService {

    private final AsistenciaDAO asistenciaDAO;

    public AsistenciaServiceImpl(AsistenciaDAO asistenciaDAO) {
        this.asistenciaDAO = asistenciaDAO;
    }

    public void registrar(long usuarioId, LocalDate fecha, LocalTime entrada, LocalTime salida) {
        if (!asistenciaDAO.esEmpleado(usuarioId)) {
            throw new IllegalArgumentException("Solo un empleado activo puede registrar asistencia.");
        }

        if (fecha == null || entrada == null || salida == null || !salida.isAfter(entrada)) {
            throw new IllegalArgumentException("Revisa la fecha y las horas.");
        }

        LocalTime horaProgramada = asistenciaDAO.horaEntradaEsperada(usuarioId);
        if (horaProgramada == null) {
            throw new IllegalArgumentException("El empleado no tiene una hora de entrada configurada.");
        }

        String estado = entrada.isAfter(horaProgramada) ? "TARDANZA" : "PUNTUAL";
        asistenciaDAO.registrar(usuarioId, fecha, entrada, salida, estado);
    }

    public List<Asistencia> historial(long usuarioId) {
        return asistenciaDAO.historial(usuarioId);
    }

    public Asistencia detalle(long asistenciaId, long usuarioId) {
        Asistencia asistencia = asistenciaDAO.detalle(asistenciaId, usuarioId);

        if (asistencia == null) {
            throw new IllegalArgumentException("Asistencia no encontrada.");
        }
        return asistencia;
    }
}
