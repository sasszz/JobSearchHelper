<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Search Helper</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar fixed-top navbar-light bg-light navbar-expand-lg mr-auto p-3">
    <div class="container">
        <span class="navbar-brand mb-0 h1 title">
            <img src="/imgs/boxicon.png" width="25" height="25" class="d-inline-block align-top" alt="Cube">
            Job Search Helper
        </span>
        <div>
            <ul class="navbar-nav gap-3">
                <li class="nav-item">
                    <a class="btn btn-outline-dark text-dark title disabled">Because looking for a job should be a lil easier.</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-light text-dark title" href="/home">Back</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-8">
            <div class="card mt-5 mb-3 p-3">
                <div class="card-body">
                    <h5 class="card-title text-dark text-center title">Edit Job</h5>
                    <div class="form-group">
                        <form:form action="/edit/job/${job.id}" method="post" modelAttribute="job">
                            <input type="hidden" name="_method" value="put">
                            <form:input type="hidden" name="user" path="user"/>
                            <div class="row mt-4">
                                <div class="col">
                                    <form:label path="title">Job Title</form:label>
                                    <form:input class="form-control" path="title"/>
                                </div>
                                <div class="col">
                                    <form:label path="jobType">Job Type</form:label>
                                    <form:select class="form-control" path="jobType">
                                        <form:option value="NONE" label="--- Select ---"/>
                                        <form:option value="fulltime" label="Full-Time"></form:option>
                                        <form:option value="parttime" label="Part-Time"></form:option>
                                        <form:option value="intern" label="Internship"></form:option>
                                        <form:option value="apprentice" label="Apprenticeship"></form:option>
                                        <form:option value="freelance" label="Freelance"></form:option>
                                        <form:option value="contract" label="Contract"></form:option>
                                    </form:select>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <form:label path="appliedOn">Date of Application</form:label>
                                    <form:input type="date" class="form-control" path="appliedOn"/>
                                </div>
                                <div class="col">
                                    <form:label path="status">Application Status</form:label>
                                    <form:select class="form-control" path="status">
                                        <form:option value="NONE" label="--- Select ---"/>
                                        <form:option value="applied" label="Applied"></form:option>
                                        <form:option value="recruiter" label="Recruiter Contact"></form:option>
                                        <form:option value="interview" label="Interview"></form:option>
                                        <form:option value="negotiation" label="Negotiations"></form:option>
                                        <form:option value="rejected" label="Rejected"></form:option>
                                        <form:option value="accepted" label="Accepted"></form:option>
                                    </form:select>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <form:label path="company">Company</form:label>
                                    <form:input class="form-control" path="company" />
                                </div>
                                <div class="col">
                                    <form:label path="jobLocation">Job Location</form:label>
                                    <form:input class="form-control" path="jobLocation" />
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <form:label path="url">Link to Job Posting</form:label>
                                    <form:input class="form-control" path="url"/>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <form:label path="description">Description</form:label>
                                    <form:textarea class="form-control" path="description"/>
                                </div>
                                <div class="col">
                                    <form:label path="notes">Notes</form:label>
                                    <form:textarea class="form-control" path="notes"/>
                                </div>
                            </div>
                            <div class="row mt-4 justify-content-center">
                                <div class="col-7 text-center">
                                    <form:checkbox class="form-check-input" path="shareJob" />
                                    <form:label path="shareJob">Share to Public Job Board?</form:label>
                                </div>
                            </div>
                            <div class="row mt-4 justify-content-center">
                                <div class="col-7 d-flex flex-column text-center">
                                    <form:errors path="title" class="text-danger"/>
                                    <form:errors path="jobType" class="text-danger"/>
                                    <form:errors path="company" class="text-danger"/>
                                    <form:errors path="url" class="text-danger"/>
                                    <form:errors path="jobLocation" class="text-danger"/>
                                </div>
                            </div>
                            <input class="btn btn-outline-light mt-2 align-self-end" type="submit" value="Update">
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>