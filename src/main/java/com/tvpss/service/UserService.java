package com.tvpss.service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.tvpss.model.User;
import com.tvpss.model.UserRoles;
import com.tvpss.repository.UserDao;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostConstruct
    @Transactional
    public void initializeUsers() {
        if(userDao.findAllUsers().isEmpty()) { 
            userDao.save(new User("superadmin", passwordEncoder.encode("super123"), UserRoles.SUPER_ADMIN, "Selangor", "superadmin@tvpss.com", true));
            userDao.save(new User("adminppd", passwordEncoder.encode("ppd123"), UserRoles.ADMIN_PPD, "Johor", "adminppd@tvpss.com", true));
            userDao.save(new User("adminstate", passwordEncoder.encode("state123"), UserRoles.ADMIN_STATE, "Melaka", "adminstate@tvpss.com", true));
            userDao.save(new User("adminschool", passwordEncoder.encode("school123"), UserRoles.ADMIN_SCHOOL, "Kedah", "adminschool@tvpss.com", true));
            userDao.save(new User("student", passwordEncoder.encode("student123"), UserRoles.STUDENT, "Penang", "student@tvpss.com", true));
            userDao.save(new User("qiqi03", passwordEncoder.encode("chuaqi123"), UserRoles.STUDENT, "Johor", "chloee031023@gmail.com", true));
            userDao.save(new User("joyce1019", passwordEncoder.encode("joyce123"), UserRoles.STUDENT, "Johor", "joyce031019@gmail.com", true));
            userDao.save(new User("denies0516", passwordEncoder.encode("denies123"), UserRoles.STUDENT, "Johor", "denies0516@gmail.com", true));
            userDao.save(new User("enting0601", passwordEncoder.encode("enting123"), UserRoles.STUDENT, "Johor", "enting0601@gmail.com", true));
            userDao.save(new User("tingfang0416", passwordEncoder.encode("tingfang123"), UserRoles.STUDENT, "Johor", "ttf0416@gmail.com", true));
            userDao.save(new User("zyii0905", passwordEncoder.encode("zyii123"), UserRoles.STUDENT, "Johor", "zyiibusytoeat@gmail.com", true));
        }
    }
   
    @Transactional
    public long getUserCountByRole(int role) {
        return userDao.countUsersByRole(role);
    }
    
    @Transactional
    public User findByUsernameAndPassword(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null; // Return null if credentials don't match
    }

    @Transactional
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }
    
    @Transactional
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Transactional
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }
    
    @Transactional
    public boolean isUsernameExists(String username) {
        User user = userDao.findByUsername(username);
        return user != null;  // Returns true if the user already exists.
    }
    
    @Transactional
    public boolean isEmailExists(String email) {
        User user = userDao.findByEmail(email);
        return user != null;
    }

    @Transactional
    public void addUser(String username, String email, int role, String state, String password, boolean enabled) {
        User user = userDao.findByUsername(username);
        if (user != null) {
            throw new RuntimeException("Username already exists");
        }
        String encryptedPassword = passwordEncoder.encode(password);
        user = new User(username, encryptedPassword, role, state, email, enabled);
        userDao.save(user);
    }


    @Transactional
    public void updateUser(String username, String email, int role, String state) {
        User user = userDao.findByUsername(username);
        if (user != null) {
            user.setEmail(email);
            user.setRole(role);
            user.setState(state);
            userDao.save(user);  // Save after updating
            
            User existingUserWithEmail = userDao.findByEmail(email);
            
            // Check if another user already has this email
            if (existingUserWithEmail != null && !existingUserWithEmail.getUsername().equals(username)) {
                throw new RuntimeException("Email is already in use by another account.");
            }

            user.setEmail(email);
            user.setRole(role);
            user.setState(state);
            userDao.save(user);  // Save after updating
        }
    }

    @Transactional
    public void deleteUser(String username) {
        userDao.deleteByUsername(username);
    }
}