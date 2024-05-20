
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Brand List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h2>Brand List</h2>
<div class="container">
    <div class="sub-header">
        <div class="float-left sub-title">Brand Management</div>
        <div class="float-left main-search">
            <input class="search-brand" type="text" placeholder="Search..."/>
            <button type="submit" class="search-btn">Search</button>
        </div>
        <div class="float-right"><a class="btn btn-success add-btn" id="addModal">Add Brand</a></div>
        <a href="/" id="logoutBtn" class="btn btn-danger">Logout</a>
    </div>
    <table class="table table-bordered" id="brandInfoTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Logo</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="brand" items="${brands}">
            <tr>
                <td>${brand.brandId}</td>
                <td>${brand.brandName}</td>
                <td>
                    <img src="images/${brand.logo}" alt="${brand.brandName}" width="50" height="50">
                </td>
                <td>${brand.description}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="brandInfoModal">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="brandInfoForm" role="form" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title">Add Brand</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group d-none">
                        <label>Brand ID</label>
                        <input type="text" class="form-control" id="brandId" name="brandId" placeholder="Brand Id" readonly>
                    </div>
                    <div class="form-group">
                        <label for="brandName">Brand Name <span class="required-mask">(*)</span></label>
                        <input type="text" class="form-control" id="brandName" name="brandName" placeholder="Brand name">
                    </div>
                    <div class="form-group">
                        <label for="logo">Logo <span class="required-mask">(*)</span></label>
                        <div class="preview-image-upload" id="logoImg">

                        </div>
                        <input type="file" class="form-control upload-image" name="logoFiles" accept="image/*" />
                        <input type="hidden" class="old-img" id="logo" name="logo">
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea name="description" id="description" cols="30" rows="3" class="form-control" placeholder="Description"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveBrandBtn">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5+5hb7p1hxvEb53It1cbYQw07KzxS/xFJ9e6NaFg" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>

