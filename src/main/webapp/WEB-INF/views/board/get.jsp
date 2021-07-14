<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
	
	<div class="col-2">	
		<nav class="nav flex-column">
  			<a class="nav-link active" href="${appRoot }/board/list">글 목록</a>
  			<a class="nav-link" href="${appRoot }/board/register">글 쓰기</a>
  			<a class="nav-link" href="#">Link</a>
  			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		</nav>
	</div>
	
	<div class="col-10">
		<form>
	         <div class="form-group">
	         	<label for="input1">제목</label>         
	            <input class="form-control" id="input1" name="title" value="${board.title }" readonly="readonly">
	         </div>
	         <div class="form-group">
	         	<label for="textarea1">내용</label>         
	            <textarea id="textarea1" class="form-control" name="content" readonly="readonly"><c:out value="${board.content }"></c:out></textarea>
	         </div>

	         
	         <div class="form-group">
	            <label for="input2">작성자</label>
	         	<input name="writer" class="form-control" id="input2" value="${board.writer }" readonly="readonly">
	         	<
	         </div>
	        
	        <c:url value="/board/modify" var="modifyUrl">
	           <c:param name="bno" value="${board.bno }"></c:param>
	           <c:param name="pageNum" value="${cri.pageNum }"></c:param>
	           <c:param name="amount" value="${cri.amount }"></c:param>
	           <c:param name="type" value="${cri.type }"></c:param>
	           <c:param name="keyword" value="${cri.keyword }"></c:param>
	        </c:url>
	        
	        <c:if test="${pinfo.member.userId eq board.writer }">
		         <a class="btn btn-secondary" href="${modifyUrl }">수정/삭제</a>
	        </c:if>
	        
	      </form>
	</div>
</div>
</body>
</html>