package com.tvpss.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "user")
public class User implements Serializable {

    @Id
    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "role", nullable = false)
    private int role; // e.g., 1 for SUPER_ADMIN, 2 for ADMIN_PPD, etc.

    @Column(name = "state")
    private String state; 

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "enabled", nullable = false)
    private boolean enabled = true;  // Default to enabled

    public User() {}

    // Add a new constructor
    public User(String username, String password, int role, String state, String email, boolean enabled) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.state = state;
        this.email = email;
        this.enabled = enabled;  
    }

    // Getters and Setters
     public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public int getRole() {
        return role;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserRoleName() {
        switch (this.role) {
            case 1:
                return "Super Admin";
            case 2:
                return "PPD Admin";
            case 3:
                return "State Admin";
            case 4:
                return "School Admin";
            case 5:
                return "Student";
            default:
                return "Unknown Role";
        }
    }
}
