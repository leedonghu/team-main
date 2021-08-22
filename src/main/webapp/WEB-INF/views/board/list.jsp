<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<title>Insert title here</title>

<script>
$(document).ready(function(){
	$("#list-pagenation1 a").click(function(e){
		//기본 액션 중지
		e.preventDefault();
		
		console.log("a요소 클릭됨");
		
		var actionForm = $("#actionForm");
		
		//form의 pageNum input의 값을 a 요소의 href값으로 변경
		actionForm.find("[name=pageNum]").val($(this).attr("href"));
		
		//submit
		actionForm.submit();
	});
});
</script>

</head>
<body>

<div class="container">
<pr:navbar></pr:navbar>
	
	<div class="row">
		<div class="col-4"></div>
		<div class="col-8">
 		 	<form action="${listUrl }" method="get" class="form-inline">
    			<select name="type" class="form-control mr-sm-2">
       				<option value="">--</option>
       				<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
       				<option value="C" ${cri.type == "C" ? 'selected' : '' }>내용</option>
       				<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
       				<option value="TC" ${cri.type == "TC" ? 'selected' : '' }>제목 or 내용</option>
       				<option value="TW" ${cri.type == "TW" ? 'selected' : '' }>제목 or 작성자</option>
       				<option value="TWC" ${cri.type == "TWC" ? 'selected' : '' }>제목 or 내용 or 작성자</option>
    			</select>
  
    			<input name="keyword" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" value="${cri.keyword }">
    			<input type="hidden" name="pageNum" value="1">
    			<input type="hidden" name="amount" value="${cri.amount }">
    			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
  			</form>	
		</div>
	</div>
	
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

<!-- PAGENATION -->
<nav aria-label="Page navigation example">
  <ul id="list-pagenation1" class="pagination justify-content-center">
    
    <c:if test="${pageMaker.prev }">
      <li class="page-item">
        <a class="page-link" href="${pageMaker.startPage -1 }" tabindex="-1">Previous</a>
      </li>
    </c:if>
    
    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
    <%-- href="${appRoot }/board/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}" --%>
       <li class="page-item ${num == cri.pageNum ? 'active' : '' }"><a class="page-link" href="${num }">${num }</a></li>
    </c:forEach>
    
    <c:if test="${pageMaker.next }">
       <li class="page-item">
         <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
       </li>
    </c:if>
    
  </ul>
</nav>


<!-- 페이지 링크용 form -->
<div style="display: none;">
   <form id="actionForm" action="${appRoot }/board/list" method="get">
      <input name="pageNum" value="${cri.pageNum }"/>
      <input name="amount" value="${cri.amount }"/>
      <input name="type" value="${cri.type }"/>
      <input name="keyword" value="${cri.keyword }"/>
   </form>
</div>
	
</div>

<!-- 글을 CRUD 했을때 사용하는 모달  -->
<c:if test="${not empty result }">
<script>
$(document).ready(function(){
	
	
	if(history.state == null){
		
	$("#board-modal1").modal('show');
	history.replaceState({}, null);
	}
});
</script>

<div id="board-modal1" class="modal" tabindex="-1">
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