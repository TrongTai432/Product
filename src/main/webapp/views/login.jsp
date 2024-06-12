<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login & Signup Form</title>
    <link rel="stylesheet" href="<c:url value='/css/product.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/base.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/login.css' />">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <jsp:include page="../common/head.jsp" />
</head>

<body>
<div class="wrapper">
    <div class="title-text">
        <div class="title login">Login Form</div>
        <div class="title signup">Register Form</div>
    </div>
    <div class="form-container">
        <div class="slide-controls">
            <input type="radio" name="slide" id="login" checked>
            <input type="radio" name="slide" id="signup">
            <label for="login" class="slide login">Login</label>
            <label for="signup" class="slide signup">Register</label>
            <div class="slider-tab"></div>
        </div>
        <div class="form-inner">
            <form action="/loginAction" method="POST" class="login">
                <div class="field">
                    <input type="text" name="username" id="username" placeholder="Username" required>
                </div>
                <div class="field">
                    <input type="password" name="password" id="password" placeholder="Password" required>
                </div>
                <c:if test="${not empty param.error}">
                    <div class="error-message">Invalid username or password</div>
                </c:if>
                <div class="pass-link"><a href="#">Forgot password?</a></div>
                <div class="field btn">
                    <div class="btn-layer"></div>
                    <input type="submit" value="Login">
                </div>
                <div class="signup-link">Not a member? <a href="">Register now</a></div>
            </form>
            <form action="<c:url value='/' />" method="POST" class="signup">
                <div class="field">
                    <input type="text" name="username" placeholder="Username" required>
                </div>
                <div class="field">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="field">
                    <input type="password" name="confirmPassword" placeholder="Confirm password" required>
                </div>
                <div class="field btn">
                    <div class="btn-layer"></div>
                    <input type="submit" value="Signup">
                </div>
            </form>
        </div>
    </div>
</div>
</body>

<jsp:include page="../common/footer.jsp" />
<script src="/js/login.js"></script>
<script src="/js/product.js"></script>
<script src="/js/base.js"></script>

</html>
