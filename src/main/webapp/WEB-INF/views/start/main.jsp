<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>



<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<title>Insert title here</title>

</head>
<body>

<div class="container">
<pr:navbar></pr:navbar>




<div class="row">
	<!--       왼쪽 nav          -->
	
<div class="card col-3" style="width: 18rem;">
  <c:if test="${empty profile.fileName }">
  	<img src="${appRoot }/resources/img/구름.png" class="card-img-top" alt="...">
  </c:if>
  <c:if test="${!empty profile.fileName }">
  	<img src="${imgRoot}${profile.userId }/${profile.fileName}" class="card-img-top" alt="...">
  </c:if>
  
  <form action="${appRoot }/start/main" method="post" enctype="multipart/form-data">
  	<label for="pro-file">프로필 사진 수정</label>
  	<input type="file" id="pro-file" name="file" hidden accept="image/*"><br><br>
  	<input hidden name="userId" value="${pinfo.member.userId }">
  	<button class="btn btn-primary" type="submit" hidden id="pro-submit">수정</button>
  </form>
  
  <div class="card-body">
    <h5 class="card-title">${profile.userName }(${profile.userName })</h5>
    <p class="card-text">${profile.userNickName }</p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">${profile.point }</li>
    <li class="list-group-item">A second item</li>
    <li class="list-group-item">A third item</li>
  </ul>
  <div class="card-body">
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
</div>
	
	<!--          본문 영역            -->
	
	<div class="col-9 border">
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		
		
	</div>
</div>
</div>
<hr>
	
</body>

<script>
$(function(){
	$("#pro-file").change(function(){
		$("#pro-submit").removeAttr("hidden");
	});
});
</script>
</html>