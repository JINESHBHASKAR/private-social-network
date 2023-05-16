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
import java.sql.ResultSet;
import java.util.HashMap;

@WebServlet(name = "UpdateLike")
public class LikeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String post_id = request.getParameter("post_id");

        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        Connection con = Database.getConnection(request, response);

        HashMap<String, String> jsonData = new HashMap<>();

        try {
            statement = con.prepareStatement("select post_id ,user_id from likes where user_id = ? and post_id = ?");
            statement.setString(1, user.getId());
            statement.setString(2, post_id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                statement = con.prepareStatement("DELETE FROM likes WHERE user_id = ? AND post_id = ?");
                statement.setString(1, user.getId());
                statement.setString(2, post_id);

                int resultDel = statement.executeUpdate();

                if(resultDel>0) {
                    jsonData.put("status", "success");
                    jsonData.put("message", "Unliked");
                } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "unable to unlike");
                }

            } else {
                String sql = "insert into likes (user_id,post_id) values (?,?)";
                statement = con.prepareStatement(sql);
                statement.setString(1, user.getId());
                statement.setString(2, post_id);
                int numOfRow = statement.executeUpdate();
                if (numOfRow > 0) {
                    jsonData.put("status", "success");
                    jsonData.put("message", "Liked");
                } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "unable to like");
                }
            }
            resultSet.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


        out.print(new Gson().toJson(jsonData));
        out.close();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
