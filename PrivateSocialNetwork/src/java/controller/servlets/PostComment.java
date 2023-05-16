package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import java.io.BufferedReader;
import model.Comment;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

@WebServlet(name = "PostComment")
public class PostComment extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("index.jsp");
        }

        String comment = request.getParameter("comment");
        String post_id = request.getParameter("post_id");

        HashMap<String, String> jsonData = new HashMap<>();

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        PreparedStatement statement = null;
        Connection con = Database.getConnection(request,response);
        
        /*ProcessBuilder pb = new ProcessBuilder("py","C:\\Users\\user\\Desktop\\Sahridaya\\PrivateSocialNetwork\\sentiment.py",comment);
        Process p = pb.start();
        BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String outp="";
        String sentiment="";
        while((outp = in.readLine())!=null) {
            sentiment=outp;
        }
        if(sentiment.equals("neg")) {
            
            try {
            String sql = "Update posts set negCount = negCount + 1 WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, post_id);
            int res = ps.executeUpdate();
            
            if(res>0) {
                try {
                sql = "SELECT negCount FROM  posts WHERE id = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, post_id);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()) {
                    int count = rs.getInt("negCount");
                    if(count>3) {
                        if(deletePost(post_id,con)) {
                            jsonData.put("status", "delete");
                            jsonData.put("message", "Too many bad comments, Post deleted!");
                            jsonData.put("post_id",post_id);
                        }
                    }  else {  
                            jsonData.put("status", "Negetive");
                            jsonData.put("message", "Comment contains bad words!");
                    }
                    
                        
                }
                } catch(Exception e) {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "Oops, Something went wrong!");
                    e.printStackTrace();
                }
            
            }
                
            }
            
             catch(Exception e) {
                  jsonData.put("status", "fail");
                  jsonData.put("message", "Oops, Something went wrong!");
                  e.printStackTrace();
                 
            }
            
            
            
        }
        else {

        try {
            
            String sql = "Update posts set negCount = negCount - 1 WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, post_id);
            int res = ps.executeUpdate();
            
            sql = "insert into comments (post_id, user_id, comment) values (?,?,?)";
            statement = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1,post_id);
            statement.setString(2,user.getId());
            statement.setString(3,comment);

            int numOfRow = statement.executeUpdate();

            String generatedKey = "";

            ResultSet rs = statement.getGeneratedKeys();

            if (rs.next()) {
                generatedKey = rs.getString(1);

                ps = con.prepareStatement("SELECT comments.id, profile_pic, comment, datetime, post_id, users.full_name FROM comments INNER JOIN users ON comments.user_id=users.id WHERE comments.id = ?");
                ps.setString(1, generatedKey);
                ResultSet resultSet = ps.executeQuery();

                if(resultSet.next()) {                    
                    
                    Comment commentLatest = new Comment();

                    commentLatest.setId(resultSet.getString("id"));
                    commentLatest.setComment(resultSet.getString("comment"));
                    String dateTime = resultSet.getString("datetime");
                    dateTime = dateTime.substring(0, dateTime.length()-5);
                    commentLatest.setDateTime(dateTime);
                    commentLatest.setPostedBy(resultSet.getString("full_name"));
                    commentLatest.setPostedByPic(resultSet.getString("profile_pic"));

                    jsonData.put("status", "success");
                    jsonData.put("message", new Gson().toJson(commentLatest));

                } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "Unable to post comment!");

                }

            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Oops, something went wrong!");

            }

        } catch (Exception e){
            e.printStackTrace();
        }
        }
        
        out.print(new Gson().toJson(jsonData));
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }
    
    protected boolean deletePost(String post_id,Connection con) throws SQLException {
            PreparedStatement statement = con.prepareStatement("DELETE FROM posts WHERE id = ?");
            statement.setString(1, post_id);
            int resultDel = statement.executeUpdate();
            
            statement = con.prepareStatement("DELETE FROM comments WHERE post_id = ?");
            statement.setString(1, post_id);
            statement.executeUpdate();

            statement = con.prepareStatement("DELETE FROM likes WHERE post_id = ?");
            statement.setString(1, post_id);
            statement.executeUpdate();
            if(resultDel>0)
                return true;
            else
                return false;
    }
}*/
        
        try {
            
            String sql = "insert into comments (post_id, user_id, comment) values (?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1,post_id);
            ps.setString(2,user.getId());
            ps.setString(3,comment);
            ps.executeUpdate();

            String generatedKey = "";

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                generatedKey = rs.getString(1);

                ps = con.prepareStatement("SELECT comments.id, profile_pic, comment, datetime, post_id, users.full_name FROM comments INNER JOIN users ON comments.user_id=users.id WHERE comments.id = ?");
                ps.setString(1, generatedKey);
                ResultSet resultSet = ps.executeQuery();

                if(resultSet.next()) {                    
                    
                    Comment commentLatest = new Comment();
                    commentLatest.setId(resultSet.getString("id"));
                    commentLatest.setComment(resultSet.getString("comment"));
                    String dateTime = resultSet.getString("datetime");
                    dateTime = dateTime.substring(0, dateTime.length()-5);
                    commentLatest.setDateTime(dateTime);
                    commentLatest.setPostedBy(resultSet.getString("full_name"));
                    commentLatest.setPostedByPic(resultSet.getString("profile_pic"));

                    jsonData.put("status", "success");
                    jsonData.put("message", new Gson().toJson(commentLatest));

                } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "Unable to post comment!");

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }
    
    protected boolean deletePost(String post_id,Connection con) throws SQLException {
            PreparedStatement statement = con.prepareStatement("DELETE FROM posts WHERE id = ?");
            statement.setString(1, post_id);
            int resultDel = statement.executeUpdate();
            
            statement = con.prepareStatement("DELETE FROM comments WHERE post_id = ?");
            statement.setString(1, post_id);
            statement.executeUpdate();

            statement = con.prepareStatement("DELETE FROM likes WHERE post_id = ?");
            statement.setString(1, post_id);
            statement.executeUpdate();
            if(resultDel>0)
                return true;
            else
                return false;
    }
}

