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