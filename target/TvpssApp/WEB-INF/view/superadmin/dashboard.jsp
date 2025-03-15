<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ page isELIgnored = "false" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Super Admin Dashboard</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/superAdminDashboard.css">
	<style>
		.stats {
		    display: flex;
		    gap: 20px;
		    margin-bottom: 20px;
		}
		
		.stat {
		    flex: 1;
		    background: #FFFFFF; /* White background for stat cards */
		    text-align: center;
		    padding: 20px;
		    border-radius: 10px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow */
		}
		
		.stat h3 {
		    font-size: 1em;
		    color: #6B7280; /* Neutral gray for stat labels */
		}
		
		.stat p {
		    font-size: 2em;
		    font-weight: bold;
		    color: #4B6CB7; /* Blue for stat numbers */
		}
		
		.chart-container {
		    background: #FFFFFF; /* White background */
		    border-radius: 10px; /* Rounded corners */
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
		    padding: 20px; /* Add space inside the container */
		    flex: 1; /* Flex property to allow equal width */
		}
		
		.charts {
		    display: flex;
		    gap: 20px; /* Space between the charts */
		    margin-bottom: 20px; /* Space below the section */
		}
		
		.chart h3 {
		    font-size: 1.1em;
		    color: #4B6CB7; /* Blue for the title */
		    margin-bottom: 10px; /* Space below the title */
		    text-align: center;
		}
		
		.circle-chart {
		    width: 150px;
		    height: 150px;
		    border-radius: 50%;
		    background: conic-gradient(#4B6CB7 80%, #F7F9FF 0%);
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin: 20px auto; /* Center align the circle chart */
		}
		
		.circle-chart span {
		    font-size: 1.5em;
		    font-weight: bold;
		    color: #FFFFFF;
		}
		
		.chart p {
		    text-align: center; /* Center-align the text */
		    color: #4B5563; /* Neutral gray for the text */
		    font-size: 0.9em;
		    margin-top: 10px; /* Add spacing above the text */
		}
	</style>
</head>

<body>
    <div class="dashboard">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="logo">
                <img src="/TvpssApp/resources/images/TvpssLogo.png" alt="TVPSS Logo">

                <h2>TVPSS</h2>
            </div>
            <nav>
                <ul>
                    <li><a href="#" class="active">Dashboard</a></li>
                    <li><a href="/TvpssApp/superadmin/manageUsers">User Management</a></li>
                </ul>
            </nav>
            <div class="settings">
			    <div class="setting-item">
			        <i class="icon-settings"></i> Setting
			    </div>
			    <div class="divider"></div>
			    <div class="setting-item">
		            <i class="icon-logout"></i>
		            <a href="/TvpssApp/login" style="text-decoration: none; color: inherit;">Logout</a>
		        </div>
			</div>
        </aside>

        <!-- Main Content -->
        <main class="content">
        
            <header class="header">
			    <div class="header-top">
				    <div class="notification">
				        <div class="notification-icon">
				            <i class="icon-bell"></i>
				            <span class="notification-badge"></span>
				        </div>
				    </div>
					<div class="user-info">
					    <img src="/TvpssApp/resources/images/superAdminLogo.png" alt="User Avatar">
					    <span>Miss Tan<br>Super Admin</span>
					</div>
			    </div>
			    
			    <div class="divider"></div>

			    <div class="welcome-search">
			        <h1>Hello, welcome!</h1>
			    </div>
			</header>

            <section class="stats">
			    <div class="stat">
			        <h3>Number of State Admin</h3>
			        <p>${stateAdminCount}</p>
			    </div>
			    <div class="stat">
			        <h3>Number of PPD Admin</h3>
			        <p>${ppdAdminCount}</p>
			    </div>
			    <div class="stat">
			        <h3>Number of School Admin</h3>
			        <p>${schoolAdminCount}</p>
			    </div>
			</section>
            
            <section class="charts">
			    <div class="chart-container">
			        <div class="chart">
			            <h3>Number of active users</h3>
			            <canvas id="activeUsersChart"></canvas>
			        </div>
			    </div>
			    <div class="chart-container">
			        <div class="stat">
					    <h3>Number of Student</h3>
					    <p>${studentCount}</p>
					</div>
					<div style="text-align: center;">
						<img src="/TvpssApp/resources/images/studentIcon.png" alt="Student Icon" style="width: 300px; height: 180px; margin-top: 28px;" >
					</div>
			    </div>
			</section>
        </main>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', () => {
        const barChart = document.getElementById('activeUsersChart').getContext('2d');

        const activeUsersData = [<c:forEach var="data" items="${activeUsersData}" varStatus="status">
                                     ${data}<c:if test="${!status.last}">,</c:if>
                                 </c:forEach>];

        new Chart(barChart, {
            type: 'bar',
            data: {
                labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                datasets: [{
                    label: 'Active Users',
                    data: activeUsersData,
                    backgroundColor: [
                        '#4B6CB7', '#4B6CB7', '#4B6CB7', '#4B6CB7', '#4B6CB7', '#4B6CB7', '#4B6CB7'
                    ],
                    borderColor: '#354A9F',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: true,
                        labels: {
                            color: '#4B5563'
                        }
                    }
                },
                scales: {
                    x: {
                        ticks: {
                            color: '#4B5563'
                        }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#4B5563'
                        }
                    }
                }
            }
        });
    });
</script>

    
</body>
</html>
