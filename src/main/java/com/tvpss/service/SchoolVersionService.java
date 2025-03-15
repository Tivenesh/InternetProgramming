package com.tvpss.service;

import com.tvpss.model.SchoolVersion;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SchoolVersionService {

    // Initialize the list here
    private List<SchoolVersion> versions = new ArrayList<>();

    // Constructor to populate sample data
    public SchoolVersionService() {
        versions.add(new SchoolVersion("SCH001", "SMK Air Tawar", "Kota Tinggi", "Pending", "Cik Zurina Binti Hanapi", "Inactive", 1));
        versions.add(new SchoolVersion("SCH002", "SMK Ayer Baloi", "Ayer Baloi", "Verified", "En. Yusri Bin Muhammad", "Active", 2));
        versions.add(new SchoolVersion("SCH003", "SMK Banang Jaya", "Batu Pahat", "Active", "Pn. Zalina Binti Abdullah", "Active", 3));

        // Debug log
        System.out.println("SchoolVersionService initialized with: " + versions);
    }

    // Method to get all versions
    public List<SchoolVersion> getAllVersions() {
        System.out.println("Returning all school versions: " + versions);
        return new ArrayList<>(versions); // Defensive copy
    }

    // Add the required method
    public List<SchoolVersion> getAllSchoolVersions() {
        return getAllVersions(); // Reusing the existing method
    }

    public boolean updateVersionStatus(String schoolCode, int newVersion) {
        SchoolVersion version = getVersionBySchoolCode(schoolCode);
        if (version != null) {
            if (newVersion > version.getVersion()) { // Only allow upgrades
                version.setVersion(newVersion);
                version.setVersionStatus("Active");
                return true;
            }
        }
        return false;
    }

    // Method to get a version by school code
    public SchoolVersion getVersionBySchoolCode(String schoolCode) {
        return versions.stream()
                .filter(v -> v.getSchoolCode().equalsIgnoreCase(schoolCode))
                .findFirst()
                .orElse(null);
    }

    public int getTotalApplications() {
        return versions.size();
    }

    public long getVerifiedSchoolsCount() {
        return versions.stream()
                .filter(v -> "Verified".equalsIgnoreCase(v.getVersionStatus()))
                .count();
    }

    public long getPendingApprovalsCount() {
        return versions.stream()
                .filter(v -> "Pending".equalsIgnoreCase(v.getVersionStatus()))
                .count();
    }

    public void addSchoolVersion(SchoolVersion schoolVersion) {
        versions.add(schoolVersion);
    }

    public boolean deleteSchoolVersion(String schoolCode) {
        return versions.removeIf(version -> version.getSchoolCode().equalsIgnoreCase(schoolCode));
    }

    public List<SchoolVersion> searchSchoolVersions(String keyword) {
        String lowerCaseKeyword = keyword.toLowerCase();
        return versions.stream()
                .filter(version -> version.getSchoolCode().toLowerCase().contains(lowerCaseKeyword) ||
                        version.getSchoolName().toLowerCase().contains(lowerCaseKeyword) ||
                        version.getDistrict().toLowerCase().contains(lowerCaseKeyword) ||
                        version.getContactPerson().toLowerCase().contains(lowerCaseKeyword))
                .toList();
    }

    public void approveVersion(String schoolCode) {
        SchoolVersion version = getVersionBySchoolCode(schoolCode);
        if (version != null) {
            version.setVersionStatus("Verified");
            version.setStatus("Active");
        }
    }

    public void rejectVersion(String schoolCode) {
        SchoolVersion version = getVersionBySchoolCode(schoolCode);
        if (version != null) {
            version.setVersionStatus("Rejected");
            version.setStatus("Inactive");
        }
    }
}
