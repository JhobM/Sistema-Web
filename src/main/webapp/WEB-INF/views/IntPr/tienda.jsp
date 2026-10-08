<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda</title>
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

        <h1>Bienvenido a la tienda</h1>

        <p>
            Consulta nuestros productos y promociones disponibles.
        </p>

        <h2>Productos destacados</h2>

        <c:forEach var="producto" items="${productosDestacados}">
            <section>
                <h3>${producto.nombre}</h3>
                <p>Precio: S/ ${producto.precio}</p>
                <a href="/Producto/detalle-producto?id=${producto.id}">
                    Ver producto
                </a>
            </section>
        </c:forEach>

    </main>
    </div>

</div>

</body>
</html>


