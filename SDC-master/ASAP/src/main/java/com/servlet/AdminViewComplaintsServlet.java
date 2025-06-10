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

@WebServlet("/adminViewComplaints")
public class AdminViewComplaintsServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null || !username.equals("admin")) {
            request.setAttribute("error", "Access denied. Please login as admin.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        ComplaintDAO complaintDAO = new ComplaintDAO();
        List<Complaint> complaints = complaintDAO.getAllComplaints();

        request.setAttribute("complaints", complaints);
        request.getRequestDispatcher("admin_complaints.jsp").forward(request, response);
    }
}