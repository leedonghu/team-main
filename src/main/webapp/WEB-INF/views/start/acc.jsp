<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<div class="container">
	<script>
// 아이디 패턴과 중복을 확인하는 버튼
var url = "${pageContext.request.contextPath}"+"/start/checkId";

$(document).ready(function() {
	$("#button1").click(function() {
		var userId = $("#input2").val();
		
		$.post(url, {userId: userId}, function(data) {
			if (data == 'ok') {
				// 가입 가능 메세지
				// console.log("ok");
				alert("사용 가능합니다.");
			} else if(data == 'not ok') {
				// 가입 불가능 메세지
				// console.log("not ok");
				alert("이미 존재하는 아이디입니다.");
				$("#input2").val("");
			} else {
				alert("아이디 패턴을 확인해주세요.");
				$("#input2").val("");
			}
		});
	});
});

//비밀번호 패턴을 확인하는 버튼
var url2 = "${pageContext.request.contextPath}"+"/start/checkPassword";

$(document).ready(function(){
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
	//모든 input이 채워졌을 때 submit 버튼이 활성화
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

</head>
<body>
<div class="container">
	
	<div><h3>회원가입</h3></div>
<hr>
<div></div>

<!-- 회원가입 정보를 받아 post 방식으로 다시 NewAccountServlet으로 보내준다 -->
<form action="<%=request.getContextPath() %>/start/acc" method="post" id="form1">
	<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">이름</span>
  </div>
  <input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon1" name="userName" id="input1">
</div>

<div class="input-group mb-3">
 <span class="input-group-text" id="basic-addon2">아이디</span>
  <input type="text" class="form-control" placeholder="영문자, 숫자를 사용하여  5~10글자 사이로 만들어주세요" aria-label="Recipient's username" aria-describedby="button-addon2"  name="userId" id="input2">
  
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="button1">확인</button>
  </div>
 
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon3">비밀번호</span>
  </div>
  <input type="password" class="form-control" placeholder="영문자, 숫자를 사용하여  8~14글자 사이로 만들어주세요" aria-label="Username" aria-describedby="basic-addon3" name="userPw" id="input3">
  <div class="input-group-append">
    <button class="btn btn-outline-secondary" type="button" id="button2">확인</button>
  </div>
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon4">전화번호</span>
  </div>
  <input type="text" class="form-control" placeholder="010xxxxxxxx" aria-label="Username" aria-describedby="basic-addon4" name="mobileNum" id="input4">
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon5">이메일</span>
  </div>
  <input type="text" class="form-control" placeholder="xxxx@xxxx" aria-label="Username" aria-describedby="basic-addon5" name="email" id="input5">
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon6">주소</span>
  </div>
  <input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon6" name="address" id="input6">
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon7">생년월일</span>
  </div>
  <input type="date" class="form-control" placeholder="생년월일" aria-label="Username" aria-describedby="basic-addon6" name="birth" id="input7">
</div>

<button type="submit" class="btn btn-primary" id="submit1" disabled>확인</button>
</form>
	
</div>
<script>
$(function(){
	$("#input6").click(function(){
		
    	new daum.Postcode({
        	oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            
            var roadAdd = data.roadAddress;
            $("#input6").val(roadAdd);
    	    }
	    }).open();
	});
});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>