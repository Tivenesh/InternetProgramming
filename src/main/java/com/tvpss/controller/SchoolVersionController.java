package com.tvpss.controller;

import com.tvpss.model.SchoolVersion;
import com.tvpss.service.SchoolVersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/schoolVersion")
public class SchoolVersionController {

    @Autowired
    private SchoolVersionService schoolVersionService;
  

    @GetMapping("/view")
    public String viewSchoolVersions(Model model) {
        List<SchoolVersion> versions = schoolVersionService.getAllVersions();
        System.out.println("Controller sending versions: " + versions); // Debug log
        model.addAttribute("versions", versions);
        return "adminstate/view"; // Points to /WEB-INF/view/adminstate/view.jsp
    }


    @GetMapping("/dashboard")
    public String viewDashboard(Model model) {
        model.addAttribute("totalApplications", schoolVersionService.getTotalApplications());
        model.addAttribute("verifiedSchools", schoolVersionService.getVerifiedSchoolsCount());
        model.addAttribute("pendingApprovals", schoolVersionService.getPendingApprovalsCount());
        return "adminstate/dashboard"; // Points to /WEB-INF/view/adminstate/dashboard.jsp
    }

    @GetMapping("/details/{schoolCode}")
    public String viewSchoolDetails(@PathVariable String schoolCode, Model model) {
        SchoolVersion schoolVersion = schoolVersionService.getVersionBySchoolCode(schoolCode);
        if (schoolVersion == null) {
            return "redirect:/schoolVersion/view"; // Redirect to view if invalid code
        }
        model.addAttribute("school", schoolVersion);
        return "adminstate/details"; // Points to /WEB-INF/view/adminstate/details.jsp
    }

    @PostMapping("/notify")
    public String sendUpdateNotification(@RequestParam("schoolCode") String schoolCode) {
        // Logic for notification handling
        System.out.println("Notification sent for school: " + schoolCode);
        return "redirect:/schoolVersion/dashboard";
    }
    
    @PostMapping("/verify/{schoolCode}")
    public String verifySchoolVersion(@PathVariable String schoolCode, 
                                      @RequestParam("action") String action, 
                                      RedirectAttributes redirectAttributes) {

        if (action.equals("approve")) {
            schoolVersionService.approveVersion(schoolCode);
            redirectAttributes.addFlashAttribute("success", "Version approved for school " + schoolCode);
        } else if (action.equals("reject")) {
            schoolVersionService.rejectVersion(schoolCode);
            redirectAttributes.addFlashAttribute("success", "Version rejected for school " + schoolCode);
        }
        return "redirect:/adminppd/schoolValidation"; // Redirect back to school validation
    }
}

