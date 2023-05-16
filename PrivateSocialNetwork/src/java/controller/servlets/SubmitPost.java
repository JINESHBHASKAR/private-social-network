package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import java.io.BufferedReader;
import java.io.File;
import model.Post;
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
import java.util.HashMap;
import java.util.List;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "SubmitPost")
public class SubmitPost extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        
        String root = getServletContext().getRealPath("/");
        File path = new File(root + "/posts");
        if (!path.exists()) {
            boolean status = path.mkdirs();
        }
       
        String[] inputs = new String[2];
        String imageFileName = "";
        int i=0;
        if(ServletFileUpload.isMultipartContent(request))
        {
            try {
                List<FileItem> multiparts=new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                for(FileItem item:multiparts)
                {
                    inputs[i++]=item.getString();
                    if(!item.isFormField())
                    {
                        imageFileName=new File(item.getName()).getName();
                        if(!imageFileName.equals(""))
                            item.write(new File(path+File.separator+imageFileName));
                    }
                }
                
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        
        Connection con = Database.getConnection(request, response);

        String postContent = inputs[0];
        
        User user = (User) request.getSession().getAttribute("loggedInUser");

        HashMap<String, String> jsonData = new HashMap<String, String>();

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
       /* ProcessBuilder pb = new ProcessBuilder("py","E:\\Developer\\Projects\\Safe Social Site\\SafeSocialNetwork\\sentiment.py",postContent);
        Process p = pb.start();
        BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String outp="";
        String sentiment="";
        while((outp = in.readLine())!=null) {
            sentiment=outp;
        }*/
            try {
                if (insertPost(con, user, postContent,imageFileName)) {
                    jsonData.put("status", "success");
                    jsonData.put("post", getLatestPost(con, user));

                } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Unable To Insert Post!");

                }
            } catch (SQLException e) {
                e.printStackTrace();
                jsonData.put("status", "fail");
                jsonData.put("message", "Oops, something went wrong!");
            }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonData));
        out.flush();
    }

    private boolean insertPost(Connection con, User user, String postContent, String imageFileName) throws SQLException {
        String sql = "INSERT INTO posts (user_id, content, image) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, user.getId());
        ps.setString(2, postContent);
        ps.setString(3, imageFileName);

        int result = ps.executeUpdate();

        return result > 0;
    }

    private String getLatestPost(Connection con, User user) throws SQLException {
        Post post = new Post();

        String sql = "SELECT posts.id, user_id, profile_pic, content, posts.image, datetime, full_name FROM posts INNER JOIN users ON posts.user_id=users.id ORDER BY posts.id DESC LIMIT 1";
        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            post.setId(rs.getString("id"));
            post.setUserId(rs.getString("user_id"));
            post.setContent(rs.getString("content"));
            post.setImage(rs.getString("image"));
            String dateTime = rs.getString("datetime");
            dateTime = dateTime.substring(0, dateTime.length()-5);
            post.setDateTime(dateTime);
            post.setPostedBy(rs.getString("full_name"));
            post.setPostedByPic(rs.getString("profile_pic"));


            post.setTotalLikes("0");
            post.setLikedByMe("false");
        }


        return new Gson().toJson(post);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
