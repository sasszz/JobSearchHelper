package com.lucie.jobsearch.services;

import java.util.Optional;

import com.lucie.jobsearch.models.LoginUser;
import com.lucie.jobsearch.models.User;
import com.lucie.jobsearch.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User register(User newUser, BindingResult result) {

//        Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());

        // Reject if email is taken (present in database)
//        if(potentialUser.isPresent()) {
//            result.rejectValue("email", "Matches", "An account with that email already exists!");
//        }

        // Reject if password doesn't match confirmation
        if(!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
        }

        // Return null if result has errors
        if(result.hasErrors()) {
            return null;
        }

        // Hash and set password, save user to database
        String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashed);
        return userRepository.save(newUser);

    }

    public User login(LoginUser newLogin, BindingResult result) {

        Optional<User> potentialUser = userRepository.findByUserName(newLogin.getUserName());

        // Find user in the DB by email
        // Reject if NOT present
//        if(!potentialUser.isPresent()) {
//            result.rejectValue("email", "Matches", "User not found!");
//            return null;
//        }
//
//        // User exists, retrieve user from DB
        User user = potentialUser.get();

        // Reject if BCrypt password match fails
        if(!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
            result.rejectValue("password", "Matches", "Invalid Password!");
        }

        // Return null if result has errors
        if(result.hasErrors()) {
            return null;
        }

        // Otherwise, return the user object
        return user;
    }

    public User findById(Long id) {
        Optional<User> potentialUser = userRepository.findById(id);
        if(potentialUser.isPresent()) {
            return potentialUser.get();
        }
        return null;
    }

    public User updateUserElevator(User user, String elevator) {
        user.setElevator(elevator);
        return userRepository.save(user);
    }
}