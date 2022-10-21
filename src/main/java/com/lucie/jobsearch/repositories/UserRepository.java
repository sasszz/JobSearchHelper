package com.lucie.jobsearch.repositories;

import java.util.Optional;

import com.lucie.jobsearch.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends CrudRepository<User, Long> {

//    Optional<User> findByEmail(String email);
    Optional<User> findByUserName(String userName);


}