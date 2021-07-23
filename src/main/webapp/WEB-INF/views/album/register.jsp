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
  

  <div class="form-group" id="album-input-div1">
    <label for="album-input1">사진 선택</label>
    <input type="file" class="form-control-file" id="album-input1" multiple files accept="image/*" name="files">
  </div>

  <!-- 
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
   -->
  <div class="form-group">
    <label for="album-textarea1">comment</label>
    <textarea class="form-control" id="album-textarea1" rows="3" name="comment"></textarea>
  </div>
  
  <div class="form-group">
    <label for="input2">작성자</label>
	<input  hidden name="writer" class="form-control" id="album-input2" value="${pinfo.member.userId }" readonly>
	<input class="form-control" value="${pinfo.member.userName }" readonly>
  </div>
  
  <button class="btn btn-primary" type="submit">등록</button>
</form>
		
	</div>
</div>
	
	<div class="test">
		<c:forEach  begin="0" end="10" var="i">
			<img id="test-img1${i }" src="">
		</c:forEach>
	</div>
</div>


<script>
/* 파일이 선택되고 나서 */
 $(function(){
	 $("#album-input1").change(function(e){
		 e.preventDefault();
		 var inputVar = $("#album-input1").val();
		 
		 //files를 쓰려면 실제 element에서만 사용가능
		 //jquery로는 사용불가
		 //jquery객체는 배열처럼 생겼는데, 그것의 [0]를 가져오면 실제 element를 가져오게됨 
		 var files = $("#album-input1")[0].files
		 
		 
		 var filesLength = files.length;
		 
		 if(filesLength > 10){
			 alert("사진의 최대 갯수는 10개입니다.");
			 $("#album-input1").empty();
		 }
		 
		 /*
		 for (var file of files) {
			 console.log(file.name);
			 console.log(URL.createObjectURL(file));
			 $(".test-img1").attr("src", URL.createObjectURL(file));
		 }
		 */
		 
		 for(var i = 0; i<files.length; i++ ){
			 $("#test-img1" + i).attr("src", URL.createObjectURL(files[i]));
			 console.log(files[i].name);
			 console.log(URL.createObjectURL(files[i]));
		 }
	 });
 });

</script>
</body>
</html>