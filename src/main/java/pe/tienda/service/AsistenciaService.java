package pe.tienda.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import pe.tienda.asistencia.Asistencia;

public interface AsistenciaService {

    void registrar(long usuarioId, LocalDate fecha, LocalTime entrada,
                   LocalTime salida);

    List<Asistencia> historial(long usuarioId);

    Asistencia detalle(long asistenciaId, long usuarioId);
}
