package controller.servlets;

import com.google.gson.Gson;
import database.Database;
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

/**
 * 
 * @author Jinesh
 * 
 */
@WebServlet(name = "DeletePost")
public class DeletePost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = Database.getConnection(request, response);

        String postId = request.getParameter("post_id");
        User user = (User) request.getSession().getAttribute("loggedInUser");

        HashMap<String, String> jsonData = new HashMap<String, String>();

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        PreparedStatement statement = null;
        try {
            statement = con.prepareStatement("DELETE FROM posts WHERE id = ?");
            statement.setString(1, postId);
            int resultDel = statement.executeUpdate();

            statement = con.prepareStatement("DELETE FROM comments WHERE post_id = ?");
            statement.setString(1, postId);
            statement.executeUpdate();

            statement = con.prepareStatement("DELETE FROM likes WHERE post_id = ?");
            statement.setString(1, postId);
            statement.executeUpdate();

            if(resultDel>0) {
                jsonData.put("status", "success");
                jsonData.put("message", "Post Deleted!");
            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Unable to Delete Post");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            jsonData.put("status", "fail");
            jsonData.put("message", "Unable to Delete Post");

        }

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        out.print(new Gson().toJson(jsonData));
        out.flush();
        out.close();
    }
}
