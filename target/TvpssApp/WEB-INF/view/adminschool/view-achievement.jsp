<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Student Achievement</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/achievement.css' />">
    <script>
        function toggleFormMode() {
            const formMode = document.getElementById('form-mode').value;
            document.getElementById('single-form').style.display = formMode === 'Individual Achievement Form' ? 'block' : 'none';
            document.getElementById('multiple-form').style.display = formMode === 'Multiple Achievement Form' ? 'block' : 'none';
        }

        window.onload = toggleFormMode;
    </script>
</head>
<body>
    <div class="main-container">
        <%@ include file="/WEB-INF/view/common/adSchoolsidebar.jsp" %>
        <section class="content">
            <%@ include file="/WEB-INF/view/common/adSchoolheader.jsp" %>
            
            <hr class="divider">
            <br>
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
                    <div class="form-group">
                        <label for="form-mode">Select Form Application</label>
                        <div class="input-wrapper">
                            <input type="text" id="form-mode" name="formMode" value="<c:out value='${achievement.formMode == "single" ? "Individual Achievement Form" : "Multiple Achievement Form"}' />" readonly>
                        </div>
                    </div>

                    <!-- Individual Form -->
                    <div id="single-form" style="display: <c:out value='${achievement.formMode == "single" ? "block" : "none"}' />;">
                        <div class="form-group">
                            <label for="ic-number">IC Number</label>
                            <div class="input-wrapper">
                                <input type="text" id="ic-number" name="icNumber" value="${achievement.icNumber}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="full-name">Full Name</label>
                            <div class="input-wrapper">
                                <input type="text" id="full-name" name="fullName" value="${achievement.fullName}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="activity-name">Activity Name</label>
                            <div class="input-wrapper">
                                <input type="text" id="activity-name" name="activityName" value="${achievement.activityName}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="category">Category</label>
                            <div class="input-wrapper">
                                <input type="text" id="category" name="category" value="${achievement.category}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="sub-category">Sub-category</label>
                            <div class="input-wrapper">
                                <input type="text" id="sub-category" name="subCategory" value="${achievement.subCategory}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="award-info">Award Information</label>
                            <div class="input-wrapper">
                                <input type="text" id="award-info" name="awardInfo" value="${achievement.awardInfo}" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Multiple Form -->
                    <div id="multiple-form" style="display: <c:out value='${achievement.formMode == "multiple" ? "block" : "none"}' />;">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <div class="input-wrapper">
                                <input type="text" id="category" name="category" value="${achievement.category}" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="activity-name">Activity Name</label>
                            <div class="input-wrapper">
                                <input type="text" id="activity-name" name="activityName" value="${achievement.activityName}" readonly>
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
                        <button type="button" class="btn submit" onclick="window.history.back()">Back</button>
                    </div>
                </form>
            </div>
        </section>
    </div>
</body>
</html>