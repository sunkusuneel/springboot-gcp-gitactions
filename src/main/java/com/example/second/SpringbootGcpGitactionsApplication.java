package com.example.second;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class SpringbootGcpGitactionsApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringbootGcpGitactionsApplication.class, args);
	}
	  @GetMapping("/")
	    public String hello() {
	        return "Hello from Spring Boot on Cloud Run!";
	    }
}
