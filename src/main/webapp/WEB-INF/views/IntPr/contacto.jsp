<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacto</title>
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
        <h1>Contacto</h1>
    </header>

    <main>
        <h2>Escríbenos</h2>

        <form>
            <label for="correo">Correo</label>
            <input type="email" id="correo" name="correo" placeholder="cliente@correo.com">

            <label for="mensaje">Mensaje o comentario</label>
            <textarea id="mensaje" name="mensaje" rows="5" placeholder="Escribe tu mensaje"></textarea>

            <button type="button">Enviar</button>
        </form>

        <nav>
            <a href="/IntPr/tienda">Volver a la tienda</a>
        </nav>
    </main>
</div>
</div>
</body>
</html>


