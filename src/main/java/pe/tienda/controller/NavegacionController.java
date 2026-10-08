package pe.tienda.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import pe.tienda.producto.Producto;
import pe.tienda.service.ProductoService;
import pe.tienda.service.VentaService;

@Controller
public class NavegacionController {

    private final ProductoService productoService;
    private final VentaService ventaService;

    public NavegacionController(ProductoService productoService,
                                VentaService ventaService) {
        this.productoService = productoService;
        this.ventaService = ventaService;
    }

    @GetMapping({"/", "/IntPr/tienda"})
    public String tienda(Model model) {
        List<Producto> productos = productoService.catalogo(null, null);
        List<Producto> destacados = new ArrayList<>();

        for (int i = 0; i < productos.size() && i < 4; i++) {
            destacados.add(productos.get(i));
        }

        model.addAttribute("productosDestacados", destacados);
        return "IntPr/tienda";
    }

    @GetMapping("/IntEmp/panel")
    public String panel(Model model) {
        model.addAttribute("metricas", ventaService.metricas());
        return "IntEmp/panel";
    }

    @GetMapping("/IntPr/carrito")
    public String carrito() {
        return "redirect:/Venta/carrito";
    }

    @GetMapping("/IntPr/contacto")
    public String contacto() {
        return "IntPr/contacto";
    }

    @GetMapping("/IntPr/publicidad")
    public String publicidad() {
        return "IntPr/publicidad";
    }

    @GetMapping("/Pago/realizar-pago")
    public String pago() {
        return "redirect:/Venta/realizar-pago";
    }
}
