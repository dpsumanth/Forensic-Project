package network;

import Dbcon.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * 
 */
public class Req extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String fid = request.getParameter("fid");
            String fname = request.getParameter("fname");
            String sk = request.getParameter("sk");
            String ownname = request.getParameter("owner_name");

            HttpSession session = request.getSession(true);
            Connection conn = DbConnection.getConnection();
            Statement st3 = conn.createStatement();
            ResultSet rs1 = null;
            String uname = session.getAttribute("ssuname").toString();
            System.out.println("ssname=======" + uname);

            // Get current date time
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date currentDate = new Date();
            String currentDateStr = dateFormat.format(currentDate);

            rs1 = st3.executeQuery("select * from timeseal where fid='" + fid + "' and uname='" + uname + "'");
            if (rs1.next()) {
                String startTimeStr = rs1.getString("start_time");
                String endTimeStr = rs1.getString("end_time");

                System.out.println("Start Time from DB: " + startTimeStr);
                System.out.println("End Time from DB: " + endTimeStr);
                System.out.println("Current Time: " + currentDateStr);

                // Parse dates with flexible format handling
                Date startTime = parseDateFlexible(startTimeStr);
                Date endTime = parseDateFlexible(endTimeStr);
                
                if (startTime == null || endTime == null) {
                    response.sendRedirect("search_patient.jsp?ms2=Invalid date format in database");
                    return;
                }

                System.out.println("Parsed Start Time: " + startTime);
                System.out.println("Parsed End Time: " + endTime);
                System.out.println("Current Time: " + currentDate);

                // Check if current time is within the allowed time range
                if (currentDate.after(startTime) && currentDate.before(endTime)) {
                    String User_Name = (String) session.getAttribute("ssuname");
                    System.out.println("UserNAme----" + User_Name);
                    String Email = (String) session.getAttribute("ssmail");
                    String Status = "No";

                    Connection con = DbConnection.getConnection();
                    Statement st = con.createStatement();

                    String sql = "insert into request(user_name, email, file_name, secret_key, status) values ('"
                            + User_Name + "','" + Email + "','" + fname + "','" + sk + "','" + Status + "')";

                    int x = st.executeUpdate(sql);
                    if (x != 0) {
                        response.sendRedirect("search_patient.jsp?msg=Request_send_Successfully");
                    } else {
                        response.sendRedirect("search_patient.jsp?message=fail");
                    }
                } else {
                    System.out.println("Access denied - Current time is outside allowed range");
                    System.out.println("Is current after start? " + currentDate.after(startTime));
                    System.out.println("Is current before end? " + currentDate.before(endTime));
                    response.sendRedirect("search_patient.jsp?msggg=yes");
                }
            } else {
                response.sendRedirect("search_patient.jsp?ms2=You don't have access permission");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("search_patient.jsp?message=error");
        }
    }

    /**
     * Flexible date parser that handles multiple formats
     */
    private Date parseDateFlexible(String dateString) {
        if (dateString == null || dateString.trim().isEmpty()) {
            return null;
        }
        
        // Remove any extra spaces and trim
        dateString = dateString.trim();
        
        // Try different date formats in order of likelihood
        String[] possibleFormats = {
            "yyyy-MM-dd HH:mm:ss",  // Format with seconds
            "yyyy-MM-dd HH:mm",     // Format without seconds
            "yyyy-MM-dd",           // Date only
            "dd-MM-yyyy HH:mm:ss",
            "dd-MM-yyyy HH:mm",
            "dd/MM/yyyy HH:mm:ss",
            "dd/MM/yyyy HH:mm"
        };
        
        for (String format : possibleFormats) {
            try {
                DateFormat df = new SimpleDateFormat(format);
                df.setLenient(false); // Strict parsing
                return df.parse(dateString);
            } catch (ParseException e) {
                // Try next format
                continue;
            }
        }
        
        System.out.println("Unable to parse date: " + dateString);
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}