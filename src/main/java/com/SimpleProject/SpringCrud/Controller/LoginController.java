package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.UserModel;
import com.SimpleProject.SpringCrud.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    // Show login page
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) {
            // Already logged in, redirect to dashboard
            return "redirect:/dashboard";
        }
        return "login"; // JSP page
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session) {
        // If user is not logged in, redirect to login
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        return "dashboard"; // this should match the JSP name
    }


    // Process login
    @PostMapping("/login")
    public String loginUser(@RequestParam String username,
                            @RequestParam String password,
                            HttpSession session,
                            Model model) {

        UserModel user = userService.findByUsername(username);

        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            session.setAttribute("loggedInUser", user);
            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }

    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // clear session
        return "redirect:/login?logout=true";
    }

    // Show signup page
    @GetMapping("/signup")
    public String showSignupPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") != null) {
            // Already logged in, redirect to dashboard
            return "redirect:/dashboard";
        }
        return "signup"; // signup.jsp
    }

    // Process signup
    @PostMapping("/signup")
    public String registerUser(@RequestParam String username,
                               @RequestParam String email,
                               @RequestParam String password,
                               Model model) {

        if (userService.findByUsername(username) != null) {
            model.addAttribute("error", "Username already exists!");
            return "signup";
        }

        if (userService.findByEmail(email) != null) {
            model.addAttribute("error", "Email already registered!");
            return "signup";
        }

        UserModel newUser = new UserModel();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(passwordEncoder.encode(password)); // password encoded
        userService.registerUser(newUser);

        model.addAttribute("success", "Registration successful! Please login.");
        return "login";
    }
}