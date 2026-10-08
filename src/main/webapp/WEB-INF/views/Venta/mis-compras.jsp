<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis compras</title>
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

        <h1>Mis compras</h1>

        <c:forEach var="compra" items="${compras}">
            <section>
                <h3>Venta #${compra.id_venta}</h3>
                <p>Fecha: ${compra.fecha_venta}</p>
                <p>Total: S/ ${compra.total}</p>
                <p>Estado: ${compra.estado}</p>
                <a href="/Venta/detalle-venta?id=${compra.id_venta}">
                    Ver detalle
                </a>
            </section>
        </c:forEach>

    </main>
    </div>

</div>

</body>
</html>


