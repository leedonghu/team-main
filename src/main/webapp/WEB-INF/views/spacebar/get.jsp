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

.out{
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
	width: 100%;
	margin: 0;
}
.detail{
	width:123.54px;
	height: 70px;
	border: solid;
	text-align: center;
	
}
.color-bar{
	border: solid;
}
#bar1{
	border: solid #d50000;
}
#bar2{
	border: solid #c51162;
}
#bar3{
	border: solid #aa00ff;
}
#bar4{
	border: solid #6200ea;
}
#bar5{
	border: solid #304ffe;
}
#bar6{
	border: solid #2962ff;
}
#bar7{
	border: solid #0091ea;
}
#bar8{
	border: solid #00b8d4;
}
#bar9{
	border: solid #00bfa5;
}
#bar10{
	border: solid #00c853;
}
#bar11{
	border: solid #64dd17;
}
#bar12{
	border: solid #aeea00;
}
#bar13{
	border: solid #ffd600;
}
#score{
	width: 249.08px;
	height: 150px;
	border: solid;
	text-align: center;
	line-height:150px;
	vertical-align:middle;
	font-size: 100px;
	font-color: red;
	
}
#high, #time{
	font-size: 30px;
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
		 			<a class="nav-link" href="${appRoot }/space/get">스페이스바 부수기</a>
		 			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
			</nav>
		</div>

	<!--          본문 영역            -->
	
		<div class="col-10 border">
			<div class="out">
					<h2>스페이스바 부수기</h2>
			</div>
			<br>
			
			<!-- 상태 보여주는  div-->
			<div class="out">
				
				
					<div class="color-bar" id="bar1">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar2">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar3">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar4">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar5">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar6">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar7">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar8">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar9">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar10">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar11">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar12">&nbsp&nbsp&nbsp</div>
					<div class="color-bar" id="bar13">&nbsp&nbsp&nbsp</div>
				
				
			</div>
			<br>
			<!-- 시간 흐름 -->
			<div class="out time">
				<div class="row">
					<div class="col-6 detail">
						<div class="child">시간 </div>
						<div id="time" class="child">30</div>
					</div>
					<div class="col-6 detail">
						<div class="child">최고 점수 </div>
						<div id="high" class="child">${list[0].score }</div>
					</div>
				</div>
			</div>
			
			<!-- 점수 보여주는 div -->
			<div class="out">
				<div id="score">0</div>
			</div>
			<br>
			<br>
			<!-- 게임 시작 버튼 -->
			<div class="out">
				<button class="btn btn-primary" id="start-btn">25point</button>
			</div>	
			<br>
			<br>
			<!-- 등수 보여주는 div -->
			<div class="out">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>등수</th>
						<th>아이디</th>
						<th>점수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="pride" varStatus="status">
						<tr>
							<td>${status.index +1}</td>
							<td>${pride.userId }(${pride.userName })</td>
							<td>${pride.score }</td>
						</tr>
					</c:forEach>

					
				</tbody>
			</table>
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
$(function(){
	
	$("#start-btn").click(function(){
		//var time = parseInt($("#time").text());
		$("#start-btn").blur();
		console.log("뺴1");
		
		//포인트 확인 ajax
		$.ajax({
			type:"get",
			url:"${appRoot}/spacebar/checkPoint",
			success:function(data){
				console.log("point check");
				console.log(data)
				if(data == false){
					$(".modal-title").text("포인트 부족");
					$(".modal-body > p").text("가지고계신 포인트가 25포인트보다 적습니다.");
					$("#result-madal").modal("show");
					$("#modal-close").click(function(){
						location.reload();
					});
				}else {
					spacebar();
				}
			},
			error:function(){
				console.log("point check 실패");
			}
				
		});

		function spacebar(){
			
		var score = parseInt($("#score").text());
		$(document).keyup(function(){

			score = score + 1 ;
			$("#score").text(score);
			
			if(score>0 && score <=10){
				$("#bar1").css("background-color", "#d50000");
			}else if(score>10 && score <=20){
				$("#bar2").css("background-color", "#c51162");
			}else if(score>20 && score<=30){
				$("#bar3").css("background-color", "#aa00ff");
			}else if(score>30 && score <=40){
				$("#bar4").css("background-color", "#6200ea");
			}else if(score>40 && score <=50){
				$("#bar5").css("background-color", "#304ffe");
			}else if(score>50 && score <=60){
				$("#bar6").css("background-color", "#2962ff");
			}else if(score>60 && score <=70){
				$("#bar7").css("background-color", "#0091ea");
			}else if(score>70 && score<=80){
				$("#bar8").css("background-color", "#00b8d4");
			}else if(score>80 && score<=90){
				$("#bar9").css("background-color", "#00bfa5");
			}else if(score>90 && score<=100){
				$("#bar10").css("background-color", "#00c853");
			}else if(score>100 && score<=110){
				$("#bar11").css("background-color", "#64dd17");
			}else if(score>110 && score<=120){
				$("#bar12").css("background-color", "#aeea00");
			}else if(score>120 && score<=130){
				$("#bar13").css("background-color", "#ffd600");
			}
		
		});
		
		
		
		
		var countdown =	setInterval(function(){
			console.log("1초지남")
			var time = parseInt($("#time").text());
			time = time-1;
			$("#time").text(time);
			if(time == 0){
				var score = $("#score").text();
				//setInterval 종료시킴
				clearInterval(countdown);
				
				var data = {score: score};
				
				$.ajax({
					url:"${appRoot}/spacebar/score",
					type:"post",
					data: JSON.stringify(data),
					contentType: "application/json",
					success:function(data){
						console.log("성공");
						var point = [200, 100, 75, 50, 25]
						if(data <= 4){
							console.log(data)
							$(".modal-title").text("축하합니다");
							$(".modal-body > p").text(point[data] + "포인트를 얻으였습니다.");
							$("#result-madal").modal("show");
							$("#modal-close").click(function(){
								location.reload();
							});
						}else{
							console.log(data)
							$(".modal-title").text("아깝습니다.");
							$(".modal-body > p").text(data + 1 + "등 입니다.");
							$("#result-madal").modal("show");
							$("#modal-close").click(function(){
								location.reload();
							});
						}
					},
					error:function(){
						console.log("실패");
					}
					
				})
			}
		}, 1000);
		
		}
		
	});
});

</script>
</body>
</html>