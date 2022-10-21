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
                    <a class="btn btn-outline-dark text-dark title disabled">Let's get to work!</a>
                </li>
                <c:choose>
                    <c:when test="${sessionScope.userId == null}">
                        <li class="nav-item">
                            <a class="btn btn-outline-info text-white title" href="/index">Login</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-secondary text-black title" href="/home">My Page</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-info text-white title" href="/logout">Logout</a>
                        </li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col">
            <div class="card mt-5 mb-3 p-3 bg-info">
                <div class="card-body">
                    <h2 class="card-title text-white text-center title">Shared Job Board</h2>
                    <div class="row">
                        <div class="col">
<%--                            <a href="/sort/title">Sort by Title</a>--%>
                            <table class="table table-dark table-striped table-hover table-bordered text-center mt-4 align-middle pb-5 sortable">
                                <thead class="thead-primary bg-light">
                                <tr>
                                    <th>Kudos</th>
                                    <th>Job Title</th>
                                    <th>Company</th>
                                    <th>Job Type</th>
                                    <th>Description</th>
                                    <th>Link</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="job" items="${jobs}">
                                    <c:if test="${job.shareJob}">
                                    <tr class="text-center">
                                        <td>${job.users.size()}</td>
                                        <td>${job.title}</td>
                                        <td>${job.company}</td>
                                        <td>${job.jobType}</td>
                                        <td>${job.description}</td>
                                        <td><a href="${job.url}" class="btn btn-outline-info text-light btn-sm">Link</a></td>
                                    </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>