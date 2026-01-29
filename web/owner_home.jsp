<!DOCTYPE HTML>
<html>
<head>
	<meta charset="UTF-8">
	<title>TAFC - Admin Dashboard</title>
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
			flex-direction: column;
			align-items: center;
		}

		.dashboard-container {
			width: 100%;
			max-width: 1200px;
			margin: 0 auto;
		}

		.welcome-section {
			background: white;
			border-radius: 12px;
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
			padding: 2rem;
			margin-bottom: 2rem;
			text-align: center;
		}

		.welcome-section i {
			font-size: 4rem;
			color: var(--secondary);
			margin-bottom: 1rem;
			display: block;
		}

		.welcome-section h2 {
			color: var(--primary);
			font-size: 2rem;
			margin-bottom: 1rem;
		}

		.welcome-section p {
			color: #666;
			font-size: 1.1rem;
			max-width: 800px;
			margin: 0 auto;
		}

		.admin-name {
			color: var(--secondary);
			font-weight: 600;
		}

		.dashboard-stats {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
			gap: 1.5rem;
			margin-bottom: 2rem;
		}

		.stat-card {
			background: white;
			border-radius: 12px;
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
			padding: 1.5rem;
			text-align: center;
			transition: all 0.3s ease;
			border-top: 4px solid var(--secondary);
		}

		.stat-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
		}

		.stat-card i {
			font-size: 2.5rem;
			color: var(--secondary);
			margin-bottom: 1rem;
			display: block;
		}

		.stat-card h3 {
			color: var(--primary);
			font-size: 1.5rem;
			margin-bottom: 0.5rem;
		}

		.stat-card p {
			color: #666;
			font-size: 0.9rem;
		}

		.quick-actions {
			background: white;
			border-radius: 12px;
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
			padding: 2rem;
		}

		.quick-actions h3 {
			color: var(--primary);
			font-size: 1.5rem;
			margin-bottom: 1.5rem;
			text-align: center;
		}

		.action-grid {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
			gap: 1.5rem;
		}

		.action-card {
			background: #f8f9fa;
			border-radius: 8px;
			padding: 1.5rem;
			text-align: center;
			transition: all 0.3s ease;
			cursor: pointer;
			border: 1px solid #e9ecef;
		}

		.action-card:hover {
			background: var(--gradient);
			transform: translateY(-3px);
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
		}

		.action-card:hover i,
		.action-card:hover h4,
		.action-card:hover p {
			color: white;
		}

		.action-card i {
			font-size: 2rem;
			color: var(--secondary);
			margin-bottom: 1rem;
			display: block;
			transition: all 0.3s ease;
		}

		.action-card h4 {
			color: var(--primary);
			font-size: 1.1rem;
			margin-bottom: 0.5rem;
			transition: all 0.3s ease;
		}

		.action-card p {
			color: #666;
			font-size: 0.8rem;
			transition: all 0.3s ease;
		}

		.alert-success {
			background-color: #d4edda;
			color: #155724;
			padding: 0.75rem 1.25rem;
			border-radius: 6px;
			margin-bottom: 1.5rem;
			border-left: 4px solid #c3e6cb;
			text-align: center;
			display: none;
		}

		.alert-success.show {
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

			.welcome-section {
				padding: 1.5rem;
			}

			.welcome-section h2 {
				font-size: 1.5rem;
			}

			.dashboard-stats {
				grid-template-columns: 1fr;
			}

			.action-grid {
				grid-template-columns: 1fr;
			}
		}

		@media (max-width: 480px) {
			.welcome-section {
				padding: 1rem;
			}
			
			.welcome-section h2 {
				font-size: 1.3rem;
			}
			
			.welcome-section i {
				font-size: 3rem;
			}
		}
	</style>
	<script>
		// Check if there's a success message to display
		window.onload = function() {
			const urlParams = new URLSearchParams(window.location.search);
			if (urlParams.has('msg')) {
				document.getElementById('successMessage').classList.add('show');
				// Hide the message after 5 seconds
				setTimeout(function() {
					document.getElementById('successMessage').classList.remove('show');
				}, 5000);
			}
		};
	</script>
</head>
<body>
    <%
        if (request.getParameter("msg") != null) {
    %>
    <script>alert('Login Successfully');</script>
    <%
        }
        String owner = session.getAttribute("owner_rname") != null ? session.getAttribute("owner_rname").toString() : "Admin";
        System.out.println("ownerrrrrrrrrr" + owner);
    %>
    
	<div id="header">
		<h1>Enhanced Digital Forensic Security Model</h1>
		<ul>
			<li class="selected">
				<a href="owner_home.jsp"><i class="fas fa-home"></i> Admin Home</a>
			</li>
			<li>
				<a href="file_upload.jsp"><i class="fas fa-upload"></i> File Upload</a>
			</li>
			<li>
				<a href="view_file.jsp"><i class="fas fa-eye"></i> View File</a>
			</li>
            <li>
				<a href="time_t.jsp"><i class="fas fa-clock"></i> Time Seal</a>
			</li>
            <li>
				<a href="user_de.jsp"><i class="fas fa-users"></i> User Requests</a>
			</li>
            <li>
				<a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
			</li>
		</ul>
	</div>
	
	<div id="body">
		<div class="dashboard-container">
			<div id="successMessage" class="alert-success">
				<strong>Success!</strong> You have logged in successfully.
			</div>
			
			<div class="welcome-section">
				<i class="fas fa-user-shield"></i>
				<h2>Welcome, <span class="admin-name"><%= owner %></span>!</h2>
				<p>You are now accessing the Admin Dashboard of the Enhanced Digital Forensic Security System. Manage files, time seals, and user requests from this centralized interface.</p>
			</div>

			<div class="dashboard-stats">
				<div class="stat-card">
					<i class="fas fa-file-upload"></i>
					<h3>24</h3>
					<p>Files Uploaded</p>
				</div>
				<div class="stat-card">
					<i class="fas fa-user-clock"></i>
					<h3>12</h3>
					<p>Pending Requests</p>
				</div>
				<div class="stat-card">
					<i class="fas fa-shield-alt"></i>
					<h3>36</h3>
					<p>Time Seals Applied</p>
				</div>
				<div class="stat-card">
					<i class="fas fa-database"></i>
					<h3>1.2 GB</h3>
					<p>Storage Used</p>
				</div>
			</div>

			<div class="quick-actions">
				<h3>Quick Actions</h3>
				<div class="action-grid">
					<a href="file_upload.jsp" class="action-card">
						<i class="fas fa-upload"></i>
						<h4>Upload File</h4>
						<p>Add new forensic evidence to the system</p>
					</a>
					<a href="view_file.jsp" class="action-card">
						<i class="fas fa-eye"></i>
						<h4>View Files</h4>
						<p>Browse and manage uploaded evidence</p>
					</a>
					<a href="time_t.jsp" class="action-card">
						<i class="fas fa-clock"></i>
						<h4>Time Seals</h4>
						<p>Apply time-based access controls</p>
					</a>
					<a href="user_de.jsp" class="action-card">
						<i class="fas fa-users"></i>
						<h4>User Requests</h4>
						<p>Manage access requests from users</p>
					</a>
				</div>
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