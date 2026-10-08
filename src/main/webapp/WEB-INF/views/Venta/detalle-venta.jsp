<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de compra</title>
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

        <h1>Detalle de compra</h1>

        <p><strong>Venta:</strong> #${detalles[0].id_venta}</p>
        <p><strong>Fecha:</strong> ${detalles[0].fecha_venta}</p>

        <hr>

        <h2>Productos</h2>

        <c:forEach var="linea" items="${detalles}">
            <section>
                <h3>${linea.producto}</h3>
                <p>Cantidad: ${linea.cantidad}</p>
                <p>Precio unitario: S/ ${linea.precio_unitario}</p>
                <p>Subtotal: S/ ${linea.subtotal_linea}</p>
            </section>
        </c:forEach>

        <hr>

        <p>Subtotal: S/ ${detalles[0].total_parcial}</p><p>Descuento: S/ ${detalles[0].descuento}</p>
        <h3>Total: S/ ${detalles[0].total}</h3><p>Estado: ${detalles[0].estado}</p>

        <a href="/Venta/mis-compras">
            Volver
        </a>

    </main>
    </div>

</div>

</body>
</html>

