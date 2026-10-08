package pe.tienda.repository;

import java.math.BigDecimal;

public interface PagoDAO {

    int registrar(long ventaId, BigDecimal monto, String metodo);
}
