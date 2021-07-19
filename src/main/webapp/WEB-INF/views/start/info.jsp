<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>


<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<script>
$(function(){
	
	//비밀번호 패턴을 확인하는 버튼
		var url2 = "${pageContext.request.contextPath}"+"/start/checkPassword";

	
		$("#button2").click(function(){
			var userPw = $("#input3").val();
			
			$.post(url2, {userPw: userPw}, function(data){
				if(data == 'good'){
					alert("사용 가능합니다.")
				} else{
					alert("비밀번호 패턴을 확인해주세요.");
					$("#input3").val("");
				}
			});
		});
	
var disableSubmit = function() {
	
	var allTyped = true;
	$("#form1 input").each(function(i, elem) {
		allTyped = allTyped && ($(this).val() != '');
	});
	
	if (allTyped) {
		$("#submit1").removeAttr("disabled");
	} else {
		$("#submit1").attr("disabled", "disabled");
	}
};

	$("#form1 input").on({
		"mouseup" : disableSubmit,
		"keyup" : disableSubmit,
		"change" : disableSubmit
	});
});
</script>

<title>Insert title here</title>
</head>
<body>
<div class="container">
<pr:navbar></pr:navbar>
<form action="<%=request.getContextPath() %>/start/info" method="post" id="form1">
	<div class="input-group mb-3">
  		<div class="input-group-prepend">
    		<span class="input-group-text" id="basic-addon1">이름</span>
  		</div>
  		<input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon1" name="userName" id="input1" value="${member.userName }" readonly>
	</div>

	<div class="input-group mb-3">
 		<span class="input-group-text" id="basic-addon2">아이디</span>
  		<input type="text" class="form-control" placeholder="영문자, 숫자를 사용하여  5~10글자 사이로 만들어주세요" aria-label="Recipient's username" aria-describedby="button-addon2"  name="userId" id="input2" value="${member.userId }" readonly>
	</div>

	<div class="input-group mb-3">
  		<div class="input-group-prepend">
    		<span class="input-group-text" id="basic-addon3">비밀번호</span>
  		</div>
  		<input type="password" class="form-control" placeholder="영문자, 숫자를 사용하여  8~14글자 사이로 만들어주세요" aria-label="Username" aria-describedby="basic-addon3" name="userPw" id="input3" value="${member.userPw }">
  		<div class="input-group-append">
    		<button class="btn btn-outline-secondary" type="button" id="button2">확인</button>
  		</div>
	</div>


	<div class="input-group mb-3">
  		<div class="input-group-prepend">
    		<span class="input-group-text" id="basic-addon4">전화번호</span>
  		</div>
  		<input type="text" class="form-control" placeholder="010xxxxxxxx" aria-label="Username" aria-describedby="basic-addon4" name="mobileNum" id="input4" value="${member.mobileNum }">
	</div>

	<div class="input-group mb-3">
  		<div class="input-group-prepend">
    		<span class="input-group-text" id="basic-addon5">이메일</span>
  		</div>
  		<input type="text" class="form-control" placeholder="xxxx@xxxx" aria-label="Username" aria-describedby="basic-addon5" name="email" id="input5" value="${member.email }">
	</div>

	<div class="input-group mb-3">
  		<div class="input-group-prepend">
    		<span class="input-group-text" id="basic-addon6">주소</span>
  		</div>
  		<input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon6" name="address" id="input6" value="${member.address }">
	</div>

	<div class="input-group mb-3">
  		<div class="input-group-prepend">
    		<span class="input-group-text" id="basic-addon7">닉네임</span>
  		</div>
  		<input type="text" class="form-control"  aria-label="Username" aria-describedby="basic-addon6" name="userNickName" id="input7" value="${member.userNickName }">
	</div>

	<button type="submit" class="btn btn-primary" id="submit1" disabled>수정</button>
</form>
</div>

<!-- 개인정보 수정 했을때 사용하는 모달  -->
<c:if test="${not empty result }">
<script>
$(document).ready(function(){
	
	
	if(history.state == null){
		
	$("#member-modal1").modal('show');
	history.replaceState({}, null);
	}
});
</script>

<div id="member-modal1" class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">${messageTitle }</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>${messageBody }</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

</c:if>
</body>
</html>