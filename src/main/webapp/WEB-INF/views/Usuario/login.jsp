<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
    <link rel="stylesheet" href="/styles.css">
</head>

<body>

<header>
    <h1>Iniciar sesión</h1>
</header>

<main>

    <c:if test="${not empty errorLogin}">
        <p class="mensaje-error" role="alert">${errorLogin}</p>
    </c:if>

    <form action="/Usuario/login" method="post">

        <label for="correo">Correo electrónico</label>
        <input
            type="email"
            id="correo"
            name="correo"
            required
        >

        <label for="contrasena">Contraseña</label>
        <input
            type="password"
            id="contrasena"
            name="contrasena"
            required
        >

        <button type="submit">
            Iniciar sesión
        </button>

    </form>

    <p>
        ¿No tienes una cuenta?
        <a href="/Usuario/registro">Registrarse</a>
    </p>

</main>

</body>
</html>

