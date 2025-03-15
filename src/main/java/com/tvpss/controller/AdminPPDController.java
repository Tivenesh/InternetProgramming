package com.tvpss.controller;

import com.tvpss.model.School;
import com.tvpss.repository.SchoolDao;
import com.tvpss.service.SchoolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/adminppd")
public class AdminPPDController {

    @Autowired
    private SchoolService schoolService;
    
    @Autowired
    private SchoolDao schoolDao;

    /**
     * Dashboard for Admin PPD.
     */
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
    	
    	long activeSchools = schoolDao.countActiveSchools();
        long inactiveSchools = schoolDao.countInactiveSchools();
    	long totalSchools = schoolService.getTotalSchools();
    	
    	model.addAttribute("activeSchools", activeSchools);
        model.addAttribute("pendingValidations", inactiveSchools);
        model.addAttribute("totalSchools", totalSchools);
        
        return "adminppd/dashboard";
    }

    /**
     * Display School TVPSS Validation list.
     */
    @GetMapping("/schoolValidation")
    public String schoolValidation(Model model) {
        List<School> schools = schoolService.getAllSchools();
        model.addAttribute("schools", schools);
        return "adminppd/schoolValidation";
    }

    @PostMapping("/updateSchool")
    public String updateSchool(@RequestParam String schoolCode,
                               @RequestParam String schoolOfficerName, // New field
                               RedirectAttributes redirectAttributes) {
        School school = schoolService.getSchoolBySchoolCode(schoolCode);
        if (school != null) {
            school.setSchoolOfficerName(schoolOfficerName);
            schoolService.saveOrUpdate(school);
            redirectAttributes.addFlashAttribute("successMessage", "School updated successfully.");
        }
        return "redirect:/adminppd/schoolValidation";
    }

    /**
     * Display details of a specific school.
     *
     * @param schoolCode The school code to look up details.
     * @param model      Model to pass data to the view.
     * @return School details page.
     */
    @GetMapping("/schoolDetails")
    public String schoolDetails(@RequestParam("schoolCode") String schoolCode, Model model) {
        School school = schoolService.getSchoolBySchoolCode(schoolCode);
        if (school == null) {
            model.addAttribute("errorMessage", "No school found with the provided code.");
            return "adminppd/schoolValidation";
        }
        model.addAttribute("school", school);
        return "adminppd/schoolDetails";
    }


    /**
     * Update the details of a school.
     *
     * @param schoolCode          The school code to update.
     * @param collaborationExternalAgencies
     * @param tvpssLogo           Whether the school has uploaded a TVPSS logo.
     * @param studio              Whether the school has a TV studio.
     * @param youtubeUpload       Whether the school uploads to YouTube.
     * @param recordingInSchool   Whether the school supports in-school recording.
     * @param recordingInOutSchool Whether the school supports in and out of school recording.
     * @param redirectAttributes  Attributes for flash messages.
     * @return Redirect to school details page with updates.
     */
    @PostMapping("/updateVersionStatus")
    public String updateVersionStatus(@RequestParam String schoolCode,
                                      @RequestParam String versionStatus,
                                      RedirectAttributes redirectAttributes) {
        School school = schoolService.getSchoolBySchoolCode(schoolCode);
        if (school != null) {
            school.setVersionStatus(versionStatus);
            schoolService.saveOrUpdate(school);
            redirectAttributes.addFlashAttribute("successMessage", "Version status updated successfully.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "School not found.");
        }
        return "redirect:/adminppd/schoolValidation";
    }

    @PostMapping("/updateTvpssVersion")
    public String updateTvpssVersion(@RequestParam String schoolCode,
                                     @RequestParam Integer tvpssVersion,
                                     @RequestParam(required = false) String studio,
                                     @RequestParam(required = false) String recordingInSchool,
                                     @RequestParam(required = false) String recordingInOutSchool,
                                     RedirectAttributes redirectAttributes) {
        School school = schoolService.getSchoolBySchoolCode(schoolCode);
        if (school != null) {
            school.setTvpssVersion(tvpssVersion);  // Set new version
            school.setStudio(studio != null ? "Yes" : "No"); // Handle checkboxes
            school.setRecordingInSchool(recordingInSchool != null ? "Yes" : "No");
            school.setRecordingInOutSchool(recordingInOutSchool != null ? "Yes" : "No");
            schoolService.saveOrUpdate(school);    // Save to database
            redirectAttributes.addFlashAttribute("successMessage", "TVPSS version updated successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "School not found.");
        }
        return "redirect:/adminppd/schoolDetails?schoolCode=" + schoolCode;
    }

    /**
     * Redirect to updated school details after update.
     *
     * @param updatedSchool The updated school details.
     * @param model         Model to pass data to the view.
     * @return Updated school details page.
     */
    @GetMapping("/updatedSchoolDetails")
    public String updatedSchoolDetails(@ModelAttribute("updatedSchool") School updatedSchool, Model model) {
        if (updatedSchool == null) {
            model.addAttribute("errorMessage", "No updated school information available.");
            return "redirect:/adminppd/schoolValidation";
        }
        model.addAttribute("updatedSchool", updatedSchool);
        return "adminppd/schoolDetails";
    }
    
    @PostMapping("/validateSchool")
    public String validateSchool(
        @RequestParam String schoolCode,
        @RequestParam boolean isValid,
        RedirectAttributes redirectAttributes
    ) {
        School school = schoolService.getSchoolBySchoolCode(schoolCode);
        if (school != null) {
            schoolService.updateVersionStatus(school, isValid);
            redirectAttributes.addFlashAttribute("successMessage", "School version status updated successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "School not found.");
        }
        return "redirect:/adminppd/schoolValidation";
    }

    
}

