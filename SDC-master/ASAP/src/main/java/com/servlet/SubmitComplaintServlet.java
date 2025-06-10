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

@WebServlet("/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Check if user is logged in
        if (userId == null) {
            request.setAttribute("error", "Please login to submit a complaint.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Get form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // Basic validation
        if (title == null || title.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Title and description are required.");
            request.getRequestDispatcher("submit_complaint.jsp").forward(request, response);
            return;
        }

        // Create Complaint object
        Complaint complaint = new Complaint();
        complaint.setUserId(userId);
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setStatus("Pending");

        // Save to database
        ComplaintDAO complaintDAO = new ComplaintDAO();
        if (complaintDAO.submitComplaint(complaint)) {
            request.setAttribute("success", "Complaint submitted successfully!");
            request.getRequestDispatcher("submit_complaint.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to submit complaint. Try again.");
            request.getRequestDispatcher("submit_complaint.jsp").forward(request, response);
        }
    }
}