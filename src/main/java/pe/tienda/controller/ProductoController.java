package pe.tienda.controller;

import java.math.BigDecimal;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pe.tienda.service.CategoriaService;
import pe.tienda.service.ProductoService;

@Controller
@RequestMapping("/Producto")
public class ProductoController {

    private final ProductoService productoService;
    private final CategoriaService categoriaService;

    public ProductoController(ProductoService productoService,
                              CategoriaService categoriaService) {
        this.productoService = productoService;
        this.categoriaService = categoriaService;
    }

    @GetMapping("/catalogo-productos")
    public String catalogo(@RequestParam(required = false) String buscar, @RequestParam(required = false) Long categoria,
                           @RequestParam(required = false) String modo, HttpSession session, Model model) {
        boolean empleado = "EMPLEADO".equals(session.getAttribute("tipoUsuario"));
        boolean modoEdicion = empleado && "editar".equals(modo);
        boolean modoDesactivacion = empleado && "desactivar".equals(modo);

        if (modoEdicion || modoDesactivacion) {
            model.addAttribute("productos", productoService.listarTodos());
            model.addAttribute("modo", modo);
        } else {
            model.addAttribute("productos", productoService.catalogo(buscar, categoria));
            model.addAttribute("modo", null);
        }

        model.addAttribute("categorias", categoriaService.listar());
        model.addAttribute("buscar", buscar);
        model.addAttribute("categoriaSeleccionada", categoria);
        return "Producto/catalogo-productos";
    }

    @GetMapping("/detalle-producto")
    public String detalle(@RequestParam(defaultValue = "1") long id, Model model) {
        model.addAttribute("producto", productoService.detalle(id));
        return "Producto/detalle-producto";
    }

    @GetMapping("/registrar-producto")
    public String mostrarRegistro(Model model) {
        model.addAttribute("categorias", categoriaService.listar());
        return "Producto/registrar-producto";
    }

    @PostMapping("/registrar-producto")
    public String registrar(@RequestParam String nombre, @RequestParam(required = false) String descripcion, @RequestParam long categoria, @RequestParam BigDecimal precio,
                            @RequestParam int stock, HttpSession session) {
        long usuarioId = (Long) session.getAttribute("usuarioId");
        productoService.registrar(nombre, descripcion, categoria, precio, stock, usuarioId);
        return "redirect:/Producto/catalogo-productos";
    }

    @GetMapping("/editar-producto")
    public String mostrarEdicion(@RequestParam(required = false) Long id, Model model) {
        if (id == null) {
            return "redirect:/Producto/catalogo-productos?modo=editar";
        }

        model.addAttribute("producto", productoService.detalle(id));
        model.addAttribute("categorias", categoriaService.listar());
        return "Producto/editar-producto";
    }

    @PostMapping("/editar-producto")
    public String editar(@RequestParam long id, @RequestParam String nombre, @RequestParam(required = false) String descripcion, @RequestParam long categoria,
                         @RequestParam BigDecimal precio, @RequestParam int stock) {
        productoService.editar(id, nombre, descripcion, categoria, precio, stock);
        return "redirect:/Producto/catalogo-productos";
    }

    @GetMapping("/desactivar-producto")
    public String mostrarDesactivacion(@RequestParam(required = false) Long id, Model model) {
        if (id == null) {
            return "redirect:/Producto/catalogo-productos?modo=desactivar";
        }

        model.addAttribute("producto", productoService.detalle(id));
        return "Producto/desactivar-producto";
    }

    @PostMapping("/desactivar-producto")
    public String desactivar(@RequestParam long id) {
        productoService.desactivar(id);
        return "redirect:/Producto/catalogo-productos";
    }
}
