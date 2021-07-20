<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<style>
#album-input1 {
  apperance: none;
  -webkit-apperance: none;
}

</style>

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
			<h1>사진첩 등록</h1>
<form method="post" id="album-form1" action="${appRoot }/album/register" enctype="multipart/form-data">
  <div class="form-group">
    <label for="album-title1">제목</label>
    <input type="text" class="form-control" id="album-title1" placeholder="" name="title">
  </div>
  

  <div class="form-group">
    <label for="album-input1">사진 선택</label>
    <input type="file" class="form-control-file" id="album-input1" multiple accept="image/*" name="file">
  </div>

  
  <div class="form-group">
    <label for="exampleFormControlSelect2">Example multiple select</label>
    <select multiple class="form-control" id="exampleFormControlSelect2">
      <option>1</option>
      <option>2</option>
      <option>3</option>
      <option>4</option>
      <option>5</option>
    </select>
  </div>
  <div class="form-group">
    <label for="exampleFormControlTextarea1">Example textarea</label>
    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
  </div>
  
  <button class="btn btn-primary" type="submit">등록</button>
</form>
		
	</div>
</div>
	
</div>


<script>
/* 파일이 선택되고 나서 */
 
$(function(){
	$("#album-input1").change(function(){
		
	});
});

</script>
</body>
</html>