<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi perfil</title>
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
    <h1>Mi perfil</h1>
</header>

<main>

    <h2>Información del usuario</h2>

    <p>
        <strong>Nombres:</strong>
        ${usuario.nombres}
    </p>

    <p>
        <strong>Apellidos:</strong>
        ${usuario.apellidos}
    </p>

    <p>
        <strong>Correo:</strong>
        ${usuario.correo}
    </p>

    <p>
        <strong>Teléfono:</strong>
        ${usuario.telefono}
    </p>

    <a href="/Usuario/editar-perfil">
        Editar perfil
    </a>

</main>

</div>
</div>
</body>
</html>

