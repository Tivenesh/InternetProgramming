package com.tvpss.repository;

import com.tvpss.model.Achievement;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class AchievementDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public void save(Achievement achievement) {
        sessionFactory.getCurrentSession().merge(achievement);
    }

    @Transactional
    public List<Achievement> getAllAchievements() {
        return sessionFactory.getCurrentSession()
                .createQuery("from Achievement", Achievement.class).list();
    }

    @Transactional
    public Optional<Achievement> findByAchievementId(String achievementId) {
        return Optional.ofNullable(sessionFactory.getCurrentSession()
                .createQuery("from Achievement where achievementId = :achievementId", Achievement.class)
                .setParameter("achievementId", achievementId)
                .uniqueResult());
    }

    @Transactional
    public void deleteByAchievementId(String achievementId) {
        Achievement achievement = findByAchievementId(achievementId).orElse(null);
        if (achievement != null) {
            sessionFactory.getCurrentSession().delete(achievement);
        } else {
            System.out.println("Achievement not found for ID: " + achievementId);
        }
    }

    @Transactional
    public void add(Achievement achievement) {
        System.out.println("Persisting Achievement: " + achievement.getAchievementId());
        sessionFactory.getCurrentSession().persist(achievement);
    }
}