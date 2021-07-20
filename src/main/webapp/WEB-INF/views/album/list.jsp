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
	
	<div class="col-2">	
		<nav class="nav flex-column">
  			<a class="nav-link active" href="${appRoot }/album/list">사진첩</a>
  			<a class="nav-link" href="${appRoot }/album/register">사진첩 등록</a>
  			<a class="nav-link" href="#">Link</a>
  			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		</nav>
	</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
			<h1>글 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="board" varStatus="status">
				<tr>
					<td>${board.bno }</td>
					<td>
						<c:url value="/board/get" var="getUrl">
	           				<c:param name="bno" value="${board.bno }"></c:param>
	           				<c:param name="pageNum" value="${pageMaker.cri.pageNum }"></c:param>
	           				<c:param name="amount" value="${pageMaker.cri.amount }"></c:param>
	           				<c:param name="type" value="${cri.type }"/>
	           				<c:param name="keyword" value="${cri.keyword }"/>
	        			</c:url>
	        
	        			<a href="${getUrl}">
						${board.title } 
							<c:if test="${board.replyCnt > 0 }">
								[${board.replyCnt }]
							</c:if>
						
						</a>
					
					</td>
					<td>${board.writer }</td>
					<td>${board.cnt }</td>
					<td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>
		</tbody>
		
	</table>	
		
	</div>
</div>
	
</div>
</body>
</html>