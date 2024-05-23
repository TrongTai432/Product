
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <jsp:include page="../common/header.jsp" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
    <style>
        .pagination a {
            margin: 0 4px;
            padding: 6px 12px;
            text-decoration: none;
            color: #007bff;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
        }

        .pagination a.active {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .pagination a:hover {
            background-color: #e2e6ea;
            border-color: #dae0e5;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="sub-header">
        <div class="float-left main-search">
            <input class="search-brand" type="text" placeholder="Search..." />
            <button type="submit" class="search-btn">Search</button>
        </div>
        <div class="float-right">
            <button type="button" id="addBrandBtn" class="btn btn-primary">
                Add brand
            </button>

            <a href="/" id="logoutBtn" class="btn btn-danger">Logout</a>
        </div>
    </div>
    <table class="table table-bordered" id="brandInfoTable">

        <thead>
        <h2>Brand List</h2>
        <tr>
            <th>Brand ID</th>
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
                    <img src="images/${brand.logo}" alt="${brand.brandName}" width="50" height="50" name="logoFiles" >
                </td>
                <td>${brand.description}</td>
                <td>
                    <button class="btn btn-primary edit-btn" data-id="${brand.brandId}" >Edit</button>
                    <button class="btn btn-danger delete-btn" data-id="${brand.brandId}" data-name="${brand.brandName}">Delete</button>
                </td>
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

<!-- add brand Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="brandInfoForm" role="form" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Add Brand</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                        <div class="preview-image-upload" id="logoImg"></div>
                        <input type="file" class="form-control upload-image" name="logoFiles" accept="image/*" />
                        <input type="hidden" class="old-img" id="logo" name="logo">
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea name="description" id="description" cols="30" rows="3" class="form-control" placeholder="Description"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="saveBrandBtn">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>




<!-- Edit Brand Modal -->
<div class="modal fade" id="editBrandModal" tabindex="-1" role="dialog" aria-labelledby="editBrandModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="editBrandForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="editBrandModalLabel">Edit Brand</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Brand ID</label>
                        <input type="text" class="form-control" id="editBrandId" name="brandId" readonly>
                    </div>
                    <div class="form-group">
                        <label>Brand Name</label>
                        <input type="text" class="form-control" id="editBrandName" name="brandName">
                    </div>
                    <div class="form-group">
                        <label>Logo</label>
                        <input type="file" class="form-control" id="editLogo" name="logo">
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" id="editDescription" name="description"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- Modal Deleting Brand --%>
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true" >
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Delete Brand</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Do you want to delete <b id="deletedBrandName"></b>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="deleteSubmitBtn">Delete</button>
            </div>
        </div>
    </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script src="${pageContext.request.contextPath}/js/brand.js"></script>
<%--<script src="${pageContext.request.contextPath}/css/base.css"></script> --%>
</body>
</html>

