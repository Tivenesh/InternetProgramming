package com.tvpss.service;

import com.tvpss.model.User;
import com.tvpss.model.UserRoles;
import com.tvpss.repository.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userDao.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        // Convert integer roles to Spring Security roles
        String roleWithPrefix = "ROLE_" + mapRoleToString(user.getRole());
        System.out.println("Logging in user: " + username + " with role: " + roleWithPrefix);

        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),
                Collections.singleton(new SimpleGrantedAuthority(roleWithPrefix))
        );
    }

    // Map integer role to corresponding string
    private String mapRoleToString(int role) {
        switch (role) {
            case UserRoles.SUPER_ADMIN:
                return "SUPER_ADMIN";
            case UserRoles.ADMIN_PPD:
                return "ADMIN_PPD";
            case UserRoles.ADMIN_STATE:
                return "ADMIN_STATE";
            case UserRoles.ADMIN_SCHOOL:
                return "ADMIN_SCHOOL";
            case UserRoles.STUDENT:
                return "STUDENT";
            default:
                return "UNKNOWN";
        }
    }
}
