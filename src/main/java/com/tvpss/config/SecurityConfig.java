package com.tvpss.config;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.tvpss.model.User;
import com.tvpss.service.UserService;


@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private UserService userService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder auth = 
                http.getSharedObject(AuthenticationManagerBuilder.class);

        auth.jdbcAuthentication()
            .dataSource(dataSource)
            .passwordEncoder(passwordEncoder())
            .usersByUsernameQuery("SELECT username, password, enabled FROM user WHERE username = ?")
            .authoritiesByUsernameQuery(
            "SELECT username, " +
            "CASE role " +
            "  WHEN 1 THEN 'ROLE_SUPER_ADMIN' " +
            "  WHEN 2 THEN 'ROLE_ADMIN_PPD' " +
            "  WHEN 3 THEN 'ROLE_ADMIN_STATE' " +
            "  WHEN 4 THEN 'ROLE_ADMIN_SCHOOL' " +
            "  WHEN 5 THEN 'ROLE_STUDENT' " +
            "  ELSE 'ROLE_UNKNOWN' " +
            "END AS role " +
            "FROM user WHERE username = ?");
            
        return auth.build();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .antMatchers("/", "/login", "/resources/**").permitAll()
                .antMatchers("/superadmin/**").hasAuthority("ROLE_SUPER_ADMIN")
                .antMatchers("/adminppd/**").hasAuthority("ROLE_ADMIN_PPD")
                .antMatchers("/adminstate/**").hasAuthority("ROLE_ADMIN_STATE")
                .antMatchers("/adminschool/**").hasAuthority("ROLE_ADMIN_SCHOOL")
                .antMatchers("/student/**").hasAuthority("ROLE_STUDENT")
                .anyRequest().authenticated()
            )
            .formLogin(login -> login
            .loginPage("/login")
            .successHandler(this::handleLoginSuccess)  // Handle successful login
            .failureHandler(this::handleLoginFailure) 
            .permitAll()
        )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .permitAll()
            )
            .csrf().disable();

            http.exceptionHandling()
            .defaultAuthenticationEntryPointFor(
                (request, response, authException) -> response.sendRedirect("/login"),
                (request) -> request.getRequestURI().equals("/")
            );


        return http.build();
    }

     private void handleLoginSuccess(HttpServletRequest request, HttpServletResponse response,
                                Authentication authentication) throws IOException {
        String username = authentication.getName();
        User user = userService.findByUsername(username);  // Fetch user by authenticated username

        HttpSession session = request.getSession();
        session.setAttribute("loggedInUser", user);
        session.setAttribute("role", user.getRole());

        System.out.println("User " + username + " logged in with role: " + user.getRole());
        response.sendRedirect(request.getContextPath() + determineRedirectUrl(authentication));
    }

    private void handleLoginFailure(HttpServletRequest request,
                                    HttpServletResponse response,
                                    AuthenticationException exception) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("errorMessage", "Invalid username or password. Please try again.");
    
    // Redirect to /login with error message stored in session
        response.sendRedirect("/TvpssApp/login");
    }

    private String determineRedirectUrl(Authentication authentication) {
        String role = authentication.getAuthorities().stream()
                                    .map(grantedAuthority -> grantedAuthority.getAuthority())
                                    .findFirst()
                                    .orElse("ROLE_UNKNOWN");

        Map<String, String> roleRedirectMap = Map.of(
            "ROLE_SUPER_ADMIN", "/superadmin/dashboard",
            "ROLE_ADMIN_PPD", "/adminppd/dashboard",
            "ROLE_ADMIN_STATE", "/adminstate/dashboard",
            "ROLE_ADMIN_SCHOOL", "/adminschool/dashboard",
            "ROLE_STUDENT", "/student/dashboard"
        );

        return roleRedirectMap.getOrDefault(role, "/dashboard");
    }
}