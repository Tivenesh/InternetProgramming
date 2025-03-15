<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Result</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/application-result.css">
</head>
<body>
<section class="content">
    <%@ include file="/WEB-INF/view/common/studentHeader.jsp" %>

<div class="result-container">
    <img src="/TvpssApp/resources/images/status.png" alt="Application-result" class="application-result-image">
    <div class="result-box">
        <div class="result-header"></div>
        <h1>
            <c:choose>
                <c:when test="${application.status eq 'In Progress'}">In Progress</c:when>
                <c:when test="${application.status eq 'Accepted'}">Congratulations!</c:when>
                <c:otherwise>Unsuccessful</c:otherwise>
            </c:choose>
        </h1>

        <div class="application-details">
            <p><strong>Full Name:</strong> ${application.fullName}</p>
            <p><strong>IC No:</strong> ${application.icNumber}</p>
            <p>
                <strong>Application Status:</strong> 
                <span class="${application.status eq 'In Progress' ? 'pending' : (application.status eq 'Accepted' ? 'success' : 'rejected')}">
                    <c:choose>
                        <c:when test="${application.status eq 'Accepted'}">Success</c:when>
                        <c:when test="${application.status eq 'Rejected'}">Unsuccessful</c:when>
                        <c:otherwise>${application.status}</c:otherwise>
                    </c:choose>
                </span>
            </p>

            <!-- Show Comment only if Status is Success or Unsuccessful -->
            <c:if test="${application.status ne 'In Progress'}">
                <p class="comment-section">
                    <strong>Comment From Teacher:</strong> 
                </p>
            </c:if>
        </div>

        <!-- Message Based on Status -->
        <c:if test="${application.status ne 'In Progress'}">
            <p class="result-message">
                <c:choose>
                    <c:when test="${application.status eq 'Accepted'}">
                        We are pleased to inform you that your application has been accepted. 
                        Congratulations on your achievement! You have demonstrated excellent performance, 
                        and we are confident that you will continue to succeed.
                    </c:when>
                    <c:otherwise>
                        We regret to inform you that your application was unsuccessful. We appreciate the effort 
                        and time you dedicated to preparing your application. Unfortunately, we received many applications, 
                        and we had to make some difficult decisions.
                    </c:otherwise>
                </c:choose>
            </p>
        </c:if>

        <!-- Action Buttons (Back and Print) -->
        <div class="action-buttons">
            <a href="/TvpssApp/student/dashboard" class="back-btn">Back</a>
            
            <!-- Print Button Hidden if In Progress -->
            <c:if test="${application.status ne 'In Progress'}">
                <button class="print-btn" onclick="window.print()">Print Result</button>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>
