
$(document).ready(function() {
    findProduct(1);

    var list = [];
    $(".check").on('click', function (){
        list = [];
        $(".sb_dropdown").find('input[name="brand.brandName"]:checked').each(function() {
            list.push($(this).val());
        });
        console.log(list);
    });

    //reset page
    $('#resetPage').on('click', function() {
        $('input[type=checkbox]').each(function() {
            this.checked = false;
        })
        list = [];
        $('#search-product').val('');
        $('#priceTo').val('');
        $('#priceFrom').val('');
        findProduct(1);
    });


    var num = 7;
    var showMore;
    $('.sb_dropdown').children('li').hide().each(function() {
        if($(this).index() < num ){
            $(this).show();
        }
    });

    $('.sb_dropdown').append('<li class="show-more"><a id="showMore">Show more</a></li>');
    $('#showMore').on('click', function() {
        if( showMore = $(this).parent('li')){
            showMore.siblings().show();
            showMore.hide();
        }
    });

    //pagination
    $('.pagination').on('click','.page-link', function(){
        var pageNumber = $(this).attr("data-index");
        var keyword =  $(".search-product").val();
        var priceFrom = $("#priceFrom").val();
        var priceTo = $("#priceTo").val();
        if ( keyword != "" || list != "" || priceFrom != "" || priceTo != "") {
            searchProduct(pageNumber,true,list);
        } else {
            findProduct(pageNumber);
        }
    });


    var $infoProductModal = $('#infoProductModal');
    var $productInfoForm  = $('#productInfoForm');

    //show add modal
    $('#addProduct').on('click', function() {
        resetForm($productInfoForm);
        showModalWithCustomizedTitle($infoProductModal , "Add Product");
        $('#logoImg img').attr('src' , '/images/product.jpg');
        $('#productId').closest(".form-group").addClass("d-none");
        var now = new Date();
        var day = ("0" + now.getDate()).slice(-2);
        var month = ("0" + (now.getMonth() + 1)).slice(-2);
        var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
        $('#saleDate').val(today);
    });

   //show update modal
    $('#productInfoTable').on('click','.edit-btn',  function() {
        // get product info
        $.ajax({
            url : "/product/api/findAll?id=" + $(this).data("id"),
            type : 'GET',
            dataType : 'json',
            contentType : 'application/json',
            success : function(responseData) {
                if(responseData.responseCode == 100){
                    var productInfo = responseData.data;
                    resetForm($productInfoForm);
                    showModalWithCustomizedTitle($infoProductModal, "Edit Product");

                    $('#productId').val(productInfo.productId);
                    $('#productName').val(productInfo.productName);
                    $('#quantity').val(productInfo.quantity);
                    $('#price').val(productInfo.price);
                    $('#saleDate').val(productInfo.saleDate);
                    $('#brandId').val(productInfo.brandEntity.brandId);
                    $('#description').val(productInfo.description);
                    if(productInfo.image == null || productInfo.image == ""){
                        productInfo.image = '/images/product.jpg';
                    }
                    $("#logoImg img").attr("src", productInfo.image);
                    $("#image").val(productInfo.image);
                    $('#productId').closest(".form-group").removeClass("d-none");
                }
            }
        });
    });

    //save
    $('#saveProduct').on('click', function(event) {
        event.preventDefault();
        var formData = new FormData($productInfoForm[0]);
        var productId = formData.get("productId");
        var isAdd = productId == undefined || productId == "";

        ($productInfoForm).validate({
            ignore: [],
            rules: {
                productName: {
                    required: true,
                    maxlength : 50
                },
                quantity : {
                    required: true,
                    number : true,
                },
                price : {
                    required: true,
                    number : true,
                },
                saleDate : {
                    required: true,
                },
                imageFiles: {
                    required: isAdd,
                },
            },
            messages: {
                productName: {
                    required: "Product Name can't empty",
                    maxlength: "The Product Name must be less than 50 characters",
                },
                quantity : {
                    required: "Quantity can't empty",
                    number : "Please enter a valid number.",
                },
                price : {
                    required: "Price can't empty",
                    number : "Please enter a valid Number.",
                },
                saleDate : {
                    required: "Sale Date can't empty",
                },
                imageFiles: {
                    required: "Please upload Product Image",
                }
            },
            errorElement: "div",
            errorClass: "error-message-invalid"
        });
        if($productInfoForm.valid()){
            $.ajax({
                url : "/product/api/" +(isAdd ? "add" : "update"),
                type : "POST",
                enctype : "multipart/form-data",
                processData : false,
                contentType : false,
                cache: false,
                timeout : 1000,
                data : formData,
                success : function(responseData) {
                    if(responseData.responseCode == 100){
                        $infoProductModal.modal('hide');
                        findProduct(1);
                        showNotification(true,responseData.responseMsg);
                    }else{
                        showMsgOnField($productInfoForm.find("#productName"),responseData.responseMsg);
                    }
                }
            });
        }
    });


    //show delete modal
    $('#productInfoTable').on('click' , '.delete-btn', function() {
        var productName = $(this).data("name");
        $("#deletedBrandName").text(productName);
        $("#deleteBtn").attr("data-id", $(this).data("id"));
        $('#deleteModal').modal('show');
    });

    //delete
    $('#deleteBtn').on('click', function() {
        $.ajax({
            url : "/product/api/delete/" + $(this).attr("data-id"),
            type : 'DELETE',
            dataType : 'json',
            contentType : 'application/json',
            success : function(responseData) {
                $('#deleteModal').modal('hide');
                showNotification(responseData.responseCode == 100, responseData.responseMsg);
                findProduct(1);
            }
        });
    });


  //search
    $('#searchPrice').on('click', function() {
        searchProduct(1, true, list);
    });

});

function findProduct(pageNumber) {
    $.ajax({
        url : "/product/api/findAll/" + pageNumber,
        type : 'GET',
        contentType : "application/json",
        success : function(responseData) {
            if(responseData.responseCode == 100){
                renderTable(responseData.data.productList);
                renderPage(responseData.data.paginationInfo);
                totalItem(responseData.data.totalItem);
            }
        }
    });
}

function searchProduct(pageNumber, isClickedSearchBtn, list) {
    var search = {
        keyword:$(".search-product").val(),
        priceFrom:$("#priceFrom").val(),
        priceTo:$("#priceTo").val(),
        list: list
    };

    $.ajax({
        url: '/product/api/searchProduct/' + pageNumber,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success: function (responseData) {
            if(responseData.responseCode == 100) {
                renderTable(responseData.data.productList);
                renderPage(responseData.data.paginationInfo);
                if(responseData.data.paginationInfo.pageNumberList.length < 2){
                    $('.pagination').addClass("d-none");
                }else{
                    $('.pagination').removeClass("d-none")
                }
                totalItem(responseData.data.totalItem);
            }
        },
        data: JSON.stringify(search)
    });
}


function totalItem(item) {
    $(".total").empty();
    $(".total").append(item);
}


function formatDate(date) {
    var d = new Date(date);
    var day = d.getDate();
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    if(day < 10){
        day = '0' + day;
    }
    if(month < 10){
        month = "0" + month;
    }

    var dateFormat = day + "/" + month + "/" + year;
    return dateFormat;
}

function renderTable(productList) {
    var format = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND',
        minimumFractionDigits: 0,
    });
    var rowHTML= "";
    $("#productInfoTable tbody").empty();
    $.each(productList, function(key, value) {
        rowHTML = "<tr>"
            // +	"<td>" + value.productId + "</td>"
            +	"<td >" + value.productName + "</td>"
            +	"<td class='text-center'>" + value.quantity  +  "</td>"
            +	"<td class='text-center'>" + format.format(value.price)     +  "</td>"
            +	"<td class='text-center'>" + formatDate(value.saleDate)  +  "</td>"
            +	"<td class='text-center'>" + value.brandEntity.brandName + "</td>"
            +	"<td class='text-center'><a href='" + value.image + "' data-toggle='lightbox' data-max-width='1000'><img class='img-fluid' src='" + value.image + "'></td>"
            +	"<td>" + value.description + "</td>"
            +		"<td class = 'action-btns'>"
            +			 "<a class='edit-btn' data-id='" + value.productId +"'><i class='fas fa-edit'></i></a> | " +
            "<a class='delete-btn' data-name='" + value.productName + "' data-id='" + value.productId + "'><i class='fas fa-trash-alt'></i></a>"
            +		"</td>"
        "</tr>";
        $("#productInfoTable tbody").append(rowHTML);
    });
}


function renderPage(pagination){
    var paginationInnerHtml = "";
    if(pagination.pageNumberList.length > 0){
        $("ul.pagination").empty();

        paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (pagination.firstPage == 0 ? ' disabled' : '') + '" href="javascript:void(0)" data-index="'+ pagination.firstPage + '">First Page</a></li>'
        paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (pagination.previousPage == 0 ? ' disabled' : '') + '" href="javascript:void(0)" data-index="'+ pagination.previousPage + '"> < </a></li>'
        $.each(pagination.pageNumberList, function(key, value) {
            paginationInnerHtml += '<li class="page-item"><a class="page-link '+ (value == pagination.currentPage ? ' active' : '') +'" href="javascript:void(0)" data-index="' + value +'">' + value + '</a></li>';
        });
        paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (pagination.nextPage == 0 ? ' disabled' : '') + '" href="javascript:void(0)" data-index="'+ pagination.nextPage + '"> > </a></li>'
        paginationInnerHtml += '<li class="page-item"><a class="page-link ' + (pagination.lastPage == 0 ? ' disabled' : '') + '" href="javascript:void(0)" data-index="'+ pagination.lastPage + '">Last Page</a></li>'
        $("ul.pagination").append(paginationInnerHtml);
    }
}