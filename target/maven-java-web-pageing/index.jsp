<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Ambil parameter page, jika kosong pakai default dashboard
    String currentPage = request.getParameter("page");
    if (currentPage == null || currentPage.trim().isEmpty()) {
        currentPage = "/views/dashboard/dashboard.jsp";
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8" />
    <title>Aplikasi BPBL</title>

    <!-- Sidebar style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css" rel="stylesheet" />

    <!-- <style>
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
        }
        .sidebar .nav-link {
            color: #fff;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: #495057;
        }
    </style> -->

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>

</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar p-3">
            <jsp:include page="/views/templates/sidebar.jsp" />
        </nav>

        <!-- Konten utama -->
        <main class="col-md-10 pt-3">
            <jsp:include page="<%= currentPage %>" />
        </main>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
