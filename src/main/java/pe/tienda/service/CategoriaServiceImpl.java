package pe.tienda.service;

import java.util.List;
import org.springframework.stereotype.Service;
import pe.tienda.categoria.Categoria;
import pe.tienda.repository.CategoriaDAO;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    private final CategoriaDAO categoriaDAO;

    public CategoriaServiceImpl(CategoriaDAO categoriaDAO) {
        this.categoriaDAO = categoriaDAO;
    }

    public List<Categoria> listar() {
        return categoriaDAO.listar();
    }

    public Categoria buscar(long id) {
        Categoria categoria = categoriaDAO.buscar(id);

        if (categoria == null) {
            throw new IllegalArgumentException("Categoría no encontrada.");
        }

        return categoria;
    }

    public void registrar(String nombre, String descripcion, long responsable) {
        validarNombre(nombre);
        categoriaDAO.insertar(nombre, descripcion, responsable);
    }

    public void editar(long id, String nombre, String descripcion) {
        validarNombre(nombre);
        categoriaDAO.actualizar(id, nombre, descripcion);
    }

    public void desactivar(long id) {
        categoriaDAO.desactivar(id);
    }

    private void validarNombre(String nombre) {
        if (nombre == null || nombre.isBlank()) {
            throw new IllegalArgumentException("El nombre es obligatorio.");
        }
    }
}
