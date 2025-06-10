package com.servlet;

import com.dao.ComplaintDAO;
import com.model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewComplaints")
public class ViewComplaintsServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Check if user is logged in
        if (userId == null) {
            request.setAttribute("error", "Please login to view your complaints.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Fetch user complaints
        ComplaintDAO complaintDAO = new ComplaintDAO();
        List<Complaint> complaints = complaintDAO.getUserComplaints(userId);

        // Set complaints in request scope
        request.setAttribute("complaints", complaints);
        request.getRequestDispatcher("user_complaints.jsp").forward(request, response);
    }
}