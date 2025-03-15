<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit TVPSS Version</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/schoolInformation.css' />">
    <style>
    input[type="radio"] {
    margin: 0;
    position: relative;
    top: 20px; /* Adjust this value to control how far down the radio button moves */
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
            <div class="title-container">
                <h2>Submit TVPSS Version</h2>
            </div>
            
            <div class="form-container">
                <form action="<c:url value='/adminschool/save-tvpss-version' />" method="POST" id="tvpssForm">
                    <!-- School Details (Read-Only Fields) -->
                    <h3>School Details</h3>
                    <input type="hidden" id="schoolCode" name="schoolCode" value="${school.code}">

                    <div class="form-group">
                        <label for="schoolName">School Name</label>
                        <input type="text" id="schoolName" name="schoolName" value="${school.name}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${school.email}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="address1">Address 1</label>
                        <input type="text" id="address1" name="address1" value="${school.address1}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="address2">Address 2</label>
                        <input type="text" id="address2" name="address2" value="${school.address2}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="postcode">Postcode</label>
                        <input type="text" id="postcode" name="postcode" value="${school.postcode}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="state">State</label>
                        <input type="text" id="state" name="state" value="${school.state}" readonly>
                    </div>

                    <!-- TVPSS Version Section -->
                    <h4>TVPSS Version Details</h4>

                    <div class="form-group">
                        <label>Connerminittv Available</label>
                        <label>
                            <input type="radio" name="connerminittv" value="Yes" ${school.connerminittv == 'Yes' ? 'checked' : ''}>
                            Yes
                        </label>
                        <label>
                            <input type="radio" name="connerminittv" value="No" ${school.connerminittv == 'No' ? 'checked' : ''}>
                            No
                        </label>
                    </div>


                    <div class="form-group">
                        <label>Recording Equipment Available</label>
                        <label>
                            <input type="radio" name="recordingEquipment" value="Yes" ${school.recordingEquipment == 'Yes' ? 'checked' : ''}>
                            Yes
                        </label>
                        <label>
                            <input type="radio" name="recordingEquipment" value="No" ${school.recordingEquipment == 'No' ? 'checked' : ''}>
                            No
                        </label>
                    </div>

                    <div class="form-group">
                        <label>Collaborate with external agencies</label>
                        <label>
                            <input type="radio" name="collaborationExternalAgencies" value="Yes" ${school.collaborationExternalAgencies == 'Yes' ? 'checked' : ''}>
                            Yes
                        </label>
                        <label>
                            <input type="radio" name="collaborationExternalAgencies" value="No" ${school.collaborationExternalAgencies == 'No' ? 'checked' : ''}>
                            No
                        </label>
                    </div>

                    <div class="form-group">
                        <label>Green Screen Technology</label>
                        <label>
                            <input type="radio" name="greenScreenTechnology" value="Yes" ${school.greenScreenTechnology == 'Yes' ? 'checked' : ''}>
                            Yes
                        </label>
                        <label>
                            <input type="radio" name="greenScreenTechnology" value="No" ${school.greenScreenTechnology == 'No' ? 'checked' : ''}>
                            No
                        </label>
                    </div>

                    <!-- Submit Button -->
                    <div class="form-actions">
                        <button type="submit" class="btn submit">Save TVPSS Version</button>
                    </div>
                </form>
            </div>
        </section>
    </div>

    <script>
        // Show confirmation when the form is submitted
        document.getElementById('tvpssForm').addEventListener('submit', function (e) {
            alert('The TVPSS version details have been submitted successfully.');
        });
    </script>

</body>
</html>
