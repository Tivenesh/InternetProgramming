<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add User</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/superAdminDashboard.css">
    <style>
        .form-container {
            background: #FFFFFF;
            border-radius: 10px;
            padding: 30px;
            max-width: 500px;
            margin: 40px auto;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-container h1 {
            font-size: 24px;
            color: #4B6CB7; 
            margin-bottom: 20px;
            text-align: center;
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
            font-size: 14px;
            border: 1px solid #D1D5DB; 
            border-radius: 5px;
            margin-bottom: 20px;
            background: #F9FAFB; 
        }

        .form-container button {
            width: 48%;
            padding: 10px;
            font-size: 14px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-container .submit-btn {
            background: #4B6CB7;
            color: #FFFFFF;
        }

        .form-container .submit-btn:hover {
            background: #354A9F;
        }

        .form-container .cancel-btn {
            background: #E5E7EB;
            color: #4B5563; 
        }

        .form-container .cancel-btn:hover {
            background: #D1D5DB;
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
            <!-- Header -->
            <header class="header">
                <div class="header-top">
                    <!-- Notification Icon -->
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
                <span>User Management</span> &gt; <span>Create New User</span>
            </div>

            <!-- Add User Form -->
            <div class="form-container">
                <form action="/TvpssApp/superadmin/addUser" method="post" onsubmit="return validateForm()">
                    <label for="username">Full Name:</label>
                    <input type="text" id="username" name="username" required placeholder="Fill in your name">

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required placeholder="email@tvpss.com">

                    <label for="role">Type of Role:</label>
                    <select id="role" name="role" required>
                        <option value="" disabled selected>Select type of role</option>
                        <option value="1">Super Admin</option>
                        <option value="2">PPD Admin</option>
                        <option value="3">State Admin</option>
                        <option value="4">School Admin</option>
                        <option value="5">Student</option>
                    </select>

                    <label for="state">State:</label>
                    <select id="state" name="state" required>
                        <option value="" disabled selected>Select a state</option>
                        <option value="Johor">Johor</option>
                        <option value="Melaka">Melaka</option>
                        <option value="Negeri Sembilan">Negeri Sembilan</option>
                        <option value="Selangor">Selangor</option>
                        <option value="Pahang">Pahang</option>
                        <option value="Perak">Perak</option>
                        <option value="Kelantan">Kelantan</option>
                        <option value="Terengganu">Terengganu</option>
                        <option value="Penang">Penang</option>
                        <option value="Kedah">Kedah</option>
                        <option value="Perlis">Perlis</option>
                        <option value="Sabah">Sabah</option>
                        <option value="Sarawak">Sarawak</option>
                    </select>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required placeholder="Enter a secure password">

                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Re-enter the password">

                    <div style="display: flex; justify-content: space-between;">
                        <button type="button" class="cancel-btn" onclick="location.href='/TvpssApp/superadmin/manageUsers'">Cancel</button>
                        <button type="submit" class="submit-btn">Submit</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
    
    <c:if test="${not empty error}">
        <script>
            alert("${error}");
        </script>
    </c:if>
    
    <script>
	 	// Validate email and passwords
	    function validateForm() {
	        const email = document.getElementById("email").value;
	        const password = document.getElementById("password").value;
	        const confirmPassword = document.getElementById("confirmPassword").value;
	        
	     // Use regex to validate general email format
	        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

	        if (!emailRegex.test(email)) {
	            alert("Please enter a valid email address.");
	            return false; // Prevent form submission
	        }
	        
	        // Check if passwords match
	        if (password !== confirmPassword) {
	            alert("Passwords do not match!");
	            return false;
	        }
	        
	     // Check if username exists
	        const xhrUsername = new XMLHttpRequest();
	        xhrUsername.open("GET", "/TvpssApp/checkUsernameExists?username=" + encodeURIComponent(username), false);
	        xhrUsername.onreadystatechange = function () {
	            if (xhrUsername.readyState === 4 && xhrUsername.status === 200) {
	                const response = xhrUsername.responseText;
	                if (response === "true") {
	                    alert("Username already exists.");
	                    userExists = true;
	                }
	            }
	        };
	        xhrUsername.send();

	        // Check if email exists
	        const xhrEmail = new XMLHttpRequest();
	        xhrEmail.open("GET", "/TvpssApp/checkEmailExists?email=" + encodeURIComponent(email), false);
	        xhrEmail.onreadystatechange = function () {
	            if (xhrEmail.readyState === 4 && xhrEmail.status === 200) {
	                const response = xhrEmail.responseText;
	                if (response === "true") {
	                    alert("Email already exists.");
	                    emailExists = true;
	                }
	            }
	        };
	        xhrEmail.send();

	        // Prevent form submission if username or email already exists
	        if (userExists || emailExists) {
	            return false;
	        }

	        return true;
	    }
    </script>
</body>
</html>