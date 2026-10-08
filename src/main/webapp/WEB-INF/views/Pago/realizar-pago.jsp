<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Realizar pago</title>
    <link rel="stylesheet" href="/styles.css">
    <c:if test="${sessionScope.tipoUsuario ne 'EMPLEADO'}">
        <link rel="stylesheet" href="/styles-cliente.css">
    </c:if>
</head>

<body>

<div class="${sessionScope.tipoUsuario eq 'EMPLEADO' ? 'contenedor employee-layout' : 'contenedor cliente-layout'}">

    <c:choose>
      <c:when test="${sessionScope.tipoUsuario eq 'EMPLEADO'}">
        <jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
      </c:when>
      <c:otherwise>
        <jsp:include page="/WEB-INF/views/fragments/menu-cliente.jsp" />
      </c:otherwise>
    </c:choose>

    <div class="${sessionScope.tipoUsuario eq 'EMPLEADO' ? 'employee-content' : 'cliente-content'}">
    <main>

        <h1>Realizar pago</h1>

        <h2>Resumen de compra</h2>

        <p>Subtotal: S/ ${resumen.subtotal}</p>
        <p>Descuento aplicado: S/ ${resumen.descuento}</p>
        <h3>Total: S/ ${resumen.total}</h3>

        <form action="/Venta/realizar-pago" method="post" data-confirm-unsaved>

            <p>Método de pago: <strong>Yape</strong></p>

            <button type="submit">
                Confirmar pago
            </button>

        </form>

    </main>
    </div>

</div>

<script src="/unsaved-changes.js"></script>
</body>
</html>

