package com.example.picao;

import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@Log4j2
@SpringBootApplication
public class PicaoApplication implements CommandLineRunner {

    @Value("${spring.profiles.active}")
    private String activeProfile;

    public static void main(String[] args) {
        SpringApplication.run(PicaoApplication.class, args);
    }

    @Override
    public void run(String... args) {
        log.info("Active Profile: {}", activeProfile);
    }
}
