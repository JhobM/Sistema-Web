package pe.tienda.repository;

import java.util.List;
import pe.tienda.categoria.Categoria;

public interface CategoriaDAO {

    List<Categoria> listar();

    List<Categoria> listarActivas();

    Categoria buscar(long id);

    int insertar(String nombre, String descripcion, long responsable);

    int actualizar(long id, String nombre, String descripcion);

    int desactivar(long id);
}
