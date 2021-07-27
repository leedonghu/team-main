<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
  			<a class="nav-link active" href="#">Active</a>
  			<a class="nav-link" href="#">Link</a>
  			<a class="nav-link" href="#">Link</a>
  			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		</nav>
	</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		<h1>본문</h1><br>
		
		
	</div>
</div>
</div>
<hr>
	
</body>
</html>