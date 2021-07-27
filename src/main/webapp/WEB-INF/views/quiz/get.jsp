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
#quiz-start {
width : 100%;
text-align : center;
}

#quiz-start > div,button{
display: inline-block;
}

.col-10.border{
width : 100%;
text-align : center;
}

.col-10.border > h2{
display: inline-block;
}

</style>
</head>
<body>
<div class="container">
<pr:navbar></pr:navbar>
	<div class="row">
	<!--       왼쪽 nav          -->
	
	<div class="col-2">	
		<nav class="nav flex-column">
  			<a class="nav-link active" href="${appRoot }/quiz/get">오늘의 quiz</a>
  			<a class="nav-link" href="${appRoot }/album/register">문제내기</a>
  			<a class="nav-link" href="#">Link</a>
  			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		</nav>
	</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
			<h2>quiz</h2>
	
	<!-- 문제풀기 -->
	<!-- 문제풀기 버튼을 누르면 5point 차감 -->
	<div class="justify-content-center mt-3" id="quiz-start">
		<div>오늘의 문제!</div><br>
		<div>5point</div><br>
		<button class="btn btn-primary btn-lg" id="quiz-btn1">문제풀기</button>
	</div>
	
	<div class="quiz-solution">
		<form>
			<div class="form-group" hidden id="quiz-solution-form">
				<label for="que" class="col-form-label">문제</label>
				<textarea class="form-control" id="que" readonly>${quiz.que }</textarea>
				<br>
				<label for="ans" class="col-form-label">답</label>
				<input class="form-control" id="ans">
				<input hidden id="quiz-solution" value="${quiz.ans }">
				<button class="btn btn-primary btn-lg" id="quiz-solution-btn1">확인</button>
			</div>
		</form>
	</div>

		
	</div>
</div>
</div>

<!-- 스크립트 -->
<script>
	$(function(){
		$("#quiz-btn1").click(function(){
			$("#quiz-solution-form").removeAttr("hidden");
			$("#quiz-start").attr("hidden", "hidden");
		});
		
		$("#quiz-solution-btn1").click(function(e){
			e.preventDefault();
			var ans = $("#ans").val();
			var sol = $("#quiz-solution").val();
			//글자사이 공백 제거
			console.log(ans.replace(/ /g, ""));
			
			var reAns = ans.replace(/ /g, "");
			var reSol = sol.replace(/ /g, "");
			
			if(reAns === reSol){
				
			}
			
		})
	});
</script>

</body>
</html>