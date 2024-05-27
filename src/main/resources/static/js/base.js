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