package pe.tienda.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    private final SessionAuthInterceptor auth;

    public WebConfig(SessionAuthInterceptor auth) {
        this.auth = auth;
    }
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(auth)
                .addPathPatterns(
                        "/Usuario/perfil-usuario",
                        "/Usuario/editar-perfil",
                        "/Usuario/horario-empleado",
                        "/Usuario/registrar-empleado",
                        "/Categoria/**",
                        "/Asistencia/**",
                        "/Producto/registrar-producto",
                        "/Producto/editar-producto",
                        "/Producto/desactivar-producto",
                        "/IntEmp/panel",
                        "/Venta/**",
                        "/Pago/**");
    }
}
