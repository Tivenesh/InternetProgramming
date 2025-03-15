package com.tvpss.model;

import java.io.Serializable;

public class SchoolVersion implements Serializable {

    private String schoolCode;       // School Code
    private String schoolName;       // School Name
    private String district;         // District
    private String contactPerson;    // Contact Person
    private String versionStatus;    // Version Status
    private String status;           // Status (Active/Inactive)
    private int version;             // Version

    public SchoolVersion() {
        this.versionStatus = "Inactive"; // Set default value for versionStatus
        this.status = "Inactive"; 
    }

    public SchoolVersion(String schoolCode, String schoolName, String district, String contactPerson, String versionStatus, String status, int version) {
        this.schoolCode = schoolCode;
        this.schoolName = schoolName;
        this.district = district;
        this.contactPerson = contactPerson;
        this.versionStatus = versionStatus;
        this.status = status;
        this.version = version;
    }

    // Getters and Setters
    public String getSchoolCode() {
        return schoolCode;
    }

    public void setSchoolCode(String schoolCode) {
        this.schoolCode = schoolCode;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getVersionStatus() {
        return versionStatus;
    }

    public void setVersionStatus(String versionStatus) {
        this.versionStatus = versionStatus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    @Override
    public String toString() {
        return "SchoolVersion{" +
                "schoolCode='" + schoolCode + '\'' +
                ", schoolName='" + schoolName + '\'' +
                ", district='" + district + '\'' +
                ", contactPerson='" + contactPerson + '\'' +
                ", versionStatus='" + versionStatus + '\'' +
                ", status='" + status + '\'' +
                ", version=" + version +
                '}';
    }
}
