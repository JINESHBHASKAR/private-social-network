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
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Jinesh
 */
@WebServlet(name = "UpdateStatus", urlPatterns = {"/UpdateStatus"})
public class UpdateStatus extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            doPost(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con = Database.getConnection(request, response);
        
        User user = (User) request.getSession().getAttribute("loggedInUser");
        
        HashMap<String, String> jsonData = new HashMap<>();
        
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        
        if (user == null) {
            response.sendRedirect("index.jsp");
        }
        
        String id = request.getParameter("id");
        String status = request.getParameter("status");
        
        System.out.println("Follow_id:"+status);
        try {
            String sql = "UPDATE notifications SET status = ? WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setString(2, id);
            int res = pstmt.executeUpdate();
            if(res>0) {
                    jsonData.put("status", "success");
                    jsonData.put("message", "Status Updated");
            } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "Unable to update");
            }
   
        } catch(Exception e) {
                e.printStackTrace();
                jsonData.put("status", "fail");
                jsonData.put("message", "Oops, something went wrong!");
        }
        
        out.print(new Gson().toJson(jsonData));
        out.close();

        
        
    }

}
