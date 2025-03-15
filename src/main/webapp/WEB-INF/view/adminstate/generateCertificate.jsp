<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate E-Certificate</title>
    <link rel="stylesheet" href="/TvpssApp/resources/css/stateAdminDashboard.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
    <style>
		body {
		    font-family: Arial, sans-serif;
		    background-color: #F8FAFF;
		    margin: 0;
		    padding: 0;
		}
		
		/* Breadcrumb Styling */
		.breadcrumb {
		            margin: 20px 10px;
		            font-size: 14px;
		            color: #6B7280;
		}
		
		.breadcrumb span {
		            font-weight: bold;
		            color: #4B6CB7;
		}
		
		.breadcrumb-container {
            margin-bottom: 20px;
        }

        .breadcrumb-container nav {
            font-size: 14px;
            color: #555;
        }

        .breadcrumb-container a {
            color: #007bff;
            text-decoration: none;
        }

        .breadcrumb-container a:hover {
            text-decoration: underline;
        }

        .breadcrumb-container ol {
            padding: 0;
            list-style: none;
            display: flex;
            gap: 5px;
        }

        .breadcrumb-container ol li::after {
            content: ">";
            margin: 0 5px;
            color: #555;
        }

        .breadcrumb-container ol li:last-child::after {
            content: "";
        }

		/* Modal Styling */
		.overlay {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: rgba(0, 0, 0, 0.5);
		    z-index: 999;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		.modal {
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    width: 500px;
		    background: #ffffff;
		    border-radius: 12px;
		    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		    z-index: 1000;
		    padding: 30px;
		}
		
		.modal-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.modal-header h2 {
		    font-size: 20px;
		    font-weight: bold;
		    color: #1E3A8A; /* Dark Blue */
		    margin: 0;
		}

		.modal-header .close-btn {
		    font-size: 18px;
		    background: none;
		    border: none;
		    color: #6B7280;
		    cursor: pointer;
		}
		
		.modal-body {
		    font-size: 14px;
		    color: #6B7280;
		    margin-bottom: 20px;
		}
		
		.modal-footer {
		    display: flex;
		    justify-content: flex-end;
		    align-items: center;
		    gap: 15px;
		}
		
		.modal-footer .btn-cancel {
		    background-color: #E5E7EB;
		    color: #374151;
		    border: none;
		    border-radius: 8px;
		    padding: 10px 20px;
		    font-size: 14px;
		    cursor: pointer;
		    text-align: center;
		}
		
		.modal-footer .btn-cancel:hover {
		    background-color: #D1D5DB;
		}
		
		.modal-footer .btn-confirm {
		    background-color: #1E3A8A;
		    color: #ffffff;
		    border: none;
		    border-radius: 8px;
		    padding: 10px 20px;
		    font-size: 14px;
		    cursor: pointer;
		    text-align: center;
		}
		
		.modal-footer .btn-confirm:hover {
		    background-color: #163A72;
		}
		
		.form-container {
		    background: #FFFFFF;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		    padding: 30px 40px;
		    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
		}
		
		h1 {
		    font-size: 25px;
		    color: #4B6CB7;
		    margin-bottom: 30px;
		    text-align: left;
		}
		
		h2 {
		    margin-bottom: 20px;
		    color: #515B92;
		    font-size: 24px;
		    font-weight: 500;
		}
		
		.form-group {
		    display: flex;
		    flex-direction: column;
		    margin-bottom: 15px;
		    position: relative;
		}

		label {
		    margin-bottom: 3px;
            margin-left: 3px;
		    color: #464651;
		    font-size: 14px;
		}
		
		input, select {
		    padding: 10px;
		    font-size: 14px;
		    color: #7e7e7e;
		    border: 1px solid #CBD5E1;
		    border-radius: 4px;
		    width: 100%;
		    outline: none;
            background-color: 0 0 0 2px rgba(126, 129, 145, 0.5);
		}
		
		input:focus, input:hover,
		select:focus, select:hover {
		    border-color: #515B92;
		    box-shadow: 0 0 0 2px rgba(81, 91, 146, 0.2);
		}
		
		.form-actions {
		    display: flex;
		    justify-content: flex-end;
		    gap: 20px;
		    margin-top: 20px;
		}
		
		.input-wrapper {
		    position: relative;
		    display: flex;
		    align-items: center;
		}
		
		/* Input field styles */
		.input-wrapper input {
		    width: 100%;
		    padding-right: 30px; /* Space for the clear icon */
		}
		.btn {
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    font-size: 14px;
		    cursor: pointer;
		}
		
		.btn.cancel {
		    background: #FFFFFF;
		    border: 1px solid #CBD5E1;
		    color: #515B92;
		    margin-right: 10px;
		}
		
		.btn.submit {
		    background: #515B92;
		    color: #FFFFFF;
		}
		
		/* Generate Cert */
		.generate-cert {
			display:flex;
			align-items: center;
		}
		.generate-cert-btn {
            background-color: #4B6CB7;
            color: #FFFFFF;
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            display:flex;
			align-items: center;
        }

        .generate-cert-btn:hover {
            background-color: #354A9F;
        }
        
        .temp-row {
		    display: flex;
		    align-items: center;
		    align-content: space-between;
		}
		.temp-col {
		    display: flex;
		    flex-direction: row;
		    justify-content: center;
			margin: auto;
		    gap: 10px;
		}
		
        .temp-col input[type="radio"] {
        	margin-top: 5px;
		    width: 16px;
		    height: 16px; 
		}
        .temp-col .form-check-label {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    font-size: 14px;
		}
		
		.temp-col .form-check-label img {
		    margin-top: 5px;
		    margin-bottom: 5px;
		}

        .img-thumbnail {
        	width: 100px;
  			height: auto;
        }
        
        .color-container {
        	width: 100px;
        }
        
        input[type="color"] {
		    width: 10rem;
		    height: 3rem;
		    border: 0;
		    border-radius: none;
		}
	</style>
</head>

<body>
	<!-- Success Message -->
	<c:if test="${param.success == 'true'}">
	    <div class="alert">
	        <div>
	            <img src="/TvpssApp/resources/images/successIcon.png" alt="Success Icon" style="width: 24px; height: 24px;">
	        </div>
	        <div>
	            <strong>Data Updated Successfully!</strong>
	            <p>Action was successfully performed.</p>
	        </div>
	        <button class="close-btn" onclick="this.parentElement.style.display='none';">&times;</button>
	    </div>
	</c:if>
	
	<!-- Error Message -->
	<c:if test="${not empty error}">
	    <div class="alert error">
	        <span class="message">${error}</span>
	        <button class="close" onclick="this.parentElement.style.display='none';">&times;</button>
	    </div>
	</c:if>
	
	<!-- Delete Confirmation Modal -->
	<div class="overlay" id="overlay" style="display: none;"></div>
	<div class="modal" id="confirmationModal" style="display: none;">
	    <div class="modal-header">
	        <h2>Do you want to delete the user?</h2>
	        <button class="close-btn" onclick="hideModal()">ÃÂÃÂ</button>
	    </div>
	    <div class="modal-body">
	        <p>This will be an irreversible operation.</p>
	    </div>
	    <div class="modal-footer">
	        <button class="btn-cancel" onclick="hideModal()">No</button>
	        <form id="deleteForm" action="/TvpssApp/deleteUser" method="post" style="margin: 0;">
	            <input type="hidden" name="username" id="deleteUsername" value="">
	            <button class="btn-confirm" type="submit">Yes</button>
	        </form>
	    </div>
	</div>
	
    <div class="dashboard">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="logo">
                <img src="/TvpssApp/resources/images/TvpssLogo.png" alt="TVPSS Logo">

                <h2>TVPSS</h2>
            </div>
            <nav>
                <ul>
                    <li><a href="/TvpssApp/adminstate/dashboard" class="menu-item ${page == 'dashboard' ? 'active' : ''}">Dashboard</a><li>
			        <li><a href="/TvpssApp/adminstate/viewCertApplication" class="menu-item ${page == null || page == 'viewCertApplication' || page == 'generateCertificate' ? 'active' : ''}">Generate E-Certificate</a><li>
				    <li><a href="/TvpssApp/adminstate/schoolVersion/view" class="menu-item ${page== 'tvpss-version' ? 'active' : ''}">Submit TVPSS Version</a><li>
                </ul>
            </nav>
            <div class="settings">
			    <div class="setting-item">
			        <i class="icon-settings"></i> Setting
			    </div>
			    <div class="divider"></div>
			    <div class="setting-item">
			        <a href="/TvpssApp/login" style="text-decoration: none; color: inherit;">Logout</a>
			    </div>
			</div>
        </aside>

        <!-- Main Content -->
        <main class="content">
            <header class="header">
			    <div class="header-top">
			    <!-- Notification Icon -->
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
			    <div class="divider"></div> <!-- Thin dividing line -->
			    <!-- Bottom Section: Welcome and Search Bar -->
			    <div class="welcome-search">
			        <h1>Generate E-Certificate</h1>
			    </div>
			</header>

			<div class="breadcrumb-container">
		        <nav aria-label="breadcrumb">
		            <ol class="breadcrumb">
		                <li><a href="viewCertApplication">Application of E-Certificate</a></li>
		                <li aria-current="page">Generate E-Certificate</li>
		            </ol>
		        </nav>
		    </div>
		    
		    <div class="form-container">
		    <h1>Application of Student Information</h1>
		    
		    <form id="certificateForm" method="POST" action="<c:url value='/adminstate/generateCertificate' />" enctype="multipart/form-data">
		 
		        <!-- Individual Form -->
		        <div id="single-form">
		        
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
		        <br>
		        <hr>
		        <br>
		        <!-- Certificate -->
		    	<h1>Generate Certificate</h1>
		        <div class="form-group">
		        	<label class="form-label">Select Certificate Template:</label>
		        	<br>
                    <div class="temp-row">
                        <div class="temp-col">
                            <input type="radio" name="template" id="Classic" value="Classic" checked>
                            <label for="template1" class="form-check-label">
                                <img src="/TvpssApp/resources/images/Classic.png" class="img-thumbnail">
                                Classic
                            </label>
                        </div>
                        <div class="temp-col">
                            <input type="radio" name="template" id="Modern" value="Modern">
                            <label for="template2" class="form-check-label">
                                <img src="/TvpssApp/resources/images/Modern.png" class="img-thumbnail">
                                Modern
                            </label>
                        </div>
                        <div class="temp-col">
                            <input type="radio" name="template" id="Professional" value="Professional">
                            <label for="template3" class="form-check-label">
                                <img src="/TvpssApp/resources/images/Professional.png" class="img-thumbnail">
                                Professional
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">  	
		        	<label for="font-type">Font Type</label>
		        	<div class="input-wrapper">
	                     <select id="fontSelect" class="form-select">
		                     <option disabled selected>- Select Font Type-</option>
	                         <option value="Arial">Arial</option>
	                         <option value="'Courier New'">Courier New</option>
	                         <option value="Georgia">Georgia</option>
	                         <option value="'Times New Roman'">Times New Roman</option>
	                         <option value="Verdana">Verdana</option>
	                     </select>
		            </div>
   				</div>
                <div class="color-container">
                    <label class="font-color">Font Color</label>
                    <input type="color" id="fontColorPicker" name="font-color" value="#000000">
                </div> 
                 <br>     
 	       	 	 <div class="form-group">  
		        	<label for="upload-sign">Upload Signature</label>
			         <div class="input-wrapper">
			         	<input type="file" id="signatureUpload" name="upload-sign" accept="image/*">
			         </div>
				 </div>
				 <div class="form-group">
                     <label class="form-label">Output Format</label>
                     <div class="form-check">
                         <input class="form-check-input" type="checkbox" id="pdfCheck">
                         <label class="form-check-label" for="pdfCheck">PDF</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="checkbox" id="jpgCheck">
                         <label class="form-check-label" for="jpgCheck">JPG</label>
                     </div>
                     <div class="form-check">
                         <input class="form-check-input" type="checkbox" id="pngCheck">
                         <label class="form-check-label" for="pngCheck">PNG</label>
                     </div>
                 </div>	
				 <br>
			 	 <div class="generate-cert">
		            	<button id="generateBtn" class="generate-cert-btn">Generate Certificate</button>
				 </div>
				 
			</form>
			<br>
	      </div>  
	</main>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const generateBtn = document.getElementById('generateBtn');
    const signatureUpload = document.getElementById('signatureUpload');
    let uploadedSignature = null;

    signatureUpload.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                uploadedSignature = e.target.result;
                
                const previewContainer = document.createElement('div');
                previewContainer.style.marginTop = '10px';
                const previewImg = document.createElement('img');
                previewImg.src = uploadedSignature;
                previewImg.style.maxWidth = '200px';
                previewImg.style.maxHeight = '100px';
                previewContainer.appendChild(previewImg);
                
                const existingPreview = document.querySelector('.signature-preview');
                if (existingPreview) {
                    existingPreview.remove();
                }
                
                previewContainer.classList.add('signature-preview');
                signatureUpload.parentNode.appendChild(previewContainer);

                updateLiveCertificatePreview();
            };
            reader.readAsDataURL(file);
        }
    });

    function createCertificatePreview() {
        const certificatePreview = document.createElement('div');
        
        certificatePreview.style.width = '2480px';
        certificatePreview.style.height = '3508px';
        certificatePreview.style.position = 'relative';
        
        const fullName = document.getElementById('full-name').value || 'Student Name';
        const activityName = document.getElementById('activity-name').value || 'Activity Name';
        const awardInfo = document.getElementById('award-info').value || 'Award Information';
        
        const fontFamily = document.getElementById('fontSelect').value || 'Arial';
        const fontColor = document.getElementById('fontColorPicker').value || '#000000';
        
        const selectedTemplate = document.querySelector('input[name="template"]:checked').value;
        const templateBackgrounds = {
            'Classic': '/TvpssApp/resources/images/Classic.png',
            'Modern': '/TvpssApp/resources/images/Modern.png',
            'Professional': '/TvpssApp/resources/images/Professional.png'
        };

        let signatureHtml = '';
        if (uploadedSignature) {
            signatureHtml = 
                '<div style="' +
                    'position: absolute;' +
                    'bottom: 335px;' +
                    'left: 50%;' +
                    'transform: translateX(-50%);' +
                    'text-align: center;' +
                '">' +
                    '<img src="' + uploadedSignature + '" style="max-width: 700px; max-height: 420px;">' +
                '</div>';
        }

        certificatePreview.innerHTML = 
            '<div style="' +
                'width: 100%; ' +
                'height: 100%; ' +
                'position: absolute; ' +
                'background-image: url(\'' + templateBackgrounds[selectedTemplate] + '\');' +
                'background-size: cover;' +
                'background-position: center;' +
                'display: flex;' +
                'flex-direction: column;' +
                'justify-content: center;' +
                'align-items: center;' +
                'text-align: center;' +
                'padding: 200px;' +
                'box-sizing: border-box;' +
                'font-family: ' + fontFamily + ';' +
                'color: ' + fontColor + ';' +
            '">' +
	            '<div style="' +
		            'position: relative;' +
		            'width: 100%;' +
		            'height: 100%;' +
		            'display: flex;' +
		            'flex-direction: column;' +
		            'justify-content: center;' +
		            'align-items: center;' +
		            'text-align: center;' +
		        '">' +
		            '<h3 style="' +
		                'position: absolute;' +
		                'top: 1780px;' +
		                'left: 50%;' +
		                'transform: translate(-50%, -50%);' +
		                'font-size: 160px;' +
		                'font-weight: bold;' +
		                'text-align: center;' +
		                'width: 100%;' +
		            '">' + fullName + '</h3>' +
		            '<h4 style="' +
		                'position: absolute;' +
		                'top: 2250px;' +
		                'left: 50%;' +
		                'transform: translate(-50%, -50%);' +
		                'font-size: 60px;' +
		                'text-align: center;' +
		                'width: 100%;' +
		            '">' + activityName + ', ' + '<p style="' +
		                                            'font-size: 50px;' +
		                                            'font-weight: 400;' +
		            								'"> for being the ' + awardInfo + '</p>' + '</h4>' +
		            signatureHtml +
		           /* '<p style="' +
		                'position: absolute;' +
		                'top: 2730px;' +
		                'left: 50%;' +
		                'transform: translate(-50%, -50%);' +
		                'font-size: 50px;' +
		                'text-align: center;' +
		                'width: 100%;' +
		            '">' + signatoryRole + +'<br>'signatoryName + '</p>' +
		        '</div>' +*/
		    '</div>'; 

        return certificatePreview;
    }

    function updateLiveCertificatePreview() {
        const existingPreview = document.querySelector('.certificate-live-preview-container');
        if (existingPreview) {
            existingPreview.remove();
        }

        const certificatePreview = createCertificatePreview();
        certificatePreview.style.transform = 'scale(0.3)';
        certificatePreview.style.transformOrigin = 'top left';
        certificatePreview.style.width = '2480px';
        certificatePreview.style.height = '3508px';

        const previewContainer = document.createElement('div');
        previewContainer.classList.add('certificate-live-preview-container');
        previewContainer.style.display = 'flex';
        previewContainer.style.justifyContent = 'center';
        previewContainer.style.marginTop = '20px';
        previewContainer.style.overflow = 'hidden';
        previewContainer.style.width = '100%';
        previewContainer.style.height = '1100px';

        const previewWrapper = document.createElement('div');
        previewWrapper.style.width = '744px';
        previewWrapper.style.height = '1052px';
        previewWrapper.style.overflow = 'hidden';
        previewWrapper.appendChild(certificatePreview);

        previewContainer.appendChild(previewWrapper);

        const formContainer = document.querySelector('.form-container');
        formContainer.appendChild(previewContainer);
    }

    function addPreviewEventListeners() {
        document.querySelectorAll('input[name="template"]').forEach(radio => {
            radio.addEventListener('change', updateLiveCertificatePreview);
        });

        document.getElementById('fontSelect').addEventListener('change', updateLiveCertificatePreview);
        document.getElementById('fontColorPicker').addEventListener('input', updateLiveCertificatePreview);
        
        document.getElementById('full-name').addEventListener('input', updateLiveCertificatePreview);
        document.getElementById('activity-name').addEventListener('input', updateLiveCertificatePreview);
        document.getElementById('award-info').addEventListener('input', updateLiveCertificatePreview);
    }

    addPreviewEventListeners();
    updateLiveCertificatePreview();

    function generateCertificate(type) {
        const certificatePreview = createCertificatePreview();
        document.body.appendChild(certificatePreview);

        html2canvas(certificatePreview, { 
            scale: 1,
            useCORS: true,
            width: 2480,
            height: 3508,
            dpi: 300
        }).then(canvas => {
            document.body.removeChild(certificatePreview);

            switch(type) {
                case 'pdf':
                    const { jsPDF } = window.jspdf;
                    const pdf = new jsPDF('p', 'px', [2480, 3508]);
                    pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 0, 0, 2480, 3508);
                    pdf.save('certificate.pdf');
                    break;
                
                case 'jpg':
                    const jpgLink = document.createElement('a');
                    jpgLink.download = 'certificate.jpg';
                    jpgLink.href = canvas.toDataURL('image/jpeg');
                    jpgLink.click();
                    break;
                
                case 'png':
                    const pngLink = document.createElement('a');
                    pngLink.download = 'certificate.png';
                    pngLink.href = canvas.toDataURL('image/png');
                    pngLink.click();
                    break;
            }
        });
    }

    generateBtn.addEventListener('click', function(e) {
        e.preventDefault();

        const pdfChecked = document.getElementById('pdfCheck').checked;
        const jpgChecked = document.getElementById('jpgCheck').checked;
        const pngChecked = document.getElementById('pngCheck').checked;

        if (pdfChecked) generateCertificate('pdf');
        if (jpgChecked) generateCertificate('jpg');
        if (pngChecked) generateCertificate('png');
    });

    document.querySelectorAll('input[name="template"]').forEach(radio => {
        radio.addEventListener('change', updateLiveCertificatePreview);
    });

    document.getElementById('fontSelect').addEventListener('change', updateLiveCertificatePreview);
    document.getElementById('fontColorPicker').addEventListener('input', updateLiveCertificatePreview);

    updateLiveCertificatePreview();
});
    </script>
</body>
</html>