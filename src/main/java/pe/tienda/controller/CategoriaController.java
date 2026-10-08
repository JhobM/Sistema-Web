package pe.tienda.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pe.tienda.service.CategoriaService;

@Controller
@RequestMapping("/Categoria")
public class CategoriaController {

    private final CategoriaService categoriaService;

    public CategoriaController(CategoriaService categoriaService) {
        this.categoriaService = categoriaService;
    }

    @GetMapping("/listar-categorias")
    public String listar(Model model) {
        model.addAttribute("categorias", categoriaService.listar());
        return "Categoria/listar-categorias";
    }

    @GetMapping("/registrar-categoria")
    public String mostrarRegistro() {
        return "Categoria/registrar-categoria";
    }

    @PostMapping("/registrar-categoria")
    public String registrar(@RequestParam String nombre,
                            @RequestParam(required = false) String descripcion,
                            HttpSession session) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        categoriaService.registrar(nombre, descripcion, usuarioId);
        return "redirect:/Categoria/listar-categorias";
    }

    @GetMapping("/editar-categoria")
    public String mostrarEdicion(@RequestParam long id, Model model) {
        model.addAttribute("categoria", categoriaService.buscar(id));
        return "Categoria/editar-categoria";
    }

    @PostMapping("/editar-categoria")
    public String editar(@RequestParam long id,
                         @RequestParam String nombre,
                         @RequestParam(required = false) String descripcion) {
        categoriaService.editar(id, nombre, descripcion);
        return "redirect:/Categoria/listar-categorias";
    }

    @GetMapping("/desactivar-categoria")
    public String mostrarDesactivacion(@RequestParam long id, Model model) {
        model.addAttribute("categoria", categoriaService.buscar(id));
        return "Categoria/desactivar-categoria";
    }

    @PostMapping("/desactivar-categoria")
    public String desactivar(@RequestParam long id) {
        categoriaService.desactivar(id);
        return "redirect:/Categoria/listar-categorias";
    }
}
