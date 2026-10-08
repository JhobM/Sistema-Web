package pe.tienda.producto;

import java.math.BigDecimal;

public class Producto {

    private long id;
    private String nombre;
    private String descripcion;
    private long idCategoria;
    private BigDecimal precio;
    private int stock;
    private String estado;
    private long idUsuarioResponsable;

    public Producto() {
    }

    public Producto(
            long id,
            String nombre,
            String descripcion,
            long idCategoria,
            BigDecimal precio,
            int stock,
            String estado,
            long idUsuarioResponsable
    ) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.idCategoria = idCategoria;
        this.precio = precio;
        this.stock = stock;
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

    public long getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(long idCategoria) {
        this.idCategoria = idCategoria;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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
