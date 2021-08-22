<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	<div class="col-2">	
		<nav class="nav flex-column">
		<br>
  			<a class="nav-link active" href="${appRoot }/board/list">글 목록</a>
  			<a class="nav-link" href="${appRoot }/board/register">글 쓰기</a>

		</nav>
	</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
			<h1>글 쓰기</h1>
	<div class="row">
	    <div class="col-12">
	      <form action="${appRoot }/board/register" method="post">
	         <div class="form-group">
	         	<label for="input1">제목</label>         
	            <input class="form-control" id="input1" name="title">
	         </div>
	         <div class="form-group">
	         	<label for="textarea1">내용</label>         
	            <textarea id="textarea1" class="form-control" name="content"></textarea>
	         </div>

	         <div class="form-group">
	            <label for="input2">작성자</label>
	         	<input  hidden name="writer" class="form-control" id="input2" value="${pinfo.member.userId }" readonly>
	         	<input class="form-control" value="${pinfo.member.userName }" readonly>
	         </div>
	         <input type="submit" value="작성" class="btn btn-primary" />
	      
	      </form>
	    
	    </div>
	</div>
		
	</div>
</div>
</div>
</body>
</html>