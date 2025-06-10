import java.sql.*;

public class DisplayData {
    public static void main(String[] args) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDC", "root", "h0p3");
             Statement s = con.createStatement()) {

            ResultSet rs = s.executeQuery("SELECT * FROM student");
            if (rs != null) {
                System.out.println("SID \t STU_NAME \t ADDRESS");
                System.out.println("________________________________________");

                while (rs.next()) {
                    System.out.println(rs.getString("s_id") + " \t " + rs.getString("s_name") + " \t " + rs.getString("s_address"));
                    System.out.println("________________________________________");
                }
            }

        } catch (SQLException err) {
            System.out.println("ERROR: " + err);
        }
    }
}
  
