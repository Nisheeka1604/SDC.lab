<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Complaint" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Complaints - Complaint Tracking System</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <%-- Check if user is logged in --%>
    <% if (session.getAttribute("userId") == null) { %>
        <div class="container">
            <div class="alert alert-danger" role="alert">
                Please login to view your complaints. <a href="login.jsp">Login here</a>.
            </div>
        </div>
    <% } else { %>
        <div class="container">
            <h2>My Complaints</h2>
            <%-- Display error message if any --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <%-- Display complaints table --%>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Remarks</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                        if (complaints != null && !complaints.isEmpty()) {
                            for (Complaint complaint : complaints) {
                    %>
                        <tr>
                            <td><%= complaint.getTitle() %></td>
                            <td><%= complaint.getDescription() %></td>
                            <td>
                                <span class="badge <%= complaint.getStatus().equals("Pending") ? "badge-pending" : 
                                                        complaint.getStatus().equals("In Progress") ? "badge-in-progress" : 
                                                        "badge-resolved" %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td><%= complaint.getRemarks() != null ? complaint.getRemarks() : "-" %></td>
                            <td><%= complaint.getCreatedAt() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="text-center">No complaints found.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <p class="text-center mt-3">
                <a href="submit_complaint.jsp">Submit New Complaint</a> | 
                <a href="logout">Logout</a>
            </p>
        </div>
    <% } %>
    <!-- Bootstrap JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>