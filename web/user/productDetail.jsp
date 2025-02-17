

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout"class="min-w-[1050px] max-w-[1420px] mx-auto">
        <jsp:include page="include/header.jsp"/>
        <c:set value="${product}" var="p"/>
        <div class = "bg-while-100 mb-3 rounded-lg">
            <div class="flex space-x-[100px]">
                <div class="">
                    <img class="rounded-lg w-[800px] h-auto" src="${p.image}" alt="alt"/>
                </div> 
                <div class="col-md-6 ">
                    <c:if test="${p.category.id != null}">
                        <p class="text-4xl font-bold mb-2 text-gray py-2">${p.productName}</p>
                        <hr/>
                        <a class="underline font-semibold text-gray text-xl hover:text-gray-400 focus:text-gray-400 transition duration-300 ease-in-out"href="search-product?categorySelect=0&searchKey=&brandSelect=${p.brand.id}&priceRange=allRange&sortOrder=">A product from: ${p.brand.brandName}</a>
                        <p class="mb-3 text-gray font-semibold">Description: ${p.generalInfo}</p>
                        <hr/>
                        <p class="text-gray font-semibold">Guarantee date (by year): ${p.warrantyInfo}</p>
                        <p class="text-gray font-semibold">Stock Units: ${p.stockUnits}</p>
                        <p class="mb-3 text-gray font-semibold">Have sold: ${p.unitsSold}</p>
                        <p class="fs-2 text-color-black mb-5 text-gray font-semibold flex">US $${p.price}</p>
                    </c:if>
                    <div class="ml-[100px]">
                    <button class="cart btn btn-primary w-[500px] mb-2 font-bold rounded-full py-3" data-product-id="${p.id}" >Add to watchlist</button>
                    <a href="./search-product?categorySelect=${p.category.id}" class="font-bold btn btn-primary w-[500px] rounded-full py-3">Look for similar product</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        <script src = "resources/script/jquery-3.7.1.min.js"></script>
        <script src = "resources/script/script.js"></script>
        </div>
    </body>
            <jsp:include page="include/footer.jsp"/>
</html>
