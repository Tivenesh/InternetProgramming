<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Details</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/superAdminDashboard.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F8FAFF;
            margin: 0;
            padding: 0;
        }

        .main-container {
            display: flex;
        }

        .sidebar {
            width: 250px;
            background-color: #4B6CB7;
            padding: 20px;
            color: white;
            height: 100vh;
        }

        .sidebar .logo img {
            max-width: 100%;
        }

        .sidebar h2 {
            font-size: 18px;
            margin: 20px 0;
            text-align: center;
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
        }

        .sidebar nav ul li {
            margin: 15px 0;
        }

        .sidebar nav ul li a {
            text-decoration: none;
            color: white;
            display: block;
            padding: 10px;
            border-radius: 5px;
        }

        .sidebar nav ul li a.active {
            background-color: #354A9F;
        }

        .content {
            flex: 1;
            padding: 20px;
        }

        .details-container {
            margin: 20px 0;
        }

        .details-section, .checklist-section {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .details-section h4, .checklist-section h4 {
            margin-bottom: 15px;
            color: #4B6CB7;
        }

        .details-list {
            list-style: none;
            padding: 0;
        }

        .details-list li {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .details-list li span {
            font-size: 14px;
        }

        .checklist {
            list-style: none;
            padding: 0;
        }

        .checklist li {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .checklist li input {
            margin-right: 10px;
        }

        .update-button {
            background-color: #4B6CB7;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .update-button:hover {
            background-color: #354A9F;
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
                <li><a href="/TvpssApp/adminstate/dashboard">Dashboard</a></li>
                <li><a href="/TvpssApp/adminstate/schoolVersion/view" class="active">View School Version Status</a></li>
            </ul>
        </nav>
    </aside>

    <main class="content">
        <header class="header">
            <h1>School Details</h1>
        </header>

        <div class="details-container">
            <!-- School Information Section -->
            <div class="details-section">
                <h4>School Information</h4>
                <ul class="details-list">
                    <li><span>School Code:</span><span>${school.code}</span></li>
                    <li><span>School Name:</span><span>${school.name}</span></li>
                    <li><span>Address 1:</span><span>${school.address1}</span></li>
                    <li><span>Address 2:</span><span>${school.address2}</span></li>
                    <li><span>Postcode:</span><span>${school.postcode}</span></li>
                    <li><span>State:</span><span>${school.state}</span></li>
                    <li><span>Telephone:</span><span>${school.telephoneNumber}</span></li>
                    <li><span>Email:</span><span>${school.email}</span></li>
                    <li><span>Logo TVPSS:</span>
                        <c:if test="${not empty school.logo}">
                            <img src="<c:url value='/adminschool/school-logo/${school.code}' />" alt="School Logo" width="100">
                        </c:if>
                        <c:if test="${empty school.logo}">
                            <span>No logo uploaded</span>
                        </c:if>
                    </li>
                    <li><span>YouTube Link:</span>
                        <c:if test="${not empty school.youtubeLink}">
                            <a href="${school.youtubeLink}" target="_blank">${school.youtubeLink}</a>
                        </c:if>
                        <c:if test="${empty school.youtubeLink}">
                            <span>No link provided</span>
                        </c:if>
                    </li>
                </ul>
            </div>

            <!-- Checklist Section -->
            <div class="checklist-section">
                <h4>Requirements Checklist</h4>
                <form id="checklistForm" method="post" action="/TvpssApp/adminstate/updateVersionStatus">
                    <input type="hidden" name="schoolCode" value="${school.code}">
                    <ul class="checklist">
                        <li>
                            <input type="checkbox" name="tvpssLogo" value="true" ${school.tvpssLogo ? "checked" : ""}>
                            <label>Logo TVPSS</label>
                        </li>
                        <li>
                            <input type="checkbox" name="studio" value="true" ${school.studio ? "checked" : ""}>
                            <label>Corner/Mini/TV Studio</label>
                        </li>
                        <li>
                            <input type="checkbox" name="youtubeUpload" value="true" ${school.youtubeUpload ? "checked" : ""}>
                            <label>Upload to YouTube</label>
                        </li>
                        <li>
                            <input type="checkbox" name="recordingInSchool" value="true" ${school.recordingInSchool ? "checked" : ""}>
                            <label>Recording in School</label>
                        </li>
                        <li>
                            <input type="checkbox" name="recordingInOutSchool" value="true" ${school.recordingInOutSchool ? "checked" : ""}>
                            <label>Recording in and out of School</label>
                        </li>
                    </ul>
                    <label>Update Version Status:</label>
                    <select name="versionStatus">
                        <option value="Active" ${school.versionStatus == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${school.versionStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                    <button type="submit" class="update-button">Update</button>
                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>
