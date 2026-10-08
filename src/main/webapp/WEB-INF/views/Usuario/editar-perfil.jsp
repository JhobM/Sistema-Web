<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar perfil</title>
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
    <h1>Editar perfil</h1>
</header>

<main>

    <form action="/Usuario/editar-perfil" method="post" data-confirm-unsaved>

        <label for="nombres">Nombres</label>
        <input
            type="text"
            id="nombres"
            name="nombres"
            value="${usuario.nombres}"
        >

        <label for="apellidos">Apellidos</label>
        <input
            type="text"
            id="apellidos"
            name="apellidos"
            value="${usuario.apellidos}"
        >

        <label for="correo">Correo</label>
        <input
            type="email"
            id="correo"
            name="correo"
            value="${usuario.correo}"
        >

        <label for="telefono">Teléfono</label>
        <input
            type="text"
            id="telefono"
            name="telefono"
            value="${usuario.telefono}"
        >

        <button type="submit">
            Guardar cambios
        </button>

    </form>

    <p>
        <a href="/Usuario/perfil-usuario">
            Volver al perfil
        </a>
    </p>

</main>

</div>
</div>
<script src="/unsaved-changes.js"></script>
</body>
</html>

