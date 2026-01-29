/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package network;

import Dbcon.DbConnection;
import algorithm.Encryption;
import algorithm.Ftpcon;
import algorithm.MHE_Encryptor;
import algorithm.PaillierKeyPair;
import com.oreilly.servlet.MultipartRequest;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.StringTokenizer;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * 
 */
public class Upload1 extends HttpServlet {

   File file;
final String filepath="D:/";
 Random r=new Random();
 String nameid = "";
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
            HttpSession session=request.getSession(true);
             MultipartRequest m=new MultipartRequest(request,filepath);
             String pname = m.getParameter("pname");
             System.out.println("pname"+pname);
             String owner=session.getAttribute("owner_rname").toString();
             System.out.println("owner name isssssssss"+owner);
           File file=m.getFile("file");           
           String filename=file.getName().toLowerCase();
            
            Connection con= DbConnection.getConnection();
            Statement st3=con.createStatement();
            ResultSet rt3=st3.executeQuery("select * from upload2 where owner_name='"+owner+"'");
            if(rt3.next()){
                response.sendRedirect("file_upload.jsp?failed='yes'");
            }
            else
            {
                ResultSet rs=st3.executeQuery("select * from upload2 where filename='"+filename+"'");
                if(rs.next())
                {
                    response.sendRedirect("file_upload.jsp?failed='file name is allready existed'");
                }
                else
                {
                 FileInputStream fis = null;
        long size = 0;
        String email="";
        String[] lines = null;
                    int count = 0;
                   
                    String key = null;
                    String userid = null;
                   
                    
                    int master = 0;
                    String sec = "";
                    String pub = "";
                       BufferedReader br=new BufferedReader(new FileReader(filepath+filename));
          StringBuffer sb=new StringBuffer();
                  
            String temp=null;
            while(( temp=br.readLine())!=null){
                System.out.println("lineeeee"+temp);
               sb.append(temp+"\r\n\r\n");              
           }        
            String str=sb.toString();
           System. out.println("file content:"+sb.toString());
           
//             lines = str.split("\r\n|\r|\n");
                                nameid = (String) session.getAttribute("owner_rname");
                                System.out.println("nameiddddd------"+nameid);
                                sec = Utilities.stringtoByte(filename + filename.length());
                                pub = Utilities.stringtoByte(nameid);
                                //int ran=r.nextInt(100);
                                //String mas=String(ran);
                                master = Utilities.generatePin();
                                //========================================================
                               String fName="";
          KeyGenerator symmetric_key = KeyGenerator.getInstance("AES");
	symmetric_key.init(128);
	SecretKey secretKey = symmetric_key.generateKey();
        System.out.println("secret key:"+secretKey);
//        MHE_Encryptor mhe=new MHE_Encryptor();
//        PaillierKeyPair user1 = new PaillierKeyPair();
            Encryption e=new Encryption();
           String encryptedtext=e.encrypt(sb.toString(),secretKey);
           //storing encrypted file
            FileWriter fw=new FileWriter(file);
            fw.write(encryptedtext);
            fw.close();
            
        //converting secretkey to String
            byte[] b=secretKey.getEncoded();//encoding secretkey
            String skey=Base64.encode(b);
            System.out.println("converted secretkey to string:"+skey);
            
            
            
            
            //getting properties
            //HttpSession user=request.getSession(true);
//            HttpSession session=request.getSession(true);
//            String owner=session.getAttribute("owner_rname").toString();
            
             DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   //get current date time with Date()
	     Date date = new Date();
//	     System.out.println(dateFormat.format(date));
             String Start_time= dateFormat.format(date); 
             System.out.println("current Date----upload "+Start_time);
               
	   //get current date time with Calendar()
	    Calendar cal = Calendar.getInstance();
            cal.setTime(date);
             cal.add(Calendar.DATE, 1);
             Date close_time= cal.getTime();
             String End_time=dateFormat.format(close_time);
//             Date End_Time = cal.getTime();
	    System.out.println("current Date add one date"+End_time);
               //get current date time
            
            
            //
            String len=file.length()+"bytes";
                 boolean status=new Ftpcon().upload(file);
              String filecontent=sb.toString();
         System.out.println("File== content=="+filecontent);
         String extractkeywords="";
         String comoinfo =filecontent.substring(0,filecontent.indexOf("=")-1);
          String docdep=filecontent.substring(filecontent.lastIndexOf("=")+1,filecontent.lastIndexOf("@")-1);
          String perinfo=filecontent.substring(filecontent.lastIndexOf("@")+1,filecontent.lastIndexOf("#")-1);
          String keywordinfo=filecontent.substring(filecontent.lastIndexOf("#")+1,filecontent.length());
          StringTokenizer stmes= new StringTokenizer(keywordinfo,"\r\n");
          while(stmes.hasMoreTokens())
          {
              extractkeywords+=stmes.nextToken()+",";
          }
          
          System.out.println("File==222 content==22"+docdep);
           System.out.println("File==333 content==33"+perinfo);
      System.out.println("File==333 content==33"+comoinfo);
      System.out.println("File==Keyword"+keywordinfo);
      System.out.println("Extracted Keywords"+extractkeywords);
        PreparedStatement pstm1 = null;
            
            if(status){
                //Connection con= Dbconnection.getConn();
                Statement st=con.createStatement();

               
                int i=st.executeUpdate("insert into upload2(filename,content,owner_name,start_time,end_time,sceret_key,patient,docdep,perinfo,comoinfo,masterkey,publickey)values('"+file.getName()+"','"+encryptedtext+"','"+owner+"','"+Start_time+"','"+End_time+"','"+skey+"','"+pname+"','"+docdep+"','"+perinfo+"','"+comoinfo+"','"+master+"','"+pub+"')");
                System.out.println(i);
                if(i!=0){
                   // out.println("success");
                    String sql2 = "select email from reg where uname= '" + nameid + "'";
          PreparedStatement  pst = (PreparedStatement) con.prepareStatement(sql2);
            ResultSet rs1 = pst.executeQuery();
            if(rs1.next())
            {
                email=rs1.getString(1);
            }
                    session.setAttribute("fname", filename);
                    session.setAttribute("exkey", extractkeywords);
                     String msg="For your File"
                             + ":"+filename+"Secret key="+skey;
                                mail.secretMail(msg,nameid,email);
                    response.sendRedirect("setkeyword.jsp?status='uploded'");
                    
                }
                else{
                    out.println("error while uploading additional informations");
                }
            
//                 out.println("file stored");
//                 out.println(file.length());
            }
            
            else{
                out.println("error");
            }
           
        }
            }
        }
            catch(Exception e)
            {
                System.out.println("errror ------"+e);
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
