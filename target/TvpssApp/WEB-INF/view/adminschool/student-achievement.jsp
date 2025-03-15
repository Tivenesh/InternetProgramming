<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Student Achievement</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/viewAchievement.css' />">

    <link rel="stylesheet" href="<c:url value='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' />">
    <style>
		.btn.achievement {
            background-color: #4B6CB7;
            color: #FFFFFF;
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            display:flex;
			align-item: center;
        }

        .btn.achievement :hover {
            background-color: #354A9F;
        }
        
        /* Modal Styling */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5); /* Dim background */
    z-index: 999;
    display: flex;
    justify-content: center; /* Center horizontally */
    align-items: center; /* Center vertically */
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

.btn-cancel {
    background: #f5f5f5;
    color: #333;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 10px;
    transition: background 0.3s;
}

.btn-cancel:hover {
    background: #ddd;
}

.btn-confirm {
    background: #d9534f;
    color: #fff;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background 0.3s;
}

.btn-confirm:hover {
    background: #c9302c;
}

.close-btn {
    background: none;
    border: none;
    font-size: 18px;
    cursor: pointer;
    color: #333;
}

.close-btn:hover {
    color: #000;
}
        
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/view/common/adSchoolsidebar.jsp" %>

        <!-- Main Content -->
        <section class="content">
            <%@ include file="/WEB-INF/view/common/adSchoolheader.jsp" %>
            
            <hr class="divider">
            <!-- School Information Form -->
            <div class="title-container">
                <h2>${achievementTitle}</h2>
            </div>
            
            <!-- Search bar -->
            <div class="search-container">
                <input type="text" id="search" placeholder="Find Achievement..." oninput="filterTable()">
                <button class="btn view">Search</button>
                
                <!-- Add Achievement Button -->
                <button class="btn achievement" onclick="window.location.href='<c:url value='/adminschool/submit-achievement' />'">+ Add Achievement</button>
            </div>
            
            <!-- Table -->
            <div class="table-container">
                <table id="achievementTable">
                    <thead>
                        <tr>
                            <th>Activity Name</th>
                            <th>Category</th>
                            <th>Form Mode</th>
                            <th>Status</th>
                            <th>More Details</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="achievement" items="${achievements}">
                            <tr>
                                <td>${achievement.activityName}</td>
                                <td>${achievement.category}</td>
                                <td>${achievement.formMode}</td>
                                <td>
                                    <span style="color: <c:choose>
                                                <c:when test='${achievement.status == "Pending"}'>orange</c:when>
                                                <c:when test='${achievement.status == "Generated"}'>green</c:when>
                                                <c:when test='${achievement.status == "Rejected"}'>red</c:when>
                                                <c:otherwise>grey</c:otherwise>
                                            </c:choose>; font-weight: bold;">
                                        ${achievement.status}
                                    </span>
                                </td>
                                <td><button class="btn view" onclick="window.location.href='<c:url value='/adminschool/view-achievement?id=${achievement.achievementId}' />'">View</button></td>
                                <td>
                                    <button class="btn edit" onclick="window.location.href='<c:url value='/adminschool/edit-achievement?id=${achievement.achievementId}' />'"><i class="fa fa-edit"></i></button>
                                    <button class="btn delete" onclick="showModal('${achievement.achievementId}')">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <button class="active">1</button>
                <button>2</button>
                <button>3</button>
                <button>Next</button>
            </div>
        </section>
    </div>
    
     <!-- Delete Confirmation Modal -->
	<div class="overlay" id="overlay" style="display: none;"></div>
	<div class="modal" id="confirmationModal" style="display: none;">
	    <div class="modal-header">
	        <h2>Do you want to delete this achievement?</h2>
	        <button class="close-btn" onclick="hideModal()">×</button>
	    </div>
	    <div class="modal-body">
	        <p>This will be an irreversible operation.</p>
	    </div>
	    <div class="modal-footer">
	        <button class="btn-cancel" onclick="hideModal()">No</button>
	        <form id="deleteForm" action="/TvpssApp/adminschool/delete-achievement" method="post" style="margin: 0;">
	            <input type="hidden" name="achievementId" id="deleteAchievementId" value="">
	            <button class="btn-confirm" type="submit">Yes</button>
	        </form>
	    </div>
	</div>



    <script>
    function filterTable() {
        const searchValue = document.getElementById('search').value.toLowerCase();
        const rows = document.querySelectorAll('#achievementTable tbody tr');

        rows.forEach(row => {
            const category = row.cells[1].textContent.toLowerCase();
            const activityName = row.cells[2].textContent.toLowerCase();

            if (category.includes(searchValue) || activityName.includes(searchValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

 	function viewAchievement(id) {
        window.location.href = `/adminschool/view/${id}`;
    }

    function showModal(achievementId) {
        const overlay = document.getElementById('overlay');
        const modal = document.getElementById('confirmationModal');
        const deleteAchievementId = document.getElementById('deleteAchievementId');
        deleteAchievementId.value = achievementId;

        overlay.style.display = 'flex'; // Show overlay
        modal.style.display = 'block'; // Show modal
    }

    function hideModal() {
        const overlay = document.getElementById('overlay');
        const modal = document.getElementById('confirmationModal');

        overlay.style.display = 'none'; // Hide overlay
        modal.style.display = 'none'; // Hide modal
    }
    </script>
</body>
</html>
