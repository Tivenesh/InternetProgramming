<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/superAdminDashboard.css">
    <link rel="stylesheet" href="/TvpssApp/resources/css/viewUserInformation.css">
</head>

<body>
	<!-- Success Message -->
	<c:if test="${param.success == 'true'}">
	    <div class="alert">
	        <div>
	            <img src="/TvpssApp/resources/images/successIcon.png" alt="Success Icon" style="width: 24px; height: 24px;">
	        </div>
	        <div>
	            <strong>Data Updated Successfully!</strong>
	            <p>Action was successfully performed.</p>
	        </div>
	        <button class="close-btn" onclick="this.parentElement.style.display='none';">&times;</button>
	    </div>
	</c:if>
	
	<!-- Error Message -->
	<c:if test="${not empty error}">
	    <div class="alert error">
	        <span class="message">${error}</span>
	        <button class="close" onclick="this.parentElement.style.display='none';">&times;</button>
	    </div>
	</c:if>
	
	<!-- Delete Confirmation Modal -->
	<div class="overlay" id="overlay" style="display: none;"></div>
	<div class="modal" id="confirmationModal" style="display: none;">
	    <div class="modal-header">
	        <h2>Do you want to delete the user?</h2>
	        <button class="close-btn" onclick="hideModal()">ÃÂ</button>
	    </div>
	    <div class="modal-body">
	        <p>This will be an irreversible operation.</p>
	    </div>
	    <div class="modal-footer">
	        <button class="btn-cancel" onclick="hideModal()">No</button>
	        <form id="deleteForm" action="/TvpssApp/superadmin/deleteUser" method="post" style="margin: 0;">
	            <input type="hidden" name="username" id="deleteUsername" value="">
	            <button class="btn-confirm" type="submit">Yes</button>
	        </form>
	    </div>
	</div>
	
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

			<!-- Breadcrumb Section -->
			<div class="breadcrumb">
			    <i class="icon-user"></i>
			    <span>User Management</span> &gt; <span>All Users</span>
			</div>

			<section class="manage-users-header">
				<div class="search-bar">
					<form action="/TvpssApp/superadmin/manageUsers" method="get">
						<input 
							type="text" 
							id="search" 
							name="searchQuery" 
							placeholder="Search Users"
							oninput="filterTable()"
						/>
					</form>
				</div>
				<div class="sort-dropdown">
					<label for="sort">Sort by:</label>
					<select id="sort" onchange="sortTable()">
						<option  selected>Default</option>
						<option value="name">Name</option>
						<option value="state">State</option>
					</select>
				</div>

				<button class="add-user-btn" onclick="location.href='/TvpssApp/superadmin/addUser'">+ Add New User</button>

			</section>

	        <!-- User Table -->
	        <section class="user-table-container">
	            <table class="user-table">
	                <thead>
	                    <tr>
	                        <th>Name</th>
	                        <th>State</th>
	                        <th>Type of Role</th>
	                        <th>Email</th>
	                        <th>Actions</th>
	                    </tr>
	                </thead>
	                <tbody>     
					    <c:forEach var="user" items="${users}">
						    <c:if test="${fn:containsIgnoreCase(user.username, param.searchQuery) || fn:containsIgnoreCase(user.email, param.searchQuery)}">
						        <tr>
						            <td>${user.username}</td>
						            <td>${user.state}</td>
						            <td>${user.getUserRoleName()}</td>
						            <td>${user.email}</td>
						            <td>
						                <!-- Check if the user is not a Super Admin -->
						                <c:if test="${user.getUserRoleName() != 'Super Admin'}">
						                    <button class="edit-btn" onclick="location.href='/TvpssApp/superadmin/editUser?username=${user.username}'">Edit</button>
						                    <button class="delete-btn" onclick="showModal('${user.username}')">Delete</button>
						                </c:if>
						            </td>
						        </tr>
						    </c:if>
						</c:forEach>
					</tbody>
	            </table>
	        </section>

	        <!-- Pagination Section -->
			<div class="pagination">
			    <c:if test="${currentPage > 1}">
			        <button onclick="location.href='?page=${currentPage - 1}'">&lt;</button>
			    </c:if>
			
			    <c:forEach begin="1" end="${totalPages}" var="i">
			        <button 
			            class="${currentPage == i ? 'active' : ''}" 
			            onclick="location.href='?page=${i}'">${i}</button>
			    </c:forEach>

			    <c:if test="${currentPage < totalPages}">
			        <button onclick="location.href='?page=${currentPage + 1}'">&gt;</button>
			    </c:if>
			</div>
    	</main>
	</div>
	
	<script>
	    // Automatically hide the alert box after 5 seconds with slide-out effect
	    setTimeout(() => {
	        const alertBox = document.querySelector('.alert');
	        if (alertBox) {
	            alertBox.classList.add('slide-out');
	            setTimeout(() => {
	                alertBox.style.display = 'none';
	            }, 500);
	        }
	    }, 5000);
	    
	    //Delete confirmation
	    function showModal(username) {
		    const overlay = document.getElementById('overlay');
		    const modal = document.getElementById('confirmationModal');
		    const deleteUsername = document.getElementById('deleteUsername');
		    deleteUsername.value = username;
		
		    overlay.style.display = 'flex'; // Show the modal and center it
		    modal.style.display = 'block';
		}

		function hideModal() {
		    const overlay = document.getElementById('overlay');
		    const modal = document.getElementById('confirmationModal');
		
		    overlay.style.display = 'none';
		    modal.style.display = 'none';
		}
		
		function filterTable() {
		    const searchValue = document.getElementById('search').value.toLowerCase();
		    const table = document.querySelector('.user-table tbody'); 
		    const rows = table.getElementsByTagName('tr');

		    if (searchValue.trim() === '') {
		        for (let i = 0; i < rows.length; i++) {
		            rows[i].style.display = ''; 
		        }
		        return; 
		    }

		    for (let i = 0; i < rows.length; i++) {
		        const nameCell = rows[i].getElementsByTagName('td')[0]; 
		        const emailCell = rows[i].getElementsByTagName('td')[3]; 

		        const nameText = nameCell ? nameCell.innerText.toLowerCase() : '';
		        const emailText = emailCell ? emailCell.innerText.toLowerCase() : '';

		        if (nameText.startsWith(searchValue) || emailText.startsWith(searchValue)) {
		            rows[i].style.display = '';
		        } else {
		            rows[i].style.display = 'none'; 
		        }
		    }
		}
	    
		function sortTable() {
		    const table = document.querySelector('.user-table tbody');
		    const rows = Array.from(table.getElementsByTagName('tr')); 
		    const sortBy = document.getElementById('sort').value;

		    if (sortBy === 'default') {

		        rows.sort((a, b) => a.rowIndex - b.rowIndex);
		    } else {
		        rows.sort((a, b) => {
		            let valueA, valueB;

		            if (sortBy === 'name') {
		                valueA = a.cells[0].innerText.toLowerCase(); 
		                valueB = b.cells[0].innerText.toLowerCase();
		            } else if (sortBy === 'state') {
		                valueA = a.cells[1].innerText.toLowerCase(); 
		                valueB = b.cells[1].innerText.toLowerCase();
		            }

		            return valueA.localeCompare(valueB); 
		        });
		    }


		    rows.forEach(row => table.appendChild(row));
		}


	</script>
</body>
</html>