
package com.tvpss.model;

import javax.persistence.*;

import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;
import java.util.Arrays;

@Entity
@Table(name = "school")
public class School implements Serializable {

    @Id
    @Column(name = "code")
    private String code;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "address1", nullable = false)
    private String address1;

    @Column(name = "address2")
    private String address2;

    @Column(name = "postcode", nullable = false)
    private String postcode;

    @Column(name = "state", nullable = false)
    private String state;

    @Column(name = "telephone_number")
    private String telephoneNumber;

    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Lob
    @Column(name = "logo")
    private byte[] logo;

    @Transient
    private MultipartFile logoFile;

    @Column(name = "youtube_link")
    private String youtubeLink;

    @Column(name = "logo_filename")
    private String logoFilename;

    @Column(name = "conner_minittv")
    private String connerminittv;

    @Column(name = "recording_equipment")
    private String recordingEquipment;

    @Column(name = "green_screen_technology")
    private String greenScreenTechnology;

    @Column(name = "studio")
    private String studio;

    @Column(name = "recording_in_school")
    private String recordingInSchool;

    @Column(name = "recording_in_out_school")
    private String recordingInOutSchool;

    @Column(name = "tvpss_version")
    private Integer tvpssVersion = 0;

    @Column(name = "version_status")
    private String versionStatus = "Inactive";

    @Column(name = "collaboration_external_agencies")
    private String collaborationExternalAgencies;

    @Column(name = "school_officer_name")
    private String schoolOfficerName;

    
    public String getSchoolOfficerName() {
        return schoolOfficerName;
    }

    public void setSchoolOfficerName(String schoolOfficerName) {
        this.schoolOfficerName = schoolOfficerName;
    }

    public String getVersionStatus() {
        return versionStatus;
    }

    public void setVersionStatus(String versionStatus) {
        this.versionStatus = versionStatus;
    }

    public Integer getTvpssVersion() {
        return tvpssVersion;
    }

    public void setTvpssVersion(Integer tvpssVersion) {
        this.tvpssVersion = tvpssVersion;
    }

    
    public School() {
    }

    public String getLogoFilename() {
        return logoFilename;
    }

    public void setLogoFilename(String logoFilename) {
        this.logoFilename = logoFilename;
    }

    // Getters and Setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getTelephoneNumber() {
        return telephoneNumber;
    }

    public void setTelephoneNumber(String telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public byte[] getLogo() {
        return logo;
    }

    public void setLogo(byte[] logo) {
        this.logo = logo;
    }

    public MultipartFile getLogoFile() {
        return logoFile;
    }

    public void setLogoFile(MultipartFile logoFile) {
        this.logoFile = logoFile;
    }

    public String getYoutubeLink() {
        return youtubeLink;
    }

    public void setYoutubeLink(String youtubeLink) {
        this.youtubeLink = youtubeLink;
    }

    public String getConnerminittv() {
        return connerminittv;
    }

    public void setConnerminittv(String connerminittv) {
        this.connerminittv = connerminittv;
    }

    public String getRecordingEquipment() {
        return recordingEquipment;
    }

    public void setRecordingEquipment(String recordingEquipment) {
        this.recordingEquipment = recordingEquipment;
    }

    public String getGreenScreenTechnology() {
        return greenScreenTechnology;
    }

    public void setGreenScreenTechnology(String greenScreenTechnology) {
        this.greenScreenTechnology = greenScreenTechnology;
    }

    public String getStudio() {
        return studio;
    }

    public void setStudio(String studio) {
        this.studio = studio;
    }

    public String getRecordingInSchool() {
        return recordingInSchool;
    }

    public void setRecordingInSchool(String recordingInSchool) {
        this.recordingInSchool = recordingInSchool;
    }

    public String getRecordingInOutSchool() {
        return recordingInOutSchool;
    }

    public void setRecordingInOutSchool(String recordingInOutSchool) {
        this.recordingInOutSchool = recordingInOutSchool;
    }

    public String getCollaborationExternalAgencies() {
        return collaborationExternalAgencies;
    }

    public void setCollaborationExternalAgencies(String collaborationExternalAgencies) {
        this.collaborationExternalAgencies = collaborationExternalAgencies;
    }

    @Override
    public String toString() {
        return "School [code=" + code + ", name=" + name + ", address1=" + address1 + ", address2=" + address2
                + ", postcode=" + postcode + ", state=" + state + ", telephoneNumber=" + telephoneNumber + ", email="
                + email + ", logo=" + Arrays.toString(logo) + ", logoFile=" + logoFile + ", youtubeLink=" + youtubeLink
                + ", logoFilename=" + logoFilename + ", connerminittv=" + connerminittv + ", recordingEquipment="
                + recordingEquipment + ", greenScreenTechnology=" + greenScreenTechnology + ", studio=" + studio
                + ", recordingInSchool=" + recordingInSchool + ", recordingInOutSchool=" + recordingInOutSchool
                + ", tvpssVersion=" + tvpssVersion + ", versionStatus=" + versionStatus
                + ", collaborationExternalAgencies=" + collaborationExternalAgencies + ", schoolOfficerName="
                + schoolOfficerName + "]";
    }

    

    

    

    

    
}
