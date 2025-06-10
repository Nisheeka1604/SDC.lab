<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Complaint - Complaint Tracking System</title>
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
                Please login to submit a complaint. <a href="login.jsp">Login here</a>.
            </div>
        </div>
    <% } else { %>
        <div class="container">
            <h2>Submit a Complaint</h2>
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
            <form action="submitComplaint" method="post">
                <div class="form-group">
                    <label for="title">Complaint Title</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary mt-3">Submit Complaint</button>
            </form>
            <p class="text-center mt-3">
                <a href="viewComplaints">View Your Complaints</a> | 
                <a href="logout">Logout</a>
            </p>
        </div>
    <% } %>
    <!-- Bootstrap JS CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>