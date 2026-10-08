package pe.tienda.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class SessionAuthInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();
        String context = request.getContextPath();
        String tipoUsuario = null;

        if (session != null) {
            tipoUsuario = (String) session.getAttribute("tipoUsuario");
        }

        if (session == null || session.getAttribute("usuarioId") == null) {
            response.sendRedirect(context + "/Usuario/login");
            return false;
        }

        boolean requiereEmpleado = uri.startsWith(context + "/Categoria/")
                || uri.startsWith(context + "/Asistencia/")
                || uri.equals(context + "/IntEmp/panel")
                || uri.equals(context + "/Usuario/registrar-empleado")
                || esAdministracionProducto(uri, context);

        if (requiereEmpleado && !"EMPLEADO".equals(tipoUsuario)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return false;
        }
        return true;
    }

    private boolean esAdministracionProducto(String uri, String context) {
        String inicioRutaProducto = context + "/Producto/";
        boolean esRutaProducto = uri.startsWith(inicioRutaProducto);
        boolean esCatalogo = uri.equals(inicioRutaProducto + "catalogo-productos");
        boolean esDetalle = uri.equals(inicioRutaProducto + "detalle-producto");
        return esRutaProducto && !esCatalogo && !esDetalle;
    }
}
