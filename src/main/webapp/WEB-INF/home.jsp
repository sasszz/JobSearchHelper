<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Search Helper</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    <a class="btn btn-outline-secondary text-black title" href="/kudos">Job Board</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-info text-white title" href="/logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col">
            <div class="card mt-5 text-center bg-info mb-3 p-3">
                <div class="card-body">
                    <h3 class="card-title title text-dark">Hello <span class="text-secondary"><c:out value="${user.userName}"></c:out></span>! Welcome back.</h3>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <div class="card mt-1 text-center mb-3 p-3">
                <div class="card-body">
                    <h5 class="card-title title text-dark">Job Application Chart</h5>
                    <div class="row">
                        <div class="col">
                            <canvas id="myChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card mt-1 text-center mb-3 p-3 bg-info">
                <div class="card-body">
                    <h5 class="card-title title"><a class="btn btn-lg btn-outline-secondary text-dark" href="/new/job">New Job Application</a></h5>
                    <h5 class="card-title title mt-3"><a class="btn btn-lg btn-outline-dark text-dary" href="/applications">View Your Applications</a></h5>
                    <h5 class="card-title title mt-3"><a class="btn btn-lg btn-outline-secondary text-dark" href="/letter">Cover Letter Starter</a></h5>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
        </div>
    </div>
</div>
</body>

<script>
    let data = JSON.parse('${jsonData}')

    window.onload = function() {
        loadChart(data);
        console.log(data)
    };
    // $.getJSON("/json/output.json", function(data) {

    function loadChart(data) {{
        // let labels = Object.keys(data)
        let labels = []
        let numApps = []
        for(const key in data){
            labels.push(key);
            numApps.push(data[key])
        }
        console.log(labels);
        console.log(numApps);

        // let numberApps = Object.values(data)
        // console.log(numberApps);


        let dates = [];
        for(let i = 0; i < labels.length; i++){
            let temp = Date.parse(labels[i]);
            const date = new Date(temp)
            const year = date.getFullYear();

            const month = date.getMonth();

            const monthName = date.toLocaleString('default', {
                month: 'long',
            });

            const day = date.getDate();

            dates.push(monthName + " " + day)
        }

        const ctx = document.getElementById('myChart').getContext('2d');
        const myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Number of Applications',
                    data: numApps,
                    backgroundColor: [
                        '#5A62F3'
                    ]
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        grace: 1,
                        ticks: {
                            stepSize: 1 }
                    }
                }
            }
        });
    }};

</script>
</html>