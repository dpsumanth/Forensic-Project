<!DOCTYPE HTML>
<html>
<head>
	<meta charset="UTF-8">
	<title>TAFC - File Upload</title>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<style>
		:root {
			--primary: #2c3e50;
			--secondary: #3498db;
			--accent: #e74c3c;
			--light: #ecf0f1;
			--dark: #2c3e50;
			--success: #2ecc71;
			--warning: #f39c12;
			--gradient: linear-gradient(135deg, #3498db, #2c3e50);
		}

		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Poppins', sans-serif;
		}

		body {
			background-color: #f9f9f9;
			color: #333;
			line-height: 1.6;
			min-height: 100vh;
			display: flex;
			flex-direction: column;
		}

		#header {
			background: var(--gradient);
			color: white;
			padding: 1.5rem 0;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
			position: relative;
			z-index: 10;
		}

		#header h1 {
			font-size: 1.8rem;
			font-weight: 600;
			text-align: center;
			margin-bottom: 1.5rem;
			padding: 0 1rem;
		}

		#header ul {
			display: flex;
			justify-content: center;
			list-style: none;
			flex-wrap: wrap;
			gap: 0.5rem;
		}

		#header ul li {
			margin: 0 0.5rem;
		}

		#header ul li a {
			color: white;
			text-decoration: none;
			font-weight: 500;
			padding: 0.5rem 1rem;
			border-radius: 4px;
			transition: all 0.3s ease;
			display: flex;
			align-items: center;
			font-size: 0.9rem;
		}

		#header ul li a i {
			margin-right: 8px;
		}

		#header ul li a:hover {
			background-color: rgba(255, 255, 255, 0.2);
			transform: translateY(-2px);
		}

		#header ul li.selected a {
			background-color: rgba(255, 255, 255, 0.2);
			font-weight: 600;
		}

		#body {
			flex: 1;
			padding: 2rem;
			display: flex;
			justify-content: center;
			align-items: flex-start;
		}

		.upload-container {
			background: white;
			border-radius: 12px;
			box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
			padding: 2.5rem;
			width: 100%;
			max-width: 800px;
			margin: 2rem auto;
		}

		.upload-header {
			text-align: center;
			margin-bottom: 2rem;
		}

		.upload-header i {
			font-size: 3rem;
			color: var(--secondary);
			margin-bottom: 1rem;
			display: block;
		}

		.upload-header h2 {
			color: var(--primary);
			font-size: 1.8rem;
			margin-bottom: 0.5rem;
		}

		.upload-header p {
			color: #666;
			font-size: 0.95rem;
		}

		.upload-form {
			display: grid;
			gap: 1.5rem;
		}

		.form-group {
			margin-bottom: 1.5rem;
		}

		.form-group label {
			display: block;
			margin-bottom: 0.5rem;
			font-weight: 500;
			color: var(--dark);
		}

		.form-control {
			width: 100%;
			padding: 0.8rem 1rem;
			border: 1px solid #ddd;
			border-radius: 6px;
			font-size: 1rem;
			transition: all 0.3s ease;
		}

		.form-control:focus {
			outline: none;
			border-color: var(--secondary);
			box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
		}

		.file-upload-area {
			border: 2px dashed #ddd;
			border-radius: 8px;
			padding: 2rem;
			text-align: center;
			transition: all 0.3s ease;
			cursor: pointer;
			background: #fafafa;
		}

		.file-upload-area:hover {
			border-color: var(--secondary);
			background: #f0f7ff;
		}

		.file-upload-area.dragover {
			border-color: var(--success);
			background: #f0fff4;
		}

		.file-upload-area i {
			font-size: 3rem;
			color: #bbb;
			margin-bottom: 1rem;
			display: block;
		}

		.file-upload-area h4 {
			color: var(--primary);
			margin-bottom: 0.5rem;
		}

		.file-upload-area p {
			color: #666;
			font-size: 0.9rem;
			margin-bottom: 1rem;
		}

		.file-input {
			display: none;
		}

		.file-info {
			display: none;
			margin-top: 1rem;
			padding: 1rem;
			background: #f8f9fa;
			border-radius: 6px;
			border-left: 4px solid var(--secondary);
		}

		.file-info.show {
			display: block;
		}

		.file-info p {
			margin: 0.3rem 0;
			font-size: 0.9rem;
			color: #555;
		}

		.file-info .file-name {
			font-weight: 600;
			color: var(--primary);
		}

		.btn-upload {
			width: 100%;
			background: var(--gradient);
			color: white;
			border: none;
			padding: 0.9rem;
			border-radius: 6px;
			font-size: 1rem;
			font-weight: 600;
			cursor: pointer;
			transition: all 0.3s ease;
			margin-top: 1rem;
			display: flex;
			align-items: center;
			justify-content: center;
			gap: 8px;
		}

		.btn-upload:hover {
			transform: translateY(-2px);
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
		}

		.btn-upload:disabled {
			background: #ccc;
			cursor: not-allowed;
			transform: none;
			box-shadow: none;
		}

		.security-notice {
			background-color: #f8f9fa;
			border-left: 4px solid var(--secondary);
			padding: 1rem;
			margin-top: 1.5rem;
			border-radius: 0 4px 4px 0;
		}

		.security-notice h4 {
			color: var(--primary);
			margin-bottom: 0.5rem;
			font-size: 0.9rem;
			display: flex;
			align-items: center;
		}

		.security-notice h4 i {
			margin-right: 8px;
		}

		.security-notice p {
			font-size: 0.8rem;
			color: #666;
			margin: 0;
		}

		.alert-message {
			padding: 0.75rem 1.25rem;
			border-radius: 6px;
			margin-bottom: 1.5rem;
			border-left: 4px solid;
			text-align: center;
			display: none;
		}

		.alert-success {
			background-color: #d4edda;
			color: #155724;
			border-color: #c3e6cb;
		}

		.alert-error {
			background-color: #f8d7da;
			color: #721c24;
			border-color: #f5c6cb;
		}

		.alert-message.show {
			display: block;
		}

		#footer {
			background-color: var(--dark);
			color: white;
			padding: 2rem 1rem 1rem;
			margin-top: auto;
		}

		.footer-content {
			max-width: 1200px;
			margin: 0 auto;
			display: flex;
			flex-wrap: wrap;
			justify-content: space-between;
			align-items: center;
		}

		.footer-content p {
			margin-bottom: 1rem;
		}

		.social-links {
			display: flex;
			gap: 1rem;
		}

		.social-links a {
			display: flex;
			align-items: center;
			justify-content: center;
			width: 36px;
			height: 36px;
			background-color: rgba(255, 255, 255, 0.1);
			border-radius: 50%;
			color: white;
			text-decoration: none;
			transition: all 0.3s ease;
		}

		.social-links a:hover {
			background-color: var(--secondary);
			transform: translateY(-3px);
		}

		.copyright {
			text-align: center;
			padding-top: 1.5rem;
			border-top: 1px solid rgba(255, 255, 255, 0.1);
			width: 100%;
			margin-top: 1rem;
			color: rgba(255, 255, 255, 0.7);
			font-size: 0.9rem;
		}

		@media (max-width: 768px) {
			#header h1 {
				font-size: 1.5rem;
			}

			#header ul {
				flex-direction: column;
				align-items: center;
			}

			#header ul li {
				margin: 0.3rem 0;
				width: 100%;
				text-align: center;
			}

			#header ul li a {
				justify-content: center;
			}

			#body {
				padding: 1rem;
			}

			.upload-container {
				padding: 2rem 1.5rem;
				margin: 1rem;
			}
		}

		@media (max-width: 480px) {
			.upload-container {
				padding: 1.5rem 1rem;
			}
			
			.upload-header h2 {
				font-size: 1.5rem;
			}
			
			.upload-header i {
				font-size: 2.5rem;
			}
		}
	</style>
	<script>
		// Check if there's a status message to display
		window.onload = function() {
			const urlParams = new URLSearchParams(window.location.search);
			
			if (urlParams.has('status')) {
				document.getElementById('successMessage').classList.add('show');
				// Hide the message after 5 seconds
				setTimeout(function() {
					document.getElementById('successMessage').classList.remove('show');
				}, 5000);
			}
			
			if (urlParams.has('msgg')) {
				document.getElementById('errorMessage').classList.add('show');
				// Hide the message after 5 seconds
				setTimeout(function() {
					document.getElementById('errorMessage').classList.remove('show');
				}, 5000);
			}
		};

		// File upload functionality
		document.addEventListener('DOMContentLoaded', function() {
			const fileInput = document.getElementById('fileInput');
			const fileUploadArea = document.getElementById('fileUploadArea');
			const fileInfo = document.getElementById('fileInfo');
			const fileName = document.getElementById('fileName');
			const fileSize = document.getElementById('fileSize');
			const fileType = document.getElementById('fileType');
			const uploadButton = document.getElementById('uploadButton');
			
			// Click on upload area to trigger file input
			fileUploadArea.addEventListener('click', function() {
				fileInput.click();
			});
			
			// Handle file selection
			fileInput.addEventListener('change', function(e) {
				handleFileSelection(e.target.files[0]);
			});
			
			// Drag and drop functionality
			fileUploadArea.addEventListener('dragover', function(e) {
				e.preventDefault();
				fileUploadArea.classList.add('dragover');
			});
			
			fileUploadArea.addEventListener('dragleave', function() {
				fileUploadArea.classList.remove('dragover');
			});
			
			fileUploadArea.addEventListener('drop', function(e) {
				e.preventDefault();
				fileUploadArea.classList.remove('dragover');
				handleFileSelection(e.dataTransfer.files[0]);
			});
			
			function handleFileSelection(file) {
				if (file) {
					// Update file info
					fileName.textContent = file.name;
					fileSize.textContent = formatFileSize(file.size);
					fileType.textContent = file.type || 'Unknown';
					
					// Show file info
					fileInfo.classList.add('show');
					
					// Enable upload button
					uploadButton.disabled = false;
				}
			}
			
			function formatFileSize(bytes) {
				if (bytes === 0) return '0 Bytes';
				const k = 1024;
				const sizes = ['Bytes', 'KB', 'MB', 'GB'];
				const i = Math.floor(Math.log(bytes) / Math.log(k));
				return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
			}
		});
	</script>
</head>
<body>
    <%
        if (request.getParameter("status") != null) {
    %>
    <script>alert('File Upload to Drive HQ');</script>
    <%
        }
        if (request.getParameter("msgg") != null) {
    %>
    <script>alert('File Upload Failed');</script>
    <%
        }
    %>
    
	<div id="header">
		<h1>Enhanced Digital Forensic Security Model</h1>
		<ul>
			<li>
				<a href="owner_home.jsp"><i class="fas fa-home"></i> Admin Home</a>
			</li>
			<li class="selected">
				<a href="file_upload.jsp"><i class="fas fa-upload"></i> File Upload</a>
			</li>
			<li>
				<a href="view_file.jsp"><i class="fas fa-eye"></i> View File</a>
			</li>
            <li>
				<a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
			</li>
		</ul>
	</div>
	
	<div id="body">
		<div class="upload-container">
			<div id="successMessage" class="alert-message alert-success">
				<strong>Success!</strong> File uploaded to ADrive successfully.
			</div>
			
			<div id="errorMessage" class="alert-message alert-error">
				<strong>Error!</strong> File upload failed. Please try again.
			</div>
			
			<div class="upload-header">
				<i class="fas fa-file-Forensic"></i>
				<h2>Forensic Record Upload</h2>
				<p>Securely upload Forensic records to the forensic system</p>
			</div>
			
			<form action="Upload1" method="post" enctype="multipart/form-data" class="upload-form">
				<div class="form-group">
					<label for="pname">Victim Name *</label>
					<input type="text" name="pname" placeholder="Enter Victim Name" required id="pname" class="form-control">
				</div>
				
				<div class="form-group">
					<label for="fileInput">Forensic  Record (FR) *</label>
					<div id="fileUploadArea" class="file-upload-area">
						<i class="fas fa-cloud-upload-alt"></i>
						<h4>Select a file to upload</h4>
						<p>Drag & drop your file here or click to browse</p>
						<p class="form-hint">Supported formats: .txt (Max: 50MB)</p>
						<input type="file" name="file" required id="fileInput" class="file-input" accept=".txt">
					</div>
					
					<div id="fileInfo" class="file-info">
						<p><strong>Selected File:</strong></p>
						<p class="file-name" id="fileName">No file selected</p>
						<p><strong>Size:</strong> <span id="fileSize">-</span></p>
						<p><strong>Type:</strong> <span id="fileType">-</span></p>
					</div>
				</div>
				
				<button type="submit" class="btn-upload" id="uploadButton" disabled>
					<i class="fas fa-upload"></i> Upload Medical Record
				</button>
			</form>
			
			<div class="security-notice">
				<h4><i class="fas fa-shield-alt"></i> Security Notice</h4>
				<p>All uploaded Forensic records are encrypted using optimal key encryption and protected with role-based and time-based access controls. Only authorized personnel will have access to these records.</p>
			</div>
		</div>
	</div>
	
	<div id="footer">
		<div class="footer-content">
			<p>&copy; 2025 JSS - Enhanced Digital Forensic Security</p>
			<div class="social-links">
				<a href="#"><i class="fab fa-facebook-f"></i></a>
				<a href="#"><i class="fab fa-twitter"></i></a>
				<a href="#"><i class="fab fa-google-plus-g"></i></a>
				<a href="#"><i class="fas fa-rss"></i></a>
			</div>
			<div class="copyright">
				<p>Enhanced Digital Forensic Security Model Using Role-Based and Time-Based Access Control Using Optimal Key Encryption</p>
			</div>
		</div>
	</div>
</body>
</html>