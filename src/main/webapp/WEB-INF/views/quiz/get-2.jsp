<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<title>Insert title here</title>

<style>

.col-10.border{
width : 100%;
text-align : center;
}

.col-10.border > div, h2{
display: inline-block;
}

.quiz-end{
font-size: 20px;
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
			
	
	<br>
	<br>
	<br>
	<div class="quiz-end">
		<div>오늘은 여기까지</div>
		<div>내일 다시 도전해주세요!</div>
	</div>
	

		
	</div>
</div>
</div>

<script>

</script>
</body>
</html>