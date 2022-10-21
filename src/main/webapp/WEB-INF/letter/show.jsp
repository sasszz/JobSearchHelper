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
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
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
            <div class="card mt-5 mb-3 p-3 bg-info">
                <div class="card-body">
                    <h5 class="card-title text-dark text-center title">Cover Letter Starter</h5>
                    <div class="bg-white text-black letter p-3 mt-3">
                        <p class="copy"><fmt:formatDate type="date" dateStyle = "long" value="${job.appliedOn}" /></p>
                        <p class="copy">Application for <c:out  value="${job.title}"></c:out>, <c:out value="${job.company}"></c:out></p>
                        <p class="copy">[HIRING MANAGER/RECRUITER NAME]</p>
                        <p class="copy">Manager, Recruiter at <c:out value="${job.company}"></c:out></p>
                        <p class="copy"><c:out value="${addressee}"></c:out>,</p>
                        <p class="copy">Paragraph 1: <c:out value="${user.elevator}"></c:out>,</p>
                        <p class="copy">Paragraph 2: [SPECIFICS ON EXPERIENCE/SKILLS AND HOW THEY APPLY TO POSITION]</p>
                        <p class="copy" id="myInput">Paragraph 3: Thank you for your time and consideration. I'd love a chance to learn more about this position and demonstrate how I can help <c:out value="${job.company}"></c:out> reach its organizational goal of [COMPANY MISSION STATEMENT]. I believe my [SPECIFIC SKILLS] make me a great candidate for the position of <c:out value="${job.title}"></c:out>. I can be reached at [CONTACT INFORMATION] if you need any other information.</p>
                        <p class="copy">Sincerely,</p>
                        <p class="copy"><c:out value="${yourName}"></c:out></p>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <a class="btn btn-outline-light align-self-start title" href="/letter">Reset</a>
                        </div>

                        <div class="col d-flex align-items-end justify-content-end">
                            <button id="button" class="btn btn-outline-dark text-white title">Copy</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>

    document.querySelector("#button").addEventListener('click', async event => {
        if (!navigator.clipboard) {
            // Clipboard API not available
            return
        }
        let text = [...document.querySelectorAll(".copy")]
        console.log(text)
        let list = [].slice.call(text);
        console.log(list)
        let innertext = list.map(function(e) { return e.innerText; }).join("\n");
        console.log(innertext)

        try {
            await navigator.clipboard.writeText(innertext)
            event.target.textContent = 'Copied to clipboard'
        } catch (err) {
            console.error('Failed to copy!', err)
        }
    })
</script>
</html>