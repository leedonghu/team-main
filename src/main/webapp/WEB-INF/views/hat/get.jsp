<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<title>Insert title here</title>

<style>

.col-10.border{
width : 100%;
text-align : center;
}

.col-10.border > h2{
display: inline-block;
}

.input-group.mb-3 > input{
	height: 38px;
	width: 55px;
}

.insert > input{
	height: 38px;
	width: 100px;
}

.justify-content-center.mt-3{
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
}

.justify-content-center.mt-3 > img {
	flex-grow: 1;
}
</style>


</head>
<body>

<div class="container">
	<pr:navbar></pr:navbar>
	<div class="row">
	<!--       왼쪽 nav          -->
	
	<div class="col-2">	
		<nav class="nav flex-column">
  			<a class="nav-link active" href="${appRoot }/quiz/get">오늘의 quiz</a>
  			<a class="nav-link" href="${appRoot }/hat/get">공을 찾아라</a>
  			<a class="nav-link" href="${appRoot }/spacebar/get">스페이스바 부수기</a>
  			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		</nav>
	</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
			<h2>공을 찾아라</h2>
	
	<!-- 공찾기 -->
	<!-- 포인트 걸고 모자를 눌러서 맞추면 포인트 획득 -->
	
		<div class="justify-content-center mt-3" id="quiz-start">
			<button class="btn btn-light btn-outline-light" disabled><img id="img1" class="1" src="${appRoot }/resources/quiz/모자1.png" width="169.5" height="225.33"></button>
			<button class="btn btn-light btn-outline-light" disabled><img id="img2" class="2" src="${appRoot }/resources/quiz/모자1.png" width="169.5" height="225.33"></button>
			<button class="btn btn-light btn-outline-light" disabled><img id="img3" class="3" src="${appRoot }/resources/quiz/모자1.png" width="169.5" height="225.33"></button>
			
		</div>
			<div class="insert">
				<input type="number" id="bet-input">
				<button class="btn btn-outline-secondary" type="button" id="bet-button">Bet</button>
			</div>
		
	</div>
</div>
</div>

<!-- 모달 -->
<div class="modal" tabindex="-1" role="dialog" id="result-madal" data-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="modal-close">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
/*
function excute(){
	var ans = Math.floor(Math.random() * 3) + 1;
	var click = $(this).attr("id");
	console.log(click);
}
*/
$(function(){
	var ans = Math.floor(Math.random() * 3) + 1;
	var store = [1, 2, 3];
	var src1 = "${appRoot }/resources/quiz/모자"
	var src2 = ".png"
	
	$("img").click(function(){
		var betPoint = $("#bet-input").val();
		var id = $(this).attr("id");
		var num = $(this).attr("class");
		console.log(id);
		console.log(num);
		console.log(ans);
		
		setTimeout(function(){firstChange();}, 1000);
		setTimeout(function(){secondChange();}, 1100);
		setTimeout(function(){
			if(ans == num){
				
				$.ajax({
					type:"post",
					url:"${appRoot}/hat/addPoint/" + betPoint,
					success:function(data){
						console.log("성공");
						$(".modal-title").text("성공");
						$(".modal-body > p").text(data + "포인트를 얻으였습니다.");
						$("#result-madal").modal("show");
						$("#modal-close").click(function(){
							location.reload();
						});
					},
					error:function(){
						console.log("실패");
					}
				});
				

			}else{
				$(".modal-title").text("실패");
				$(".modal-body > p").text("다시 도전하세요!");
				$("#result-madal").modal("show");
				$("#modal-close").click(function(){
					location.reload();
				});
			}
		}, 1400);

	});
	
	function firstChange(){
		for(var i = 0; i<store.length; i++){
			if(ans == store[i]){
				$("#img" + store[i]).attr("src", src1 + 3 + src2);
			}else {
				$("#img" + store[i]).attr("src", src1 + 2 + src2);
			}
		}
		console.log("first");
	}
	
	function secondChange(){
		for(var i = 0; i<store.length; i++){
			if(ans == store[i]){
				$("#img" + store[i]).attr("src", src1 + 5 + src2);
			}else {
				$("#img" + store[i]).attr("src", src1 + 4 + src2);
			}
		}
		console.log("second");
	}
	
	$("#bet-button").click(function(){
		var betPoint = $("#bet-input").val();
		
		$.ajax({
			type:"post",
			url: "${appRoot}/hat/checkPoint/" + betPoint,
			success: function(data){
				console.log(betPoint);
				console.log("베팅 성공");
				
				if(data == true){
					$(".modal-title").text("배팅성공");
					$(".modal-body > p").text("모자를 눌러주세요");
					$("#result-madal").modal("show");
					$("#bet-input").attr("readonly", "readonly");
					$("#quiz-start > button").removeAttr("disabled");

				}else{
					$(".modal-title").text("배팅실패");
					$(".modal-body > p").text("가지고계신 POINT가 적거나 0포인트 이상 베팅해주세요.");
					$("#result-madal").modal("show");
				}
			},
			error: function(){
				console.log("베팅 실패");
			}
			
		});
	});
});
</script>
</body>
</html>