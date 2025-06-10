import java.sql.*;
import java.util.Scanner;

public class InsertData {
    public static void main(String[] args) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost/SDC", "root", "h0p3");
             Statement s = con.createStatement()) { // Corrected statement

            Scanner sc = new Scanner(System.in);
            System.out.println("Inserting Data into student table:");
            System.out.println("________________________________________");

            System.out.print("Enter student id: ");
            int sid = sc.nextInt();
            sc.nextLine(); // Consume newline character
            
            System.out.print("Enter student name: ");
            String sname = sc.nextLine(); // Use nextLine() to allow full names

            System.out.print("Enter student address: ");
            String saddr = sc.nextLine(); // Use nextLine() for multi-word addresses

            String insertQuery = "INSERT INTO student VALUES(" + sid + ",'" + sname + "','" + saddr + "')";
            s.executeUpdate(insertQuery);

            System.out.println("Data inserted successfully into student table");

        } catch (SQLException err) {
            System.out.println("ERROR: " + err);
        }
    }
}
