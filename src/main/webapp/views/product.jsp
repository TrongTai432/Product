<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <jsp:include page="../common/header.jsp" />
    <script src="${pageContext.request.contextPath}/css/product.css"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product List</title>
    <style>
        .pagination a {
            margin: 0 4px;
            padding: 8px 16px;
            text-decoration: none;
            color: #000;
            border: 1px solid #ddd;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
        th.price, td.price {
            width: 150px;
        }
        th.sale-date, td.sale-date {
            width: 120px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="sub-header">
        <div class="float-left main-search">
            <input class="search-product" type="text" placeholder="Search..." />
            <button type="submit" class="search-btn">Search</button>
        </div>
        <div class="float-right">
            <button type="button" id="addProductBtn" class="btn btn-primary">
                Add product
            </button>

            <a href="/" id="logoutBtn" class="btn btn-danger">Logout</a>
        </div>
    </div>
    <h2>Product List</h2>
    <table class="table table-bordered" >
        <thead>
        <tr>
            <th>Product ID</th>
            <th>Name</th>
            <th>Quantity</th>
            <th class="price">Price</th>
            <th class="sale-date">Sale Date</th>
            <th>Description</th>
            <th>Brand</th>
            <th>Image</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.productId}</td>
                <td>${product.productName}</td>
                <td>${product.quantity}</td>
                <td class="price">${product.price}</td>
                <td class="sale-date">${product.saleDate}</td>
                <td>${product.description}</td>
                <td>${product.brandEntity.brandName}</td>
                <td><img src="images/${product.image}" alt="${product.productName}" width="50" height="50"></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${pager.firstPage != 0}">
            <a href="?page=1">&laquo; First</a>
            <a href="?page=${pager.previousPage}">Previous</a>
        </c:if>

        <c:forEach var="page" items="${pager.pageNumberList}">
            <c:choose>
                <c:when test="${page == pager.currentPage}">
                    <a href="?page=${page}" class="active">${page}</a>
                </c:when>
                <c:otherwise>
                    <a href="?page=${page}">${page}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${pager.lastPage != 0}">
            <a href="?page=${pager.nextPage}">Next</a>
            <a href="?page=${pager.lastPage}">Last &raquo;</a>
        </c:if>
    </div>
</div>
</body>
</html>
