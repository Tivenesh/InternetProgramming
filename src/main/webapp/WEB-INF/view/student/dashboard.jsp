<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tvpss.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Resource Center TV</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background-color: #515B92;
            overflow-x: hidden;
        }
      
        header {
            width: 100vw;
            height: 80px;
            background: #FFFFFF;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 32px;
            box-sizing: border-box;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo img {
            width: 180px;
            height: auto;
        }

        nav {
            display: flex;
            gap: 32px;
            margin-right: 250px;
        }
        nav a {
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            color: #515B92;
        }
        .student-email {
            padding: 10px 24px;
            background: #FFC601;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            color: #30325C;
            text-decoration: none;
            margin-right: 30px;
        }
        .right-section {
            display: flex;
            align-items: center;
            margin-left: auto;
            gap: 20px;  /* Adds spacing between nav, email, and button */
        }
        .apply-btn {
            display: inline-block;
            padding: 10px 24px;
            background: #FFC601;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            color: #30325C;
            text-decoration: none;
        }
        .hero {
            text-align: center;
            color: #FFFFFF;
            padding: 50px 20px;
        }
        .hero h1 {
            font-size: 48px;
            font-weight: 800;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 20px;
            line-height: 1.5;
            margin-bottom: 30px;
            max-width: 760px;
            margin: 0 auto;
        }
        .hero .apply-now {
            background: #FFC601;
            border-radius: 25px;
            padding: 10px 24px;
            color: #000;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            margin-top: 40px;
        }
        .steps {
            width: 760px;
            margin: 0px auto;
            background: #FDFEFF;
            box-shadow: 0 0 4px rgba(0, 0, 0, 0.25);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            margin-bottom: 100px;
        }
        .steps-image img {
            width: 100%;
            display: block;
            border-radius: 10px;
        }
        
        .steps-apply-now {
            display: block;
            background: #FFC601;
            color: #000000;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            padding: 10px 24px;
            border-radius: 25px;
            margin: 20px auto;
            width: 150px;
        }
    </style>
</head>
<body>

    <header>
        <div class="logo">
            <img src="/TvpssApp/resources/images/tvpss.png" alt="Ministry of Education Logo">

        </div>
        <div class="right-section">
        <nav>
            <a href="/TvpssApp/dashboard">Dashboard</a>
            <a href="/TvpssApp/student/application">Application</a>
            <a href="/TvpssApp/login">Log Out</a>
        </nav>
        <div class="student-email">
            <% 
                User loggedInUser = (User) session.getAttribute("loggedInUser");
                if (loggedInUser != null) {
            %>
                <span><%= loggedInUser.getEmail() %></span>
            <% } else { %>
                <span>Guest</span>
            <% } %>
        </div>
        </div>

        <a href="/TvpssApp/student/application" class="apply-btn">Apply Now</a>

    </header>

    <section class="hero">
        <h1>SCHOOL RESOURCE CENTER TV</h1>
        <p>
            Join us in producing interesting and creative news content. An opportunity to learn, create, and share stories on the school platform. Apply now and be part of the team!
        </p>
        <a href="/TvpssApp/student/application" class="apply-now">Apply Now</a>
    </section>

    <section class="steps">
        <!-- Image Section -->
        <div class="steps-image">
            <img src="/TvpssApp/resources/images/studentPortal.png" alt="Steps Illustration">
        </div>

        <!-- Apply Now Button -->
        <a href="/TvpssApp/student/application" class="steps-apply-now">Apply Now</a>
    </section>

</body>
</html>
