/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Message;
import model.User;


@WebServlet(name = "LoadMessages", urlPatterns = {"/LoadMessages"})
public class LoadMessages extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Message> messages = new ArrayList<Message>();
        
        User user = (User) request.getSession().getAttribute("loggedInUser");   
        
        if (user == null) {
            response.sendRedirect("index.jsp");
        }
        
        String buddy_id = request.getParameter("buddy_id");
        System.out.println("buddy_id: "+buddy_id);
        
        HashMap<String, String> jsonData = new HashMap<>();

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        Connection con = Database.getConnection(request,response);
        
        try {
            String sql = "SELECT messages.id, profile_pic, content, datetime, buddy_id, users.full_name FROM messages\n" +
                         "INNER JOIN users ON messages.user_id = users.id\n" +
                         "WHERE users.id IN (?,?) AND messages.buddy_id IN (?,?) ORDER BY messages.id DESC";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1,buddy_id);
            ps.setString(2,user.getId());
            ps.setString(3,buddy_id);
            ps.setString(4,user.getId());
            
            ResultSet result = ps.executeQuery();

            while(result.next()) {
                Message message = new Message();

                message.setId(result.getString("id"));
                message.setMessage(result.getString("content"));
                String dateTime = result.getString("datetime");
                dateTime = dateTime.substring(0, dateTime.length()-5);
                message.setDateTime(dateTime);
                if(result.getString("full_name").equals(user.getFullName()))
                    message.setSentBy("me");
                else
                    message.setSentBy(result.getString("full_name"));
                message.setSentByProfilePic(result.getString("profile_pic"));
                messages.add(message);

            }
                
            jsonData.put("status", "success");
            jsonData.put("message", new Gson().toJson(messages));

        } catch (Exception e){
            e.printStackTrace();
            jsonData.put("status", "fail");
            jsonData.put("message", "Oops, something went wrong!");
        }
        
        out.print(new Gson().toJson(jsonData));
        out.flush();
    }
}
