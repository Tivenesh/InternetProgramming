package com.tvpss.config;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{SecurityConfig.class, HibernateConfig.class};
    }
    
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{WebMvcConfig.class};
    }
    
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
    
    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        // Define upload directory (create this directory in your project)
        String uploadDirectory = System.getProperty("java.io.tmpdir");
        
        // Set up multipart config
        MultipartConfigElement multipartConfig = new MultipartConfigElement(
            uploadDirectory,
            5 * 1024 * 1024,  // max file size
            25 * 1024 * 1024, // max request size
            0                 // file size threshold
        );
        
        registration.setMultipartConfig(multipartConfig);
    }
}
