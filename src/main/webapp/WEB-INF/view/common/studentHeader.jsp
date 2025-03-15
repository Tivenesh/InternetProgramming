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
            position: fixed;
            top: 0;
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
    </style>
</head>
<body>

    <header>
        <div class="logo">
            <img src="/TvpssApp/resources/images/tvpss.png" alt="Ministry of Education Logo">

        </div>
        <div class="right-section">
        <nav>
            <a href="/TvpssApp/student/dashboard">Dashboard</a>
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


    

</body>
</html>
