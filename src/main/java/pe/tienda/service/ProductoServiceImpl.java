package pe.tienda.service;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.stereotype.Service;
import pe.tienda.categoria.Categoria;
import pe.tienda.producto.Producto;
import pe.tienda.repository.CategoriaDAO;
import pe.tienda.repository.ProductoDAO;

@Service
public class ProductoServiceImpl implements ProductoService {
    private final ProductoDAO productoDAO;
    private final CategoriaDAO categoriaDAO;

    public ProductoServiceImpl(ProductoDAO productoDAO, CategoriaDAO categoriaDAO) {
        this.productoDAO = productoDAO;
        this.categoriaDAO = categoriaDAO;
    }

    public List<Producto> catalogo(String texto, Long categoria) {
        return productoDAO.buscarDisponibles(texto, categoria);
    }

    public List<Producto> listarTodos() {
        return productoDAO.listarTodos();
    }

    public Producto detalle(long id) {
        Producto producto = productoDAO.buscar(id);

        if (producto == null) {
            throw new IllegalArgumentException("Producto no encontrado.");
        }

        return producto;
    }

    public void registrar(String nombre, String descripcion, long categoria,
                          BigDecimal precio, int stock, long responsable) {
        validarProducto(nombre, precio, stock);
        validarCategoriaActiva(categoria);
        productoDAO.insertar(nombre, descripcion, categoria, precio, stock, responsable);
    }

    public void editar(long id, String nombre, String descripcion, long categoria,
                       BigDecimal precio, int stock) {
        detalle(id);
        validarProducto(nombre, precio, stock);
        validarCategoriaActiva(categoria);
        productoDAO.actualizar(id, nombre, descripcion, categoria, precio, stock);
    }

    public void desactivar(long id) {
        detalle(id);
        productoDAO.desactivar(id);
    }

    private void validarProducto(String nombre, BigDecimal precio, int stock) {
        if (nombre == null || nombre.isBlank() || precio == null
                || precio.signum() < 0 || stock < 0) {
            throw new IllegalArgumentException("Revisa nombre, precio y stock.");
        }
    }

    private void validarCategoriaActiva(long categoriaId) {
        for (Categoria categoria : categoriaDAO.listarActivas()) {
            if (categoria.getId() == categoriaId) {
                return;
            }
        }
        throw new IllegalArgumentException("La categoría no existe o está inactiva.");
    }
}
