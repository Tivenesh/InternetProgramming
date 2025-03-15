<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Admin Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/schoolAdmindashboard.css' />">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<div class="dashboard-container">
    <!-- Sidebar -->
    <%@ include file="/WEB-INF/view/common/adSchoolsidebar.jsp" %>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <%@ include file="/WEB-INF/view/common/adSchoolheader.jsp" %>

        <!-- Dashboard Cards -->
        <section class="stats-cards">
            <div class="card">
                <div class="card-icon"><img src="<c:url value='/resources/images/numOfStudent.png' />" alt="Profile"></div>
                <div class="card-info">
                    <span>Number of Students</span>
                    <h2>${studentCount}</h2>
                </div>
            </div>
            <div class="card">
                <div class="card-icon"><img src="<c:url value='/resources/images/totalAchievement.png' />" alt="Profile"></div>
                <div class="card-info">
                    <span>Total Achievement</span>
                    <h2>${totalAchievements}</h2>
                </div>
            </div>
            <div class="card">
                <div class="card-icon"><img src="<c:url value='/resources/images/numOfCrew.png' />" alt="Profile"></div>
                <div class="card-info">
                    <span>Number of Crew</span>
                    <h2>${numCrew}</h2>
                </div>
            </div>
        </section>

        <!-- Charts Section -->
        <section class="charts">
            <div class="bar-chart">
                <h3>Crew Overview</h3>
                <canvas id="crewBarChart" width="400" height="300"></canvas>
            </div>
            <div class="pie-chart">
                <h3>Division of Crew by Gender</h3>
                <canvas id="genderPieChart" width="300" height="300"></canvas>
            </div>
        </section>
    </main>
</div>

<script>
    // Bar Chart for Crew Overview
    const ctxBar = document.getElementById('crewBarChart').getContext('2d');
    const crewBarChart = new Chart(ctxBar, {
        type: 'bar',
        data: {
            labels: ${chartLabels}, // Dynamically passed labels
            datasets: [{
                label: 'Crew',
                data: ${chartData}, // Dynamically passed data
                backgroundColor: '#6ebae9'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 10
                    }
                }
            }
        }
    });

    // Pie Chart for Gender Division
    const ctxPie = document.getElementById('genderPieChart').getContext('2d');
    const genderPieChart = new Chart(ctxPie, {
        type: 'pie',
        data: {
            labels: ['Male', 'Female'],
            datasets: [{
                label: 'Division of Crew by Gender',
                data: [${genderMale}, ${genderFemale}], // Dynamic values
                backgroundColor: ['#89dad2', '#f5f3d7']
            }]
        },
        options: {
            responsive: true
        }
    });
</script>

</body>
</html>
</html>
