<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desactivar Categoría</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="contenedor employee-layout">
<jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
<div class="employee-content">
<header>
    <h1>Desactivar Categoría</h1>
</header>
<main>
    <nav>
        <a href="/Categoria/listar-categorias">Volver a categorías</a>
    </nav>

    <h2>Polos</h2>
    <p>Esta categoría no se eliminará físicamente. Solo cambiará su estado a inactiva.</p>
    <p>Los productos asociados conservarán su información.</p>

    <h2>${categoria.nombre}</h2>
    <form action="/Categoria/desactivar-categoria" method="post">
        <input type="hidden" name="id" value="${categoria.id}">
        <button type="submit">Confirmar desactivación</button>
    </form>
</main>
</div>
</div>
</body>
</html>


