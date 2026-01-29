<!DOCTYPE HTML>
<%@page import="Dbcon.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>TAFC - Time Seal</title>
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

		.time-seal-container {
			width: 100%;
			max-width: 1200px;
			margin: 0 auto;
		}

		.page-header {
			background: white;
			border-radius: 12px;
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
			padding: 2rem;
			margin-bottom: 2rem;
			text-align: center;
		}

		.page-header i {
			font-size: 3rem;
			color: var(--warning);
			margin-bottom: 1rem;
			display: block;
		}

		.page-header h2 {
			color: var(--primary);
			font-size: 1.8rem;
			margin-bottom: 0.5rem;
		}

		.page-header p {
			color: #666;
			font-size: 1rem;
			max-width: 800px;
			margin: 0 auto;
		}

		.time-info {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
			gap: 1.5rem;
			margin-bottom: 2rem;
		}

		.info-card {
			background: white;
			border-radius: 8px;
			box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
			padding: 1.5rem;
			text-align: center;
			border-top: 4px solid var(--warning);
		}

		.info-card i {
			font-size: 2rem;
			color: var(--warning);
			margin-bottom: 1rem;
			display: block;
		}

		.info-card h3 {
			font-size: 1.2rem;
			color: var(--primary);
			margin-bottom: 0.5rem;
		}

		.info-card p {
			color: #666;
			font-size: 0.9rem;
		}

		.files-table-container {
			background: white;
			border-radius: 12px;
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
			padding: 2rem;
			overflow-x: auto;
		}

		.files-table {
			width: 100%;
			border-collapse: collapse;
			min-width: 700px;
		}

		.files-table thead {
			background: var(--gradient);
			color: white;
		}

		.files-table th {
			padding: 1rem;
			text-align: left;
			font-weight: 600;
			font-size: 0.9rem;
		}

		.files-table tbody tr {
			border-bottom: 1px solid #eee;
			transition: all 0.3s ease;
		}

		.files-table tbody tr:hover {
			background-color: #f8f9fa;
		}

		.files-table td {
			padding: 1rem;
			color: #555;
			font-size: 0.9rem;
		}

		.files-table .file-name {
			font-weight: 500;
			color: var(--primary);
		}

		.files-table .patient-name {
			font-weight: 500;
		}

		.files-table .action-cell {
			text-align: center;
		}

		.btn-time-seal {
			background: var(--warning);
			color: white;
			border: none;
			padding: 0.6rem 1.2rem;
			border-radius: 4px;
			font-size: 0.8rem;
			font-weight: 500;
			cursor: pointer;
			transition: all 0.3s ease;
			display: inline-flex;
			align-items: center;
			gap: 5px;
			text-decoration: none;
		}

		.btn-time-seal:hover {
			background: #e67e22;
			transform: translateY(-2px);
			box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
		}

		.no-files {
			text-align: center;
			padding: 3rem;
			color: #666;
		}

		.no-files i {
			font-size: 4rem;
			color: #ddd;
			margin-bottom: 1rem;
			display: block;
		}

		.no-files h3 {
			font-size: 1.5rem;
			margin-bottom: 0.5rem;
			color: #777;
		}

		.no-files p {
			font-size: 1rem;
		}

		.status-badge {
			display: inline-block;
			padding: 0.3rem 0.6rem;
			border-radius: 20px;
			font-size: 0.75rem;
			font-weight: 500;
		}

		.status-sealed {
			background: #e8f5e8;
			color: #2ecc71;
		}

		.status-pending {
			background: #fff3cd;
			color: #856404;
		}

		.status-unsealed {
			background: #fde8e8;
			color: #e74c3c;
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

			.page-header {
				padding: 1.5rem;
			}

			.page-header h2 {
				font-size: 1.5rem;
			}

			.time-info {
				grid-template-columns: 1fr;
			}

			.files-table-container {
				padding: 1rem;
			}

			.files-table th,
			.files-table td {
				padding: 0.75rem 0.5rem;
			}
		}

		@media (max-width: 480px) {
			.page-header {
				padding: 1rem;
			}
			
			.page-header h2 {
				font-size: 1.3rem;
			}
			
			.page-header i {
				font-size: 2.5rem;
			}
		}
	</style>
</head>
<body>
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
				<a href="view_file.jsp"><i class="fas fa-eye"></i> View Files</a>
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
		<div class="time-seal-container">
			<div class="page-header">
				<i class="fas fa-clock"></i>
				<h2>Time Seal Management</h2>
				<p>Apply time-based access controls to your medical records. Time seals restrict file access to specific time periods for enhanced security.</p>
			</div>

			<div class="time-info">
				<div class="info-card">
					<i class="fas fa-shield-alt"></i>
					<h3>Enhanced Security</h3>
					<p>Time-based access controls add an extra layer of security to your sensitive medical records</p>
				</div>
				<div class="info-card">
					<i class="fas fa-calendar-alt"></i>
					<h3>Flexible Scheduling</h3>
					<p>Set precise start and end times for file accessibility based on your requirements</p>
				</div>
				<div class="info-card">
					<i class="fas fa-user-lock"></i>
					<h3>Access Control</h3>
					<p>Combine time seals with role-based permissions for comprehensive security</p>
				</div>
			</div>

			<div class="files-table-container">
				<%
					Connection con = null;
					Statement st = null;
					ResultSet rs = null;
					int fileCount = 0;
					try {
						con = DbConnection.getConnection();
						st = con.createStatement();
						String owner = session.getAttribute("owner_rname").toString();
						rs = st.executeQuery("select * from upload2 where owner_name='" + owner + "'");
						
						if (rs.isBeforeFirst()) {
				%>
				<table class="files-table">
					<thead>
						<tr>
							<th>Patient ID</th>
							<th>Owner Name</th>
							<th>Patient Name</th>
							<th>File Name</th>
							<th>Current Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
							while(rs.next()) {
								fileCount++;
								// Determine current time seal status
								String statusClass = "status-unsealed";
								String statusText = "No Time Seal";
								String startTime = rs.getString("start_time");
								String endTime = rs.getString("end_time");
								
								if (startTime != null && !startTime.isEmpty() && endTime != null && !endTime.isEmpty()) {
									statusClass = "status-sealed";
									statusText = "Time Sealed";
								}
						%>
						<tr>
							<td><%=rs.getString("id")%></td>
							<td><%=rs.getString("owner_name")%></td>
							<td class="patient-name"><%=rs.getString("patient")%></td>
							<td class="file-name">
								<i class="fas fa-file-medical" style="color: #3498db; margin-right: 5px;"></i>
								<%=rs.getString("filename")%>
							</td>
							<td>
								<span class="status-badge <%=statusClass%>">
									<i class="fas fa-<%=statusClass.equals("status-sealed") ? "check" : "clock"%>"></i>
									<%=statusText%>
								</span>
							</td>
							<td class="action-cell">
								<a href="set_date.jsp?id=<%=rs.getString("id")%>&fname=<%=rs.getString("filename")%>" class="btn-time-seal">
									<i class="fas fa-clock"></i> 
									<%=statusClass.equals("status-sealed") ? "Modify" : "Set"%> Time Seal
								</a>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
						} else {
				%>
				<div class="no-files">
					<i class="fas fa-file-medical"></i>
					<h3>No Files Available</h3>
					<p>You need to upload files before you can apply time seals.</p>
					<br>
					<a href="file_upload.jsp" class="btn-time-seal">
						<i class="fas fa-upload"></i> Upload Files First
					</a>
				</div>
				<%
						}
					} catch (Exception ex) {
						ex.printStackTrace();
				%>
				<div class="no-files">
					<i class="fas fa-exclamation-triangle" style="color: #f39c12;"></i>
					<h3>Database Error</h3>
					<p>Unable to load files. Please try again later.</p>
				</div>
				<%
					} finally {
						try {
							if (rs != null) rs.close();
							if (st != null) st.close();
							if (con != null) con.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				%>
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