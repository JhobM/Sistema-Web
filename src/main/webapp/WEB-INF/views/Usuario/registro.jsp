<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de usuario</title>
    <link rel="stylesheet" href="/styles.css">
</head>

<body>

<header>
    <h1>Registro de usuario</h1>
</header>

<main>

    <form action="/Usuario/registro" method="post">

        <label for="nombres">Nombres</label>
        <input
            type="text"
            id="nombres"
            name="nombres"
            required
        >

        <label for="apellidos">Apellidos</label>
        <input
            type="text"
            id="apellidos"
            name="apellidos"
            required
        >

        <label for="correo">Correo electrónico</label>
        <input
            type="email"
            id="correo"
            name="correo"
            required
        >

        <label for="telefono">Teléfono</label>
        <input
            type="text"
            id="telefono"
            name="telefono"
        >

        <label for="contrasena">Contraseña</label>
        <input
            type="password"
            id="contrasena"
            name="contrasena"
            required
        >

        <label for="confirmar">Confirmar contraseña</label>
        <input
            type="password"
            id="confirmar"
            name="confirmar"
            required
        >

        <button type="submit">
            Registrarse
        </button>

    </form>

    <p>
        ¿Ya tienes una cuenta?
        <a href="/Usuario/login">Iniciar sesión</a>
    </p>

</main>

</body>
</html>

