<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/superAdminDashboard.css">
    <style>
        .form-container {
            max-width: 500px;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-container h1 {
            font-size: 24px;
            font-weight: bold;
            color: #4B5563;
            margin-bottom: 20px;
        }

        .form-container label {
            display: block;
            font-size: 14px;
            color: #6B7280;
            margin-bottom: 5px;
        }

        .form-container input, .form-container select {
            width: 100%;
            padding: 10px;
            border: 1px solid #D1D5DB;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 15px;
            color: #4B5563;
        }

        .form-container input:focus, .form-container select:focus {
            outline: none;
            border-color: #4B6CB7;
            box-shadow: 0 0 0 2px rgba(75, 108, 183, 0.2);
        }

        .form-container button {
            padding: 10px 20px;
            background-color: #4B6CB7;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            margin-right: 10px;
        }

        .form-container button:hover {
            background-color: #354A9F;
        }

        .form-container .cancel-btn {
            background-color: #E5E7EB;
            color: #6B7280;
        }

        .form-container .cancel-btn:hover {
            background-color: #D1D5DB;
        }
        
        /* Breadcrumb Styling */
        .breadcrumb {
            margin: 20px 10px; 
            font-size: 14px;
            color: #6B7280; 
        }

        .breadcrumb span {
            font-weight: bold;
            color: #4B6CB7; 
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
                    <li><a href="/TvpssApp/superadmin/dashboard">Dashboard</a></li>
                    <li><a href="/TvpssApp/superadmin/manageUsers" class="active">User Management</a></li>
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
                <div class="divider"></div> <!-- Thin dividing line -->
			    <!-- Bottom Section: Welcome and Search Bar -->
			    <div class="welcome-search">
			        <h1>User Management</h1>
			    </div>
            </header>

			<!-- Breadcrumb -->
            <div class="breadcrumb">
                <span>User Management</span> &gt; <span>Edit user</span>
            </div>
            
            <!-- Edit User Form -->
            <section class="form-section">
                <div class="form-container">
                    <form action="/TvpssApp/superadmin/updateUser" method="post" onsubmit="return validateForm()">
					    <label for="username">Username:</label>
					    <input type="text" id="username" name="username" value="${user.username}" disabled><br><br>
					    <input type="hidden" name="username" value="${user.username}">
					
					    <label for="email">Email:</label>
					    <input type="email" id="email" name="email" value="${user.email}" required><br><br>
					
					    <label for="role">Role:</label>
					    <select id="role" name="role" disabled>
					        <option value="1" <c:if test="${user.role == 1}">selected</c:if>>Super Admin</option>
					        <option value="2" <c:if test="${user.role == 2}">selected</c:if>>PPD Admin</option>
					        <option value="3" <c:if test="${user.role == 3}">selected</c:if>>State Admin</option>
					        <option value="4" <c:if test="${user.role == 4}">selected</c:if>>School Admin</option>
					        <option value="5" <c:if test="${user.role == 5}">selected</c:if>>Student</option>
					    </select><br><br>
					    <input type="hidden" name="role" value="${user.role}"> <!-- Send the role value in a hidden field -->
					
					    <label for="state">State:</label>
					    <select id="state" name="state" required>
					        <option value="Johor" <c:if test="${user.state == 'Johor'}">selected</c:if>>Johor</option>
					        <option value="Melaka" <c:if test="${user.state == 'Melaka'}">selected</c:if>>Melaka</option>
					        <option value="Negeri Sembilan" <c:if test="${user.state == 'Negeri Sembilan'}">selected</c:if>>Negeri Sembilan</option>
					        <option value="Selangor" <c:if test="${user.state == 'Selangor'}">selected</c:if>>Selangor</option>
					        <option value="Pahang" <c:if test="${user.state == 'Pahang'}">selected</c:if>>Pahang</option>
					        <option value="Perak" <c:if test="${user.state == 'Perak'}">selected</c:if>>Perak</option>
					        <option value="Kelantan" <c:if test="${user.state == 'Kelantan'}">selected</c:if>>Kelantan</option>
					        <option value="Terengganu" <c:if test="${user.state == 'Terengganu'}">selected</c:if>>Terengganu</option>
					        <option value="Penang" <c:if test="${user.state == 'Penang'}">selected</c:if>>Penang</option>
					        <option value="Kedah" <c:if test="${user.state == 'Kedah'}">selected</c:if>>Kedah</option>
					        <option value="Perlis" <c:if test="${user.state == 'Perlis'}">selected</c:if>>Perlis</option>        
					        <option value="Sabah" <c:if test="${user.state == 'Sabah'}">selected</c:if>>Sabah</option>
					        <option value="Sarawak" <c:if test="${user.state == 'Sarawak'}">selected</c:if>>Sarawak</option>
					    </select><br><br>					
					    <button type="submit">Update User</button>
					</form>
                </div>
            </section>
        </main>
    </div>
    
    <c:if test="${not empty error}">
        <script>
            alert("${error}");
        </script>
    </c:if>
    
    <script>
    // Validate email
    function validateForm() {
	    const email = document.getElementById("email").value;
	
	    // Validate email format using regex
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    if (!emailRegex.test(email)) {
	        alert("Please enter a valid email address.");
	        return false;
	    }
	
	    // AJAX request to check if email already exists
	    let emailExists = false;
	    const xhr = new XMLHttpRequest();
	    xhr.open("GET", "/TvpssApp/checkEmailExists?email=" + encodeURIComponent(email), false);
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            const response = xhr.responseText;
	            if (response === "true") {
	                alert("Email already exists.");
	                emailExists = true;
	            }
	        }
	    };
	    xhr.send();
	
	    return !emailExists;
	}
    </script>
</body>
</html>
