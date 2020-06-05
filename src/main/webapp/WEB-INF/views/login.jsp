<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/fonts/fontawesome/css/fontawesome-all.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

<style>
    html,
    body {
        height: 100%;
    }

    body {
        display: -ms-flexbox;
        display: flex;
        -ms-flex-align: center;
        align-items: center;
        padding-top: 40px;
        padding-bottom: 40px;
    }
</style>
	
<title>Login </title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	<div class="splash-container">
        <div class="card ">
        
            <div class="card-header text-center">
            	<span class="navbar-brand">Renting</span>
				<span class="splash-description">Please enter your user information.</span>
			</div>
			
			
            <div class="card-body">
				<c:if test="${param.error != null}">
				     <div style="color:red;font-size:13px">
				     	Invalid Username or Password
				     </div>
				     <br>
				</c:if>
			
				<c:if test="${requestScope['errormessage'] != null}">
					<div style="color:red;font-size:13px">
						<c:out value='${requestScope["errormessage"]}'/>
				     </div>
				</c:if>	
				
				<c:if test="${requestScope['successmessage'] != null}">
					<div style="color:green;font-size:13px">
						<c:out value='${requestScope["successmessage"]}'/>
				    </div>
				</c:if>	
			
				
                <form  action="login" method="POST">
                    <div class="form-group">
                        <input class="form-control form-control-lg" id="username" type="text" placeholder="Username" name="username" autocomplete="off">
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-lg" id="password" type="password" placeholder="Password" name="password">
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg btn-block">Sign in</button>
                </form>
            </div>
            <div class="card-footer bg-white p-0  text-center">
                <div class="card-footer-item card-footer-item-bordered">
                    <a href="${contextPath}/forgetPassword" class="footer-link">Forgot Password</a>
                </div>
            </div>
        </div>
    </div>
	
</body>

</html>