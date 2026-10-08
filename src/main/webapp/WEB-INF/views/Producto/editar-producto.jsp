<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar producto</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="contenedor employee-layout">
<jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
<div class="employee-content">
    <header>
        <h1>Editar producto</h1>
    </header>
    <main>
        <form action="/Producto/editar-producto" method="post" data-confirm-unsaved>
            <input type="hidden" name="id" value="${producto.id}">
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" name="nombre" value="${producto.nombre}">

            <label for="descripcion">Descripción</label>
            <textarea id="descripcion" name="descripcion">${producto.descripcion}</textarea>

            <label for="categoria">Categoría</label>
            <select id="categoria" name="categoria">
                <c:forEach var="categoria" items="${categorias}">
                    <option value="${categoria.id}"
                            ${producto.idCategoria == categoria.id ? 'selected' : ''}>
                        ${categoria.nombre}
                    </option>
                </c:forEach>
            </select>

            <label for="precio">Precio</label>
            <input type="number" id="precio" name="precio" step="0.01" value="${producto.precio}">

            <label for="stock">Stock</label>
            <input type="number" id="stock" name="stock" min="0" value="${producto.stock}">

            <button type="submit">Guardar cambios</button>
        </form>

        <p><a href="/Producto/detalle-producto?id=${producto.id}">Cancelar</a></p>
    </main>
</div>
</div>
<script src="/unsaved-changes.js"></script>
</body>
</html>


