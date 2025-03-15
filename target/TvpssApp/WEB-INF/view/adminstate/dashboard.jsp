<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>State Admin Dashboard</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/stateAdminDashboard.css">
    <style>
        .dashboard-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .stats-cards {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .stats-card {
            flex: 1;
            background-color: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 0 10px;
            text-align: center;
        }

        .stats-card h4 {
            font-size: 16px;
            color: #6B7280;
            margin-bottom: 10px;
        }

        .stats-card p {
            font-size: 28px;
            color: #4B6CB7;
            font-weight: bold;
        }

        .charts-container {
            display: flex;
            gap: 20px;
        }

        .chart-box {
            flex: 1;
            background-color: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .chart-box h4 {
            font-size: 16px;
            color: #4B5563;
            text-align: center;
            margin-bottom: 10px;
        }

        canvas {
            max-width: 100%;
        }

        .dropdown {
            text-align: center;
            margin-bottom: 10px;
        }

        .dropdown select {
            padding: 5px;
            font-size: 14px;
        }

        .circular-chart {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 200px;
            height: 200px;
            margin: 0 auto;
        }

        .circular-chart canvas {
            width: 100%;
            height: 100%;
        }

        .progress-label {
            position: absolute;
            font-size: 24px;
            font-weight: bold;
            color: #4B6CB7;
            text-align: center;
        }

        .progress-label span {
            display: block;
            font-size: 12px;
            color: #6B7280;
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
                    <li><a href="/TvpssApp/adminstate/dashboard" class="menu-item ${page == null || page == 'dashboard' ? 'active' : ''}">Dashboard</a><li>
			        <li><a href="/TvpssApp/adminstate/viewCertApplication" class="menu-item ${page == 'viewCertApplication' || page == 'generateCertificate' ? 'active' : ''}">Generate E-Certificate</a><li>
				    <li><a href="/TvpssApp/adminstate/schoolVersion/view" class="menu-item ${page== 'tvpss-version' ? 'active' : ''}">Submit TVPSS Version</a><li>
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
	                    <img src="/TvpssApp/resources/images/stateAdminLogo.png" alt="User Avatar">
	                    <span>User<br>State Admin</span>
	                </div>
	            </div>
	            <div class="divider"></div>
	            <div class="welcome-search">
	                <h1>Hello, welcome!</h1>
	            </div>
	        </header>
	
	        <div class="dashboard-container">
	            <!-- Statistics Cards -->
	            <div class="stats-cards">
				    <div class="stats-card">
				        <h4>Number of Applications Certificate</h4>
				        <p>${certificateCount}</p>
				    </div>
				    <div class="stats-card">
				        <h4>Number of Achievements</h4>
				        <p>${achievementCount}</p>
				    </div>
				    <div class="stats-card">
				        <h4>Number of TVPSS According to State</h4>
				        <p>${totalSchools}</p>
				    </div>
				</div>
	
	            <!-- Charts Section -->
	            <div class="charts-container">
	                <!-- Bar Chart -->
	                <div class="chart-box">
	                    <h4>Number Verified by Version</h4>
	                    <canvas id="barChart"></canvas>
	                </div>
	
	                <!-- Circular Chart -->
	                <div class="chart-box">
	                    <h4>School Student Achievement Percentage by State</h4>
	                    <div class="circular-chart">
	                        <canvas id="circularChart"></canvas>
	                    </div>
	                    <div class="progress-label">60%<span>Domestic Percentage</span></div>
	                </div>
	            </div>
	        </div>
	    </main>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	    // Bar Chart
	    const barChart = new Chart(document.getElementById('barChart'), {
	        type: 'bar',
	        data: {
	            labels: ['Version 1', 'Version 2', 'Version 3'],
	            datasets: [{
	                label: 'Number Verified',
	                data: [40, 150, 300],
	                backgroundColor: '#A0C4FF',
	                borderRadius: 5
	            }]
	        },
	        options: {
	            responsive: true,
	            scales: {
	                x: { ticks: { color: '#4B5563' } },
	                y: { beginAtZero: true, ticks: { color: '#4B5563' } }
	            }
	        }
	    });
	
	    // Circular Chart
	    const circularChart = new Chart(document.getElementById('circularChart'), {
	        type: 'doughnut',
	        data: {
	            labels: ['Completed', 'Remaining'],
	            datasets: [{
	                data: [60, 40],
	                backgroundColor: ['#4B6CB7', '#E5E7EB'],
	                cutout: '80%'
	            }]
	        },
	        options: {
	            responsive: true,
	            plugins: {
	                tooltip: { enabled: false },
	                legend: { display: false }
	            }
	        }
	    });
	</script>
</body>
</html>