package pe.tienda.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pe.tienda.service.AsistenciaService;
import pe.tienda.service.UsuarioService;

@Controller
@RequestMapping("/Asistencia")
public class AsistenciaController {

    private final AsistenciaService asistenciaService;
    private final UsuarioService usuarioService;

    public AsistenciaController(AsistenciaService asistenciaService,
                                UsuarioService usuarioService) {
        this.asistenciaService = asistenciaService;
        this.usuarioService = usuarioService;
    }

    @GetMapping("/registrar-asistencia")
    public String mostrarFormulario(HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("usuario", usuarioService.perfil(usuarioId));
        return "Asistencia/registrar-asistencia";
    }

    @PostMapping("/registrar-asistencia")
    public String registrar(@RequestParam LocalDate fecha,
                            @RequestParam LocalTime entrada,
                            @RequestParam LocalTime salida,
                            HttpSession session) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        asistenciaService.registrar(usuarioId, fecha, entrada, salida);
        return "redirect:/Asistencia/historial-asistencia";
    }

    @GetMapping("/historial-asistencia")
    public String historial(HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("asistencias", asistenciaService.historial(usuarioId));
        return "Asistencia/historial-asistencia";
    }

    @GetMapping("/detalle-asistencia")
    public String detalle(@RequestParam long id, HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("asistencia", asistenciaService.detalle(id, usuarioId));
        model.addAttribute("usuario", usuarioService.perfil(usuarioId));
        return "Asistencia/detalle-asistencia";
    }
}
