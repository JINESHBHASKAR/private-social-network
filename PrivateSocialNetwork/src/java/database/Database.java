package database;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

public class Database {

    public static Connection getConnection(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection con=null;
            try {
                Class.forName(request.getServletContext().getInitParameter("dbDriver"));
                con = DriverManager.getConnection(request.getServletContext().getInitParameter("dbUrl"), request.getServletContext().getInitParameter("dbUser"), request.getServletContext().getInitParameter("dbPwd"));
                request.getServletContext().setAttribute("connection", con);

            } catch (Exception e) {
                e.printStackTrace();
            }

        return con;
    }

}
