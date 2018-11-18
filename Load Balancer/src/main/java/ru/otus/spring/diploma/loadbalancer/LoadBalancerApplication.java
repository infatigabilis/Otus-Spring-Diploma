package ru.otus.spring.diploma.loadbalancer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

@SpringBootApplication
@EnableZuulProxy
@EnableDiscoveryClient
public class LoadBalancerApplication {

	public static void main(String[] args) {
		try {
			SpringApplication.run(LoadBalancerApplication.class, args);

		} catch (Exception e) {
			System.out.println("Exit because of application failed to start");
			System.exit(-1);
		}
	}
}
