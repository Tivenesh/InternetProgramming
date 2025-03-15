package com.tvpss.service;

import com.tvpss.model.Achievement;
import com.tvpss.model.Certificate;
import com.tvpss.repository.AchievementDao;
import com.tvpss.repository.CertificateDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

@Service
public class GenerateService {
    @Autowired
    private CertificateDao certificateDao;

    @Autowired
    private AchievementDao achievementDao;

    // Get all certificates
    @Transactional
    public List<Certificate> getAllCertificates() {
        return certificateDao.getAllCertificates();
    }

    // Add a new certificate
    @Transactional
    public void addCertificate(Certificate certificate) {
        certificateDao.save(certificate);
    }

    @SuppressWarnings("hiding")
    @Transactional
    public <Optional>Certificate findCertificateBySchoolCode(String schoolCode) {
        return certificateDao.findBySchoolCode(schoolCode);
    }    
    
    @Transactional
    public Optional<Certificate> getCertificateById(String certificateId) {
        return certificateDao.findById(certificateId);
    }

    @Transactional
    public Optional<Achievement> getAchievementByCertificateId(String certificateId) {
        return achievementDao.findByAchievementId(certificateId);
    }

    @Transactional
    public void initializeCertificatesAndAchievements() {
        if (certificateDao.getAllCertificates().isEmpty()) {
            // Initialize Certificates
            certificateDao.save(new Certificate("SA1001", "SCH001", "SJK (C) Kuo Kuang 2", "Sport Achievement", "Single", "Pending"));
            certificateDao.save(new Certificate("MA1001", "SCH002", "SK Impian Emas", "Academic Achievement", "Multiple", "Generated"));
            certificateDao.save(new Certificate("MA1002", "SCH003", "SK Taman Universiti", "Sport Achievement", "Single", "Pending"));
            certificateDao.save(new Certificate("SA1002", "SCH004", "SK Mutiara Rini", "Singing Competition", "Multiple", "Generated"));
            certificateDao.save(new Certificate("SA1003", "SCH005", "SK Taman Sri Pulai", "Essay Competition", "Single", "Pending"));

            // Initialize Achievements
            achievementDao.save(new Achievement("SA1001", "070101145678", "Ahmad bin Abdullah", "MSSD JB Badminton", "Sport Achievement", "Badminton", "Champion", "Pending", "Single"));
            achievementDao.save(new Achievement("MA1001", "International Olympiad Mathematical", "Academic Achievement", new File("documents/math.xlsx"), new File("documents/support.pdf"), "Pending", "Multiple"));
            achievementDao.save(new Achievement("MA1002", "MSSZ Athletic Tournament", "Sport Achievement", new File("documents/sport.xlsx"), new File("documents/support.pdf"), "Generated", "Multiple"));
            achievementDao.save(new Achievement("SA1002", "050607034455", "Siti binti Ibrahim", "Singing Competition", "Cultural Achievement", "Old Folks", "Bronze", "Generated", "Single"));
            achievementDao.save(new Achievement("SA1003", "984575757577", "Lim Jing Xuan", "Essay Competition", "Academic Achievement", "English Writing", "Champion", "Pending", "Single"));
        }
    }
   
}
