<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel del empleado</title>
    <link rel="stylesheet" href="/styles.css">
</head>
<body>

<div class="contenedor">

    <jsp:include page="/WEB-INF/views/fragments/menu-empleado.jsp" />

    <main>
        <h1>Panel del empleado</h1>
        <p>Bienvenido al sistema de gestión de la tienda.</p>

        <h2>Métricas de ventas</h2>
        <div class="metricas-grid">
            <c:forEach var="metrica" items="${metricas}">
                <section class="metrica-card">
                    <h3>${metrica.titulo}</h3>
                    <div class="grafico-lineal">
                        <svg viewBox="0 0 100 51" preserveAspectRatio="xMidYMid meet"
                             role="img" aria-label="${metrica.titulo}">
                            <line class="grafico-guia" x1="0" y1="10" x2="100" y2="10" />
                            <line class="grafico-guia" x1="0" y1="20" x2="100" y2="20" />
                            <line class="grafico-guia" x1="0" y1="30" x2="100" y2="30" />
                            <line class="grafico-guia" x1="0" y1="40" x2="100" y2="40" />
                            <polyline class="grafico-trazo" points="${metrica.linea}" />
                            <c:forEach var="punto" items="${metrica.puntos}">
                                <circle class="grafico-punto-linea" cx="${punto.x}" cy="${punto.y}" r="1.4" />
                                <text class="grafico-valor-linea" x="${punto.x}" y="${punto.y - 3}">${punto.valor}</text>
                                <text class="grafico-fecha-linea" x="${punto.x}" y="49">${punto.etiqueta}</text>
                            </c:forEach>
                        </svg>
                    </div>
                </section>
            </c:forEach>
        </div>

        <h2>Opciones disponibles</h2>

        <section>
            <h3>Categorías</h3>
            <p>Gestiona las categorías registradas en el sistema.</p>
            <a href="/Categoria/listar-categorias">Ir a categorías</a>
        </section>

        <section>
            <h3>Productos</h3>
            <p>Permite registrar, editar o desactivar productos.</p>
            <a href="/Producto/registrar-producto">Registrar producto</a>
        </section>

        <section>
            <h3>Asistencia</h3>
            <p>Registra y consulta tus asistencias.</p>
            <a href="/Asistencia/registrar-asistencia">Registrar asistencia</a>
        </section>

        <section>
            <h3>Perfil</h3>
            <p>Consulta tu información personal y horario.</p>
            <a href="/Usuario/perfil-usuario">Ver perfil</a>
        </section>

        <section>
            <h3>Empleados</h3>
            <p>Registra cuentas de empleado con su horario de trabajo.</p>
            <a href="/Usuario/registrar-empleado">Registrar empleado</a>
        </section>
    </main>

</div>

</body>
</html>
