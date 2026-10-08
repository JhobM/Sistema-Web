package pe.tienda.service;

import java.time.LocalTime;
import pe.tienda.usuario.Usuario;

public interface UsuarioService {

    void registrarCliente(String nombres, String apellidos, String correo,
                          String contrasena, String telefono);

    void registrarEmpleado(String nombres, String apellidos, String correo,
                           String contrasena, String telefono,
                           LocalTime entrada, LocalTime salida);

    Usuario iniciarSesion(String correo, String contrasena);

    Usuario perfil(long id);

    void editarPerfil(long id, String nombres, String apellidos,
                      String correo, String telefono);
}
