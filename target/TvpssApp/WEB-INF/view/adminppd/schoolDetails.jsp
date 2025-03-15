<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Details</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #f5f6fa;
        }

        .main-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background: #fff;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .logo img {
            width: 40px;
            height: 40px;
        }

        .logo h2 {
            color: #333;
            margin: 0;
        }

        nav ul {
            list-style: none;
            margin-top: 20px;
        }

        nav ul li a {
            display: block;
            padding: 12px 15px;
            color: #555;
            text-decoration: none;
            border-radius: 5px;
            margin: 5px 0;
            transition: all 0.3s ease;
        }

        nav ul li a:hover {
            background: #f0f2ff;
        }

        nav ul li a.active {
            background: #4b5db5;
            color: white;
        }

        .content {
            flex: 1;
            padding: 20px 40px;
        }

        .breadcrumb {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-bottom: 20px;
            color: #666;
        }

        .breadcrumb a {
            color: #4b5db5;
            text-decoration: none;
        }

        .page-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
        }

        .details-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .details-section, .checklist-section {
            background: #fff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        h4 {
            color: #4b5db5;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
            font-size: 18px;
        }

        .details-list, .checklist {
            list-style: none;
        }

        .details-list li {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .details-list li span:first-child {
            width: 150px;
            font-weight: 500;
            color: #666;
        }

        .details-list li:last-child {
            border-bottom: none;
        }

        .details-list img {
            max-width: 100px;
            height: auto;
        }

        .details-list a {
            color: #4b5db5;
            text-decoration: none;
        }

        .details-list a:hover {
            text-decoration: underline;
        }

        .checklist li {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .checklist li:last-child {
            border-bottom: none;
        }

        .checklist input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #4b5db5;
        }

        .status-upgrade {
            text-align: center;
            margin-bottom: 20px;
        }

        .status-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 10px;
        }

        .status-arrows {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            font-size: 24px;
            font-weight: bold;
        }

        .status-from {
            color: #4b5db5;
        }

        .status-to {
            color: #f44336;
        }

        select {
            width: 100%;
            padding: 10px;
            margin: 15px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .update-button {
            width: 100%;
            background: #4b5db5;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .update-button:hover {
            background: #3f4f9f;
        }
        
         .return-button {
        margin-top: 10px;
        background-color: #f44336;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: background 0.3s ease;
    }

    .return-button:hover {
        background-color: #d32f2f;
    }
    </style>
</head>
<body>
    <div class="main-container">
        <aside class="sidebar">
            <div class="logo">
                <img src="/TvpssApp/resources/images/TvpssLogo.png" alt="TVPSS Logo">
                <h2>TVPSS</h2>
            </div>
            <nav>
                <ul>
                    <li><a href="/TvpssApp/adminppd/dashboard">Dashboard</a></li>
                    <li><a href="/TvpssApp/adminppd/schoolValidation" class="active">School TVPSS Validation</a></li>
                </ul>
            </nav>
        </aside>

        <main class="content">
            <div class="breadcrumb">
                <a href="#">TVPSS Management</a>
                <span>></span>
                <a href="#">School Details</a>
                <span>></span>
                <span>${school.name}</span>
            </div>

            <h1 class="page-title">School Information</h1>

            <div class="details-container">
                <div class="details-section">
                    <h4>School Information</h4>
                    <ul class="details-list">
                        <li><span>School Code:</span><span>${school.code}</span></li>
                        <li><span>School Name:</span><span>${school.name}</span></li>
                        <li><span>School Officer Name:</span><span>${school.schoolOfficerName}</span></li>
                        <li><span>Address 1:</span><span>${school.address1}</span></li>
                        <li><span>Address 2:</span><span>${school.address2}</span></li>
                        <li><span>Postcode:</span><span>${school.postcode}</span></li>
                        <li><span>State:</span><span>${school.state}</span></li>
                        <li><span>Telephone:</span><span>${school.telephoneNumber}</span></li>
                        <li><span>Green Screen Technology:</span><span>${school.greenScreenTechnology}</span></li>
                        <li><span>Recording Equipment:</span><span>${school.recordingEquipment}</span></li>
                        <li><span>Conner Mini TV:</span><span>${school.connerminittv}</span></li>
                        <li><span>Collaboration With External Agencies:</span><span>${school.collaborationExternalAgencies}</span></li>
                        <li><span>Email:</span><span>${school.email}</span></li>
                        <li><span>Logo TVPSS:</span>
                            <span>
                                <c:if test="${not empty school.logo}">
                                    <img src="<c:url value='/adminschool/school-logo/${school.code}' />" alt="School Logo" width="100">
                                </c:if>
                                <c:if test="${empty school.logo}">
                                    <span>No logo uploaded</span>
                                </c:if>
                            </span>
                        </li>
                        <li><span>YouTube Link:</span>
                            <span>
                                <c:if test="${not empty school.youtubeLink}">
                                    <a href="${school.youtubeLink}" target="_blank">${school.youtubeLink}</a>
                                </c:if>
                                <c:if test="${empty school.youtubeLink}">
                                    <span>No link provided</span>
                                </c:if>
                            </span>
                        </li>
                    </ul>
                </div>

                <div class="checklist-section">
                    <h4>MEET THE REQUIREMENTS</h4>
                    <div class="status-upgrade">
                        <div class="status-text">Upgrade Version Status</div>
                        <div class="status-arrows">
                            <span class="status-from">${school.tvpssVersion != null ? school.tvpssVersion : 0}</span>
                            <span>→</span>
                            <span><strong id="calculated-version">${school.tvpssVersion}</strong></span>
                        </div> 
                    </div>

<!-- Existing Update Version Status Form -->
<form id="checklistForm" method="post" action="${pageContext.request.contextPath}/adminppd/updateVersionStatus" onsubmit="calculateAndSubmit(event)">
    <input type="hidden" name="schoolCode" value="${school.code}">
    <input type="hidden" id="calculatedVersion" name="tvpssVersion" value="${school.tvpssVersion}">
    
    

    <label>Update Version Status:</label>
    <select name="versionStatus">
        <option value="Active" ${school.versionStatus == 'Active' ? 'selected' : ''}>Active</option>
        <option value="Inactive" ${school.versionStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
    </select>

    <button type="submit" class="update-button">Update TVPSS Status</button>
</form>

<form id="updateVersionForm" method="post" action="${pageContext.request.contextPath}/adminppd/updateTvpssVersion">
    <input type="hidden" name="schoolCode" value="${school.code}">
    <input type="hidden" id="updateTvpssVersionInput" name="tvpssVersion">

    <ul class="checklist">
        <li>
            <input type="checkbox" name="tvpssLogo" value="true" onchange="updateVersionNumber()" ${school.logoFilename != null ? "checked" : ""}>
            <label>Logo TVPSS</label>
        </li>
        <li>
            <input type="checkbox" name="studio" value="true" onchange="updateVersionNumber()" ${school.studio == "Yes" ? "checked" : ""}>
            <label>Corner/Mini/TV Studio</label>
        </li>
        <li>
            <input type="checkbox" name="youtubeUpload" value="true" onchange="updateVersionNumber()" ${school.youtubeLink != null ? "checked" : ""}>
            <label>Upload to YouTube</label>
        </li>
        <li>
            <input type="checkbox" name="recordingInSchool" value="true" onchange="updateVersionNumber()" ${school.recordingInSchool == "Yes" ? "checked" : ""}>
            <label>Recording in School</label>
        </li>
        <li>
            <input type="checkbox" name="recordingInOutSchool" value="true" onchange="updateVersionNumber()" ${school.recordingInOutSchool == "Yes" ? "checked" : ""}>
            <label>Recording in and out of School</label>
        </li>
        <li>
            <input type="checkbox" name="collaborationExternalAgencies" value="true" onchange="updateVersionNumber()" ${school.collaborationExternalAgencies == "Yes" ? "checked" : ""}>
            <label>Collaboration with External Agencies</label>
        </li>
        <li>
            <input type="checkbox" name="greenScreenTechnology" value="true" onchange="updateVersionNumber()" ${school.greenScreenTechnology == "Yes" ? "checked" : ""}>
            <label>Green Screen Technology</label>
        </li>
    </ul>
    <button type="submit" class="update-button">Update TVPSS Version</button>
</form>

<!-- Return Button -->
<button class="return-button" onclick="redirectToSchoolValidation()">Return</button>

<script>
function updateVersionNumber() {
    let version = 0;  // Default version
    document.querySelectorAll('input[type="checkbox"]:checked').forEach(() => version++);
    document.getElementById('calculatedVersion').value = version;  // Update hidden input for both forms
    document.getElementById('updateTvpssVersionInput').value = version;  // Ensure consistency for the second form
    document.getElementById('calculated-version').innerText = version;  // Update UI display
}

function submitTvpssVersion(event) {
    event.preventDefault();  // Prevent default form submission

    const form = document.getElementById('updateVersionForm');
    const formData = new FormData(form);

    fetch(form.action, {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.ok) {
            alert('TVPSS Version updated successfully!');
            redirectToSchoolValidation();  // Redirect to school validation page
        } else {
            alert('Failed to update TVPSS Version. Please try again.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An unexpected error occurred.');
    });
}

function redirectToSchoolValidation() {
    window.location.href = "${pageContext.request.contextPath}/adminppd/schoolValidation";
}
</script>




                </div>
            </div>
        </main>
    </div>
</body>
</html>