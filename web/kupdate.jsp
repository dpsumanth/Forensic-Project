<%@page import="java.util.StringTokenizer"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.KeyGenerator"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Dbcon.DbConnection"%>
<%@page import="algorithm.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
     Connection con = null;
    Statement st = null;
   ResultSet rs = null;
    String fname = request.getParameter("key");
    String ti = request.getParameter("tit");
    String key = request.getParameter("keyword");
      StringTokenizer str=new StringTokenizer(key, ",");
      String es="";
      String key1="";
      while(str.hasMoreTokens())
      {
          es=str.nextToken();
          
           key1+=new TrippleDes().encrypt(es)+",";
      }
    String cat = request.getParameter("cat");
     
           System.out.println("encrypted key are:"+key1);
   con = DbConnection.getConnection();
        st = con.createStatement();
        
        int i = st.executeUpdate("update upload2 set title ='" + ti + "',keyword ='" + key1 + "', cat='"+cat+"' where filename = '"+fname+"' ");
    
    if(i!=0){
    response.sendRedirect("owner_home.jsp?Updated sucess..!");
            }else{
    response.sendRedirect("owner_home.jsp?Updated fails..!");
    }

%>