package com.lucie.jobsearch.controllers;

import com.lucie.jobsearch.models.Job;
import com.lucie.jobsearch.models.User;
import com.lucie.jobsearch.services.JobService;
import com.lucie.jobsearch.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class JobsController {

    @Autowired
    private JobService jobService;

    @Autowired
    private UserService userService;


    @GetMapping("/")
    public String landing(Model model) {
        List<Job> jobs = jobService.allJobs();
        model.addAttribute("jobs", jobs);
        return "landing.jsp";
    }

    @GetMapping("/kudos")
    public String landingKudos(HttpSession session, Model model) {
        List<Job> jobs = jobService.allJobs();
        model.addAttribute("jobs", jobs);
        Long userId = (Long) session.getAttribute("userId");

        if(userId == null) {
            return "redirect:/";
        }
        User user = (User) userService.findById(userId);

        List<Job> votedJobs = jobService.getJobsVotedByUser(user);

        model.addAttribute("votedJobs", votedJobs);
        return "kudosjobboard.jsp";
    }

    @GetMapping("/jobs/vote/{id}")
    public String vote(@PathVariable("id")Long id, HttpSession session){
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }
        User user = (User) userService.findById(userId);
        Job job = jobService.findById(id);
        job.getUsers().add(user);
        jobService.updateJob(job);
        return "redirect:/kudos";
    }

    @GetMapping("/new/job")
    public String newjob(@ModelAttribute("job") Job job, HttpSession session) {
        if(session.getAttribute("userId") == null) {
            return "redirect:/logout";
        }
        return "/jobs/newjob.jsp";
    }


    @PostMapping("/new/job")
    public String addJob(@ModelAttribute("job") Job job, HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        jobService.addJob(new Job(job.getTitle(), job.getJobType(), job.getAppliedOn(), job.getStatus(), job.getCompany(), job.getJobLocation(), job.getUrl(), job.getDescription(), job.getNotes(), job.getShareJob(), userService.findById(userId)));

        return "redirect:/json";

    }

    @RequestMapping("/job/delete/{id}")
    public String deleteJob(@PathVariable("id") Long id, HttpSession session) {

        if(session.getAttribute("userId") == null) {
            return "redirect:/logout";
        }

        jobService.deleteJob(jobService.findById(id));

        return "redirect:/home";
    }



    @GetMapping("/edit/job/{id}")
    public String editName(@PathVariable("id") Long id, HttpSession session, Model model) {

        if(session.getAttribute("userId") == null) {
            return "redirect:/logout";
        }

        Job job = jobService.findById(id);
        model.addAttribute("job", job);
        return "/jobs/updatejob.jsp";
    }

    @PutMapping("/edit/job/{id}")
    public String updatejob(
            @PathVariable("id") Long id,
            @ModelAttribute("job") Job job, HttpSession session) {

        if(session.getAttribute("userId") == null) {
            return "redirect:/logout";
        }

        jobService.updateJob(job);
        return "redirect:/home";
    }

    @GetMapping("/applications")
    public String apps(HttpSession session, Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        User user = (User) userService.findById(userId);

        List<Job> jobs = jobService.allJobsByUser(user);

        model.addAttribute("jobs", jobs);


        // SORTING FUNCTIONS

        Boolean sortedByStatus = (Boolean) session.getAttribute("sortedByStatus");
        if(sortedByStatus == null) {
            session.setAttribute("sortedByStatus", false);
        }

        if(sortedByStatus != null){
            if(sortedByStatus){
                List<Job> jobsSorted = jobService.findJobsByUserOrderByStatus(user);
                model.addAttribute("jobs", jobsSorted);
            }
        }

        Boolean sortedByDate = (Boolean) session.getAttribute("sortedByDate");
        if(sortedByDate == null) {
            session.setAttribute("sortedByDate", false);
        }

        if(sortedByDate != null){
            if(sortedByDate){
                List<Job> jobsSorted = jobService.findAllByOrderByAppliedOn(user);
                model.addAttribute("jobs", jobsSorted);
            }
        }

        return "/jobs/showjobs.jsp";
    }

    @PutMapping("/update/status/{id}")
    public String updatestatus(
            @PathVariable("id") Long id,
            @RequestParam(value="status") String status,
            HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        Job job = jobService.findById(id);

        jobService.updateJobStatus(job, status);

        return "redirect:/applications";
    }

    @PutMapping("/update/notes/{id}")
    public String updatenotes(
            @PathVariable("id") Long id,
            @RequestParam(value="notes") String notes,
            HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        Job job = jobService.findById(id);

        jobService.updateJobNotes(job, notes);

        return "redirect:/applications";
    }

    @GetMapping("/sort/status")
    public String sortStatus(HttpSession session){
        Boolean sortedByStatus = (Boolean) session.getAttribute("sortedByStatus");
        sortedByStatus = !sortedByStatus;

        session.setAttribute("sortedByStatus", sortedByStatus);

        return "redirect:/applications";
    }

    @GetMapping("/sort/date")
    public String sortDate(HttpSession session){
        Boolean sortedByDate = (Boolean) session.getAttribute("sortedByDate");
        sortedByDate = !sortedByDate;

        session.setAttribute("sortedByDate", sortedByDate);

        return "redirect:/applications";
    }

    @GetMapping("/jobs/{id}")
    public String showJob(@PathVariable("id") Long id, HttpSession session, Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/logout";
        }

        model.addAttribute("user", userService.findById(userId));

        Job job = jobService.findById(id);
        model.addAttribute("job", job);

        return "/jobs/showjob.jsp";
    }

}
