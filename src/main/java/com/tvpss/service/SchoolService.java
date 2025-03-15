package com.tvpss.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.tvpss.model.School;
import com.tvpss.repository.SchoolDao;

@Service
public class SchoolService {
	
	@Autowired
    private SchoolDao schoolDao;
	
    private List<School> schoolDatabase = new ArrayList<>();
    

    @Transactional
    public void saveSchool(School school) {
        schoolDao.saveOrUpdate(school);
    }

    @Transactional
    public School getSchool() {
        School school = schoolDao.getSchoolInfo();
        return school != null ? school : new School();
    }

    @Transactional
    public void saveOrUpdate(School school) {
        schoolDao.saveOrUpdate(school);
    }
    
    @Transactional
    public List<School> getAllSchools() {
        return schoolDao.findAll();
    }
    
    @Transactional
    public long getTotalSchools() {
        return schoolDao.countTotalSchools();
    }

    @Transactional
    public School getSchoolBySchoolCode(String schoolCode) {
        return schoolDao.getSchoolBySchoolCode(schoolCode);
    }
    
    @Transactional
    public void updateVersionStatus(String schoolCode, String versionStatus) {
        schoolDao.updateVersionStatus(schoolCode, versionStatus);
    }
    
    @Transactional
    public void updateTvpssVersion(School school) {
        int currentVersion = school.getTvpssVersion() != null ? school.getTvpssVersion() : 0;
        int newVersion = currentVersion;

        // Check criteria for incrementing the version
        if ("Yes".equalsIgnoreCase(school.getConnerminittv())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getRecordingEquipment())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getGreenScreenTechnology())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getCollaborationExternalAgencies())) newVersion++;
        if (school.getYoutubeLink() != null && !school.getYoutubeLink().isEmpty()) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getStudio())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getRecordingInSchool())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getRecordingInOutSchool())) newVersion++;

        school.setTvpssVersion(newVersion);
        saveSchool(school);  // Save the updated version
    }

    @Transactional
    public void calculateAndSaveTvpssVersion(School school) {
        int currentVersion = school.getTvpssVersion() != null ? school.getTvpssVersion() : 0;
        int newVersion = currentVersion;

        // Check criteria for incrementing the version
        if ("Yes".equalsIgnoreCase(school.getConnerminittv())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getRecordingEquipment())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getGreenScreenTechnology())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getCollaborationExternalAgencies())) newVersion++;
        if (school.getYoutubeLink() != null && !school.getYoutubeLink().isEmpty()) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getStudio())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getRecordingInSchool())) newVersion++;
        if ("Yes".equalsIgnoreCase(school.getRecordingInOutSchool())) newVersion++;

        // Set the calculated version
        school.setTvpssVersion(newVersion);

        // Save or update the school in the database
        schoolDao.saveOrUpdate(school);
    }

    
    @Transactional
    public void updateVersionStatus(School school, boolean isValid) {
        school.setVersionStatus(isValid ? "Active" : "Inactive");
        schoolDao.saveOrUpdate(school);
    }

    
    public SchoolService() {
        // Adding a test school for SCH001
        School testSchool = new School();
        testSchool.setCode("SCH001");
        testSchool.setName("TIVENESH SCHOOL");
        testSchool.setAddress1("23, JLN NB2 10/7, TAMAN NUSA BESTARI 2");
        testSchool.setAddress2("JOHOR BAHRU, JOHOR");
        testSchool.setPostcode("81300");
        testSchool.setState("JOHOR");
        testSchool.setTelephoneNumber("01126727701");
        testSchool.setEmail("tivensrinivasan@gmail.com");
        testSchool.setLogoFilename("testLogo.png"); // Assuming a test logo exists
        testSchool.setYoutubeLink("https://www.youtube.com/watch?v=25bb8H0MOEM");
        testSchool.setStudio("Yes");
        // testSchool.setYoutubeUpload("Yes");
        testSchool.setRecordingInSchool("Yes");
        testSchool.setRecordingInOutSchool("No");
        // testSchool.setTvpssLogo("Uploaded");
        schoolDatabase.add(testSchool);
    }

}