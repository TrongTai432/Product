<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .nav-link {
            margin-right: 10px;
            border: 1px solid #0056b3;
            border-radius: 5px;
            padding: 8px 12px;
            background-color: #80bdff;
        }
        .nav-link:hover {
            background-color: #0056b3;
            color: white !important;
        }
    </style>
</head>
<body>
<header>
    <div class="container mt-4">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link" href="/product">Product</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/brand">Brand</a>
            </li>
            <li class="nav-item ms-auto">
                <a href="/" id="logoutBtn" class="btn btn-danger">Logout</a>
            </li>
        </ul>
    </div>
</header>
</body>
</html>
