<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horario Empleado</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="${sessionScope.tipoUsuario eq 'EMPLEADO' ? 'contenedor employee-layout' : 'page-layout'}">
<c:if test="${sessionScope.tipoUsuario eq 'EMPLEADO'}">
    <jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
</c:if>
<div class="${sessionScope.tipoUsuario eq 'EMPLEADO' ? 'employee-content' : 'page-content'}">
    <header>
        <h1>Tienda de Ropa</h1>
    </header>

    <main>
        <h2>Horario del empleado</h2>

        <p><strong>Empleado:</strong> ${usuario.nombres} ${usuario.apellidos}</p>
        <p><strong>Hora de entrada:</strong> ${usuario.horaEntrada}</p>
        <p><strong>Hora de salida:</strong> ${usuario.horaSalida}</p>
        <p><strong>Estado:</strong> ${usuario.estado}</p>

        <nav>
            <a href="/Usuario/perfil-usuario">Volver al perfil</a>
        </nav>
    </main>
</div>
</div>
</body>
</html>


