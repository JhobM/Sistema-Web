<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desactivar producto</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="contenedor employee-layout">
<jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
<div class="employee-content">
    <header>
        <h1>Desactivar producto</h1>
    </header>
    <main>
        <p><strong>Producto:</strong> ${producto.nombre}</p>
        <p><strong>Estado actual:</strong> ${producto.estado}</p>
        <p>Al desactivar el producto, dejará de estar disponible para nuevas transacciones, pero sus datos históricos se conservarán.</p>

        <form action="/Producto/desactivar-producto" method="post">
            <input type="hidden" name="id" value="${producto.id}">
            <button type="submit">Confirmar desactivación</button>
        </form>

        <p><a href="/Producto/catalogo-productos?modo=desactivar">Cancelar</a></p>
    </main>
</div>
</div>
</body>
</html>


