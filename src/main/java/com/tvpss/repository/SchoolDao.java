package com.tvpss.repository;

import com.tvpss.model.School;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

@Repository
public class SchoolDao {

    @Autowired
    private SessionFactory sessionFactory;
    
    @Transactional
    public long countActiveSchools() {
        return (long) sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(s) FROM School s WHERE s.versionStatus = 'Active'")
                .uniqueResult();
    }

    @Transactional
    public long countInactiveSchools() {
        return (long) sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(s) FROM School s WHERE s.versionStatus = 'Inactive'")
                .uniqueResult();
    }

    @Transactional
    public void saveOrUpdate(School school) {
        Session session = sessionFactory.getCurrentSession();
        School existingSchool = session.get(School.class, school.getCode());

        if (existingSchool != null) {
            // Update fields only if they are not null
            if (existingSchool.getTvpssVersion() == null) {
                existingSchool.setTvpssVersion(0);
            }
    
            // Update other fields
            if (school.getVersionStatus() != null) {
                existingSchool.setVersionStatus(school.getVersionStatus());
            }
            if (school.getTvpssVersion() != null) {
                existingSchool.setTvpssVersion(school.getTvpssVersion());
            }

            if (school.getVersionStatus() != null) {
                existingSchool.setVersionStatus(school.getVersionStatus());
            }
            if (school.getTvpssVersion() != null) {
                existingSchool.setTvpssVersion(school.getTvpssVersion());
            }
            if (school.getConnerminittv() != null) {
                existingSchool.setConnerminittv(school.getConnerminittv());
            }
            if (school.getRecordingEquipment() != null) {
                existingSchool.setRecordingEquipment(school.getRecordingEquipment());
            }
            if (school.getGreenScreenTechnology() != null) {
                existingSchool.setGreenScreenTechnology(school.getGreenScreenTechnology());
            }
            if (school.getCollaborationExternalAgencies() != null) {
                existingSchool.setCollaborationExternalAgencies(school.getCollaborationExternalAgencies());
            }
            if (school.getStudio() != null) {
                existingSchool.setStudio(school.getStudio());
            }
            if (school.getRecordingInSchool() != null) {
                existingSchool.setRecordingInSchool(school.getRecordingInSchool());
            }
            if (school.getRecordingInOutSchool() != null) {
                existingSchool.setRecordingInOutSchool(school.getRecordingInOutSchool());
            }

            // Save changes
            session.merge(existingSchool);
        } else {
            // Save as new if school doesn't exist
            if (school.getTvpssVersion() == null) {
                school.setTvpssVersion(0); // Default version
            }
            session.save(school);
        }
    }

    @Transactional
    public Optional<School> findByCode(String schoolCode) {
        return Optional.ofNullable(sessionFactory.getCurrentSession().get(School.class, schoolCode));
    }
    
    @Transactional
    public void updateVersionStatus(String schoolCode, String versionStatus) {
        Session session = sessionFactory.getCurrentSession();
        School school = session.get(School.class, schoolCode);
        if (school != null) {
            school.setVersionStatus(versionStatus);
            session.update(school);
        }
    }
    

    @Transactional
    public long countTotalSchools() {
        return (long) sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(s) FROM School s")
                .uniqueResult();
    }

    
    @Transactional
    public List<School> getAllSchools() {
        return findAll();
    }

    @Transactional
    public List<School> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM School", School.class)
                .list();
    }


    



    @Transactional
    public Optional<School> findById(String schoolCode) {
        return Optional.ofNullable(sessionFactory.getCurrentSession().get(School.class, schoolCode));
    }

    @Transactional
    public Optional<School> findBySchoolCode(String schoolCode) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM School s WHERE s.schoolCode = :schoolCode", School.class)
                .setParameter("schoolCode", schoolCode)
                .uniqueResultOptional();
    }

   
    @Transactional
    public School getSchoolById(Long id) {
        return sessionFactory.getCurrentSession().get(School.class, id);
    }

    
    @Transactional
    public School getSchoolBySchoolCode(String schoolCode) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM School s WHERE s.code = :schoolCode", School.class)
                .setParameter("schoolCode", schoolCode)
                .uniqueResult();
    }

    
    @Transactional
    public School getSchoolInfo() {
        try {
            return sessionFactory.getCurrentSession()
                    .createQuery("FROM School", School.class)
                    .setMaxResults(1)
                    .uniqueResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Transactional
    public void deleteById(Long id) {
        Session session = sessionFactory.getCurrentSession();
        School school = session.get(School.class, id);
        if (school != null) {
            session.delete(school);
        }
    }
}