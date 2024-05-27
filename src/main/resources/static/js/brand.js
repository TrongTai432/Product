
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
                $('#editBrandModal').modal('show');
            }
        });
    });

    $("#brandInfoTable").on('click', '.delete-btn', function() {
        var brandName = $(this).data("name");
        $("#deletedBrandName").text(brandName);
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
                    window.location.reload();
                } else {
                    alert('Failed to delete brand. Please try again.');
                }
            }
        });
    });

    $('#saveBrandBtn').on('click', function(event) {
        event.preventDefault();

        var $brandInfoForm = $('#brandInfoForm');
        var formData = new FormData($brandInfoForm[0]);
        var brandId = formData.get("brandId");
        var isAddAction = !brandId;

        $brandInfoForm.validate({
            ignore: [],
            rules: {
                brandName: {
                    required: true,
                    maxlength: 50
                },
                logoFiles: {
                    required: isAddAction
                }
            },
            messages: {
                brandName: {
                    required: "Please input Brand Name",
                    maxlength: "The Brand Name must be less than 50 characters",
                },
                logoFiles: {
                    required: "Please upload Brand Logo"
                }
            },
            errorElement: "div",
            errorClass: "error-message-invalid",
            submitHandler: function(form) {
                $.ajax({
                    url: '/brand/api/add',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(response) {
                        alert(response.responseMsg);
                    },
                    error: function(error) {
                        alert('Error occurred while adding brand');
                    }
                });
            }
        });

        $brandInfoForm.submit();
    });

});







