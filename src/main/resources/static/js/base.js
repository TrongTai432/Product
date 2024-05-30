function showNotification(isSuccess, message) {
    if (isSuccess) {
        $.notify({
            icon: 'glyphicon glyphicon-ok',
            message: message
        }, {
            type: 'info',
            delay: 3000
        });
    } else {
        $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message: message
        }, {
            type: 'danger',
            delay: 6000
        });
    }
}

function showMsgOnField($element, message, isSuccessMsg) {
    var className = isSuccessMsg ? "alert-info" : "error-message-invalid";
    $element.find(".form-msg").remove();
    $element.parent().append("<div class='" + className + " form-msg'>" + message + "</div>");
}

function  showModalWithCustomizedTitle($selectedModal, title) {
    $selectedModal.find(".modal-title").text(title);
    $selectedModal.modal('show');
}



// reset form
function resetForm($formElement) {
    $formElement[0].reset();
    $formElement.find("input[type*='file']").val("");
    $formElement.find(".error-message-invalid").remove();
    $formElement.find("img").attr('src','');
}