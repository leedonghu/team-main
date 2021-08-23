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
		<br>
  			<a class="nav-link active" href="${appRoot }/quiz/get">오늘의 퀴즈</a>
  			<a class="nav-link" href="${appRoot }/hat/get">공을 찾아라</a>
  			<a class="nav-link" href="${appRoot }/spacebar/get">스페이스바 어택</a>

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
	
	
	
	<div class="quiz-solution" >
		<form>
			<div class="form-group" id="quiz-solution-form" hidden>
				<label for="que" class="col-form-label">문제</label><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><span id="que-point"></span><span>점</span>
				<textarea class="form-control" id="que" readonly>${quiz.que }</textarea>
				<br>
				<label for="ans" class="col-form-label">답</label>
				<input class="form-control" id="ans" type="text">
				<input hidden id="quiz-solution" value="${quiz.ans }">
				<input hidden id="quiz-id" value="${quiz.qid }">
				<input hidden id="quiz-userId" value="${pinfo.member.userId }">
				<button class="btn btn-primary btn-lg" id="quiz-solution-btn1">확인</button>
			</div>
		</form>
	</div>
	
	
	
	<div class="quiz-end" hidden>
		<div>오늘은 여기까지</div>
		<div>내일 다시 도전해주세요!</div>
	</div>
	

		
	</div>
</div>
</div>

<!-- 스크립트 -->
<script>
	$(function(){
		$("#quiz-btn1").click(function(){
			//문제풀기를 누르면 quiz가 있는 element들이 보이게 함
			$("#quiz-solution-form").removeAttr("hidden");
			$("#quiz-start").attr("hidden", "hidden");
			
			//각 문제는 random한 point를 얻게 만듬
			var randomPoint = Math.floor(Math.random() * 10) + 1;
			var getPoint = randomPoint * 5;
			$("#que-point").text(getPoint);
			
			//확인을 누르면 문제를 시도했다는 확인을 남김
			var point = $("#que-point").text();
			var qid = $("#quiz-id").val();
			var userId = $("#quiz-userId").val();
			console.log(point);
			
			var data = {
				point: point,
				qid: qid,
				userId: userId
					
			};
			
			$.ajax({
				type:"post",
				url:"${appRoot}/quiz/att",
				data: JSON.stringify(data),
				contentType:"application/json",
				success:function(){
					console.log("변경성공");
				},
				error:function(){
					console.log("변경실패");
				}
			});
			
		});
		
		$("#quiz-solution-btn1").click(function(e){
			e.preventDefault();
			var ans = $("#ans").val();
			var qid = $("#quiz-id").val();
			var point = $("#que-point").text();
			var sol = $("#quiz-solution").val();
			//글자사이 공백 제거
			console.log(ans.replace(/ /g, ""));
			
			var reAns = ans.replace(/ /g, "");
			var reSol = sol.replace(/ /g, "");
			
			var data = {
				qid: qid,
				ans: ans,
				point: point
			};
			
			$.ajax({
				type:"post",
				data:JSON.stringify(data),
				contentType:"application/json",
				url:"${appRoot}/quiz/checkAns",
				success:function(data){
					console.log("정답확인 성공");
					console.log(data);
					
					if(data){
						console.log("true 받음");
						endQuiz();
					}else{
						console.log("false 받음");
						keepQuiz();
					}
				},
				error:function(){
					console.log("정답확인 실패");
				}
			});
			
		});
		
		function endQuiz(){

			alert("정답을 맞추셨습니다.");
			location.reload();
		}
		
		function keepQuiz(){
			alert("다시 도전해주세요");
			$("#ans").val("");
		}
	});
</script>

</body>
</html>