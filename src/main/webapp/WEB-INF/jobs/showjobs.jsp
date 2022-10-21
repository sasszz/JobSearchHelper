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
                    <a class="btn btn-outline-warning text-black title" href="/kudos">Total Kudos:
                        <c:set var="totalKudos" value="${0}"/>
                        <c:forEach var="job" items="${jobs}">
                            <c:set var="totalKudos" value="${totalKudos + job.users.size()}" />
                        </c:forEach>
                        <span class="text-info"><c:out value="${totalKudos}"/></span>
                    </a>
                </li>
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
<div>

</div>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-10">
            <div class="card mt-5 mb-3 p-3 bg-info text-dark">
                <div class="card-body">
                    <h5 class="card-title text-dark text-center title">Your Applications</h5>
                    <div class="row">
                            <c:choose>
                            <c:when test = "${empty jobs}">
                                <div class="col text-center mt-4">
                                <h5 class="card-title title"><a class="btn btn-md btn-outline-dark title text-secondary" href="/new/job">Record New Job Application</a></h5>
                                </div>
                            </c:when>
                                <c:otherwise>
                                <div class="col">
                                <a href="/sort/status" class="btn btn-outline-light title btn-sm">Sort by Status</a>
<%--                                <a href="/sort/date" id="button" class="btn btn-outline-light btn-sm">Sort by Date</a>--%>
                            <table class="table table-dark table-striped table-bordered text-center mt-4 align-middle pb-5 sortable">
                                <thead class="text-info">
                                <tr>
                                    <th>Job Title</th>
                                    <th>View</th>
                                    <th>Date of Application</th>
                                    <th>Company</th>
                                    <th>Job Type</th>
                                    <th>Description</th>
                                    <th>Shared to Job Board?</th>
                                    <th>Application Status</th>
                                    <th> Confirm Changes </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="job" items="${jobs}">
                                <tr class="text-center">
                                    <td>${job.title}</td>
                                    <td>
                                        <form action="/jobs/${job.id}">
                                        <button class="btn btn-sm btn-outline-info" type="submit">
                                            <img src="/imgs/eye.png" width="15" height="15">
                                        </button>
                                        </form>
                                    </td>
                                    <td><fmt:formatDate type="date" value="${job.appliedOn}"  /></td>
                                    <td>${job.company}</td>
                                    <td>${job.jobType}</td>
                                    <td>${job.description}</td>
                                    <td>${job.shareJob}</td>
                                        <form action="/update/status/${job.id}" method="POST">
                                            <td>
                                            <input type="hidden" name="_method" value="put">
                                            <select class="form-control font-weight-bold text-black form-control-sm" path="status" name="status">
                                                <c:choose>
                                                    <c:when test="${job.status.equals('Applied')}">
                                                        <option value="Applied" label="Applied" selected />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="Applied" label="Applied" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${job.status.equals('Recruiter Contact')}">
                                                        <option value="Recruiter Contact" label="Recruiter Contact" selected />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="Recruiter Contact" label="Recruiter Contact" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${job.status.equals('Interviewing')}">
                                                        <option value="Interviewing" label="Interviewing" selected />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="Interviewing" label="Interviewing" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${job.status.equals('Ghosted')}">
                                                        <option value="Ghosted" label="Ghosted" selected />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="Ghisted" label="Ghosted" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${job.status.equals('Rejected')}">
                                                        <option value="Rejected" label="Rejected" selected />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="Rejected" label="Rejected" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${job.status.equals('Accepted')}">
                                                        <option value="Accepted" label="Accepted" selected />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="Accepted" label="Accepted" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </select>
                                    </td>
                                    <td>
                                        <input class="btn btn-outline-info text-white btn-sm mt-2 align-self-end" type="submit" value="Update">
                                    </td>
                                        </form>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                                </div>

                                </c:otherwise>
                            </c:choose>
                        <div class="row">
                        <div class="col d-flex align-items-end justify-content-end">
                        <a class="btn btn-sm btn-outline-secondary title text-dark align-self-end" href="/new/job">New Job Application</a>
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