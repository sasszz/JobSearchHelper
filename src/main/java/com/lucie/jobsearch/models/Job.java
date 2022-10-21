package com.lucie.jobsearch.models;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.text.spi.DateFormatProvider;
import java.util.Date;
import java.util.List;

@Entity
@Table(name="jobs")
public class Job {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String jobType;

    private String company;

    private String url;

    private String jobLocation;
    private String status;
    private String lastStatus;
    private String description;
    private String notes;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date appliedOn;
    private Boolean shareJob;

    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;

    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

    @Column(updatable=false)
    @OneToMany(mappedBy="job", fetch = FetchType.LAZY)
    private List<People> associatedPeople;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "users_jobs",
            joinColumns = @JoinColumn(name = "job_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )

    private List<User> users;

    public Job(String title, String jobType, Date appliedOn, String status, String company, String jobLocation, String url, String description, String notes, Boolean shareJob, User user) {
        this.title = title;
        this.jobType = jobType;
        this.appliedOn = appliedOn;
        this.status = status;
        this.company = company;
        this.jobLocation = jobLocation;
        this.url = url;
        this.description = description;
        this.notes = notes;
        this.shareJob = shareJob;
        this.user = user;
    }

    public Job() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getJobLocation() {
        return jobLocation;
    }

    public void setJobLocation(String jobLocation) {
        this.jobLocation = jobLocation;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLastStatus() {
        return lastStatus;
    }

    public void setLastStatus(String lastStatus) {
        this.lastStatus = lastStatus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getAppliedOn() {
        return appliedOn;
    }

    public void setAppliedOn(Date appliedOn) {
        this.appliedOn = appliedOn;
    }

    public Boolean getShareJob() {
        return shareJob;
    }

    public void setShareJob(Boolean shareJob) {
        this.shareJob = shareJob;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<People> getAssociatedPeople() {
        return associatedPeople;
    }

    public void setAssociatedPeople(List<People> associatedPeople) {
        this.associatedPeople = associatedPeople;
    }

    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public List<User> getUsers() {
        return users;
    }
    public void setUsers(List<User> votes) {
        this.users = users;
    }

}
