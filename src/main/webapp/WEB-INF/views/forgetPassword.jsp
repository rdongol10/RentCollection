<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forget Password</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
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

</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

	<div class="splash-container">
        <div class="card">
        
            <div class="card-header text-center">
	            <span class="navbar-brand">Renting</span>
	            <span class="splash-description">Please enter your user information.</span>
            </div>
            
            <div class="card-body">
                <form>
                    <p>Don't worry, we'll send you an email to reset your password.</p>
                    <div class="form-group">
                        <input class="form-control form-control-lg" type="email" name="email" placeholder="Your Email" autocomplete="off" id="email">
                  	    <div class="message" id="message"></div>
                        
                    </div>
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
			var email =jQuery("#email").val();
			if(email.trim() != ""){
				jQuery("#resetPassword").prop("disabled",true);
				requestResetPassword(email)
			}
		})
	})
	
	function requestResetPassword(mail){
		jQuery(".loading").show();
		jQuery.ajax({
			method : "POST",
			url : "${contextPath}/resetpassword",
			data : {
				email : mail
			}
			
		}).done(function(data){
			if(data.result =="true"){
				$("#message").css("color","green")
			}else{
				$("#message").css("color","red")
			}
			$("#message").html(data.message)
			jQuery(".loading").hide();
			jQuery("#resetPassword").prop("disabled",false);

		}).fail(function(){
			$("#message").css("color","red")
			$("#message").html("An error occured")
			jQuery(".loading").hide();
			jQuery("#resetPassword").prop("disabled",false);

		});
	}
</script>
</html>