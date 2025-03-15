<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View E-Certificate Application</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/stateAdminDashboard.css">
    <link rel="stylesheet" href="<c:url value='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' />">
    <style>
		body {
		    font-family: Arial, sans-serif;
		    background-color: #F8FAFF;
		    margin: 0;
		    padding: 0;
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
		
		.breadcrumb-container {
		    margin-bottom: 20px;
		}
		
		.breadcrumb-container nav {
		    font-size: 14px;
		    color: #555;
		}
		
		.breadcrumb-container a {
		    color: #007bff;
		    text-decoration: none;
		}
		
		.breadcrumb-container a:hover {
		    text-decoration: underline;
		}
		
		.breadcrumb-container ol {
		    padding: 0;
		    list-style: none;
		    display: flex;
		    gap: 5px;
		}
		
		.breadcrumb-container ol li::after {
		    content: ">";
		    margin: 0 5px;
		    color: #555;
		}
		
		.breadcrumb-container ol li:last-child::after {
		    content: "";
		}
		
		.manage-users-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.manage-users-header .search-bar input {
		    width: 300px; /* Adjust input width */
		    padding: 10px;
		    border: 1px solid #D1D5DB;
		    border-radius: 8px;
		    font-size: 14px;
		}

        .cert-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .cert-table th,
        .cert-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #F1F5FF;
        }

        .cert-table th {
            background-color: #F9FAFF;
            color: #4B6CB7;
            font-size: 14px;
            text-transform: uppercase;
        }

        .cert-table tr:hover {
            background-color: #F9FAFF;
        }

        .cert-table td {
            color: #555;
        }

		/* Button*/
		.btn {
			width:100px;
		    padding: 10px;
		    border-radius: 6px;
		    cursor: pointer;
		    text-align: center;
			justify-content: center;
		    font-size: 14px;
		    transition: background-color 0.3s;
		}
		
		.btn.preview {
			color: white;
            font-weight: bold;
            border: none;
		    background-color: #4B6CB7;
		}
		
		.btn.preview:hover {
			color: white;
			font-weight: bold;
			border: none;
		    background-color: #354A9F;
		}
		
		.btn.generated {
            font-weight: bold;
            color: #4B6CB7; 
		    border: 2px solid #4B6CB7;
		    background-color: white;
		}
		

        .pagination {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 5px;
		    margin-top: 20px;
		}
		
		.pagination button {
		    background-color: #FFFFFF;
		    color: #4B6CB7;
		    border: 1px solid #4B6CB7;
		    padding: 5px 10px;
		    border-radius: 5px;
		    cursor: pointer;
		    font-size: 14px;
		}
		
		.pagination button.active {
		    background-color: #4B6CB7;
		    color: white;
		    border: none;
		}
		
		.pagination button:hover {
		    background-color: #354A9F;
		    color: white;
		}

		/* Modal Styling */
		.overlay {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: rgba(0, 0, 0, 0.5);
		    z-index: 999;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		.modal {
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    width: 500px;
		    background: #ffffff;
		    border-radius: 12px;
		    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		    z-index: 1000;
		    padding: 30px;
		}
		
		.modal-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.modal-header h2 {
		    font-size: 20px;
		    font-weight: bold;
		    color: #1E3A8A; /* Dark Blue */
		    margin: 0;
		}

		.modal-header .close-btn {
		    font-size: 18px;
		    background: none;
		    border: none;
		    color: #6B7280;
		    cursor: pointer;
		}
		
		.modal-body {
		    font-size: 14px;
		    color: #6B7280;
		    margin-bottom: 20px;
		}
		
		.modal-footer {
		    display: flex;
		    justify-content: flex-end;
		    align-items: center;
		    gap: 15px;
		}
		
		.modal-footer .btn-cancel {
		    background-color: #E5E7EB;
		    color: #374151;
		    border: none;
		    border-radius: 8px;
		    padding: 10px 20px;
		    font-size: 14px;
		    cursor: pointer;
		    text-align: center;
		}
		
		.modal-footer .btn-cancel:hover {
		    background-color: #D1D5DB;
		}
		
		.modal-footer .btn-confirm {
		    background-color: #1E3A8A;
		    color: #ffffff;
		    border: none;
		    border-radius: 8px;
		    padding: 10px 20px;
		    font-size: 14px;
		    cursor: pointer;
		    text-align: center;
		}
		
		.modal-footer .btn-confirm:hover {
		    background-color: #163A72;
		}
	</style>
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
	        <form id="deleteForm" action="/TvpssApp/deleteUser" method="post" style="margin: 0;">
	            <input type="hidden" name="schoolCode" id="deleteUsername" value="">
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
                    <li><a href="/TvpssApp/adminstate/dashboard" class="menu-item ${page == 'dashboard' ? 'active' : ''}">Dashboard</a><li>
			        <li><a href="/TvpssApp/adminstate/viewCertApplication" class="menu-item ${page == null || page == 'viewCertApplication' || page == 'generateCertificate' ? 'active' : ''}">Generate E-Certificate</a><li>
				    <li><a href="/TvpssApp/adminstate/schoolVersion/view" class="menu-item ${page== 'tvpss-version' ? 'active' : ''}">Submit TVPSS Version</a><li>
                </ul>
            </nav>
            <div class="settings">
			    <div class="setting-item">
			        <i class="icon-settings"></i> Setting
			    </div>
			    <div class="divider"></div>
			    <div class="setting-item">
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
			            <img src="/TvpssApp/resources/images/stateAdminLogo.png" alt="User Avatar">
			            <span>User<br>State Admin</span>
			        </div>
			    </div>
			    <div class="divider"></div> <!-- Thin dividing line -->
			    <!-- Bottom Section: Welcome and Search Bar -->
			    <div class="welcome-search">
			        <h1>View E-Certificate Application</h1>
			    </div>
			</header>

			<div class="breadcrumb-container">
			    <nav aria-label="breadcrumb">
			        <ol class="breadcrumb">
			            <li aria-current="page">Application of E-Certificate</li>
			        </ol>
			    </nav>
			</div>
			
			<section class="manage-users-header">
			    <div class="search-bar">
			        <input type="text" placeholder="Search Users">
			    </div>
			    <div class="sort-dropdown">
			        <label for="sort">Sort by:</label>
			        <select id="sort">
			            <option value="newest">Newest</option>
			            <option value="oldest">Oldest</option>
			        </select>
			    </div>
			</section>


	        <!-- View E-Cert Application Table -->
	        <section class="cert-table-container">
	            <table class="cert-table">
	                <thead>
	                    <tr>
	                        <th>School Code</th>
	                        <th>School Name</th>
	                        <th>Type of Achievement </th>
	                        <th>Type of Form </th>
	                        <th>Status</th>
	                        <th>Action</th>
	                    </tr>
	                </thead>
	                <tbody>
					    <c:forEach var="certificate" items="${certificates}">
					        <tr>
					            <td>${certificate.schoolCode}</td>
					            <td>${certificate.schoolName}</td>
					            <td>${certificate.category}</td>
					            <td>${certificate.formMode}</td>
					            <td>${certificate.status}</td>
					            <td>
					                <!-- Check if the certificate had generated -->
					                <c:if test="${certificate.status != 'Generated'}">
					                    
					                </c:if>
					                <c:choose>
			                            <c:when test="${certificate.status != 'Generated'}">
			                            	<a href="${pageContext.request.contextPath}/adminstate/generateCertificate?certificateId=${certificate.certificateId}">
											    <button class="btn preview" type="button">Preview</button>
											</a>

			                            </c:when>
			                            <c:otherwise>
			                            	<button class="btn generated" onclick="location.href='/TvpssApp/adminstate/generateCertificate?certificateId=${certificate.certificateId}'">Generated</button>
			                            </c:otherwise>
			                          </c:choose>
					            </td>
					        </tr>
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
	    function showModal(schoolCode) {
		    const overlay = document.getElementById('overlay');
		    const modal = document.getElementById('confirmationModal');
		    const deleteUsername = document.getElementById('deleteUsername');
		    deleteUsername.value = schoolCode;
		
		    overlay.style.display = 'flex'; // Show the modal and center it
		    modal.style.display = 'block';
		}
		function hideModal() {
		    const overlay = document.getElementById('overlay');
		    const modal = document.getElementById('confirmationModal');
		
		    overlay.style.display = 'none';
		    modal.style.display = 'none';
		}
	</script>
</body>
</html>