package pe.tienda.pago;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Pago {

    private long id;
    private long idVenta;
    private LocalDateTime fecha;
    private BigDecimal monto;
    private String metodo;
    private String estado;

    public Pago() {
    }

    public Pago(
            long id,
            long idVenta,
            LocalDateTime fecha,
            BigDecimal monto,
            String metodo,
            String estado
    ) {
        this.id = id;
        this.idVenta = idVenta;
        this.fecha = fecha;
        this.monto = monto;
        this.metodo = metodo;
        this.estado = estado;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(long idVenta) {
        this.idVenta = idVenta;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

}
