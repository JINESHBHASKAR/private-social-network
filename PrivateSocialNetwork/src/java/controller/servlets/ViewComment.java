package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import model.Comment;
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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/LoadComments")
public class ViewComment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        List<Comment> comments = new ArrayList<>();

        Statement statement = null;
        Connection con = Database.getConnection(request, response);

        String postId = request.getParameter("post_id");

        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            statement = con.createStatement();
            PreparedStatement ps = con.prepareStatement("SELECT comments.id, users.profile_pic, comment, datetime, users.full_name FROM comments INNER JOIN users ON comments.user_id=users.id WHERE post_id = ?");
            ps.setString(1, postId);
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                Comment comment = new Comment();

                comment.setId(resultSet.getString("id"));
                comment.setComment(resultSet.getString("comment"));
                String dateTime = resultSet.getString("datetime");
                dateTime = dateTime.substring(0, dateTime.length()-5);
                comment.setDateTime(dateTime);
                comment.setPostedBy(resultSet.getString("full_name"));
                comment.setPostedByPic(resultSet.getString("profile_pic"));

                comments.add(comment);
            }

            resultSet.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        out.print(new Gson().toJson(comments));
        out.close();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}