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
		<br>
  			<a class="nav-link active" href="${appRoot }/album/list">사진첩</a>
  			<a class="nav-link" href="${appRoot }/album/register">사진첩 등록</a>

		</nav>
	</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
			<h2>앨범</h2>

<div class="row row-cols-1 row-cols-md-4" id="album-card-container1">
  
  <c:forEach items="${list }" var="album">
  <div class="col mb-4" data-ano="${album.ano }">
    <div class="card">
      <img src="${imgRoot}${album.ano }/${album.fileName[0].fileName}" class="card-img-top" alt="..." width="169.5" height="225.33">
      <!-- 
      <div class="card-body">
        <h5 class="card-title">${album.title }</h5>
        <p class="card-text">${album.comment }</p>
      </div>
       -->
    </div>
  </div>
  </c:forEach>
 
</div>
		
	</div>
</div>
	
</div>

<!-- 사진 보여주는 모달 -->

<div class="modal fade bd-example-modal-lg" id="album-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ALBUM</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
		<div class="container-fluid">
			<div class="row">
				<div class="col-6 border-right">
					<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
 						 <div class="carousel-inner">
							<!-- 사진 들어가는 곳 -->
  						</div>
  						<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
    						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    						<span class="sr-only">Previous</span>
  						</a>
  						<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
    						<span class="carousel-control-next-icon" aria-hidden="true"></span>
    						<span class="sr-only">Next</span>
  						</a>
					</div>
				</div>
				
				<div class="col-6 content">
					<!-- 내용 들어가는 곳 -->
				</div>
			</div>
		</div>
      </div>
      <div class="modal-footer">


      </div>
    </div>
  </div>
</div>


<!-- 모달 스크립트 -->

<script>
	$(function(){
		
		var albumComponent = $("#album-card-container1").on("click", ".col.mb-4", function(e){showModal(e, this);} );
		
		function showModal(e, elem){
			e.preventDefault();
			console.log("click");
			var ano = $(elem).attr("data-ano");
			
			//var ano = parseInt(anoStr);
			
			$("#album-modal").modal("show");
			$.ajax({
				type: "post",
				url: "${appRoot}/album/get/" + ano,
				success: function(data){
					//file 이름을 list로 받아옴
					console.log("성공");
					console.log(data);
					carousel(data, ano);
					
				},
				error: function(){
					console.log("실패하였습니다.");
				}
			});
			
			$.ajax({
				type: "post",
				url: "${appRoot}/album/getAlbum/" + ano,
				success: function(data){
					console.log(data);
					var title = data.title;
					var comment = data.comment;
					var writer = data.writer;
					content(title, comment, writer);
					
				},
				error: function(){
					console.log("실패하였습니다.");
					
				}
			});
		}
		
		
		function carousel(data, ano){
			var container = $(".carousel-inner").empty();
			var address = "https://choongang-donghu.s3.ap-northeast-2.amazonaws.com/"+ ano +"/";
			
			for(var i = 0 ; i < data.length; i++){
				//받아온 fileName list를 for문을 돌림
				console.log(data[i]);
				
				//active는 아이템이 되는 div들 중에 하나에만 있어야 함
				var carouselHTML = `
					<div class="carousel-item `
					
					+ (i == 0 ? 'active' : '') +
					
					`">
						<img class="d-block w-100" src="\${address}\${data[i]}">
					</div>
					`
				container.append(carouselHTML);
			}
			
			
		}
		
		function content(title, comment, writer){
			var container = $(".col-6.content").empty();
			
			var contentHTML = `
			<div class="form-group">
				<input class="form-control" value="\${writer}">
			</div>
			<hr>
			<div class="form-group">
				<input class="form-control" value="\${title}">
			</div>
			<br>
			<hr>
			<div class="form-group">
				<textarea class="form-control" row="5" width="203" height="291">\${comment}</textarea>
			</div>`
			
			container.append(contentHTML);
			
		}
		
		
		
	});
	
</script>
</body>
</html>