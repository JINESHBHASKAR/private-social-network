package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import java.io.File;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "UpdateProfile")
public class UpdateProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        
        Connection con = Database.getConnection(request, response);

        User user = (User) request.getSession().getAttribute("loggedInUser");

        HashMap<String, String> jsonData = new HashMap<String, String>();

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            String sql = "UPDATE users SET full_name = ?, state = ?, city = ?, street = ?, pincode = ?, birth_year = ? WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, request.getParameter("fullname"));
            ps.setString(2, request.getParameter("state"));
            ps.setString(3, request.getParameter("city"));
            ps.setString(4, request.getParameter("street"));
            ps.setString(5, request.getParameter("pincode"));
            ps.setString(6, request.getParameter("birthyear"));
            ps.setString(7, user.getId());

            int result = ps.executeUpdate();

            if (result > 0) {
                jsonData.put("status", "success");
                jsonData.put("message", "Profile Updated Successfully!");

                user.setFullName(request.getParameter("fullname"));
                user.setState(request.getParameter("state"));
                user.setCity(request.getParameter("city"));
                user.setStreet(request.getParameter("street"));
                user.setPinCode(request.getParameter("pincode"));
                user.setBirthYear(request.getParameter("birthyear"));

                request.getSession().setAttribute("loggedInUser", user);

            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Unable to Update Profile!");

            }

        } catch (SQLException e) {
            jsonData.put("status", "fail");
            jsonData.put("message", "Oops, something went wrong!");
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonData));
        out.flush();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
