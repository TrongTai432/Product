
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <meta charset="UTF-8">
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
        <h2>Brand List</h2>
        <thead>
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
                    <button class="btn btn-danger delete-btn" data-id="${brand.brandId}">Delete</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
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
                <p>Do you want to delete <b class="brand-name"></b>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="deleteSubmitBtn">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- Thêm jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Thêm Bootstrap -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function () {
        // Display modal to add new brand
        $('#addBrandBtn').click(function () {
            $('#brandId').val('');
            $('#brandName').val('');
            $('#logo').val('');
            $('#description').val('');
            $('#brandInfoModalLabel').text('Add Brand');
            $('#addModal').modal('show');
        });

        // Display modal to edit brand
        $('.edit-btn').click(function () {
                    var brandId = $(this).data('id');
                    $.ajax({
                        url: '/brand/api/getBrand',
                        type: 'GET',
                        data: { id: brandId },
                        success: function(response) {
                            $('#editBrandId').val(response.brandId);
                            $('#editBrandName').val(response.brandName);
                            $('#editDescription').val(response.description);
                            $('#editBrandModal').modal('show');  // Mở modal
                        }
                    });
        });

        $("#brandInfoTable").on('click', '.delete-btn', function() {
            $("#deletedBrandName").text($(this).data("name"));
            $("#deleteSubmitBtn").attr("data-id", $(this).data("id"));
            $('#confirmDeleteModal').modal('show');
        });

        // Submit delete brand
        $("#deleteSubmitBtn").on('click' , function() {
            $.ajax({
                url : "/brand/api/delete/" + $(this).attr("data-id"),
                type : 'DELETE',
                dataType : 'json',
                contentType : 'application/json',
                success : function(responseData) {
                    $('#confirmDeleteModal').modal('hide');
                    showNotification(responseData.responseCode == 100, responseData.responseMsg);
                    if (responseData.responseCode == 100) {
                        window.location.href = "/brand";
                    } else {
                        findBrands(1);
                    }
                }
            });
        });


    });
</script>

<script>
    $('#saveBrandBtn').on('click', function (event) {
        event.preventDefault();
        var formData = new FormData($brandInfoForm[0]);
        var brandId = formData.get("brandId");
        var isAddAction = brandId == undefined || brandId == "";
        //var isValidForm = formValidate($footballTeamForm, _self.getValidationInfo(isAddAction));
        $brandInfoForm.validate({
            ignone: [],
            rules: {
                brandName: {
                    required: true,
                    maxlength : 50
                },
                logoFiles: {
                    required: isAddAction,
                }
            },
            messages: {
                brandName: {
                    required: "Please input Brand Name",
                    maxlength: "The Brand Name must be less than 50 characters",
                },
                logoFiles: {
                    required: "Please upload Brand Logo",
                }
            },
            errorElement: "div",
            errorClass: "error-message-invalid"
        });

        if ($brandInfoForm.valid()) {
            // POST data to server-side by AJAX
            $.ajax({
                url: "/brand/api/" + (isAddAction ? "add" : "update"),
                type: 'POST',
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                timeout: 10000,
                data: formData,
                success: function(responseData) {
                    if (responseData.responseCode == 100) {
                        $brandInfoModal.modal('hide');
                        findBrands(1);
                        showNotification(true, responseData.responseMsg);
                    } else {
                        showMsgOnField($brandInfoForm.find("#brandName"), responseData.responseMsg);
                    }
                }
            });
        }
    });
</script>
</body>
</html>

