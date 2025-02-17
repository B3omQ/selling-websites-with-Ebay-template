<%-- 
    Document   : productCard
    Created on : Oct 7, 2024, 2:22:20 PM
    Author     : Quoc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="" style="width: 18rem; height: 17rem">
    <a href="product-detail?pid=${param.id}">
    <img src="${param.image}" class="w-full h-40 object-cover rounded-md" alt="">
    <div class="card-body">
        <h5 class="mt-2 text-[17px]">${param.productName}</h5>
        <p class="card-text"><span class="mt-12 font-bold text-xl"> $${param.price}</span> </p>
    </div>
    </a>
</div>
