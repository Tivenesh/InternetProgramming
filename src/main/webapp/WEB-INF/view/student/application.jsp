<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TVPSS Crew Application</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/student-crew-application.css">
</head>
<body>
    <!-- Content -->
     <br><br><br><br>
    <section class="content">
        <%@ include file="/WEB-INF/view/common/studentHeader.jsp" %>

        <div class="application-container">
            <h1>TVPSS Crew Application</h1>
            <form action="/TvpssApp/student/submitApplication" method="post">
                <div class="form-group">
                    <label for="studentIC">Student IC No</label>
                    <input type="text" id="studentIC" name="studentIC" required>
                </div>

                <div class="form-group">
                    <label for="studentName">Student Name</label>
                    <input type="text" id="studentName" name="studentName" required>
                </div>

                <div class="form-group">
                    <label for="studentEmail">Student Email</label>
                    <input type="email" id="studentEmail" name="studentEmail" required>
                </div>

                <div class="form-group">
                    <label for="form">Form</label>
                    <input type="number" id="studentForm" name="studentForm" min="1" max="6" value="1" required>
                </div>

                <div class="form-group">
                    <label for="state">State</label>
                    <select id="state" name="state" required>
                        <option value="Johor">Johor</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="region">Region</label>
                    <select id="region" name="region" required>
                        <option value="Ulu Tiram">Ulu Tiram</option>
                        <option value="Johor Bahru">Johor Bahru</option>
                        <option value="Skudai">Skudai</option>
                        <option value="Segamat">Segamat</option>
                        <option value="Ledang">Ledang</option>
                        <option value="Mersing">Mersing</option>
                        <option value="Pontian">Pontian</option>
                        <option value="Kluang">Kluang</option>
                        <option value="Kota Tinggi">Kota Tinggi</option>
                        <option value="Muar">Muar</option>
                        <option value="Batu Pahat>">Batu Pahat</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="schoolName">School Name</label>
                    <select id="schoolName" name="schoolName" required>
                        <option value="SK TAMAN MALURI">SK TAMAN MALURI</option>
                        <option value="SMK BUKIT INDAH">SMK BUKIT INDAH</option>
                        <option value="SK BUKIT WAHA">SK BUKIT WAHA</option>
                        <option value="SK BUKIT LINTANG">SK BUKIT LINTANG</option>
                        <option value="SK MAWAI">SK MAWAI</option>
                        <option value="SK JOHOR KAMPONG">SK JOHOR KAMPONG</option>
                        <option value="SK PANCHOR">SK PANCHOR</option>
                        <option value="SK SEDILI KECIL">SK SEDILI KECIL</option>
                        <option value="SK SEMPANG">SK SEMPANG</option>
                        <option value="SK TELOK HUTAN LESONG">SK TELOK HUTAN LESONG</option>
                        <option value="SK SERI SETIA JAYA">SK SERI SETIA JAYA</option>
                        <option value="SK NAM HENG">SK NAM HENG</option>
                        <option value="SK SEMANGAR">SK SEMANGAR</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="position">Crew Position</label>
                    <select id="position" name="position" required>
                        <option value="Cameraman">Cameraman</option>
                        <option value="Editor">Editor</option>
                        <option value="Director">Director</option>
                    </select>
                </div>

                <button type="submit" class="submit-btn">Submit Application</button>
        </form>
    </div>
    </section>
</body>
</html>