package pe.tienda.service;

import java.util.List;
import pe.tienda.categoria.Categoria;

public interface CategoriaService {

    List<Categoria> listar();

    Categoria buscar(long id);

    void registrar(String nombre, String descripcion, long responsable);

    void editar(long id, String nombre, String descripcion);

    void desactivar(long id);
}
