<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage School Information</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/schoolInformation.css' />">
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
                <h2>School Information</h2>
            </div>
            
            
            <div class="form-container">
                <form action="<c:url value='/adminschool/save-school-information'/>" method="POST" enctype="multipart/form-data" id="schoolForm">
                    <div class="form-group">
                    	<label for="schoolCode">School Code</label>
                        <div class="input-wrapper">
        					<input type="text" name="code" id="schoolCode" placeholder="Enter school code" value="${school.code}" required>
        					<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('schoolCode')" alt="Clear">
    					</div>
    				</div>
    					
    				<div class="form-group">
                        <label for="schoolName">School Name</label>
                        <div class="input-wrapper">
        					<input type="text" name="name" id="schoolName" placeholder="Enter school name" value="${school.name}" required>
        					<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('schoolName')" alt="Clear">
    					</div>
                    </div>

                    <div class="form-group">
                        <label for="schoolAddress1">School Address I</label>
                        <div class="input-wrapper">
                        	<input type="text" name="address1" id="schoolAddress1" placeholder="Enter school address I" value="${school.address1}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('schoolAddress1')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="schoolAddress2">School Address II</label>
                        <div class="input-wrapper">
                        	<input type="text" name="address2" id="schoolAddress2" placeholder="Enter school address II" value="${school.address2}">
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('schoolAddress2')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group half-width">
                        <label for="schoolOfficerName">School Officer Name</label>
                        <div class="input-wrapper">
                        	<input type="text" name="schoolOfficerName" id="schoolOfficerName" placeholder="Enter school officer name" value="${school.schoolOfficerName}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('schoolOfficerName')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group half-width">
                        <label for="postcode">Postcode</label>
                        <div class="input-wrapper">
                        	<input type="text" name="postcode" id="postcode" placeholder="Enter postcode" value="${school.postcode}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('postcode')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group half-width">
                        <label for="state">State</label>
                        <div class="input-wrapper">
                        	<input type="text" name="state" id="state" placeholder="Enter state" value="${school.state}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('state')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group half-width">
                        <label for="telephone">Tel. No</label>
                        <div class="input-wrapper">
                        	<input type="text" name="telephoneNumber" id="telephoneNumber" placeholder="Enter telephone number" value="${school.telephoneNumber}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('telephoneNumber')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group half-width">
                        <label for="email">Email</label>
                        <div class="input-wrapper">
                        	<input type="email" name="email" id="email" placeholder="Enter school email" value="${school.email}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('email')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="logo">School Logo</label>
                        <div class="input-wrapper">
                        	<input type="file" name="logoFile" id="logoFile" accept="image/*" value="${school.logoFile}">
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('logoFile')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="youtubeLink">Link Video</label>
                        <div class="input-wrapper">
                        	<input type="url" name="youtubeLink" id="youtubeLink" placeholder="Upload YouTube link" value="${school.youtubeLink}" required>
                        	<img src="<c:url value='/resources/images/clearIcon.png' />" class="clear-icon" onclick="clearInput('youtubeLink')" alt="Clear">
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn cancel" onclick="window.history.back()">Cancel</button>
                        <button type="submit" class="btn submit">Submit</button>
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
        
        <!-- Success Dialog
    <div id="successModal" class="modal" style="display: ${not empty successMessage ? 'block' : 'none'};">
        <div class="modal-content">
            <span class="close" onclick="closeSuccessDialog()">&times;</span>
            <h2>${successMessage}</h2>
            <p>Your data has been recorded to the system.</p>
        </div>
    </div> -->

</section>
</div>
    
    
    
<script>
    // Function to clear the input field
    function clearInput(inputId) {
    const inputField = document.getElementById(inputId);
    if (inputField) {
        if (inputField.type === 'file') {
            // Create a new file input element
            const newInput = document.createElement('input');
            newInput.type = 'file';
            newInput.name = inputField.name;
            newInput.accept = inputField.accept;
            newInput.className = inputField.className;
            newInput.required = inputField.required;
            
            // Replace the existing input with the new one
            inputField.parentNode.replaceChild(newInput, inputField);
        } else {
            // Clear regular text, email, or URL inputs
            inputField.value = '';
            inputField.focus();
        }
    }
}

    
    function validateForm() {
        let isValid = true; // Flag to track if the form is valid
        const formFields = document.querySelectorAll('input[required]'); // Select all required fields

        formFields.forEach((field) => {
            if (!field.value.trim()) { // Check if the field is empty
                isValid = false;
                field.classList.add('error'); // Add an error class to highlight the field
                const errorText = document.createElement('span'); // Create error message
                errorText.classList.add('error-message');
                errorText.textContent = 'This field is required';
                if (!field.parentNode.querySelector('.error-message')) { // Add message if not already present
                    field.parentNode.appendChild(errorText);
                }
            } else {
                field.classList.remove('error'); // Remove error highlight if field is valid
                const errorText = field.parentNode.querySelector('.error-message');
                if (errorText) {
                    field.parentNode.removeChild(errorText); // Remove error message
                }
            }
        });

        // Validate the file input specifically
        const fileInput = document.querySelector("input[name='logoFile']");
        if (fileInput && fileInput.files.length === 0 && !fileInput.hasAttribute('optional')) {
            isValid = false;
            fileInput.classList.add('error');
            if (!fileInput.parentNode.querySelector('.error-message')) {
                const errorText = document.createElement('span');
                errorText.classList.add('error-message');
                errorText.textContent = 'Please upload a file.';
                fileInput.parentNode.appendChild(errorText);
            }
        }
        
        return isValid;
    }
    
    function openConfirmationDialog() {
    const dialog = document.getElementById('confirmation-dialog');
    dialog.classList.remove('hidden');
}

function closeConfirmationDialog() {
    const dialog = document.getElementById('confirmation-dialog');
    dialog.classList.add('hidden');
    
}

function submitForm() {
    closeConfirmationDialog(); // Hide the dialog
    document.querySelector('form').submit(); // Submit the form
}

//Ensure the event listener is added only once
document.addEventListener('DOMContentLoaded', function () {
    const submitButton = document.querySelector('.form-actions .btn.submit');

    submitButton.addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default form submission
        
        if(validateForm()){
        openConfirmationDialog(); // Open the dialog
        }
    });

    const cancelButton = document.querySelector('.dialog-actions .btn.cancel');
    cancelButton.addEventListener('click', function () {
        closeConfirmationDialog(); // Close the dialog when "Cancel" is clicked
    });

    const confirmButton = document.querySelector('.dialog-actions .btn.submit');
    confirmButton.addEventListener('click', function () {
        submitForm(); // Submit the form when "Submit" is confirmed
    });
});

//Function to open the success dialog
function openSuccessDialog() {
    const modal = document.getElementById("successModal");
    modal.style.display = "block";
}

// Function to close the success dialog
function closeSuccessDialog() {
    const modal = document.getElementById("successModal");
    modal.style.display = "none";
}

// Close the modal when the user clicks outside of it
window.onclick = function(event) {
    const modal = document.getElementById("successModal");
    if (event.target === modal) {
        modal.style.display = "none";
    }
};


   
</script>


</body>
</html>