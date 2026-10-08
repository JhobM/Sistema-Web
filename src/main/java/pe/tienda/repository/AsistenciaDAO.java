package pe.tienda.repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import pe.tienda.asistencia.Asistencia;

public interface AsistenciaDAO {

    boolean esEmpleado(long usuarioId);

    LocalTime horaEntradaEsperada(long usuarioId);

    int registrar(long usuarioId, LocalDate fecha, LocalTime entrada,
                  LocalTime salida, String estado);

    List<Asistencia> historial(long usuarioId);

    Asistencia detalle(long asistenciaId, long usuarioId);
}
