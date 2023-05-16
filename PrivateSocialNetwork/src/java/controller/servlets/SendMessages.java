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
import java.sql.Statement;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Message;
import model.User;

@WebServlet(name = "SendMessages", urlPatterns = {"/SendMessages"})
public class SendMessages extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute("loggedInUser");   
        
        if (user == null) {
            response.sendRedirect("index.jsp");
        }
        
        String content = request.getParameter("message");
        String buddy_id = request.getParameter("buddy_id");
        System.out.println("buddy_id: "+buddy_id+" message: " + content);
        
        HashMap<String, String> jsonData = new HashMap<>();

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        PreparedStatement statement = null;
        Connection con = Database.getConnection(request,response);
        
        try {
            String sql = "insert into messages (buddy_id, user_id, content) values (?,?,?)";
            statement = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1,buddy_id);
            statement.setString(2,user.getId());
            statement.setString(3,content);

            int numOfRow = statement.executeUpdate();

            String generatedKey = "";

            ResultSet rs = statement.getGeneratedKeys();

            if (rs.next()) {
                generatedKey = rs.getString(1);

                PreparedStatement ps = con.prepareStatement("SELECT messages.id, profile_pic, content, datetime, buddy_id, users.full_name FROM messages\n" + 
                        "INNER JOIN users ON messages.user_id=users.id WHERE messages.id = ?");
                ps.setString(1, generatedKey);
                ResultSet resultSet = ps.executeQuery();

                if(resultSet.next()) {                    
                    
                    Message message = new Message();

                    message.setId(resultSet.getString("id"));
                    message.setMessage(resultSet.getString("content"));
                    String dateTime = resultSet.getString("datetime");
                    dateTime = dateTime.substring(0, dateTime.length()-5);
                    message.setDateTime(dateTime);
                    message.setSentBy("me");
                    message.setSentByProfilePic(resultSet.getString("profile_pic"));

                    jsonData.put("status", "success");
                    jsonData.put("message", new Gson().toJson(message));

                } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "Unable to send message!");

                }

            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Oops, something went wrong!");

            }

        } catch (Exception e){
            e.printStackTrace();
        }
        
        out.print(new Gson().toJson(jsonData));
        out.flush();
    }

}
