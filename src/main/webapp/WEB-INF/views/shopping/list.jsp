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
	
	<!-- 쇼핑 nav -->
<ul class="nav nav-pills" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <a class="nav-link active" id="total-product" href="${appRoot }/shopping/list" role="tab" aria-controls="home" aria-selected="true">전체 상품</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="A-category" href="${appRoot }/shopping/list?mainCategory=A" role="tab" aria-controls="profile" aria-selected="false">버거/치킨/피자</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="B-category" href="${appRoot }/shopping/list?mainCategory=B" role="tab" aria-controls="profile" aria-selected="false">카페</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="C-category" href="${appRoot }/shopping/list?mainCategory=C" role="tab" aria-controls="profile" aria-selected="false">베이커리</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="D-category" href="${appRoot }/shopping/list?mainCategory=D" role="tab" aria-controls="profile" aria-selected="false">영화/전시</a>
  </li>
</ul>
	
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

<script>
$(function(){
	
	$("a").click(function(){
		if(!$(this).hasClass("active")){
			console.log("active 없음");
			$(this).addClass("active");
			$("a[class='active']").removeClass("active");
		}
		console.log("active 있음");
	});

	
	
});

</script>
</body>
</html>