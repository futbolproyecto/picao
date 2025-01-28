package com.example.picao.core.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Log4j2
@Component
public class LoggingFilter extends OncePerRequestFilter {


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        try {
            // Continuar con la cadena de filtros
            filterChain.doFilter(request, response);

            log.info("Informacion de la peticion [{} {}] desde IP: {}",
                    request.getMethod(),
                    request.getRequestURI(),
                    request.getRemoteAddr());
        } catch (Exception ex) {
            log.error("Excepción en la petición [{} {}]: {}", request.getMethod(), request.getRequestURI(), ex.getMessage());
            throw ex;
        }
    }
}
