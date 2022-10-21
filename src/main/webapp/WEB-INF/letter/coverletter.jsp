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
                    <a class="btn btn-outline-secondary text-dark title" href="/home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-info text-white title" href="/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-8">
            <div class="card mt-5 mb-3 p-3 bg-info text-dark">
                <div class="card-body">
                    <h5 class="card-title text-dark text-center title">Cover Letter Inputs</h5>
                    <div class="form-group">
                        <form action="/submit/letter" method="post">
                            <div class="row mt-4">
                                <div class="col">
                                    <label>Your Full Name:</label>
                                    <input  class="form-control" type="text" name="yourName">
                                </div>
                                <div class="col">
                                    <label>Your applications:</label>
                                    <select class="form-select" name="jobId">
                                        <c:forEach var="job" items="${jobs}">
                                            <c:if test = "${job.status != 'rejected'}">
                                            <option value="${job.id}">${job.title}, ${job.company}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <label>Who the letter is addressed to:</label>
                                    <input class="form-control" type="text" name="addressee">
                                </div>
                                <div class="col">
                                </div>
                            </div>
                            <input type="submit" value="Submit Inputs" class="title btn btn-outline-light mt-4 align-self-end"/>
                        </form>
                    </div>
                    <div class="row mt-4">
                        <div class="col"></div>
                        <div class="col bg-black text-white rounded p-3">
                        <form action="/update/elevator/pitch/${user.id}" method="POST">
                            <input type="hidden" name="_method" value="put">
                            <label class="form-label">Update your elevator pitch below:</label>
                            <textarea rows="5" class="form-control" path="elevator" name="elevator">${user.elevator}</textarea>
                            <input class="btn btn-outline-info text-light mt-3 align-self-end title" type="submit" value="Save">
                        </form>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>