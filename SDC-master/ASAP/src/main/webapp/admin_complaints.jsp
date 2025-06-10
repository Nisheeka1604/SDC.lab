<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Complaint" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Complaints</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <%-- Check if admin is logged in --%>
    <% if (session.getAttribute("username") == null || !session.getAttribute("username").equals("admin")) { %>
        <div class="container">
            <div class="alert alert-danger" role="alert">
                Access denied. Please login as admin. <a href="login.jsp">Login here</a>.
            </div>
        </div>
    <% } else { %>
        <div class="container">
            <h2>Manage Complaints</h2>
            <%-- Display success or error message --%>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success" role="alert">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <%-- Complaints table --%>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Remarks</th>
                        <th>Created At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                        if (complaints != null && !complaints.isEmpty()) {
                            for (Complaint complaint : complaints) {
                    %>
                        <tr>
                            <td><%= complaint.getId() %></td>
                            <td><%= complaint.getUserId() %></td>
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
                            <td>
                                <form action="updateComplaint" method="post" class="d-inline">
                                    <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                                    <select name="status" class="form-select form-select-sm d-inline w-auto">
                                        <option value="Pending" <%= complaint.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                                        <option value="In Progress" <%= complaint.getStatus().equals("In Progress") ? "selected" : "" %>>In Progress</option>
                                        <option value="Resolved" <%= complaint.getStatus().equals("Resolved") ? "selected" : "" %>>Resolved</option>
                                    </select>
                                    <input type="text" name="remarks" class="form-control form-control-sm d-inline w-auto" 
                                           value="<%= complaint.getRemarks() != null ? complaint.getRemarks() : "" %>" 
                                           placeholder="Add remarks">
                                    <button type="submit" class="btn btn-primary btn-sm mt-1">Update</button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="8" class="text-center">No complaints found.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <p class="text-center mt-3">
                <a href="logout">Logout</a>
            </p>
        </div>
    <% } %>
    <!-- Bootstrap JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>