<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
<style>
.box{
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
}
</style>
</head>
<body>
<div class="container">
	<pr:navbar></pr:navbar>
	<br>
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
			<div class="card" style="max-width: 800px;">
		  		<div class="row no-gutters">
		    		<div class="col-md-8 border">
		      			<img src="${appRoot }/resources/product/${detail.productPicture}" alt="...">
		    		</div>
		    			<div class="col-md-4">
		      				<div class="card-body">
		        				<h5 class="card-title">${detail.productName }</h5>
		        				<p class="card-text">${detail.productDetail }</p>
		        				<p class="card-text"><small class="text-muted">${detail.productPoint }</small></p>
		      				</div>
		    			</div>
		  		</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>

</div>
</body>
</html>