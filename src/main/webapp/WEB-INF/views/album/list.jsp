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

<div class="row row-cols-1 row-cols-md-4">
  
  <c:forEach items="${list }" var="album">
  <div class="col mb-4">
    <div class="card">
      <img src="${imgRoot}${album.ano }/${album.fileName[0].fileName}" class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title">${album.title }</h5>
        <p class="card-text">${album.comment }</p>
      </div>
    </div>
  </div>
  </c:forEach>
 
</div>
		
	</div>
</div>
	
</div>
</body>
</html>