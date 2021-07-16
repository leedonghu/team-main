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
	<form action="<%=request.getContextPath() %>/start/acc" method="post" id="form1">
	<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">이름</span>
  </div>
  <input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon1" name="userName" id="input1" value="${member.userName }" readonly>
</div>

<div class="input-group mb-3">
 <span class="input-group-text" id="basic-addon2">아이디</span>
  <input type="text" class="form-control" placeholder="영문자, 숫자를 사용하여  5~10글자 사이로 만들어주세요" aria-label="Recipient's username" aria-describedby="button-addon2"  name="userId" id="input2" value="${member.userId }" readonly>
</div>


<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon4">전화번호</span>
  </div>
  <input type="text" class="form-control" placeholder="010xxxxxxxx" aria-label="Username" aria-describedby="basic-addon4" name="mobileNum" id="input4" value="${member.mobileNum }">
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon5">이메일</span>
  </div>
  <input type="text" class="form-control" placeholder="xxxx@xxxx" aria-label="Username" aria-describedby="basic-addon5" name="email" id="input5" value="${member.email }">
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon6">주소</span>
  </div>
  <input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon6" name="address" id="input6" value="${member.address }">
</div>

<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon7">닉네임</span>
  </div>
  <input type="text" class="form-control"  aria-label="Username" aria-describedby="basic-addon6" name="birth" id="input7" value="${member.userNickName }">
</div>

<button type="submit" class="btn btn-primary" id="submit1" disabled>수정</button>
</form>
</div>
</body>
</html>