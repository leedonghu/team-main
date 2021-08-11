<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>



<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<style>
.card-body{
height: "50";
}
</style>

<title>Insert title here</title>

</head>
<body>

<div class="container">
<pr:navbar></pr:navbar>




<div class="row">
	<!--       왼쪽 nav          -->
	
<div class="card col-2" style="width: 18rem;">
  
  <!-- 프로필 사진 수정 전 -->
  <c:if test="${empty profile.fileName }">
  	<img src="${appRoot }/resources/img/구름.png" class="card-img-top img-profile rounded-circle" alt="...">
  </c:if>
  
  <!-- 프로필 사진 수정하면  -->
  <c:if test="${!empty profile.fileName }">
  	<img src="${imgRoot}${profile.userId }/${profile.fileName}" class="card-img-top rounded-circle" alt="...">
  </c:if>
  
  <form action="${appRoot }/start/main" method="post" enctype="multipart/form-data" id="pro-form">
  	<label for="pro-file">프로필 사진 수정</label>
  	<input type="file" id="pro-file" name="file" hidden accept="image/*"><br><br>
  	<input hidden name="userId" value="${pinfo.member.userId }">
  	
  </form>
  
  <div class="card-body" id="card-body">
    <h5 class="card-title">${profile.userId }(${profile.userName })</h5>
    <p class="card-text">${profile.userNickName }</p>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item"><i class="fas fa-coins"></i>&nbsp;&nbsp;&nbsp;&nbsp;<a href="${appRoot }/start/point">${profile.point }</a></li>
    <li class="list-group-item"><i class="fas fa-user-check"></i>
    	&nbsp;&nbsp;
    	<a href="${appRoot }/start/approve">승인요청&nbsp;&nbsp;<span>${appSize }건</span></a>
    	
    	
    </li>
    <li class="list-group-item">A third item</li>
  </ul>
  <div class="card-body">
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
		<!-- 
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		 -->
		
		
	</div>
</div>
</div>
<hr>

<!-- 권한 확인 모달 -->
<div class="modal" tabindex="-1" data-backdrop="static" id="auth-modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">접근 불가</h5>

      </div>
      <div class="modal-body">
        <p>구성원들의 동의를 얻어야 합니다.</p>
        <p>${appState.size - appState.state} / ${appState.size } 진행중</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary"
									onclick="location.href='${appRoot}/start/login'">돌아가기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" tabindex="-1" id="birth-modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">HAPPY BIRTHDAY</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>생일축하합니다!</p>
        <p>100POINT를 얻으셨습니다.</p>
      </div>
      <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>

      </div>
    </div>
  </div>
</div>

<input hidden value="${size }" id="size">
<c:forEach items="${auth }" var="authName" varStatus="status">
	<input hidden value="${authName }" id="auth-${status.index }">
</c:forEach>


<input hidden value="${birth }" id="birth">

	
</body>





<script>
$(function(){
	$("#pro-file").change(function(){
		$("#pro-form").submit();
		
	});
	
	//권한을 확인해서 member권한이 없으면 다시 로그인창으로 보내는 일을 함
	var auth = [];
	var size = $("#size").val();
	var passAuth = "ROLE_MEMBER";
	var authState = 1;
	var birth = $("#birth").val();
	
	
	
	for(var i=0; i<size; i++){
		auth.push($("#auth-" + i).val());
	}
	
	console.log(auth);
	
	for(var i=0; i<auth.length; i++){
		if(passAuth == auth[i]){
			authState ++;
		}
	}
	
	if(authState == 1){
		$("#auth-modal").modal("show");
	}else{
		//member이면서 생일일때 modal 나옴
		if(birth != ""){
			$("#birth-modal").modal("show");
		}
	}
	

	
	
	
});
</script>
</html>