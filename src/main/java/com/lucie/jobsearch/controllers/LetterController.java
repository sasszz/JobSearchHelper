package com.lucie.jobsearch.controllers;

import com.lucie.jobsearch.models.Job;
import com.lucie.jobsearch.models.User;
import com.lucie.jobsearch.services.JobService;
import com.lucie.jobsearch.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class LetterController {

    @Autowired
    private UserService userService;

    @Autowired
    private JobService jobService;

    @RequestMapping("/letter")
    String index(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        User user = (User) userService.findById(userId);
        List<Job> usersJobs = jobService.allJobsByUser(user);

        model.addAttribute("jobs", usersJobs);
        model.addAttribute("user", user);

        return "/letter/coverletter.jsp";
    }

    @PutMapping("/update/elevator/pitch/{id}")
    public String updateElevator(
            @PathVariable("id") Long id,
            @RequestParam(value="elevator") String elevator,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        User user = userService.findById(id);

        userService.updateUserElevator(user, elevator);

        return "redirect:/letter";
    }


    @PostMapping("/submit/letter")
    String submit(
            @RequestParam(value = "yourName") String yourName,
            @RequestParam(value = "addressee") String addressee,
            @RequestParam(value = "jobId") Long jobId,
            HttpSession session
    ) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }
        session.setAttribute("yourName", yourName);
        session.setAttribute("addressee", addressee);
        session.setAttribute("jobId", jobId);
        return "redirect:/cover/letter/show";
    }

    @RequestMapping("/cover/letter/show")
    String show(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        Long jobId = (Long) session.getAttribute("jobId");
        Job job = (Job) jobService.findById(jobId);
        User user = (User) userService.findById(userId);

        model.addAttribute("job", job);
        model.addAttribute("user", user);

        return "/letter/show.jsp";
    }
}
