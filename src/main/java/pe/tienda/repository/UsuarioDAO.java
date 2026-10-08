package pe.tienda.repository;

import java.time.LocalTime;
import pe.tienda.usuario.Usuario;

public interface UsuarioDAO {

    Usuario porCorreo(String correo);

    Usuario porId(long id);

    int registrarCliente(String nombres, String apellidos, String correo,
                         String contrasena, String telefono);

    boolean existeCorreo(String correo);

    int registrarEmpleado(String nombres, String apellidos, String correo,
                          String contrasena, String telefono,
                          LocalTime entrada, LocalTime salida);

    int actualizarPerfil(long id, String nombres, String apellidos,
                         String correo, String telefono);
}
