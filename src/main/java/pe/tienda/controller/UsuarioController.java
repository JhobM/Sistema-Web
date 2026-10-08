package pe.tienda.controller;

import java.time.LocalTime;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pe.tienda.service.UsuarioService;
import pe.tienda.usuario.Usuario;

@Controller
@RequestMapping("/Usuario")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping("/login")
    public String login() {
        return "Usuario/login";
    }

    @PostMapping("/login")
    public String autenticar(@RequestParam String correo,
                             @RequestParam String contrasena,
                             HttpSession session,
                             RedirectAttributes flash) {
        try {
            Usuario usuario = usuarioService.iniciarSesion(correo, contrasena);
            session.setAttribute("usuarioId", usuario.getId());
            session.setAttribute("tipoUsuario", usuario.getTipoUsuario());

            if ("EMPLEADO".equals(usuario.getTipoUsuario())) {
                return "redirect:/IntEmp/panel";
            }
            return "redirect:/IntPr/tienda";
        } catch (IllegalArgumentException error) {
            flash.addFlashAttribute("errorLogin",
                    "Credenciales incorrectas. Verifica tu correo y contraseña.");
            return "redirect:/Usuario/login";
        }
    }

    @GetMapping("/registro")
    public String registro() {
        return "Usuario/registro";
    }

    @PostMapping("/registro")
    public String registrarCliente(@RequestParam String nombres,
                                   @RequestParam String apellidos,
                                   @RequestParam String correo,
                                   @RequestParam String contrasena,
                                   @RequestParam(required = false) String telefono) {
        usuarioService.registrarCliente(nombres, apellidos, correo, contrasena, telefono);
        return "redirect:/Usuario/login";
    }

    @GetMapping("/registrar-empleado")
    public String mostrarRegistroEmpleado() {
        return "Usuario/registrar-empleado";
    }

    @PostMapping("/registrar-empleado")
    public String registrarEmpleado(@RequestParam String nombres,
                                    @RequestParam String apellidos,
                                    @RequestParam String correo,
                                    @RequestParam String contrasena,
                                    @RequestParam(required = false) String telefono,
                                    @RequestParam LocalTime horaEntrada,
                                    @RequestParam LocalTime horaSalida,
                                    RedirectAttributes flash) {
        try {
            usuarioService.registrarEmpleado(nombres, apellidos, correo, contrasena,
                    telefono, horaEntrada, horaSalida);
            flash.addFlashAttribute("mensaje", "La cuenta de empleado quedó registrada.");
        } catch (IllegalArgumentException error) {
            flash.addFlashAttribute("error", error.getMessage());
        }
        return "redirect:/Usuario/registrar-empleado";
    }

    @GetMapping("/perfil-usuario")
    public String perfil(HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("usuario", usuarioService.perfil(usuarioId));
        return "Usuario/perfil-usuario";
    }

    @GetMapping("/editar-perfil")
    public String mostrarEdicionPerfil(HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("usuario", usuarioService.perfil(usuarioId));
        return "Usuario/editar-perfil";
    }

    @PostMapping("/editar-perfil")
    public String editarPerfil(HttpSession session,
                               @RequestParam String nombres,
                               @RequestParam String apellidos,
                               @RequestParam String correo,
                               @RequestParam(required = false) String telefono) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        usuarioService.editarPerfil(usuarioId, nombres, apellidos, correo, telefono);
        return "redirect:/Usuario/perfil-usuario";
    }

    @GetMapping("/horario-empleado")
    public String horario(HttpSession session, Model model) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        model.addAttribute("usuario", usuarioService.perfil(usuarioId));
        return "Usuario/horario-empleado";
    }

    @GetMapping("/logout")
    public String salir(HttpSession session) {
        session.invalidate();
        return "redirect:/Usuario/login";
    }
}
