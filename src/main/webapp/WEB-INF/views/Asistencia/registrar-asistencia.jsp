<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrar asistencia</title>
  <link rel="stylesheet" href="/styles.css">
</head>
<body>
<div class="contenedor employee-layout">
<jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />
<div class="employee-content">
  <header>
    <h2>Sistema de Tienda</h2>
    <nav>
      <a href="/Asistencia/registrar-asistencia">Registrar asistencia</a>
      <a href="/Asistencia/historial-asistencia">Historial</a>
    </nav>
  </header>

  <main>
    <h1>Registrar asistencia</h1>
    <p>Empleado: ${usuario.nombres} ${usuario.apellidos}</p>
    <p>Horario: ${usuario.horaEntrada} - ${usuario.horaSalida}</p>

    <form action="/Asistencia/registrar-asistencia" method="post" data-confirm-unsaved>
      <label for="fecha">Fecha</label>
      <input type="date" id="fecha" name="fecha" required>

      <label for="entrada">Hora de entrada</label>
      <input type="time" id="entrada" name="entrada" required>

      <label for="salida">Hora de salida</label>
      <input type="time" id="salida" name="salida" required>

      <button type="submit">Registrar asistencia</button>
    </form>
  </main>
</div>
</div>
<script src="/unsaved-changes.js"></script>
</body>
</html>


