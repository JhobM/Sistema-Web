<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito</title>
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

        <h1>Carrito de compras</h1>

        <c:choose>
          <c:when test="${empty lineas}">
            <p>Tu carrito está vacío.</p>
          </c:when>
          <c:otherwise>
            <c:forEach var="linea" items="${lineas}">
              <section>
                <h3>${linea.producto.nombre}</h3>
                <p>Precio: S/ ${linea.producto.precio}</p>
                <p>Cantidad: ${linea.cantidad}</p>
                <p>Subtotal: S/ ${linea.subtotal}</p>
                <form action="/Venta/carrito/quitar" method="post">
                  <input type="hidden" name="idProducto" value="${linea.producto.id}">
                  <button type="submit">Quitar producto</button>
                </form>
              </section>
            </c:forEach>
            <h3>Subtotal: S/ ${subtotal}</h3>
            <a href="/Pago/realizar-pago">Pagar</a>
          </c:otherwise>
        </c:choose>

    </main>
    </div>

</div>

</body>
</html>

