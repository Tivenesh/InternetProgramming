package com.tvpss.service;

import com.tvpss.model.Achievement;
import com.tvpss.model.Certificate;
import com.tvpss.repository.AchievementDao;
import com.tvpss.repository.CertificateDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

@Service
public class CertificateService {
   
    @Autowired
    private CertificateDao certificateDao;

    @Autowired
    private AchievementDao achievementDao;

    @PostConstruct
    @Transactional
    public void initializeCertificates() {
        if(certificateDao.getAllCertificates().isEmpty()) {
            certificateDao.save(new Certificate("ACH0001", "SCH001", "SJK (C) Kuo Kuang 2", "Sport Achievement", "single", "Pending"));
            certificateDao.save(new Certificate("ACH0002", "SCH004", "SK Mutiara Rini", "Singing Competition", "multiple", "Generated"));
            certificateDao.save(new Certificate("ACH0003", "SCH005", "SK Taman Sri Pulai", "Essay Competition", "single", "Pending"));
            certificateDao.save(new Certificate("ACH0004", "SCH002", "SK Impian Emas", "Academic Achievement", "multiple", "Generated"));
            certificateDao.save(new Certificate("ACH0005", "SCH003", "SK Taman Universiti", "Sport Achievememt", "single", "Pending"));
            certificateDao.save(new Certificate("ACH0006", "SCH007", "SK Mount AUstin", "Academic Achievement", "single", "Generated"));
            certificateDao.save(new Certificate("ACH0007", "SCH008", "SK Skudai", "Sport Achievememt", "single", "Pending"));
        }
    }
    
    @Transactional
    // Get all certificates
    public List<Certificate> getAllCertificates() {
        return certificateDao.getAllCertificates();
    }

    // Add a new certificate
    @Transactional
    public void addCertificate(Certificate certificate) {
        certificateDao.save(certificate);
    }

    @Transactional
    public Certificate findCertificateBySchoolCode(String schoolCode) {
        return certificateDao.findBySchoolCode(schoolCode);
    }
    
    @Transactional
    public Certificate getCertificateById(String certificateId) {
        return certificateDao.findById(certificateId)
        .orElseThrow(() -> new RuntimeException("Certificate not found for ID: " + certificateId));
    }

    @Transactional
    public Achievement getAchievementByCertificateId(String certificateId) {
        return achievementDao.findByAchievementId(certificateId)
                .orElseThrow(() -> new RuntimeException("Achievement not found for Certificate ID"));
    }
   
}
