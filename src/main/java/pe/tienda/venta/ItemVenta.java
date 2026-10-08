package pe.tienda.venta;

public class ItemVenta {

    private long idProducto;
    private int cantidad;

    public ItemVenta() {
    }

    public ItemVenta(
            long idProducto,
            int cantidad
    ) {
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    public long getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(long idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

}
