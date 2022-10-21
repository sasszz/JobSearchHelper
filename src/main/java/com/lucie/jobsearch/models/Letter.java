package com.lucie.jobsearch.models;

public class Letter {
    private String yourName;
    private String addressee;
    private String jobTitle;
    private String company;
    private String date;

    public Letter(String name, String addressee, String jobTitle, String company, String date) {
        this.yourName = yourName;
        this.addressee = addressee;
        this.jobTitle = jobTitle;
        this.company = company;
        this.date = date;
    }

    public String getYourName() {
        return yourName;
    }

    public void setYourName(String yourName) {
        this.yourName = yourName;
    }

    public String getAddressee() {
        return addressee;
    }

    public void setAddressee(String addressee) {
        this.addressee = addressee;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
