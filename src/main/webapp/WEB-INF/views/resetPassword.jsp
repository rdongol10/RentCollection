<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reset password</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
</head>

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


<body>

	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

	<div class="splash-container">
        <div class="card">
        
            <div class="card-header text-center">
	            <span class="navbar-brand">Renting</span>
	            <span class="splash-description">Please enter new Password</span>
            </div>
            
            <div class="card-body">
            	<div id="errorMessage" style="color:red">
            		
            	</div>
                <form action="savePassword" method="POST" id="passwordForm">
                    <div class="form-group">
                        <input class="form-control form-control-lg" type="password" name="password" placeholder="Password" autocomplete="off" id="password">
                    </div>
                    <div class="form-group">
                        <input class="form-control form-control-lg" type="password" name="confirmpassword" placeholder="Confirm Password" autocomplete="off" id="confirmpassword">
                    </div>
                    <input type="hidden" name="token" value="${param.token}">
                    
                    <div class="form-group pt-1"><button class="btn btn-block btn-primary btn-xl" id="resetPassword">Reset Password</button></div>
                </form>
            </div>
            
        </div>
    </div>
    
    <div class="loading" style="display:none">
		<img src="${contextPath}/resources/images/loading.gif" class="spinner" >
	</div>

</body>

<script src="<c:url value="/resources/js/jquery-3.3.1.min.js" />" ></script>
<script src="<c:url value="/resources/js/bootstrap.bundle.js" />" ></script>

<script type="text/javascript">
jQuery(document).ready(function(){
	
	jQuery("#resetPassword").on("click",function(){
		event.preventDefault();
		if(validatePassword()){
			jQuery("#passwordForm").submit();
		}
	})
})

function validatePassword(){
	if(jQuery("#password").val() != jQuery("#confirmpassword").val() ){
		jQuery("#errorMessage").html("Password does not match")
		return false;
		
	}
	
	return true;
}
</script>
</html>