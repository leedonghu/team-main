<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="row">
	<div class="col-6"></div>
	<div class="col-2"><a href="${appRoot }/start/info?userId=${pinfo.member.userId}">개인정보</a></div>
	<div class="col-4"></div>

</div>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${appRoot }/start/main">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto nav-pills">
      <li class="nav-item active">
        <a class="nav-link" href="${appRoot }/album/list">사진첩 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${appRoot }/board/list">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${appRoot }/quiz/get">게임</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${appRoot }/shopping/list">쇼핑</a>
      </li>

    </ul>
    
    <sec:authorize  access="isAuthenticated()">
     <form class="form-inline my-2 my-lg-0" action="${appRoot }/logout" method="post"> 
      <button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">로그아웃</button>
    </form>
    </sec:authorize>
    

  </div>
</nav>
