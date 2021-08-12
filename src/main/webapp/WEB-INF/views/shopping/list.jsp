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
    <a class="nav-link active" id="total-product" data-toggle="tab" href="#total-product" role="tab" aria-controls="home" aria-selected="true">전체 상품</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="A-category" data-toggle="tab" href="#category-a" role="tab" aria-controls="a" aria-selected="false">버거/치킨/피자</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="B-category" data-toggle="tab" href="#category-b" role="tab" aria-controls="b" aria-selected="false">카페</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="C-category" data-toggle="tab" href="#category-c" role="tab" aria-controls="c" aria-selected="false">베이커리</a>
  </li>
  <li class="nav-item" role="presentation">
    <a class="nav-link" id="D-category" data-toggle="tab" href="#category-d" role="tab" aria-controls="d" aria-selected="false">영화/전시</a>
  </li>
</ul>

<div class="tab-content" id="myTabContent">
	<div class="tab-pane fade show active" id="total-product" role="tabpanel" aria-labelledby="home-tab">
		<div class="row row-cols-1 row-cols-md-4" id="shopping-card-container1">
		
			
		</div>
	</div>
	
	<div class="tab-pane fade" id="category-a" role="tabpanel" aria-labelledby="a-tab">
		<div class="row row-cols-1 row-cols-md-4" id="shopping-card-containerA">
			a
		</div>
	</div>
	
	<div class="tab-pane fade" id="category-b" role="tabpanel" aria-labelledby="b-tab">
		<div class="row row-cols-1 row-cols-md-4" id="shopping-card-containerB">
			b
		</div>
	</div>
	
	<div class="tab-pane fade" id="category-c" role="tabpanel" aria-labelledby="c-tab">
		<div class="row row-cols-1 row-cols-md-4" id="shopping-card-containerC">
			c
		</div>
	</div>
	
	<div class="tab-pane fade" id="category-d" role="tabpanel" aria-labelledby="d-tab">
		<div class="row row-cols-1 row-cols-md-4" id="shopping-card-containerD">
			d
		</div>
	</div>
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
	
	function firstProduct(){
		
		$.ajax({
			type:"get",
			url:"${appRoot}/shopping/firstProduct",
			success:function(data){
				console.log("성공");
				console.log(data);
				 let container = $("#shopping-card-container1").empty();
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
				 console.log(productHTML);
				 }
				
				
			},
			error:function(){
				console.log("실패");
			}
		});
	}

	firstProduct();
	$("#total-product").click(function(){
		firstProduct();
	});
	
});

</script>
</body>
</html>