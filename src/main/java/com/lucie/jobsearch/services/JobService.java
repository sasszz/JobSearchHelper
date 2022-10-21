package com.lucie.jobsearch.services;

import com.lucie.jobsearch.models.Job;
import com.lucie.jobsearch.models.User;
import com.lucie.jobsearch.repositories.JobRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class JobService {
    private final JobRepository jobRepository;

    public JobService(JobRepository jobRepository) {
        this.jobRepository = jobRepository;
    }

    public List<Job> allJobs(){
        return jobRepository.findAll();
    }

    public void addJob(Job job) {
        jobRepository.save(job);
    }

    public Job updateJob(Job job) {
        return jobRepository.save(job);
    }

    public Job updateJobStatus(Job job, String status) {
        job.setStatus(status);
        return jobRepository.save(job);
    }

    public void deleteJob(Job job) {
        jobRepository.delete(job);
    }

    public Job findById(Long id) {
        Optional<Job> optionalJob = jobRepository.findById(id);
        if(optionalJob.isPresent()) {
            return optionalJob.get();
        }else {
            return null;
        }
    }

    public List<Job> findJobsByUserOrderByStatus(User user){
        List<Job> jobsByUserByStatus = jobRepository.findJobsByUserOrderByStatus(user);
        return jobsByUserByStatus;
    }

    public List<Job> findAllByOrderByAppliedOn(User user){
        List<Job> jobsByAppliedOn = jobRepository.findJobsByUserOrderByAppliedOn(user);
        return jobsByAppliedOn;
    }


    public List<Job> getJobsVotedByUser(User user) {
        return jobRepository.findAllByUsers(user);
    }

    public List<Job> allJobsByUser(User user) {
        return jobRepository.findAllJobsByUser(user);
    }

    public Job updateJobNotes(Job job, String notes) {
        job.setNotes(notes);
        return jobRepository.save(job);
    }
}