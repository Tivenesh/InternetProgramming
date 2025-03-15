package com.tvpss.service;

import com.tvpss.model.Achievement;
import com.tvpss.repository.AchievementDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

@Service
public class AchievementService {
	
	@Autowired
	private AchievementDao achievementDao;

	@PostConstruct
	@Transactional
	public void initializeAchievements() {
		if(achievementDao.getAllAchievements().isEmpty()) {
			achievementDao.save(new Achievement("ACH0001", "070101145678", "Ahmad bin Abdullah", "MSSD JB Badminton", "Sport Achievement", "Badminton", "Champion", "Pending", "single"));
            achievementDao.save(new Achievement("ACH0002", "050607034455", "Siti binti Ibrahim", "Singing Competition", "Cultural Achievement", "Old Folks", "Bronze", "Generated", "single"));
            achievementDao.save(new Achievement("ACH0003", "984575757577", "Lim Jing Xuan", "Essay Competition", "Academic Achievement", "English Writing", "Champion", "Pending", "single"));
            achievementDao.save(new Achievement("ACH0006", "040303006056", "Joanne Lim", "Debate Competition", "Academic Achievement", "Malay Debate", "Runner-up", "Generated", "single"));
            achievementDao.save(new Achievement("ACH0007", "083456789012", "Law Shi Jing", "Kangaroo Math", "Academic Achievement", "Math", "Participation", "Pending", "single"));

            // Multiple Achievements
            achievementDao.save(new Achievement("ACH0004", "International Olympiad Mathematical", "Academic Achievement",
                    new File("documents/math.xslx"), new File("documents/support.pdf"), "Pending", "multiple"));
            achievementDao.save(new Achievement("ACH0005", "MSSZ Athletic Tournament", "Sport Achievement",
                    new File("documents/sport.xslx"), new File("documents/support.pdf"), "Generated", "multiple"));
            achievementDao.save(new Achievement("ACH0008", "Debate Competition", "Academic Achievement",
                    new File("documents/debate.csv"), new File("documents/support.pdf"), "Pending", "multiple"));
            achievementDao.save(new Achievement("ACH0009", "STEM Innovation Competition", "Innovation Achievement",
                    new File("documents/stem.csv"), new File(""), "Generated", "multiple"));
            achievementDao.save(new Achievement("ACH0010", "Kangaroo Math", "Academic Achievement",
                    new File("documents/math.xlxs"), new File("documents/others.pdf"), "Generated", "multiple"));
		}
	}

	@Transactional
    public List<Achievement> getAllAchievements() {
        return achievementDao.getAllAchievements();
    }

	@Transactional
    public void saveAchievement(Achievement achievement) {
        Achievement existingAchievement = getAchievementByAchievementId(achievement.getAchievementId());
        if (existingAchievement != null) {
            achievementDao.save(achievement); // Uses merge internally
        } else {
            achievementDao.add(achievement); // Add new entry
        }
    }


	@Transactional
	public Achievement getAchievementByAchievementId(String achievementId) {
		return achievementDao.findByAchievementId(achievementId)
                .orElse(null);
	}
	
	@Transactional	
	public void deleteAchievement(String achievementId) {
    	achievementDao.deleteByAchievementId(achievementId);
    }

    @Transactional
	public void updateAchievement(Achievement achievement) {
		Achievement existingAchievement = getAchievementByAchievementId(achievement.getAchievementId());
		if (existingAchievement != null) {
			existingAchievement.setActivityName(achievement.getActivityName());
			existingAchievement.setCategory(achievement.getCategory());
			existingAchievement.setFormMode(achievement.getFormMode());
			existingAchievement.setStatus(achievement.getStatus());
			existingAchievement.setIcNumber(achievement.getIcNumber());
			existingAchievement.setFullName(achievement.getFullName());
			existingAchievement.setSubCategory(achievement.getSubCategory());
			existingAchievement.setAwardInfo(achievement.getAwardInfo());
			existingAchievement.setUploadDocPath(achievement.getUploadDocPath());
			existingAchievement.setSupportDocPath(achievement.getSupportDocPath());
			achievementDao.save(existingAchievement);
		}
	}

    @Transactional
    public void addAchievement(Achievement achievement) {
        System.out.println("Adding Achievement: " + achievement.getAchievementId());
        if (achievement.getActivityName() != null) {
            achievement.setActivityName(achievement.getActivityName().trim()); // Clean up activity name
        }
        achievementDao.add(achievement);
    }
}