<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar producto</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="contenedor employee-layout">
<jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
<div class="employee-content">
    <header>
        <h1>Registrar producto</h1>
    </header>
    <main>
        <form action="/Producto/registrar-producto" method="post" data-confirm-unsaved>
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" name="nombre" required>

            <label for="descripcion">Descripción</label>
            <textarea id="descripcion" name="descripcion"></textarea>

            <label for="categoria">Categoría</label>
            <select id="categoria" name="categoria" required>
                <option value="">Seleccione</option>
                <c:forEach var="categoria" items="${categorias}">
                    <option value="${categoria.id}">${categoria.nombre}</option>
                </c:forEach>
            </select>

            <label for="precio">Precio</label>
            <input type="number" id="precio" name="precio" step="0.01" required>

            <label for="stock">Stock</label>
            <input type="number" id="stock" name="stock" min="0" required>

            <button type="submit">Registrar</button>
        </form>

        <p><a href="/Producto/catalogo-productos">Volver al catálogo</a></p>
    </main>
</div>
</div>
<script src="/unsaved-changes.js"></script>
</body>
</html>


