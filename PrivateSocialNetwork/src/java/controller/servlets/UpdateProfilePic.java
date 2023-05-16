/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import steganography.Steganography;

@WebServlet(name = "UpdateProfilePic", urlPatterns = {"/UpdateProfilePic"})
public class UpdateProfilePic extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con = Database.getConnection(request, response);
        User user = (User) request.getSession().getAttribute("loggedInUser");        
        HashMap<String, String> jsonData = new HashMap<>();        
        Steganography steg = new Steganography();
        
        String root = getServletContext().getRealPath("/");
        File path = new File(root + "/profiles");
        if (!path.exists()) path.mkdirs();
        
        String imageFileName = "";
        File imageFile;
        String message;
        if(ServletFileUpload.isMultipartContent(request))
        {
            try {
                List<FileItem> multiparts=new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                for(FileItem item:multiparts)
                {
                    if(!item.isFormField())
                    {
                        imageFileName=new File(item.getName()).getName();
                        imageFile = new File(path+File.separator+imageFileName);
			BufferedImage image = steg.user_space(ImageIO.read(item.getInputStream()));
                        message = new String(steg.decode_text(steg.get_byte_data(image)));
			System.out.println("Decoded Message: " +  message);
                        if(message.equals("none")) {                            
                            if(updateProfile(con, request, response,user,imageFileName)) {
                                String msg = String.format("%04d", Integer.parseInt(user.getId()));
                                BufferedImage outputImage = steg.add_text(image, user.getId());
                                ImageIO.write(outputImage, "png", imageFile); 
                                jsonData.put("status", "success");
                                jsonData.put("message", "ProfilePic Updated Successfully!");
                                user.setProfilePic(imageFileName);
                                request.getSession().setAttribute("loggedInUser", user);                                
                            } else {
                                jsonData.put("status", "fail");
                                jsonData.put("message", "Unable to Update ProfilePic!");                                
                            }                                
                        } else {
                            if(message.equals(user.getId())) {
                                jsonData.put("status", "fail");
                                jsonData.put("message", "Duplicate ProfilePic!");                               
                            } else {
                                logBreach(con, request, response,user,message);
                                jsonData.put("status", "fail");
                                jsonData.put("message", "Cannot upload others' ProfilePic!");                                   
                            }
                        }
                    }
                }                
            } catch(Exception e) {
                e.printStackTrace();
                jsonData.put("status", "fail");
                jsonData.put("message", "Oops, something went wrong!");
            }

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(jsonData));
            out.flush();
        }
    }
    
    private boolean updateProfile(Connection con, HttpServletRequest request, HttpServletResponse response,User user, String imageFileName) throws SQLException {
        String sql = "UPDATE users SET profile_pic = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, imageFileName);
        ps.setString(2, user.getId());
        return ps.executeUpdate() > 0;
    }    
    private boolean logBreach(Connection con, HttpServletRequest request, HttpServletResponse response,User user, String recipient_id) throws SQLException {
        String sql = "INSERT INTO notifications(recipient_id,sender_id,type) VALUES(?,?,'breach') ";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, recipient_id);
        ps.setString(2, user.getId());
        return ps.executeUpdate() > 0;
    }

}
