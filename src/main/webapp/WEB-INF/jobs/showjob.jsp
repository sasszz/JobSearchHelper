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
    <script src="script.js"></script>
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
                    <a class="btn btn-outline-secondary text-dark title" href="/applications">Back</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-info text-white title" href="/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div>

</div>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-8">
            <div class="card mt-5 mb-3 p-3 bg-info text-dark">
                <div class="card-body">
                    <div class="row">
                    <h5 class="card-title text-dark text-center title">${job.title}, ${job.company}</h5>
                    <p class="text-center">Application submitted: <fmt:formatDate type="date" value="${job.appliedOn}"  /></p>
                    </div>
                    <div class="row mt-3">
                        <div class="col d-flex align-items-center justify-content-center">
                            <div class="row w-100 bg-secondary rounded p-3">
                            <form action="/update/notes/${job.id}" method="POST">
                                <input type="hidden" name="_method" value="put">
                                <label class="form-label">Update your notes below:</label>
                                <textarea rows="5" class="form-control" path="notes" name="notes">${job.notes}</textarea>
                                <input class="btn btn-outline-light text-dark mt-3 align-self-end" type="submit" value="Update">
                            </form>
                            </div>
                        </div>
                        <div class="col d-flex align-items-center justify-content-center">
                            <div class="row bg-dark rounded text-white p-3 text-center w-100">
                                <div class="col">
                                <p><span class="btn btn-outline-info btn-sm text-dark mt-3 mb-2">Description</span> <br> ${job.description}</p>
                                <p><span class="btn btn-outline-info btn-sm text-dark mb-2">Application Status</span> <br> ${job.status}</p>
                                <p><span class="btn btn-outline-info btn-sm text-dark mb-2">Job Type</span> <br> ${job.jobType}</p>
                                    <form action="/job/delete/${job.id}">
                                        <input class="btn btn-outline-danger title btn-sm" type="submit" value="Delete">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
</script>
</html>