package com.tvpss.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@ComponentScan(basePackages = "com.tvpss")
public class WebMvcConfig implements WebMvcConfigurer {
    
    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        
        // Set maximum upload size (5MB)
        resolver.setMaxUploadSize(5 * 1024 * 1024);
        
        // Set maximum size for each file (5MB)
        resolver.setMaxUploadSizePerFile(5 * 1024 * 1024);
        
        // Set maximum size in memory (1MB)
        resolver.setMaxInMemorySize(1024 * 1024);
        
        // Set default encoding
        resolver.setDefaultEncoding("UTF-8");
        
        return resolver;
    }
}
