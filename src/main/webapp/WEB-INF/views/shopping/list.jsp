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
</head>
<body>
<div class="container">
<pr:navbar></pr:navbar>
	<h1>쇼핑</h1>
<div class="row row-cols-1 row-cols-md-4" id="album-card-container1">
	<c:forEach items="${list }" var="shopping">
		<div class="col mb-4">
    		<div class="card">
      			<img src="${appRoot }/resources/product/${shopping.productPicture}" class="card-img-top" alt="..." width="169.5" height="225.33">
      
      			<div class="card-body">
        			<h5 class="card-title">${shopping.productName }</h5>
        			<p class="card-text">${shopping.productPoint }</p>
      			</div>
       
    		</div>
  		</div>
	</c:forEach>	
</div>
</div>
</body>
</html>