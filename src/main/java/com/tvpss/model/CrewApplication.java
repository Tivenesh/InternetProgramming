package com.tvpss.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "crew_application")
public class CrewApplication implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "ic_number", nullable = false)
    private String icNumber;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "position", nullable = false)
    private String position;

    @Column(name = "form", nullable = false)
    private int form;

    @Column(name = "status", nullable = false)
    private String status; // e.g., "Pending", "Approved", "Rejected"

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "state", nullable = false)
    private String state;

    @Column(name = "region", nullable = false)
    private String region;

    @Column(name = "school_name", nullable = false)
    private String schoolName;

    // Constructors
    public CrewApplication() {}

    public CrewApplication(Long id, String icNumber, String fullName, String position, int form, String status, String email, String state, String region, String schoolName) {
        this.id = id;
        this.icNumber = icNumber;
        this.fullName = fullName;
        this.position = position;
        this.form = form;
        this.status = status;
        this.email = email;
        this.state = state;
        this.region = region;
        this.schoolName = schoolName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIcNumber() {
        return icNumber;
    }

    public void setIcNumber(String icNumber) {
        this.icNumber = icNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public int getForm() {
        return form;
    }

    public void setForm(int form) {
        this.form = form;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    @Override
    public String toString() {
        return "CrewApplication [id=" + id + ", icNumber=" + icNumber + ", fullName=" + fullName + ", position="
                + position + ", form=" + form + ", status=" + status + ", email=" + email + ", state=" + state
                + ", region=" + region + ", schoolName=" + schoolName + "]";
    }

    public CrewApplication orElse(Object object) {
        throw new UnsupportedOperationException("Unimplemented method 'orElse'");
    }

    
}
