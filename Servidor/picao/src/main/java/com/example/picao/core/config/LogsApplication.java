package com.example.picao.core.config;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Component
public class LogsApplication {

    private static final Logger logger = LoggerFactory.getLogger(LogsApplication.class);

    @Around("@within(org.springframework.stereotype.Service)") // captura todos los metodos con anotacion service
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        long startTime = System.currentTimeMillis();
        Object[] args = joinPoint.getArgs();

        Object proceed;
        try {
            // Ejecuta el método del servicio
            proceed = joinPoint.proceed();
        } catch (RuntimeException ex) {

            logger.error("[{}] Excepción en el método: {} -> parámetros: {} -> Mensaje de error: {}",
                    Thread.currentThread().getName(), joinPoint.getSignature(),
                    args != null ? Arrays.toString(args) : "Sin parámetros", ex.getMessage());
            throw ex;
        }

        long endTime = System.currentTimeMillis();
        long executionTime = endTime - startTime;

        logger.info("[{}] Metodo ejecutado: {} -> parametros: {} -> tiempo de ejecucion: {} ms",
                Thread.currentThread().getName(),
                joinPoint.getSignature(), args != null ? Arrays.toString(args) : "Sin parametros", executionTime);


        return proceed;
    }
}
