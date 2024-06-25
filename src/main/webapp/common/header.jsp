<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/base.css'/>">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .navbar-custom {
            background-color: grey;
        }

        .navbar-custom .btn-danger {
            margin-left: auto;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container">
        <ul class="navbar-nav me-auto">
            <li class="nav-item">
                <a class="nav-link" href="/product">Product</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/brand">Brand</a>
            </li>
        </ul>
        <a href="/logout" id="logoutBtn" class="btn btn-danger">Logout</a>
    </div>
    </nav>
</header>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
