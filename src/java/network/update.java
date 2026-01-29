/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package network;

import Dbcon.DbConnection;
import algorithm.Encryption;
import algorithm.Ftpcon;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * 
 */
public class update extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String skey=request.getParameter("skey");
            HttpSession sess=request.getSession(true);
          //  String fname=request.getParameter("fnamae");
          String fname=sess.getAttribute("fname").toString();                  
          String  filecontent1=request.getParameter("gets");
           String own=request.getParameter("own");
           System.out.println("owner name isssss"+own);
           System.out.println("file name is name isssss"+fname);
           String role=sess.getAttribute("role").toString();
           System.out.println("role========="+role);
           if(role.equalsIgnoreCase("doctor"))
           {
           Connection con=DbConnection.getConnection();
            Statement st3=con.createStatement();
             File file = new File("D:\\"+fname);
                        FileOutputStream fop = null;
                        fop = new FileOutputStream(file);
                        System.out.append("file content"+filecontent1);
                        // if file doesnt exists, then create it
//                        if (!file.exists()) {
//                            file.createNewFile();
//                        }
                        System.out.println("fname===="+fname);
                       
                        
                    
                         BufferedOutputStream w = new BufferedOutputStream(new FileOutputStream(file));
                        int c;
              		
                        String s2=filecontent1;
                  	System.out.println("s2222222222"+s2);
              System.out.println(s2);
               KeyGenerator symmetric_key = KeyGenerator.getInstance("AES");
	symmetric_key.init(128);
	SecretKey secretKey = symmetric_key.generateKey();
        System.out.println("secret key:"+secretKey);
        
            Encryption e=new Encryption();
           String encryptedtext=e.encrypt(s2,secretKey);
           //storing encrypted file
            FileWriter fw=new FileWriter(file);
            fw.write(encryptedtext);
            fw.close();
             byte[] b=secretKey.getEncoded();//encoding secretkey
            String skey1=Base64.encode(b);
            System.out.println("converted secretkey to string:"+skey1);
            boolean status=new Ftpcon().upload(file);
            System.out.println(status);
            if(status)
            {
               Statement st=con.createStatement();
               int i=st.executeUpdate("update upload2 set content='"+encryptedtext+"',sceret_key='"+skey1+"'where owner_name='"+own+"'and filename='"+fname+"'");
//              PreparedStatement pst1=con.prepareStatement("update upload2 set content=?,sceret_key=? where owner_name='"+own+"'and filename='"+fname+"'");
//             pst1.setString(1, encryptedtext);
//             pst1.setString(2, skey1);
           // int i= pst1.executeUpdate();
            System.out.println("iiiiiiiii"+i);
         if(i>0)
         {
             System.out.println("updatedddd");
             ResultSet rs=st3.executeQuery("select * from reg where uname='"+own+"'");
             if(rs.next())
             {
             String email=rs.getString("email");
              String msg="For your File is upadated"+fname+"Secret key="+skey1;
                                mail.secretMail(msg,own,email);
                   
             }
              response.sendRedirect("user_home.jsp?status='updated'");
         }
            }
           }
         else
         {
              response.sendRedirect("user_home.jsp?statuses='norights'");
         }
        
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
