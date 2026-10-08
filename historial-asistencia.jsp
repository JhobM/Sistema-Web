<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Historial de asistencia</title>
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
    <h1>Historial de asistencia</h1>

    <table>
      <tr>
        <th>Fecha</th>
        <th>Entrada</th>
        <th>Salida</th>
        <th>Estado</th>
        <th>Detalle</th>
      </tr>
      <c:forEach var="asistencia" items="${asistencias}">
        <tr>
          <td>${asistencia.fecha}</td>
          <td>${asistencia.horaEntrada}</td>
          <td>${asistencia.horaSalida}</td>
          <td>${asistencia.estado}</td>
          <td>
            <a href="/Asistencia/detalle-asistencia?id=${asistencia.id}">
              Ver
            </a>
          </td>
        </tr>
      </c:forEach>
    </table>
  </main>
</div>
</div>
</body>
</html>


