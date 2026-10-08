package pe.tienda.venta;

import java.math.BigDecimal;

public class ResumenCompra {

    private BigDecimal subtotal;
    private BigDecimal descuento;
    private BigDecimal total;

    public ResumenCompra() {
    }

    public ResumenCompra(
            BigDecimal subtotal,
            BigDecimal descuento,
            BigDecimal total
    ) {
        this.subtotal = subtotal;
        this.descuento = descuento;
        this.total = total;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getDescuento() {
        return descuento;
    }

    public void setDescuento(BigDecimal descuento) {
        this.descuento = descuento;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

}
