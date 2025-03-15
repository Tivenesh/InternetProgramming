package com.tvpss.model;

import javax.persistence.*;

import java.io.File;
import java.io.Serializable;

@Entity
@Table(name = "achievement")
public class Achievement implements Serializable {

    @Id
    @Column(name = "achievement_id", updatable = false, nullable = false)
    private String achievementId;

    @Column(name = "activity_name", nullable = false)
    private String activityName;

    @Column(name = "category", nullable = false)
    private String category;

    @Column(name = "form_mode", nullable = false)
    private String formMode;

    @Column(name = "status", nullable = false)
    private String status;

    // Single Form
    @Column(name = "ic_number")
    private String icNumber;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "sub_category")
    private String subCategory;

    @Column(name = "award_info", nullable = true)
    private String awardInfo;

    // Multiple Form - Storing file paths
    @Column(name = "upload_doc_path")
    private File uploadDocPath;

    @Column(name = "support_doc_path")
    private File supportDocPath;

    public Achievement() {}

    // View Achievement
    public Achievement(String achievementId, String activityName, String category, String formMode, String status) {
		this.achievementId = achievementId;
        this.activityName = activityName;
        this.category = category;
        this.formMode = formMode;
        this.status = status;
    }

    // Single Achievement
    public Achievement(String achievementId, String icNumber, String fullName, String activityName, String category,
                       String subCategory, String awardInfo, String status, String formMode) {
		this.achievementId = achievementId;
        this.icNumber = icNumber;
        this.fullName = fullName;
        this.activityName = activityName;
        this.category = category;
        this.subCategory = subCategory;
        this.awardInfo = awardInfo;
        this.status = status;
        this.formMode = formMode;
    }

    // Multiple Achievement
    public Achievement(String achievementId,String activityName, String category, File uploadDocPath,
                       File supportDocPath, String status, String formMode) {
		this.achievementId = achievementId;
        this.activityName = activityName;
        this.category = category;
        this.uploadDocPath = uploadDocPath;
        this.supportDocPath = supportDocPath;
        this.status = status;
        this.formMode = formMode;
    }

    public String getAchievementId() {
        return achievementId;
    }

    public void setAchievementId(String achievementId) {
        this.achievementId = achievementId;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName != null ? activityName.trim() : null;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFormMode() {
        return formMode;
    }

    public void setFormMode(String formMode) {
        this.formMode = formMode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public String getAwardInfo() {
        return awardInfo;
    }

    public void setAwardInfo(String awardInfo) {
        this.awardInfo = awardInfo;
    }

    public File getUploadDocPath() {
        return uploadDocPath;
    }

    public void setUploadDocPath(File uploadDocPath) {
        this.uploadDocPath = uploadDocPath;
    }

    public File getSupportDocPath() {
        return supportDocPath;
    }

    public void setSupportDocPath(File supportDocPath) {
        this.supportDocPath = supportDocPath;
    }
}
