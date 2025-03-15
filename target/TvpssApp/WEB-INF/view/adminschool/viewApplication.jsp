<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Crew Application</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/view-crew-application.css' />">
</head>
<body>
    <div class="main-container">
        <!-- Sidebar -->
        <%@ include file="/WEB-INF/view/common/adSchoolsidebar.jsp" %>

        <!-- Content -->
        <section class="content">
            <%@ include file="/WEB-INF/view/common/adSchoolheader.jsp" %>

<div class="container">
    <div class="header-container">
        <h2>Crew Application Information</h2>
        <a href="/TvpssApp/adminschool/crew-application" class="btn">Back</a>
    </div>
    <form action="/TvpssApp/adminschool/updateStatus" method="post">
        <input type="hidden" name="applicationIds" value="${application.id}" />
        <label for="fullName">Full Name</label>
        <input type="text" id="fullName" value="${application.fullName}" readonly />

        <label for="icNumber">IC Number</label>
        <input type="text" id="icNumber" value="${application.icNumber}" readonly />

        <label for="email">Email</label>
        <input type="text" id="email" value="${application.email}" readonly />

        <label for="form">Form</label>
        <input type="number" id="form" value="${application.form}" readonly />

        <label for="schoolName">School</label>
        <input type="text" id="school" value="${application.schoolName}" readonly />

        <label for="address">Address</label>
        <input type="text" id="address" value="${application.region}, ${application.state}" readonly />

        <label for="position">Position</label>
        <input type="text" id="position" value="${application.position}" readonly />

        <label for="status">Application Status</label>
        <select name="status" id="status">
            <option value="In Progress" ${application.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
            <option value="Accepted" ${application.status == 'Accepted' ? 'selected' : ''}>Accepted</option>
            <option value="Rejected" ${application.status == 'Rejected' ? 'selected' : ''}>Rejected</option>
        </select>

        <button type="submit">Update Application</button>
    </form>
</div>

</body>
</html>
