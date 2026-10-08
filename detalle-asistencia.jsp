<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Detalle de asistencia</title>
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
    <h1>Detalle de asistencia</h1>
    <p><strong>Empleado:</strong> ${usuario.nombres} ${usuario.apellidos}</p>
    <p><strong>Fecha:</strong> ${asistencia.fecha}</p>
    <p><strong>Horario:</strong> ${usuario.horaEntrada} - ${usuario.horaSalida}</p>
    <p><strong>Entrada:</strong> ${asistencia.horaEntrada}</p>
    <p><strong>Salida:</strong> ${asistencia.horaSalida}</p>
    <p><strong>Estado:</strong> ${asistencia.estado}</p>

    <a href="/Asistencia/historial-asistencia">Volver al historial</a>
  </main>
</div>
</div>
</body>
</html>


