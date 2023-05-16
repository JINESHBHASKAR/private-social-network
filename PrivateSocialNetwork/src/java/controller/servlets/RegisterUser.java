package controller.servlets;

import database.Database;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;

@WebServlet(name = "RegisterUser")
public class RegisterUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = Database.getConnection(request, response);

        HashMap<String, String> jsonData = new HashMap<String, String>();

        try {
            if (insertUser(con, request, response)) {
//                jsonData.put("status", "success");
//                jsonData.put("message", "Registration Success!");
                response.sendRedirect("Home");

            } else {
//                jsonData.put("status", "fail");
//                jsonData.put("message", "Unable To Insert User!");
                response.sendRedirect("error.jsp");

            }
        } catch (SQLException e) {
//            jsonData.put("status", "fail");
//            jsonData.put("message", "User Already Exists!");
            response.sendRedirect("error.jsp");
        }

//        Gson gson = new Gson();
//
//        response.setContentType("application/json");
//        PrintWriter out = response.getWriter();
//        out.print(gson.toJson(jsonData));
//        out.flush();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private boolean insertUser(Connection con, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        
        String sql = "INSERT INTO users (full_name, gender, state, city, street, pincode, birth_year, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        String fullName = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        String street = request.getParameter("street");
        String pincode = request.getParameter("pincode");
        String birthYear = request.getParameter("birthyear");
        String email = request.getParameter("registeremail");
        String password = request.getParameter("registerpassword");
        String profilePic = "avatar.png";

        ps.setString(1, fullName);
        ps.setString(2, gender);
        ps.setString(3, state);
        ps.setString(4, city);
        ps.setString(5, street);
        ps.setString(6, pincode);
        ps.setString(7, birthYear);
        ps.setString(8, email);
        ps.setString(9, password);

        int result = ps.executeUpdate();
        String generatedKey = "";

        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) {
            generatedKey = rs.getString(1);
            User user = new User(generatedKey, fullName, gender, profilePic, state, city, street, pincode, birthYear, email, password);
            request.getSession().setAttribute("loggedInUser", user);

            return true;

        } else {
            return false;

        }
    }
}
