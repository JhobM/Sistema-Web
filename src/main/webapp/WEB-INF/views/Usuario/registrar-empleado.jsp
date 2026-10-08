<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar empleado</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="contenedor employee-layout">
<jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
<div class="employee-content">
<header><h1>Registro de empleado</h1></header>
<main>
    <p>Completa los datos de la cuenta y el horario de trabajo.</p>
    <p role="status">${mensaje}</p>
    <p role="alert">${error}</p>
    <form action="/Usuario/registrar-empleado" method="post" data-confirm-unsaved>
        <label for="nombres">Nombres</label>
        <input type="text" id="nombres" name="nombres" maxlength="100" required>
        <label for="apellidos">Apellidos</label>
        <input type="text" id="apellidos" name="apellidos" maxlength="100" required>
        <label for="correo">Correo</label>
        <input type="email" id="correo" name="correo" maxlength="180" required>
        <label for="telefono">Teléfono</label>
        <input type="tel" id="telefono" name="telefono" maxlength="30">
        <label for="contrasena">Contraseña (mínimo 8 caracteres)</label>
        <input type="password" id="contrasena" name="contrasena" minlength="8" required>
        <label for="horaEntrada">Hora de entrada</label>
        <input type="time" id="horaEntrada" name="horaEntrada" required>
        <label for="horaSalida">Hora de salida</label>
        <input type="time" id="horaSalida" name="horaSalida" required>
        <button type="submit">Registrar empleado</button>
    </form>
    <nav><a href="/IntEmp/panel">Volver al panel</a></nav>
</main>
</div>
</div>
<script src="/unsaved-changes.js"></script>
</body>
</html>
