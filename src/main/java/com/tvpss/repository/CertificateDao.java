package com.tvpss.repository;

import com.tvpss.model.Certificate;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public class CertificateDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public void save(Certificate certificate) {
        sessionFactory.getCurrentSession().saveOrUpdate(certificate);
    }

    @Transactional
    public List<Certificate> getAllCertificates() {
        return sessionFactory.getCurrentSession()
                .createQuery("from Certificate", Certificate.class).list();
    }

    @Transactional
    public Optional<Certificate> findById(String certificateId) {
        return Optional.ofNullable(sessionFactory.getCurrentSession()
                .get(Certificate.class, certificateId));
    }

    @Transactional
    public Certificate findBySchoolCode(String schoolCode) {
        return sessionFactory.getCurrentSession()
                .createQuery("from Certificate where schoolCode = :schoolCode", Certificate.class)
                .setParameter("schoolCode", schoolCode)
                .uniqueResult();
    }
}

