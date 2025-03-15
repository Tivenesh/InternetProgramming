package com.tvpss.controller;
import com.tvpss.model.UserRoles;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class LoginController {

    @GetMapping("/")
    public String redirectToLogin() {
        return "redirect:/login";  // Redirect to login when accessing the root URL
    }
    
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Display login.jsp
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Integer role = (Integer) session.getAttribute("role");
        // Redirect to the specific dashboard based on role
        if (role != null) {
            switch (role) {
            case UserRoles.SUPER_ADMIN:
                return "redirect:/superadmin/dashboard";
            case UserRoles.ADMIN_PPD:
                return "redirect:/adminppd/dashboard";
            case UserRoles.ADMIN_STATE:
                return "redirect:/adminstate/dashboard";
            case UserRoles.ADMIN_SCHOOL:
                return "redirect:/adminschool/dashboard";
            case UserRoles.STUDENT:
                return "redirect:/student/dashboard";
                default:
                    model.addAttribute("error", "Role not recognized.");
                    return "login";
            }
        }
        model.addAttribute("error", "Access Denied.");
        return "login";
    }
    
   

}