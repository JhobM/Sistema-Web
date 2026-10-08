package pe.tienda.usuario;

import java.time.LocalTime;

public class Usuario {

    private long id;
    private String nombres;
    private String apellidos;
    private String correo;
    private String telefono;
    private String tipoUsuario;
    private String estado;
    private String contrasena;
    private LocalTime horaEntrada;
    private LocalTime horaSalida;

    public Usuario() {
    }

    public Usuario(
            long id,
            String nombres,
            String apellidos,
            String correo,
            String telefono,
            String tipoUsuario,
            String estado,
            String contrasena,
            LocalTime horaEntrada,
            LocalTime horaSalida
    ) {
        this.id = id;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo = correo;
        this.telefono = telefono;
        this.tipoUsuario = tipoUsuario;
        this.estado = estado;
        this.contrasena = contrasena;
        this.horaEntrada = horaEntrada;
        this.horaSalida = horaSalida;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public LocalTime getHoraEntrada() {
        return horaEntrada;
    }

    public void setHoraEntrada(LocalTime horaEntrada) {
        this.horaEntrada = horaEntrada;
    }

    public LocalTime getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(LocalTime horaSalida) {
        this.horaSalida = horaSalida;
    }

}
