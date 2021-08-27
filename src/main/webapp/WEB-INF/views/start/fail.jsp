<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<style>
.wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  
}

.content {
  font-family: system-ui, serif;
  
  padding: 3rem;
  border-radius: 1rem;
  text-align: center;
  
}

</style>
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<div class="wrapper">
	
		<div class="content">
			<h1>로그인에 실패하였습니다</h1>
			<p>아이디 및 비밀번호를 확인해주세요</p>
			<button class="btn btn-primary" onclick="location.href='${appRoot}/start/login'">돌아가기</button>
		</div>
		

	</div>
		
</div>
</body>
</html>