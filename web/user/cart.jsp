

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Management | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
        <jsp:include page="include/header.jsp"/>
        <div class="container">
            <nav class="">
                <ol class="flex space-x-4 mb-4 mt-4 text-xs">
                    <li class="">
                        <a href="./user-home" class="text-decoration-none">Home</a>
                    </li>
                    <li> > </li>
                    <li class="">
                        <a href="./add-to-cart"text-decoration-none">Cart Order</a>
                    </li>
                </ol>
            </nav>
            <table class="table-auto w-full bg-white shadow-md rounded-lg border border-gray-200">
                <thead>
                    <tr>
                        <th class="py-3 px-4 border-b-2 text-center align-middle"><input id="check-all" type="checkbox" class="form-check-input"> Check all</th>
                        <th class="py-3 px-4 border-b-2 text-center align-middle">Product image</th>
                        <th class="py-3 px-4 border-b-2 text-center align-middle">Product Name</th>
                        <th class="py-3 px-4 border-b-2 text-center align-middle">Price</th>
                        <th class="py-3 px-4 border-b-2 text-center align-middle">Quantity</th>
                        <th class="py-3 px-4 border-b-2 text-center align-middle">Total</th>
                        <th class="py-3 px-4 border-b-2 text-center align-middle">Change</th>
                    </tr>

                </thead>
                <tbody class="text-gray-800">
                    <c:forEach items="${cart}" var="item">
                        <tr class="text-center border-b">
                            <td class="py-3 px-4"><input type="checkbox" data-product-id="${item.product.id}" class="checkbox form-check-input" ${item.isSelected == 1 ? 'checked' : ''}></td>
                            <td class="py-3 px-4"><img src="${item.product.image}" class="w-[200px]"alt="alt"/></td>
                            <td class="py-3 px-4">${item.product.productName}</td>
                            <td class="price unit-price py-3 px-4">${item.product.price}</td>
                            <td class="py-3 px-4"><input data-item-id="${item.id}" data-product-id ="${item.product.id}" data-unit-price="${item.product.price}" style="width:65px;" type="number" class="form-control quantity" value="${item.quantity}"></td>
                            <td class="sum-price py-3 px-4">${item.product.price * item.quantity}</td>
                            <td class="py-3 px-4"><button class="btn btn-danger delete-btn" data-item-id="${item.id}">Delete</button></td>
                        </tr>
                        <c:set value="${index+1}" var="index"/>
                    </c:forEach>
                    <tr class="text-center bg-gray-50">
                        <td colspan="6" class="py-4">
                            <a href="./search-product?categorySelect=1" class="btn bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-full">Buy More Products</a>
                            <a href="./checkout" class="btn bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-full">Checkout</a>
                        </td>
                        <td colspan="6">
                            <strong>Total Price: </strong><span id="total-price"></span>
                        </td>
                    </tr>
                </tbody>
            </table>

        </div>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src = "resources/script/jquery-3.7.1.min.js"></script>
        <script src = "resources/script/script.js"></script>
        <script>
            $(document).ready(function () {

                function formatPrice(price) {
                    return price.toLocaleString('US') + ' USD';
                }

                function calculatePrices() {
                    let totalPrice = 0;
                    // Loop through each quantity input field
                    $('.quantity').each(function () {
                        // Get the unit price stored in a data attribute
                        let unitPrice = $(this).data("unit-price");
                        let quantity = $(this).val();
                        let isSelected = $(this).closest('tr').find('.checkbox').prop('checked');

                        // Calculate the sum price
                        let sumPrice = unitPrice * quantity;
                        // Update the sum-price cell for this row
                        $(this).closest('tr').find('.sum-price').text(formatPrice(sumPrice));

                        // Add the sum price to the total price
                        if (isSelected === true) {
                            totalPrice += sumPrice;
                            console.log("I have added: " + sumPrice);
                        }
                    });
                    // Update the total price in the UI
                    $('#total-price').text(totalPrice.toLocaleString('US') + ' USD');
                }

                calculatePrices();
                /**
                 * 
                 * @param {type} cell is the delete button
                 * @returns {undefined}
                 */
                function deleteAnOrder(cell) {
                    $.ajax({
                        url: 'update-cart',
                        type: 'POST',
                        data: {
                            action: 'delete',
                            itemId: $(cell).data("item-id")
                        },
                        success: function (response) {
                            if (response.success) {
                                cell.closest('tr').remove();
                                calculatePrices();
                            } else {
                                alert('Error');
                            }
                            console.log($('.quantity').length);
                        },
                        error: function () {
                            alert('Error connecting to the server, please try again later');
                        }
                    });
                }


                $('#check-all').change(function () {
                    var checkAll = $(this).prop('checked'); // Get the checked state of the "Check All" checkbox
                    $('.checkbox').each(function () {
                        $(this).prop('checked', checkAll).trigger('change'); // Set the checked state for each checkbox and trigger 'change'
                    });
                });

                $('.checkbox').change(function () {

                    var isSelected = $(this).prop('checked') === true ? '1' : '0';
                    var productId = $(this).data('product-id');

                    $.ajax({
                        url: 'update-cart',
                        type: 'POST',
                        data: {
                            action: 'change-selected',
                            isSelected: isSelected,
                            productId: productId
                        },
                        success: function (response) {
                            if (response.success) {
                                console.log('Change selected, fired!');
                            }
                        },
                        error: function () {
                            alert('An error occurred');
                        }
                    });
                    // Check if all checkboxes are selected
                    if ($('.checkbox:checked').length === $('.checkbox').length) {
                        $('#check-all').prop('checked', true); // If all are checked, check the "Check All" checkbox
                    } else {
                        $('#check-all').prop('checked', false); // If not all are checked, uncheck the "Check All" checkbox
                    }
                    calculatePrices();
                });


                $('.quantity').change(function () {
                    var productId = $(this).data("product-id");
                    var quantity = $(this).val();
                    var quantityCell = $(this);
                    if (quantity === '0') {
                        if (window.confirm('Do you want to delete this item?')) {
                            deleteAnOrder(quantityCell);
                        } else {
                            quantityCell.val('1');
                        }
                        return;
                    }
                    calculatePrices(); // After the user changes the quantity, we need to recalculate the total price
                    // The following section interacts with the database
                    $.ajax({
                        url: 'update-cart',
                        type: 'POST',
                        data: {
                            action: 'change-quantity',
                            productId: productId,
                            quantity: quantity
                        },
                        success: function (response) {
                            if (response.success) {
//                                console.log('done');
                            } else {
                                quantityCell.val(response.stockUnits);
                                alert(response.message);
                            }
                        },
                        error: function () {
                            alert('Error connecting to the server, please try again later.');
                        }
                    });
                });

                $('.delete-btn').click(function () {
                    var thisCell = $(this);
                    if (window.confirm('Do you want to delete this item?')) {
                        deleteAnOrder(thisCell);
                    }
                });
            });
        </script>
        </div>
    </body>
            <jsp:include page="include/footer.jsp"/>
</html>

