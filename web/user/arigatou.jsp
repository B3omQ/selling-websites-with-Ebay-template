

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order successful | eBay</title>
        <link rel="Icon" href="https://pages.ebay.com/favicon.ico" />
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="resources/bootstrap-5.3.3-dist/css/footer.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <div id="Mainlayout" class="min-w-[1050px] max-w-[1420px] mx-auto">
            <jsp:include page="include/header.jsp"/>

            <div class="container text-center mt-5">
                <<img src="resources/images/arigatou.png" alt="alt"/>
                <h1 class="display-4 text-success">Thank You for Your Order!</h1> 
                <p class="lead mt-4">We are delighted to serve you. Your order has been received and will be processed shortly. A confirmation email has been sent to your inbox.</p> 
                <p class="lead">If you need any assistance, you can contact us via the phone number or email listed on our website. We are always ready to help!</p> 
                <p class="mt-3">We hope you have a wonderful shopping experience and look forward to serving you again in the future! You can track your order by clicking the button below, or return to the homepage.</p>

                <a href="./order" class="btn btn-info btn-lg mt-4">Track your delivery</a>
                <a href="./user-home" class="btn btn-primary btn-lg mt-4">Return to main page</a>
            </div>


            <script src="resources/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
        </div>
    </body>
    <jsp:include page="include/footer.jsp"/>
</html>
