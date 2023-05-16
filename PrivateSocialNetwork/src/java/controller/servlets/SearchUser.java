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
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "SearchUser", urlPatterns = {"/SearchUser"})
public class SearchUser extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HashMap<String,String> names = new HashMap<String,String>();
        
        String searchName = request.getParameter("searchName").toLowerCase();
        
        User user = (User) request.getSession().getAttribute("loggedInUser");
                
        System.out.println("searchName: "+searchName);
        Connection con = Database.getConnection(request, response);
        
        try {
            String sql = "SELECT id,full_name FROM users WHERE lower(full_name) like ? AND id NOT IN (?) AND id NOT IN (SELECT follow_id FROM follows WHERE user_id = ?) LIMIT 10";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%"+searchName+"%");
            ps.setString(2, user.getId());
            ps.setString(3, user.getId());

            ResultSet result = ps.executeQuery();

            while(result.next()) {
                names.put(result.getString("id"),result.getString("full_name"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        out.print(new Gson().toJson(names));
        out.flush();
       
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
        
    }

}
