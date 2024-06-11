
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <jsp:include page="../common/header.jsp" />
    <link rel="stylesheet" href="<c:url value='/css/brand.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/base.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Brand List</title>
</head>
<body>
    <div class="container">
        <div class="sub-header row align-items-center">
            <div class="col-md-4">
                <h4 class="sub-title">Brand Management</h4>
            </div>
            <div class="col-md-4 main-search">
                <input class="search-brand form-control" id="search-brand" type="text" placeholder="Search..." />
                <button type="submit" class="search-btn btn-primary">Search</button>
                <a class="btn btn-dark reset-btn" id="resetPage">Reset</a>
            </div>
            <div class="col-md-4 text-end">
                <button type="button" id="addBrandBtn" class="btn btn-success"><i class="fa fa-plus-circle"></i>Add brand</button>
            </div>
        </div>
    </div>
    <div class="container">
    <table class="table table-bordered" id="brandInfoTable">
        <thead>
        <tr class="text-center">
<%--            <th>Brand ID</th>--%>
            <th scope="col">Name</th>
            <th scope="col">Logo</th>
            <th scope="col">Description</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
        <div class="d-flex justify-content-center">
            <div class="total-items">
                <span>Total Items: </span>
            </div>&nbsp;&nbsp;
            <div class="total">

            </div>
            &nbsp;&nbsp;
            <ul class="pagination">
            </ul>
        </div>
    </div>

<!-- add brand Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="brandInfoForm" action="/brand/api/add" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Add Brand</h5>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group d-none">
                        <label>Brand ID</label>
                        <input type="text" class="form-control" id="brandId" name="brandId" placeholder="Brand Id" readonly>
                    </div>
                    <div class="form-group">
                        <label for="brandName">Brand Name <span class="required-mask">(*)</span></label>
                        <input type="text" class="form-control" id="brandName" name="brandName" placeholder="Brand name" required>
                    </div>
                    <div class="form-group">
                        <label for="logo">Logo <span class="required-mask">(*)</span></label>
                        <input type="file" class="form-control upload-image" name="logoFiles" accept=".jpg,.jpeg,.png,.gif" required/>
                        <input type="hidden" class="old-img" id="logo" name="logo">

                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea name="description" id="description" cols="30" rows="3" class="form-control" placeholder="Description"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="saveBrandBtn">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- Edit Brand Modal -->
<div class="modal fade" id="editBrandModal" tabindex="-1" role="dialog" aria-labelledby="editBrandModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="editBrandForm" role="form" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="editBrandModalLabel">Edit Brand</h5>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
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
                        <label for="logo">Logo <span class="required-mask">(*)</span></label>
                        <!-- Image element to display the current logo -->
                        <img id="currentLogo" src="#" alt="Current Logo" class="img-fluid mb-2" style="max-height: 150px; display: none;">
                        <input type="file" class="form-control upload-image" id="editLogo" name="logoFiles" accept=".jpg,.jpeg,.png,.gif" required/>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" id="editDescription" name="description"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="updateBrandBtn">Save Changes</button>
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

<jsp:include page="../common/footer.jsp" />
<script src="/js/brand.js"></script>
<script src="/js/base.js"></script>
</body>
</html>

