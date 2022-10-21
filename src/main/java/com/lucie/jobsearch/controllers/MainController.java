package com.lucie.jobsearch.controllers;

import com.lucie.jobsearch.models.Job;
import com.lucie.jobsearch.models.LoginUser;
import com.lucie.jobsearch.models.User;
import com.lucie.jobsearch.services.JobService;
import com.lucie.jobsearch.services.UserService;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

@Controller
public class MainController {
    @Autowired
    private UserService userService;

    @Autowired
    private JobService jobService;


    @GetMapping("/index")
    public String index(Model model) {
        // Bind empty User and LoginUser objects to the JSP to capture the form input
        model.addAttribute("newLogin", new LoginUser());
        return "index.jsp";
    }

    @GetMapping("/register/page")
    public String registerPage(Model model) {
        // Bind empty User and LoginUser objects to the JSP to capture the form input
        model.addAttribute("newUser", new User());
        return "register.jsp";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {

        User user = userService.register(newUser, result);

        if(result.hasErrors()) {
            // Be sure to send in the empty LoginUser before re-rendering the page.
            model.addAttribute("newLogin", new LoginUser());
            return "index.jsp";
        }

        session.setAttribute("userId", user.getId());

        return "redirect:/json";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {

        User user = userService.login(newLogin, result);

        if(result.hasErrors() || user==null) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        }

        session.setAttribute("userId", user.getId());

        return "redirect:/json";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {

        // Set userId to null and redirect to login/register page
        session.setAttribute("userId", null);

        return "redirect:/";
    }

    @GetMapping("/json")
    public String json(HttpSession session){
        Long userId = (Long) session.getAttribute("userId");
        User user = (User) userService.findById(userId);

        List<Job> jobs = jobService.allJobsByUser(user);

        //CREATE HASH MAP, Label: DATE, Value: COUNT
        Map<Date,Integer> countMap=new HashMap<>();
        for(Job job:jobs){
            if(job.getAppliedOn() != null){
                countMap.merge(job.getAppliedOn(), 1, Integer::sum);
            }
        }

        // BUILD JSON
        JSONObject json = new JSONObject(countMap);

        // BUILD JSON FILE
        try {
            FileWriter file = new FileWriter("src/main/resources/static/json/output.json");
            file.write(json.toString());
            file.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        // SEND DATA TO SESSION
//        Long userId = (Long) session.getAttribute("userId");
        session.setAttribute("jsonData", json);
        session.setAttribute("countMap", countMap);

        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        User user = (User) userService.findById(userId);
        List<Job> usersJobs = jobService.allJobsByUser(user);
        model.addAttribute("jobs", usersJobs);

        JSONObject json = (JSONObject) session.getAttribute("jsonData");
        model.addAttribute("jsonData", json);

        Map countMap = (Map) session.getAttribute("countMap");
        model.addAttribute("countMap", countMap);

        model.addAttribute("user", userService.findById(userId));

        return "home.jsp";
    }


}
