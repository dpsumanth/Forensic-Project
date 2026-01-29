package algorithm;



import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import org.apache.commons.net.ftp.FTPClient;


public class Ftpcon {
    FTPClient client = new FTPClient();
    FileInputStream fis = null;
    boolean status;
    boolean success;

public boolean upload(File file){
   try{
          client.enterLocalPassiveMode();
            client.connect("ftp.adrive.com");
            client.login("bhuvangowda7288#gmail.com", "Bhuvan001");
            client.enterLocalPassiveMode();
            System.out.println("file.getName=="+file.getName());
//           
             fis = new FileInputStream(file);
             status= client.storeFile(file.getName(), fis);
             client.logout();
             fis.close();
}
catch(Exception e){
    System.out.println(e);
}
        if(status){
             System.out.println("success");
             return true;
        }
        else{
            System.out.println("failed");
            return false;
        }
}
public boolean filedownload(String fname)
{
    

    try
    {
        client.connect("ftp.adrive.com");
       
            client.login("bhuvangowda7288#gmail.com", "Bhuvan001");
            client.enterLocalPassiveMode();
            
        File localfile = new File("D:\\"+fname);
            OutputStream outputStream = new BufferedOutputStream(new FileOutputStream(localfile));
            success = client.retrieveFile(fname, outputStream);
            outputStream.close();
    }catch(Exception e)
    {
        e.printStackTrace();
    }
     if(success){
             System.out.println("success");
             return true;
        }
        else{
            System.out.println("failed");
            return false;
          
}

   
}
}
