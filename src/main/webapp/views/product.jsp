<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <jsp:include page="../common/header.jsp" />
    <link rel="stylesheet" href="<c:url value='/css/product.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/plugins/font-awesome/css/all.min.css'/>">
    <link href="<c:url value='/plugins/datatables/css/dataTables.bootstrap4.min.css'/>" rel="stylesheet">
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
    <h2>Product List</h2>

    <table class="table table-bordered" id="productInfoTable">
        <thead>
        <tr>
            <th>Product ID</th>
            <th>Name</th>
            <th>Quantity</th>
            <th class="price">Price</th>
            <th class="sale-date">Sale Date</th>
            <th>Brand Name</th>
            <th>Image</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>

    <div class="pagination">

    </div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="/js/product.js"></script>
<script src="/js/base.js"></script>
</body>
</html>
