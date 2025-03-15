<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View School Version Status</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/superAdminDashboard.css">
    <style>
        .dashboard-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .table-container {
            margin-top: 20px;
            background-color: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        table th, table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #F3F4F6;
            color: #6B7280;
        }

        table tr:hover {
            background-color: #F9FAFB;
        }

        .btn-view {
            background-color: #3B82F6;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-view:hover {
            background-color: #2563EB;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin: 2% auto;
            width: 90%;
            max-width: 1000px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            padding: 20px;
        }

        .modal-header {
            background-color: #525D97;
            color: white;
            padding: 15px 20px;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 1.4em;
        }

        .close {
            color: white;
            font-size: 24px;
            font-weight: normal;
            cursor: pointer;
            padding: 0 10px;
        }

        .details-list {
            list-style: none;
            padding: 20px;
            margin: 0;
        }

        .details-list li {
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
        }

        .details-list li:last-child {
            border-bottom: none;
        }

        .btn-update {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            float: right;
        }

        .btn-update:hover {
            background-color: #d32f2f;
        }

        .toast-notification {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #4caf50;
            color: white;
            padding: 15px 25px;
            border-radius: 4px;
            display: none;
            z-index: 2000;
            animation: slideIn 0.3s, fadeOut 0.3s 2.7s;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); }
            to { transform: translateX(0); }
        }

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <aside class="sidebar">
            <div class="logo">
                <img src="/TvpssApp/resources/images/TvpssLogo.png" alt="TVPSS Logo">
                <h2>TVPSS</h2>
            </div>
            <nav>
                <ul>
                    <li><a href="/TvpssApp/adminstate/dashboard">Dashboard</a></li>
                    <li><a href="/TvpssApp/adminstate/viewCertApplication" class="menu-item ${page == 'viewCertApplication' || page == 'generateCertificate' ? 'active' : ''}">Generate E-Certificate</a></li>
                    <li><a href="/TvpssApp/adminstate/schoolVersion/view" class="active">View School Version Status</a></li>
                </ul>
            </nav>
            <div class="settings">
                <div class="setting-item">
                    <i class="icon-settings"></i> Setting
                </div>
                <div class="divider"></div>
                <div class="setting-item">
                    <i class="icon-logout"></i>
                    <a href="/TvpssApp/login" style="text-decoration: none; color: inherit;">Logout</a>
                </div>
            </div>
        </aside>

        <main class="content">
            <header class="header">
                <div class="header-top">
                    <div class="notification">
                        <div class="notification-icon">
                            <i class="icon-bell"></i>
                            <span class="notification-badge"></span>
                        </div>
                    </div>
                    <div class="user-info">
                        <img src="/TvpssApp/resources/images/stateAdminLogo.png" alt="User Avatar">
                        <span>User<br>State Admin</span>
                    </div>
                </div>
                <div class="divider"></div>
                <div class="welcome-search">
                    <h1>School TVPSS Information</h1>
                </div>
            </header>

            <div class="dashboard-container">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>School Code</th>
                                <th>School Name</th>
                                <th>School Officer Name</th>
                                <th>Version Status</th>
                                <th>Version</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="school" items="${schools}">
                                <tr>
                                    <td>${school.code}</td>
                                    <td>${school.name}</td>
                                    <td>${school.schoolOfficerName}</td>
                                    <td>${school.versionStatus}</td>
                                    <td>${school.tvpssVersion}</td>
                                    <td>
                                        <button class="btn-view" onclick="showDetails('${school.code}', '${school.name}', '${school.address1}', '${school.address2}', '${school.postcode}', '${school.state}', '${school.telephoneNumber}', '${school.email}', '${school.logoFilename}', '${school.youtubeLink}')">
                                            View
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Modal -->
    <div id="detailsModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>School Information</h2>
                <span class="close">&times;</span>
            </div>
            <ul class="details-list">
                <li><strong>School Code:</strong> <span id="schoolCode"></span></li>
                <li><strong>School Name:</strong> <span id="schoolName"></span></li>
                <li><strong>Address 1:</strong> <span id="address1"></span></li>
                <li><strong>Address 2:</strong> <span id="address2"></span></li>
                <li><strong>Postcode:</strong> <span id="postcode"></span></li>
                <li><strong>State:</strong> <span id="state"></span></li>
                <li><strong>Telephone:</strong> <span id="telephoneNumber"></span></li>
                <li><strong>Email:</strong> <span id="email"></span></li>
                <li><strong>Logo:</strong>
                    <img id="schoolLogo" src="" alt="School Logo" width="100" style="display:none;">
                    <span id="noLogo" style="display:none;">No logo uploaded</span>
                </li>
                <li><strong>YouTube Link:</strong> <a href="#" id="youtubeLink" target="_blank"></a></li>
            </ul>
        </div>
    </div>

    <script>
        function showDetails(code, name, address1, address2, postcode, state, telephone, email, logo, youtubeLink) {
            document.getElementById('schoolCode').textContent = code;
            document.getElementById('schoolName').textContent = name;
            document.getElementById('address1').textContent = address1;
            document.getElementById('address2').textContent = address2;
            document.getElementById('postcode').textContent = postcode;
            document.getElementById('state').textContent = state;
            document.getElementById('telephoneNumber').textContent = telephone;
            document.getElementById('email').textContent = email;

            if (logo && logo !== 'null') {
                document.getElementById('schoolLogo').src = '/resources/static/uploads/school-logos/' + logo;
                document.getElementById('schoolLogo').style.display = 'block';
                document.getElementById('noLogo').style.display = 'none';
            } else {
                document.getElementById('schoolLogo').style.display = 'none';
                document.getElementById('noLogo').style.display = 'block';
            }

            if (youtubeLink && youtubeLink !== 'null') {
                document.getElementById('youtubeLink').href = youtubeLink;
                document.getElementById('youtubeLink').textContent = youtubeLink;
            } else {
                document.getElementById('youtubeLink').textContent = 'No link provided';
                document.getElementById('youtubeLink').href = '#';
            }

            const modal = document.getElementById('detailsModal');
            modal.style.display = 'block';

            document.querySelector('.close').onclick = function () {
                modal.style.display = 'none';
            };

            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            };

            
        }
    </script>
</body>
</html>
