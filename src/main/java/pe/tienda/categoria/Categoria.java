package pe.tienda.categoria;

public class Categoria {

    private long id;
    private String nombre;
    private String descripcion;
    private String estado;
    private long idUsuarioResponsable;

    public Categoria() {
    }

    public Categoria(
            long id,
            String nombre,
            String descripcion,
            String estado,
            long idUsuarioResponsable
    ) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.estado = estado;
        this.idUsuarioResponsable = idUsuarioResponsable;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public long getIdUsuarioResponsable() {
        return idUsuarioResponsable;
    }

    public void setIdUsuarioResponsable(long idUsuarioResponsable) {
        this.idUsuarioResponsable = idUsuarioResponsable;
    }

}
