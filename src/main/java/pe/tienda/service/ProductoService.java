package pe.tienda.service;

import java.math.BigDecimal;
import java.util.List;
import pe.tienda.producto.Producto;

public interface ProductoService {

    List<Producto> catalogo(String texto, Long categoria);

    List<Producto> listarTodos();

    Producto detalle(long id);

    void registrar(String nombre, String descripcion, long categoria,
                   BigDecimal precio, int stock, long responsable);

    void editar(long id, String nombre, String descripcion, long categoria,
                BigDecimal precio, int stock);

    void desactivar(long id);
}
