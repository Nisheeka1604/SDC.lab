package com.servlet;

import com.dao.ComplaintDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/updateComplaint")
public class UpdateComplaintServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to the admin complaints page
        response.sendRedirect("adminViewComplaints");
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // Check if user is admin
        if (username == null || !username.equals("admin")) {
            request.setAttribute("error", "Access denied. Please login as admin.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Get form data
        String complaintIdStr = request.getParameter("complaintId");
        String status = request.getParameter("status");
        String remarks = request.getParameter("remarks");

        // Validate input
        if (complaintIdStr == null || status == null || !isValidStatus(status)) {
            request.setAttribute("error", "Invalid input. Please try again.");
            request.getRequestDispatcher("adminViewComplaints").forward(request, response);
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            // Update complaint in database
            ComplaintDAO complaintDAO = new ComplaintDAO();
            boolean updated = complaintDAO.updateComplaintStatus(complaintId, status, remarks != null ? remarks : "");

            if (updated) {
                request.setAttribute("success", "Complaint updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update complaint. Try again.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid complaint ID.");
        }

        // Redirect back to admin complaints page
        request.getRequestDispatcher("adminViewComplaints").forward(request, response);
    }

    private boolean isValidStatus(String status) {
        return "Pending".equals(status) || "In Progress".equals(status) || "Resolved".equals(status);
    }
}