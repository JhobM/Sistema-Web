package pe.tienda.service;

import java.time.LocalTime;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pe.tienda.usuario.Usuario;
import pe.tienda.repository.UsuarioDAO;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioDAO usuarioDAO;
    private final BCryptPasswordEncoder codificador = new BCryptPasswordEncoder();

    public UsuarioServiceImpl(UsuarioDAO usuarioDAO) {
        this.usuarioDAO = usuarioDAO;
    }

    public void registrarCliente(String nombres, String apellidos, String correo,
                                 String contrasena, String telefono) {
        validarDatos(nombres, apellidos, correo, contrasena);

        if (usuarioDAO.porCorreo(correo) != null) {
            throw new IllegalArgumentException("Ese correo ya está registrado.");
        }

        usuarioDAO.registrarCliente(nombres, apellidos, correo,
                codificador.encode(contrasena), telefono);
    }

    public void registrarEmpleado(String nombres, String apellidos, String correo,
                                  String contrasena, String telefono,
                                  LocalTime entrada, LocalTime salida) {
        if (nombres == null || nombres.isBlank()
                || apellidos == null || apellidos.isBlank()
                || correo == null || !correo.contains("@")
                || contrasena == null || contrasena.length() < 8
                || entrada == null || salida == null || !salida.isAfter(entrada)) {
            throw new IllegalArgumentException(
                    "Completa los datos; la contraseña debe tener al menos 8 caracteres "
                            + "y el horario debe ser válido.");
        }
        if (usuarioDAO.existeCorreo(correo)) {
            throw new IllegalArgumentException("Ese correo ya está registrado.");
        }

        usuarioDAO.registrarEmpleado(nombres.trim(), apellidos.trim(), correo.trim().toLowerCase(),
                codificador.encode(contrasena), telefono, entrada, salida);
    }

    public Usuario iniciarSesion(String correo, String contrasena) {
        Usuario usuario = usuarioDAO.porCorreo(correo);

        if (usuario == null) {
            throw new IllegalArgumentException("Credenciales inválidas.");
        }

        if (!codificador.matches(contrasena, usuario.getContrasena())) {
            throw new IllegalArgumentException("Credenciales inválidas.");
        }
        return usuario;
    }

    public Usuario perfil(long id) {
        Usuario usuario = usuarioDAO.porId(id);

        if (usuario == null) {
            throw new IllegalArgumentException("Usuario no encontrado.");
        }

        return usuario;
    }

    public void editarPerfil(long id, String nombres, String apellidos,
                             String correo, String telefono) {
        Usuario usuarioConCorreo = usuarioDAO.porCorreo(correo);

        if (usuarioConCorreo != null && usuarioConCorreo.getId() != id) {
            throw new IllegalArgumentException("El correo ya está en uso.");
        }
        usuarioDAO.actualizarPerfil(id, nombres, apellidos, correo, telefono);
    }

    private void validarDatos(String nombres, String apellidos,
                              String correo, String contrasena) {
        if (nombres == null || nombres.isBlank()
                || apellidos == null || apellidos.isBlank()
                || correo == null || !correo.contains("@")
                || contrasena == null || contrasena.length() < 8) {
            throw new IllegalArgumentException(
                    "Completa tus datos; la contraseña debe tener al menos 8 caracteres.");
        }
    }
}
