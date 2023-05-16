package controller.servlets;

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

/**
 *
 * @author Jinesh
 */
@WebServlet(name = "AuthUser", urlPatterns = {"/AuthUser"})
public class AuthUser extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection con = Database.getConnection(request, response);
       
        try {
            if(authenticate(con, request, response)) {
                response.sendRedirect("Home");
            
            } else {
            response.sendRedirect("error.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            
        }
    }
        
    private boolean authenticate(Connection con, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String sql = "SELECT * FROM users WHERE (email=? AND password=?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, request.getParameter("email"));
        ps.setString(2, request.getParameter("password"));

        ResultSet result = ps.executeQuery();

        if (result.next()) {
            User user = new User(result.getString("id"), result.getString("full_name"), result.getString("gender"), result.getString("profile_pic"), result.getString("state"), result.getString("city"), result.getString("street"), result.getString("pincode"), result.getString("birth_year"), result.getString("email"), result.getString("password"));
            request.getSession().setAttribute("loggedInUser", user);
            return true;
        } else {
            return false;

        }
    }


}
