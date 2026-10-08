package pe.tienda.repository;

import java.math.BigDecimal;
import java.util.List;
import pe.tienda.producto.Producto;

public interface ProductoDAO {

    List<Producto> listarDisponibles();

    List<Producto> buscarDisponibles(String texto, Long categoria);

    List<Producto> listarTodos();

    Producto buscar(long id);

    int insertar(String nombre, String descripcion, long categoria,
                 BigDecimal precio, int stock, long responsable);

    int actualizar(long id, String nombre, String descripcion, long categoria,
                   BigDecimal precio, int stock);

    int desactivar(long id);

    boolean descontarStock(long id, int cantidad);
}
