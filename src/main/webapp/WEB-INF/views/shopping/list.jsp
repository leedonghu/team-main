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
.footer{
	width: 100%; 
	height: 250px;
	background-color: black;
}
</style>
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
	
<div class="row row-cols-1 row-cols-md-4" id="shopping-card-container1">
	<c:forEach items="${list }" var="shopping">
		<div class="col mb-4">
    		<div class="card">
      			<a href="${appRoot }/shopping/detail?productId=${shopping.productId}">
      				<img src="${appRoot }/resources/product/${shopping.productPicture}" class="card-img-top" alt="..." width="169.5" height="225.33">
      			</a>
      			<div class="card-body">
        			<h5 class="card-title">${shopping.productName }</h5>
        			<p class="card-text">${shopping.productPoint }</p>
      			</div>
       			<input hidden value="${shooping.productId }">
    		</div>
  		</div>
	</c:forEach>
	
</div>
<button id="searchMoreProduct" class="btn btn-outline-primary btn-block col-sm-10 mx-auto">더 보기</button>
	
	<hr>
	<br>
	<div class="footer">
	
	</div>	
</div>

<script>
$(function(){
	let index = [12, 24, 36];
	let click = 0;
	$("#searchMoreProduct").click(function(){
		
		let data = {index : index[click]};
		
		$.ajax({
			 url:"${appRoot}/shopping/moreView",
			 type:"post",
			 data:JSON.stringify(data),
			 contentType:"application/json",
			 success:function(data){
				 console.log(data);
				 
				 let container = $("#shopping-card-container1");
				 let appRoot = "${appRoot}";
				 for(let i=0; i<data.length; i++){
					 let productHTML = `
					 	<div class="col mb-4">
				    		<div class="card">
			      				<a href="\${appRoot}/shopping/detail?productId=\${data[i].productId}">
			      					<img src="\${appRoot }/resources/product/\${data[i].productPicture}" class="card-img-top" alt="..." width="169.5" height="225.33">
			      				</a>
			      				<div class="card-body">
			        				<h5 class="card-title">\${data[i].productName }</h5>
			        				<p class="card-text">\${data[i].productPoint }</p>
			      				</div>
			       					<input hidden value="\${data[i].productId }">
			    			</div>
			  			</div>`;
				 container.append(productHTML);
				 }
				 click ++;
				 
				 if(data.length < 12){
					 $("#searchMoreProduct").attr("hidden", "hidden");
				 }
				 
				 
			 },
			 error:function(){
				 console.log("실패");
			 }
		 });
	});

	
	
});

</script>
</body>
</html>