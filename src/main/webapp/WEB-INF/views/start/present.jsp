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
	<div class="row">
	<!--       왼쪽 nav          -->
	
<div class="card col-3" style="width: 18rem;">
<br>
  <c:if test="${empty profile.fileName }">
  	<img src="${appRoot }/resources/img/구름.png" class="card-img-top" alt="...">
  </c:if>
  <c:if test="${!empty profile.fileName }">
  	<img src="${imgRoot}${profile.userId }/${profile.fileName}" class="card-img-top rounded-circle" alt="...">
  </c:if>
  
  <form action="${appRoot }/start/approve" method="post" enctype="multipart/form-data" id="pro-form">
  	<label for="pro-file">프로필 사진 수정</label>
  	<input type="file" id="pro-file" name="file" hidden accept="image/*"><br><br>
  	<input hidden name="userId" id="userId" value="${pinfo.member.userId }">
  	<button class="btn btn-primary" type="submit" hidden id="pro-submit">수정</button>
  </form>
  
  <div class="card-body" id="card-body">
    <h5 class="card-title">${profile.userId }(${profile.userName })</h5>
    <p class="card-text">${profile.userNickName }</p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item"><i class="fas fa-coins"></i>&nbsp;&nbsp;&nbsp;&nbsp;<a href="${appRoot }/start/point">${profile.point }포인트</a></li>
    <li class="list-group-item"><i class="fas fa-user-check"></i>
    	&nbsp;&nbsp;
    	<a href="${appRoot }/start/approve">승인요청&nbsp;&nbsp;<span>${appSize }건</span></a>
    	
    	
    </li>
    <li class="list-group-item"><i class="fas fa-info-circle"></i>&nbsp;&nbsp;<a href="${appRoot }/start/info?userId=${pinfo.member.userId}">개인정보</a></li>
    <li class="list-group-item"><i class="fas fa-gift"></i>&nbsp;&nbsp;<a href="${appRoot }/start/present" class="card-link">선물함&nbsp;&nbsp;<span>${myPresent }개</span></a></li>
  </ul>

</div>
	
	<!--          본문 영역            -->
	
	<div class="col-9 border">
	<h1>선물함</h1>
<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>보낸사람</th>
				<th>상품</th>
				<th>상품이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${presentList }" var="list">
				<tr>
					<td></td>
					<td class="req-id">${list.userId }</td>
					<td><img src="${appRoot }/resources/product/${list.productPicture}" height="63"></td>
					<td>${list.productName }</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>
</div>
</body>
</html>