package com.tvpss.controller;

import java.io.IOException;
import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tvpss.model.Achievement;
import com.tvpss.model.CrewApplication;
import com.tvpss.model.School;
import com.tvpss.service.AchievementService;
import com.tvpss.service.ApplicationService;
import com.tvpss.service.SchoolService;
import com.tvpss.service.UserService;

@Controller
@RequestMapping("/adminschool") // Base path for admin school routes
@SessionAttributes("school")
public class SchoolAdminController {

    @Autowired
    private SchoolService schoolService;

    @Autowired
    private ApplicationService applicationService;

    @Autowired
    private AchievementService achievementService;
    
    @Autowired
    private UserService userService;

    // private static final String UPLOAD_DIRECTORY = "src/main/webapp/resources/static/uploads/school-logos";

    @ModelAttribute("school")
    public School school() {
        return new School();
    }

    // School Information and Dashboard Management

    @GetMapping("/dashboard")
    public String showAdminSchoolDashboard(Model model) {
    	long studentCount = userService.getUserCountByRole(5);
    	
        model.addAttribute("page", "dashboard");
        model.addAttribute("pageTitle", "Welcome Admin School!");
        model.addAttribute("studentCount", studentCount);
        model.addAttribute("totalAchievements", achievementService.getAllAchievements().size());
        model.addAttribute("numCrew", applicationService.getAllApplications().size());

        // Chart data
        model.addAttribute("chartLabels", "['21 Nov', '22 Nov', '23 Nov', '24 Nov', '25 Nov', '26 Nov', '27 Nov']");
        model.addAttribute("chartData", "[40, 30, 50, 40, 20, 30, 25]");
        model.addAttribute("genderMale", 70);
        model.addAttribute("genderFemale", 30);

        return "adminschool/dashboard"; // Maps to WEB-INF/views/adminschool/dashboard.jsp
    }

    @GetMapping("/school-information")
    public String showSchoolInformation(HttpSession session, Model model) {
        School school = schoolService.getSchool();

        if (school != null && school.getCode() != null) {
            // If school information exists, redirect to view page
            return "redirect:/adminschool/viewSchoolInformation";
        }

        model.addAttribute("school", school);
        model.addAttribute("pageTitle", "School Information");
        model.addAttribute("page", "school-information");
        return "adminschool/school-information";
    }

    @PostMapping("/save-school-information")
    public String saveSchoolInformation(
            @ModelAttribute("school") School school,
            @RequestParam(value = "logoFile", required = false) MultipartFile logoFile,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        try {
            if (logoFile != null && !logoFile.isEmpty()) {
                byte[] logoBytes = logoFile.getBytes();
                school.setLogo(logoBytes);
                school.setLogoFilename(logoFile.getOriginalFilename());
            }

            schoolService.saveSchool(school);
            redirectAttributes.addFlashAttribute("successMessage", "School information saved successfully!");
            return "redirect:/adminschool/viewSchoolInformation";

        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to upload logo: " + e.getMessage());
            return "redirect:/adminschool/school-information";
        }
    }

    @GetMapping("/viewSchoolInformation")
    public String viewSchoolInformation(Model model) {
        School school = schoolService.getSchool();
        model.addAttribute("school", school);
        model.addAttribute("page", "school-information");
        model.addAttribute("pageTitle", "School Information");
        return "adminschool/viewSchoolInformation";
    }

    @GetMapping("/saveSchoolDB")
    public String saveToDatabase(HttpSession session, RedirectAttributes redirectAttributes) {
        School school = (School) session.getAttribute("school");
        schoolService.saveSchool(school);
        redirectAttributes.addFlashAttribute("message", "School details saved successfully.");
        return "redirect:/adminschool/school-information";
    }

    @GetMapping("/school-logo/{schoolCode}")
    @ResponseBody
    public ResponseEntity<byte[]> getSchoolLogo(@PathVariable String schoolCode) {
        School school = schoolService.getSchoolBySchoolCode(schoolCode);
        
        if (school != null && school.getLogo() != null) {
            HttpHeaders headers = new HttpHeaders();
            
            // Detect file type based on filename extension
            String logoFilename = school.getLogoFilename();
            if (logoFilename != null) {
                if (logoFilename.endsWith(".jpg") || logoFilename.endsWith(".jpeg")) {
                    headers.setContentType(MediaType.IMAGE_JPEG);
                } else if (logoFilename.endsWith(".png")) {
                    headers.setContentType(MediaType.IMAGE_PNG);
                } else if (logoFilename.endsWith(".gif")) {
                    headers.setContentType(MediaType.IMAGE_GIF);
                } else {
                    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM); // Default for unknown types
                }
            } else {
                headers.setContentType(MediaType.IMAGE_PNG);  // Fallback to PNG
            }

            return new ResponseEntity<>(school.getLogo(), headers, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/edit-school")
    public String editSchoolInformation(Model model) {
    School school = schoolService.getSchool();

    if (school != null && school.getCode() != null) {
        model.addAttribute("school", school);  // Load existing data for editing
    } else {
        model.addAttribute("school", new School());
    }

    model.addAttribute("pageTitle", "Edit School Information");
    model.addAttribute("page", "school-information");
    return "adminschool/school-information";  // Same JSP page but used for editing
}


 // Achievement Management

    @GetMapping("/student-achievement")
    public String viewAchievements(Model model) {
        List<Achievement> achievements = achievementService.getAllAchievements();
        model.addAttribute("achievements", achievements);
        model.addAttribute("page", "student-achievement");
        model.addAttribute("pageTitle", "Student Achievements");
        return "adminschool/student-achievement";
    }

    @GetMapping("/submit-achievement")
    public String showSubmitAchievementForm(Model model) {
        model.addAttribute("achievement", new Achievement());
        model.addAttribute("pageTitle", "Student Achievements");
        model.addAttribute("achievementTitle", "Add Student Achievement");
        model.addAttribute("isEdit", false);
        return "adminschool/submit-achievement";
    }
    
    @GetMapping("/edit-achievement")
    public String editStudentAchievement(@RequestParam("id") String achievementId, Model model) {
        Achievement achievement = achievementService.getAchievementByAchievementId(achievementId);
        
        if (achievement == null) {
            return "redirect:/adminschool/student-achievement";
        }
        
        model.addAttribute("achievement", achievement);
        model.addAttribute("pageTitle", "Student Achievements");
        model.addAttribute("achievementTitle", "Edit Student Achievement");
        model.addAttribute("page", "submit-achievement");
        model.addAttribute("isEdit", true);
        
        return "adminschool/submit-achievement";
    }

    @GetMapping("/view-achievement")
    public String viewAchievement(@RequestParam("id") String achievementId, Model model) {
        Achievement achievement = achievementService.getAchievementByAchievementId(achievementId);

                if (achievement == null) {
                    return "redirect:/adminschool/student-achievement";
                }

        model.addAttribute("achievement", achievement);
        model.addAttribute("pageTitle", "Student Achievements");
        model.addAttribute("achievementTitle", "View Student Achievement");
        return "adminschool/view-achievement";
    }
    
    @PostMapping("/submit-achievement")
    public String handleAchievementSubmission(
    		@RequestParam(value = "formMode", required = false) String formMode,
            @RequestParam(value = "achievementId", required = false) String achievementId,
            @RequestParam(value = "icNumber", required = false) String icNumber,
            @RequestParam(value = "fullName", required = false) String fullName,
            @RequestParam(value = "activityName", required = false) String activityName,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "subCategory", required = false) String subCategory,
            @RequestParam(value = "awardInfo", required = false) String awardInfo,
            @RequestParam(value = "uploadDoc", required = false) MultipartFile uploadDoc,
            @RequestParam(value = "supportDoc", required = false) MultipartFile[] supportDoc,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {

        try {

        	if (achievementId != null && !achievementId.isEmpty()) {
                Achievement existingAchievement = achievementService.getAchievementByAchievementId(achievementId);
                if (existingAchievement != null) {
                    existingAchievement.setIcNumber(icNumber);
                    existingAchievement.setFullName(fullName);
                    // Check the form mode and apply the corresponding logic
                if ("single".equalsIgnoreCase(existingAchievement.getFormMode())) {
                    existingAchievement.setActivityName(activityName != null ? activityName.trim().replaceAll(",$", "") : null);
                } else if ("multiple".equalsIgnoreCase(existingAchievement.getFormMode())) {
                    existingAchievement.setActivityName(activityName != null ? activityName.trim().replaceAll("^,", "") : null);
                }
                    existingAchievement.setCategory(category);
                    existingAchievement.setSubCategory(subCategory);
                    existingAchievement.setAwardInfo(awardInfo);
                    
                    achievementService.updateAchievement(existingAchievement);
                    redirectAttributes.addFlashAttribute("successMessage", "Achievement updated successfully!");
                    return "redirect:/adminschool/student-achievement";
                }
            }
        	
            if ("single".equalsIgnoreCase(formMode)) {
                Achievement singleAchievement = new Achievement();
                singleAchievement.setAchievementId(generateUniqueId());
                singleAchievement.setIcNumber(icNumber);
                singleAchievement.setFullName(fullName);
                singleAchievement.setActivityName(activityName != null ? activityName.trim().replaceAll(",$", "") : null);
                singleAchievement.setCategory(category);
                singleAchievement.setSubCategory(subCategory);
                singleAchievement.setAwardInfo(awardInfo);
                singleAchievement.setFormMode("single");
                singleAchievement.setStatus("Pending");
                achievementService.addAchievement(singleAchievement);

            } else if ("multiple".equalsIgnoreCase(formMode)) {
                Achievement multipleAchievement = new Achievement();
                multipleAchievement.setAchievementId(generateUniqueId());
                multipleAchievement.setActivityName(activityName != null ? activityName.trim().replaceAll("^,", "") : null);
                multipleAchievement.setCategory(category);
                multipleAchievement.setFormMode("multiple");
                multipleAchievement.setStatus("Pending");

                if (uploadDoc != null && !uploadDoc.isEmpty()) {
                    File savedCsvFile = saveUploadedFile(uploadDoc, request);
                    multipleAchievement.setUploadDocPath(savedCsvFile);
                }

                if (supportDoc != null) {
                    for (MultipartFile file : supportDoc) {
                        if (!file.isEmpty()) {
                            saveUploadedFile(file, request);
                        }
                    }
                }

                achievementService.addAchievement(multipleAchievement);
            }
            redirectAttributes.addFlashAttribute("successMessage", "Achievement added successfully!");
            return "redirect:/adminschool/student-achievement";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "An error occurred: " + e.getMessage());
            return "redirect:/adminschool/submit-achievement";
        }
    }

    private String generateUniqueId() {
    	int count = achievementService.getAllAchievements().size() + 1; 
        return String.format("ACH%04d", count);
    }

    private File saveUploadedFile(MultipartFile file, HttpServletRequest request) throws IOException {
        String uploadDir = request.getServletContext().getRealPath("/resources/uploads");
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
        File uploadedFile = new File(uploadDir, file.getOriginalFilename());
        file.transferTo(uploadedFile);
        return uploadedFile;
    }
    
    @PostMapping("/add-achievement")
    public String saveAchievementApplication(
            @ModelAttribute("achievement") Achievement achievements,
            RedirectAttributes redirectAttributes) {

    	achievementService.saveAchievement(achievements);
            redirectAttributes.addFlashAttribute("successMessage", "School information saved successfully!");
            return "redirect:/adminschool/student-achievement";

    }

    @PostMapping("/delete-achievement")
    public String deleteAchievement(@RequestParam("achievementId") String achievementId, RedirectAttributes redirectAttributes) {
        try {
            achievementService.deleteAchievement(achievementId);
            redirectAttributes.addFlashAttribute("success", "Achievement deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete achievement: " + e.getMessage());
        }
        return "redirect:/adminschool/student-achievement?success=true";
    }


    
    // Crew Application Management

    @GetMapping("/crew-application")
    public String getCrewApplications(Model model) {
        List<CrewApplication> applications = applicationService.getAllApplications();
        model.addAttribute("page", "crew-application");
        model.addAttribute("pageTitle", "Crew Application");
        model.addAttribute("applications", applications);
        return "adminschool/crew-application";
    }

    @GetMapping("/viewApplication")
    public String viewApplication(@RequestParam("id") Long applicationId, Model model) {
        CrewApplication application = applicationService.getApplicationById(applicationId);
        if (application == null) {
            model.addAttribute("errorMessage", "Application not found!");
            return "redirect:/adminschool/dashboard";
        }
        model.addAttribute("application", application);
        return "adminschool/viewApplication";
    }

    @PostMapping("/updateStatus")
    public String updateApplicationStatus(
            @RequestParam("applicationIds") List<Long> applicationIds,
            @RequestParam("status") String status,
            RedirectAttributes redirectAttributes) {

        for (Long applicationId : applicationIds) {
            applicationService.updateApplicationStatus(applicationId, status);
        }

        redirectAttributes.addFlashAttribute("message", "Applications have been updated successfully!");
        return "redirect:/adminschool/crew-application";
    }

    @GetMapping("/searchApplication")
    public String searchApplications(@RequestParam String search, Model model) {
        List<CrewApplication> results = applicationService.searchApplications(search);
        model.addAttribute("applications", results);
        return "adminschool/crew-application";
    }

    @GetMapping("/submittvpssversion")
    public String showTvpssVersionForm(HttpSession session, Model model) {
        School school = (School) session.getAttribute("school");

        model.addAttribute("page", "tvpss-version");
        model.addAttribute("school", school);
        model.addAttribute("pageTitle", "Submit TVPSS Version");
        return "adminschool/submittvpssversion";
    }
    
    
    @PostMapping("/view-submitted-tvpss-form")
    public String viewSubmittedTvpssForm(
            @ModelAttribute("school") School school,
            Model model) {
        model.addAttribute("school", school);
        return "adminschool/viewSubmittedTvpssForm"; // Path relative to /WEB-INF/view/
    }
    
    @PostMapping("/save-tvpss-version")
    public String saveTvpssVersion(
            @ModelAttribute("school") School school,
            @RequestParam("connerminittv") String connerminittv,
            @RequestParam("recordingEquipment") String recordingEquipment,
            @RequestParam("greenScreenTechnology") String greenScreenTechnology,
            @RequestParam("collaborationExternalAgencies") String collaborationExternalAgencies,
            RedirectAttributes redirectAttributes) {

        // Additional fields handling
        school.setConnerminittv(connerminittv);
        school.setRecordingEquipment(recordingEquipment);
        school.setGreenScreenTechnology(greenScreenTechnology);
        school.setCollaborationExternalAgencies(collaborationExternalAgencies);

        schoolService.saveSchool(school);
        redirectAttributes.addFlashAttribute("successMessage", "TVPSS version submitted successfully!");
        return "redirect:/adminschool/viewSchoolInformation";
    }

}
