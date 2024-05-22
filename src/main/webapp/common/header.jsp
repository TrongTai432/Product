<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .nav-link {
            margin-right: 10px;
        }
        .nav-link.active {
            background-color: #007bff;
            color: white !important;
        }
        .nav-link:hover {
            background-color: #0056b3;
            color: white !important;
        }
    </style>
</head>
<body>
<div class="container mt-3">
    <nav class="navbar navbar-expand-lg navbar-light bg-light rounded">
        <div class="container-fluid">
            <div class="navbar-nav">
                <a class="nav-link btn btn-outline-primary me-2" href="/product">Product</a>
                <a class="nav-link btn btn-primary" href="/brand">Brand</a>
            </div>
        </div>
    </nav>
</div>
</body>
</html>
