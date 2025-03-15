<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Student Achievement</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/achievement.css' />">
</head>
<body>
    <div class="main-container">
        <!-- Sidebar -->
    <%@ include file="/WEB-INF/view/common/adSchoolsidebar.jsp" %>

        <!-- Main Content -->
        <section class="content">
            <%@ include file="/WEB-INF/view/common/adSchoolheader.jsp" %>
            
            <hr class="divider">
            <br>
            <!-- School Information Form -->
            <div class="title-container">
                <h2>${achievementTitle}</h2>
            </div>
            
            <div class="breadcrumb-container">
		    <nav aria-label="breadcrumb">
		        <ol class="breadcrumb">
		            <li><a href="student-achievement">Student Achievement List</a></li>
		            <li aria-current="page">${achievementTitle}</li>
		        </ol>
		    </nav>
			</div>
		<div class="form-container">
		    <h1>Student Information</h1>
		    <form method="POST" action="<c:url value='/adminschool/submit-achievement' />" enctype="multipart/form-data">
			    <c:if test="${isEdit}">
			        <input type="hidden" name="achievementId" value="${achievement.achievementId}">
			        <input type="hidden" name="formMode" value="${achievement.formMode}">
			    </c:if>
			    
			    <c:if test="${!isEdit}">
			        <div class="form-group">
			            <label for="form-mode">Select Form Application</label>
			            <div class="input-wrapper">
			                <select id="form-mode" name="formMode" onchange="toggleFormMode()">
			                    <option disabled selected>- Choose Form Type-</option>
			                    <option value="single">Individual Achievement Form</option>
			                    <option value="multiple">Multiple Achievement Form</option>
			                </select>
			            </div>
			        </div>
			    </c:if>
    					 
		        <!-- Individual Form -->
		        <div id="single-form" style="display: ${isEdit || empty formMode ? 'block' : 'none'};">
		        
			        <div class="form-group">
			            <label for="ic-number">IC Number</label>
			            <div class="input-wrapper">
			            	<input type="text" id="ic-number" name="icNumber" value="${achievement.icNumber}" required>
			            </div>
	   				</div>
			        <div class="form-group">   				
			            <label for="full-name">Full Name</label>
			            <div class="input-wrapper">
			            	<input type="text" id="full-name" name="fullName" value="${achievement.fullName}" required>
			            </div>
	   				</div>
	   				<div class="form-group">  		            
			            <label for="activity-name">Activity Name</label>
			            <div class="input-wrapper">
			            <input type="text" id="activity-name-single" name="activityName" value="${achievement.activityName}" required>
			            </div>
	   				</div>
	   				<div class="form-group">
			            <label for="category">Category</label>
			            <div class="input-wrapper">
			                <select id="category-single" name="category" required>
			                    <option disabled ${empty achievement.category ? 'selected' : ''}>- Choose Achievement Category -</option>
			                    <c:forEach items="${['Academic Achievement', 'Cultural Achievement', 'Innovation Achievement', 'Sport Achievement', 'Volunteer']}" var="cat">
			                        <option value="${cat}" ${achievement.category == cat ? 'selected' : ''}>
			                        	${cat}
			                        </option>
			                    </c:forEach>
			                </select>
			            </div>
			        </div>
	   				<div class="form-group">  		
			            <label for="sub-category">Sub-category</label>
			            <div class="input-wrapper">
			            	<input type="text" id="sub-category" name="subCategory" value="${achievement.subCategory}">
			            </div>
	   				</div> 	
					<div class="form-group">
            <label for="award-info">Award Information</label>
            <div class="input-wrapper">
                <select id="award-info" name="awardInfo">
                    <option disabled ${empty achievement.awardInfo ? 'selected' : ''}>- Choose Award -</option>
                    <c:forEach items="${['Champion', 'Runner-up', 'Third Place', 'Consolation', 'Participation']}" var="award">
                        <option value="${award}" ${achievement.awardInfo == award ? 'selected' : ''}>
                            ${award}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>
		        </div>
		
		        <!-- Multiple Form -->
		        <div id="multiple-form" style="display: none;">
		        
			        <div class="form-group">  	
			        	<label for="category">Category</label>
			        	<div class="input-wrapper">
				            <select id="category-multiple" name="category" value="${achievements.category}" required>
		                        <option disabled selected>- Choose Achievement Category -</option>
				                <option value="Academic Achievement">Academic Achievement</option>
				                <option value="Cultural Achievement">Cultural Achievement</option>
				                <option value="Innovation Achievement">Innovation Achievement</option>
				                <option value="Sport Achievement">Sport Achievement</option>
				                <option value="Volunteer">Volunteer</option>
				            </select>
			            </div>
	   				</div>
					<div class="form-group">  
			            <label for="activity-name">Activity Name</label>
			            <div class="input-wrapper">
			            	<input type="text" id="activity-name-multiple" name="activityName" value="${achievements.activityName}" required>
			            </div>
	   				</div>
			        <div class="form-group">     
			            <label for="csv-file">Choose CSV/Excel File</label>
			            <div class="input-wrapper">
			            	<input type="file" id="uploadDoc" name="uploadDoc" accept=".csv, .xlsx">
			            </div>
	   				</div>
					<div class="form-group">  
			            <label for="support-files">Choose Supporting Documents</label>
			            <div class="input-wrapper">
			            	<input type="file" id="support-files" name="supportDoc" multiple>
			            </div>
	   				</div>
		        </div>
			
		        <div class="form-actions">
			        <button type="button" class="btn cancel" onclick="window.history.back()">Cancel</button>
			        <button type="submit" class="btn submit">
			            ${isEdit ? 'Update' : 'Submit'}
			        </button>
			    </div>
                
			    </form>
			</div>
			
			<div id="confirmation-dialog" class="confirmation-dialog hidden">
	    		<div class="confirmation-content">
	        		<h3>Are you sure you want to submit the school information?</h3>
	        		<p>The data in your form will be saved if you leave the tab.</p>
	        	<div class="dialog-actions">
	            	<button class="btn cancel" onclick="closeConfirmationDialog()">Cancel</button>
	            	<button class="btn submit" onclick="submitForm()">Submit</button>
	        	</div>
	        	</div>
	        </div>
	        
	        <!-- Success Dialog -->
		    <div id="successModal" class="modal">
		        <div class="modal-content">
		            <span class="close" onclick="closeSuccessDialog()">&times;</span>
		            <h2>${successMessage}</h2>
		            <p>Your data has been recorded to the system.</p>
		        </div>
		    </div>
		</section>
	</div>
	
<script>
// Global functions need to be accessible from HTML
window.closeConfirmationDialog = function() {
    document.getElementById('confirmation-dialog').classList.add('hidden');
};

window.closeSuccessDialog = function() {
    document.getElementById('successModal').classList.add('hidden');
};

// Form mode toggling function
window.toggleFormMode = function() {
    if (!${isEdit}) {
        const formMode = document.getElementById("form-mode").value;
        const singleForm = document.getElementById("single-form");
        const multipleForm = document.getElementById("multiple-form");

        if (formMode === "single") {
            singleForm.style.display = "block";
            multipleForm.style.display = "none";
        } else if (formMode === "multiple") {
            singleForm.style.display = "none";
            multipleForm.style.display = "block";
        }
    }
};

// Main initialization code
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    const submitButton = document.querySelector('.form-actions .btn.submit');
    const confirmationDialog = document.getElementById('confirmation-dialog');
    const confirmDialogSubmitBtn = document.querySelector('.dialog-actions .btn.submit');
    const confirmDialogCancelBtn = document.querySelector('.dialog-actions .btn.cancel');

    // Initialize edit mode form display if needed
    if (${isEdit}) {
        const formMode = '${achievement.formMode}';
        const singleForm = document.getElementById("single-form");
        const multipleForm = document.getElementById("multiple-form");
        
        if (formMode.toLowerCase() === 'single') {
            singleForm.style.display = "block";
            multipleForm.style.display = "none";
        } else if (formMode.toLowerCase() === 'multiple') {
            singleForm.style.display = "none";
            multipleForm.style.display = "block";
        }
    }

    function validateForm(formMode) {
        let isValid = true;
        
        // Clear previous error messages
        document.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
        document.querySelectorAll('.error-message').forEach(el => el.remove());

        // Skip form mode validation for edit mode
        if (!${isEdit}) {
            if (!formMode) {
                alert('Please select a form application type');
                return false;
            }
        }

        if (${isEdit} || formMode === 'single') {
            // Validate single form fields
            const singleFormFields = document.querySelectorAll('#single-form input[required], #single-form select[required]');
            singleFormFields.forEach(field => {
                if (!field.value) {
                    isValid = false;
                    addErrorToField(field);
                }
            });
        } else if (formMode === 'multiple') {
            // Validate multiple form fields
            const multipleCategory = document.getElementById('category-multiple');
            const activityName = document.getElementById('activity-name-multiple');
            const fileInput = document.getElementById('uploadDoc');

            if (!multipleCategory.value) {
                isValid = false;
                addErrorToField(multipleCategory);
            }

            if (!activityName.value) {
                isValid = false;
                addErrorToField(activityName);
            }

            if (!fileInput.files.length) {
                isValid = false;
                addErrorToField(fileInput);
            }
        }

        return isValid;
    }

    function addErrorToField(field) {
        field.classList.add('error');
        const errorText = document.createElement('span');
        errorText.classList.add('error-message');
        errorText.textContent = 'This field is required';
        field.parentNode.appendChild(errorText);
    }

    function openConfirmationDialog() {
        confirmationDialog.classList.remove('hidden');
    }

    // Submit button click handler
    submitButton.addEventListener('click', function(event) {
        event.preventDefault();
        
        const formMode = ${isEdit} ? '${achievement.formMode}' : document.getElementById('form-mode').value;
        
        if (validateForm(formMode)) {
            openConfirmationDialog();
        }
    });

    // Confirmation dialog submit button
    confirmDialogSubmitBtn.addEventListener('click', function() {
        closeConfirmationDialog();
        form.submit();
    });

    // Confirmation dialog cancel button
    confirmDialogCancelBtn.addEventListener('click', closeConfirmationDialog);
});
</script>

</body>
</html>
