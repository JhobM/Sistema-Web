<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del producto</title>
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
    <header>
        <h1>Detalle del producto</h1>
    </header>

    <main>
        <p><strong>Nombre:</strong> ${producto.nombre}</p>
        <p><strong>Descripción:</strong> ${producto.descripcion}</p>
        <p><strong>Categoría:</strong> ${producto.idCategoria}</p>
        <p><strong>Precio:</strong> S/ ${producto.precio}</p>
        <p><strong>Stock:</strong> ${producto.stock}</p>

        <form action="/Venta/carrito/agregar" method="post">
            <input type="hidden" name="idProducto" value="${producto.id}">
            <label for="cantidad">Cantidad</label>
            <input type="number" id="cantidad" name="cantidad" value="1" min="1" max="${producto.stock}" required>
            <button type="submit">Agregar al carrito</button>
        </form>

        <nav>
            <a href="/Producto/catalogo-productos">Volver al catálogo</a>
        </nav>
    </main>
</div>
</div>
</body>
</html>


