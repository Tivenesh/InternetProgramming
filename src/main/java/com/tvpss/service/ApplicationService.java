package com.tvpss.service;

import com.tvpss.model.CrewApplication;
import com.tvpss.repository.CrewApplicationDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

@Service
public class ApplicationService {

    @Autowired
    private CrewApplicationDao applicationDao;

    @PostConstruct
    @Transactional
    public void initializeApplications() {
        if(applicationDao.getAll().isEmpty()) {
            applicationDao.save(new CrewApplication(null, "1112030105123", "Chua Ern Qi", "Cameraman", 1, "In Progress", "chloee031023@gmail.com", "Johor", "Ulu Tiram", "SK Taman Mutiara Rini"));
            applicationDao.save(new CrewApplication(null, "1107110107890", "Denies Wong Ke Ying", "Newsreader", 1, "In Progress","denies0516@gmail.com", "Johor", "Skudai", "SK Seri Setia Jaya"));
            applicationDao.save(new CrewApplication(null, "1005120102341", "Joyce Lee", "Cameraman", 2, "In Progress","joyce031019@gmail.com", "Johor", "Skudai", "SK STelok Hutang Lesong"));
            applicationDao.save(new CrewApplication(null, "1008210103456", "Tan Theng Fang", "Newsreader", 2, "In Progress","ttf0416@gmail.com", "Johor", "Pasir Gudang", "SK Taman Bukit Waha"));
            applicationDao.save(new CrewApplication(null, "1109210104567", "Lim En Ting", "Newsreader", 2, "In Progress","enting0601@gmail.com", "Johor", "Skudai", "SK Taman Sempang"));
            applicationDao.save(new CrewApplication(null, "0912310105678", "Tang Zhi Yi", "Cameraman", 3, "In Progress","zyiibusytoeat@gmail.com", "Johor", "Skudai", "SK Taman Panchor"));
        }
    }

    // Get all applications
    @Transactional
    public List<CrewApplication> getAllApplications() {
        return applicationDao.getAll();
    }

    // Get an application by ID
    @Transactional
    public CrewApplication getApplicationById(Long applicationId) {
        return applicationDao.getById(applicationId);
    }

    @Transactional
    public CrewApplication getApplicationByEmail(String email) {
        return applicationDao.getApplicationByEmail(email);
    }

    // Update application status
    @Transactional
    public void updateApplicationStatus(Long id, String status) {
    	CrewApplication application = applicationDao.getById(id);
        if (application != null) {
            application.setStatus(status);
            applicationDao.save(application);
        }
    }

    // Filter applications by search criteria
    @Transactional
    public List<CrewApplication> searchApplications(String searchTerm) {
        List<CrewApplication> allApplications = applicationDao.getAll();
        return allApplications.stream()
                .filter(app -> app.getFullName().toLowerCase().contains(searchTerm.toLowerCase()) ||
                               app.getIcNumber().contains(searchTerm) ||
                               app.getPosition().toLowerCase().contains(searchTerm))
                .collect(Collectors.toList());
    }

    // Save new application to database
    @Transactional
    public void addApplication(CrewApplication application) {
        applicationDao.save(application);
        System.out.println("Saved application:" + application.getId());
    }
}

