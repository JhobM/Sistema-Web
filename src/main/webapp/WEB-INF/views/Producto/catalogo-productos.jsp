<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de productos</title>
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
        <h1>Catálogo de productos</h1>
    </header>

    <main>
        <c:if test="${modo eq 'editar'}">
            <h2>Selecciona un producto para editar</h2>
        </c:if>
        <c:if test="${modo eq 'desactivar'}">
            <h2>Selecciona un producto para desactivar</h2>
        </c:if>

        <form action="/Producto/catalogo-productos" method="get">
            <c:if test="${not empty modo}">
                <input type="hidden" name="modo" value="${modo}">
            </c:if>
            <label for="buscar">Buscar producto</label>
            <input type="text" id="buscar" name="buscar" value="${buscar}" placeholder="Nombre del producto">

            <label for="categoria">Categoría</label>
            <select id="categoria" name="categoria">
                <option value="">Todas</option>
                <c:forEach var="categoria" items="${categorias}">
                    <option value="${categoria.id}"
                            ${categoriaSeleccionada == categoria.id ? 'selected' : ''}>
                        ${categoria.nombre}
                    </option>
                </c:forEach>
            </select>

            <button type="submit">Buscar</button>
        </form>

        <table>
            <tr>
                <th>Producto</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Acción</th>
            </tr>
            <c:forEach var="producto" items="${productos}">
              <tr>
                <td>${producto.nombre}</td>
                <td>${producto.idCategoria}</td>
                <td>S/ ${producto.precio}</td>
                <td>${producto.stock}</td>
                <td>
                    <c:choose>
                        <c:when test="${modo eq 'editar'}">
                            <a href="/Producto/editar-producto?id=${producto.id}">
                                Editar
                            </a>
                        </c:when>
                        <c:when test="${modo eq 'desactivar'}">
                            <c:choose>
                                <c:when test="${producto.estado eq 'ACTIVO'}">
                                    <a href="/Producto/desactivar-producto?id=${producto.id}">
                                        Desactivar
                                    </a>
                                </c:when>
                                <c:otherwise>Inactivo</c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <a href="/Producto/detalle-producto?id=${producto.id}">
                                Ver detalle
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
              </tr>
            </c:forEach>
        </table>
        <c:if test="${empty productos}">
            <p>No hay productos para mostrar.</p>
        </c:if>
    </main>
</div>
</div>
</body>
</html>


