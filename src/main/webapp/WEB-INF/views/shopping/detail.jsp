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
	<br>
	<br>
	<br>
	<div class="row">
		<div class="col-2"></div>

		<div class="col-8">
			<div class="card" style="max-width: 800px;">
		  		<div class="row no-gutters">
		    		<div class="col-md-7 border">
		      			<img src="${appRoot }/resources/product/${detail.productPicture}" alt="..." width="424" height="400">
		    		</div>
		    			<div class="col-md-5">
		      				<div class="card-body">
		        				<h5 class="card-title">${detail.productName }</h5>
		        				<hr>
		        				<p class="card-text">${detail.productDetail }</p>
		        				<hr>
		        				<p class="card-text">${detail.productPoint }포인트</p>
		        				<form id="purchase-form" action="${appRoot }/shopping/purchase" method="post">
			        				<input hidden value="${detail.productPoint }" name="productPoint" id="productPoint">
			        				<input hidden value="${detail.productName }" name="productName">
			        				<input hidden value="${detail.productId }" name="productId">
			        				<input hidden value="${detail.mainCategory }" name="mainCategory">
			        				<input hidden value="${detail.middleCategory }" name="middleCategory">
			        				<input hidden value="${detail.subCategory }" name="subCategory">
			        				<input hidden value="" name="receiverId" id="receiverId">
		        				</form>
		        				<input hidden value="${pinfo.member.userId }" id="userId">
		        				<hr>
		        				<br>
		        				<br><br><br><br><br><br>
		        				<div>
			        				<button class="btn btn-dark" id="present-to-me">나에게 선물하기</button>
			        				<button class="btn btn-warning" id="present-to-you">선물하기</button>
		        				</div>
		      				</div>
		    			</div>
		  		</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>

</div>

<!-- 나에게 선물하기 모달 -->
<div class="modal" tabindex="-1" id="present-to-me-modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">나에게 선물하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>나에게 선물하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="to-me-modal-yes">Yes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" tabindex="-1" id="present-to-you-modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">선물하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>선물하실 분을 골라주세요</p>
        <select class="form-control form-control-lg">
  			
  			<c:forEach items="${memberList }" var="member">
  				<option>${member.userId }(${member.userName })</option>
  			</c:forEach>
		</select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="to-you-modal-yes">Yes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
$(function(){
	
	let productPoint = $("#productPoint").val();
	let userId = $("#userId").val();
	
	console.log(productPoint);
	console.log(userId);
	
	$("#present-to-me").click(function(){
		$("#present-to-me-modal").modal("show");
	});
	
	$("#present-to-you").click(function(){
		$("#present-to-you-modal").modal("show");
	});
	
	$("#to-me-modal-yes").click(function(){
		
		$.ajax({
			url:"${appRoot}/shopping/checkPoint/" + productPoint,
			type:"get",
			success:function(data){
				console.log("성공");
				if(data == false){
					alert("포인트가 부족합니다.");
					$("#present-to-me-modal").modal("hide");
				}else{
					$("#receiverId").val(userId);
					$("#purchase-form").submit();
				}
			},
			error:function(){
				console.log("실패");
				
			}
		});
		
		
	});
	
	$("#to-you-modal-yes").click(function(){
		let selected = $("select option:selected").text();
		let receiverId = selected.substring(0, 3);
		
		$.ajax({
			url:"${appRoot}/shopping/checkPoint/" + productPoint,
			type:"get",
			success:function(data){
				console.log("성공");
				if(data == false){
					alert("포인트가 부족합니다.");
					$("#present-to-you-modal").modal("hide");
				}else{
					$("#receiverId").val(receiverId);
					$("#purchase-form").submit();
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