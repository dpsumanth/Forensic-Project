/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Dbcon.DbConnection;
import algorithm.Decryption;


/**
 *
 
 */
public class download extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
             String fileid=request.getParameter("id");
             System.out.println ("file id isssssssssss======="+fileid);
             System.out.println("id isssss"+fileid);
            String skey=request.getParameter("skey");
             System.out.println ("file id seke======="+skey);
           //  String skey=
             String fname=request.getParameter("fname");
             String role=request.getParameter("role");
             System.out.println("role isssss"+role);
             String fkey=null;
             InputStream is=null;
          
          Connection con= DbConnection.getConnection();
          Statement st=con.createStatement();
          Statement st1=con.createStatement();
          
          HttpSession user=request.getSession();
          
  HttpSession session = request.getSession(true);
       String  uname=(String)session.getAttribute("ssuname");
       System.out.println("uname from download------------"+uname);
   
          
          
          
          ResultSet rt=st.executeQuery("select * from upload2  where id='"+fileid+"'");
          
          if(rt.next()){
           fname=rt.getString("filename");
           fkey=rt.getString("sceret_key");
           System.out.println("fname-----------"+fname);
           System.out.println("roleeeeeeeeeeee"+role);
           if(role.equalsIgnoreCase("doctor"))
           {
               System.out.println("role is:======="+role);
               System.out.println("skey is====="+fkey);
           String s2=(rt.getString("content").toString());
           System.out.println("s2222===="+s2);
                  String content= Decryption.decrypt(s2,fkey);
          

         System.out.println("content============"+content);
         
         response.setHeader("Content-Disposition","attachment;filename=\""+fname+"\"");        
         out.write(content);
          }
           else
               if(role.equalsIgnoreCase("police"))
               {
                   String s2=(rt.getString("comoinfo"));
                    System.out.println("infoooo"+s2);
//                    String content=new Decryption().decrypt(s2,skey);
                   
         
         response.setHeader("Content-Disposition","attachment;filename=\""+fname+"\"");        
         out.write(s2);
                   
               }
                else
               if(role.equalsIgnoreCase("insurance"))
               {
                   String s3=(rt.getString("comoinfo"));
//                    String content=new Decryption().decrypt(s3,skey);
         
         response.setHeader("Content-Disposition","attachment;filename=\""+fname+"\"");        
         out.write(s3);
                   
               }
          }
          else{              
           out.println("error while retreiving data");
          
         }
          
//         BufferedReader br=new BufferedReader(new InputStreamReader(is));
//         String temp=null;
//         StringBuffer sb=new StringBuffer();
//         while((temp=br.readLine())!=null){
//            sb.append(temp);
//         }
//         String content=new Decryption().decrypt(sb.toString(),fkey);
//         
//         response.setHeader("Content-Disposition","attachment;filename=\""+fname+"\"");        
//         out.write(content);
//         
        
         
            Calendar cal=Calendar.getInstance();
            DateFormat dateformat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");          
            String time=dateformat.format(cal.getTime());
            System.out.println("download time:"+time);
            
            st1.executeUpdate("insert into downloads (filename,username,time)values('"+fname+"','"+uname+"','"+time+"')");

                 
        }
        
        catch(Exception e){
          e.printStackTrace();
        } finally {            
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
