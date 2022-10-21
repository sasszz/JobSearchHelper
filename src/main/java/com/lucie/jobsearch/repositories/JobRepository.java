package com.lucie.jobsearch.repositories;

import com.lucie.jobsearch.models.Job;
import com.lucie.jobsearch.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JobRepository extends CrudRepository<Job, Long> {
    List<Job> findAll();
    Job findByIdIs(Long id);
    List<Job> findJobsByUserOrderByStatus(User user);

    List<Job> findJobsByUserOrderByAppliedOn(User user);

    List<Job> findAllByUsers(User user);

    List<Job> findAllJobsByUser(User user);

}
