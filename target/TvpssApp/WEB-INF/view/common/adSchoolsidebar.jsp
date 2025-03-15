<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside class="sidebar">
    <div class="sidebar-logo">
        <img src="<c:url value='/resources/images/TvpssLogo.png' />" alt="TVPSS Logo">
        <span>Management Information System</span>
    </div>
    <nav class="sidebar-menu">
        <a href="<c:url value='/adminschool/dashboard' />" class="menu-item ${page == null || page == 'dashboard' ? 'active' : ''}">Dashboard</a>
        <a href="<c:url value='/adminschool/crew-application' />" class="menu-item ${page == 'crew-application' ? 'active' : ''}">Crew Application</a>
        <a href="<c:url value='/adminschool/student-achievement' />" class="menu-item ${page == 'student-achievement' || page == 'submit-achievement' ? 'active' : ''}">Student Achievement</a>
        <a href="<c:url value='/adminschool/school-information' />" class="menu-item ${page == 'school-information' ? 'active' : ''}">School Information</a>
        <a href="<c:url value='/adminschool/submittvpssversion' />" class="menu-item ${page == 'tvpss-version' ? 'active' : ''}">Submit TVPSS Version</a>
    </nav>
    <div class="sidebar-footer">
        <a href="<c:url value='/settings' />" class="menu-item">Settings</a>
        <a href="<c:url value='/login' />" class="menu-item">Log Out</a>
    </div>
</aside>
