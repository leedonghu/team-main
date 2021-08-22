<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>



<title>Insert title here</title>
</head>
<body>
<div class="container">
	<pr:navbar></pr:navbar>
	
	
	<div class="row">
	<!--       왼쪽 nav          -->
	
		<div class="card col-2" style="width: 18rem;">
		<br>
		  
		  <!-- 프로필 사진 수정 전 -->
		  <c:if test="${empty profile.fileName }">
		  	<img src="${appRoot }/resources/img/구름.png" class="card-img-top img-profile rounded-circle" alt="...">
		  </c:if>
		  
		  <!-- 프로필 사진 수정하면  -->
		  <c:if test="${!empty profile.fileName }">
		  	<img src="${imgRoot}${profile.userId }/${profile.fileName}" class="card-img-top rounded-circle" alt="...">
		  </c:if>
		  
		  <form action="${appRoot }/start/point" method="post" enctype="multipart/form-data" id="pro-form">
		  	<label for="pro-file">프로필 사진 수정</label>
		  	<input type="file" id="pro-file" name="file" hidden accept="image/*"><br><br>
		  	<input hidden name="userId" value="${pinfo.member.userId }">
		  	
		  </form>
		  
		  <div class="card-body" id="card-body">
		    <h5 class="card-title">${profile.userId }(${profile.userName })</h5>
		    <p class="card-text">${profile.userNickName }</p>
		  </div>
		  <ul class="list-group list-group-flush">
		    <li class="list-group-item"><i class="fas fa-coins"></i>&nbsp;&nbsp;&nbsp;&nbsp;<a href="${appRoot }/start/point">${profile.point }</a></li>
		    <li class="list-group-item"><i class="fas fa-user-check"></i>
		    	&nbsp;&nbsp;
		    	<a href="${appRoot }/start/approve">승인요청&nbsp;&nbsp;<span>${appSize }건</span></a>
		    	
		    	
		    </li>
		    <li class="list-group-item">A third item</li>
		  </ul>
		  <div class="card-body">
		    <a href="#" class="card-link">Card link</a>
		    <a href="#" class="card-link">Another link</a>
		  </div>
		</div>
	
	<!--          본문 영역            -->
	
	<div class="col-10 border">
		<!-- 전체 포인트 정보 -->
			<input hidden value="${size }" id="size">
	<c:forEach items="${point.pointMap }" var="entry" varStatus="status">
		<div hidden id="total-key-${status.index }">${entry.key }</div> 
		<div hidden id="total-value-${status.index }">${entry.value }</div>
	</c:forEach>
	
	<!-- 얻은 포인트 정보 -->
	<input hidden value="${size2 }" id="size2">
	<c:forEach items="${earn.pointMap }" var="entry" varStatus="status">
		<div hidden id="earn-key-${status.index }">${entry.key }</div> 
		<div hidden id="earn-value-${status.index }">${entry.value }</div>
	</c:forEach>
	
		<!-- 잃은 포인트 정보 -->
	<input hidden value="${size3 }" id="size3">
	<c:forEach items="${lose.pointMap }" var="entry" varStatus="status">
		<div hidden id="lose-key-${status.index }">${entry.key }</div> 
		<div hidden id="lose-value-${status.index }">${entry.value }</div>
	</c:forEach>
	
		<ul class="nav nav-pills" id="myTab" role="tablist">
		  <li class="nav-item" role="presentation">
		    <a class="nav-link active" id="total-point" data-toggle="tab" href="#total" role="tab" aria-controls="home" aria-selected="true">TOTAL POINT</a>
		  </li>
		  <li class="nav-item" role="presentation">
		    <a class="nav-link" id="earn-point" data-toggle="tab" href="#earn" role="tab" aria-controls="profile" aria-selected="false">얻은 포인트[경향]</a>
		  </li>
		  <li class="nav-item" role="presentation">
		    <a class="nav-link" id="lose-point" data-toggle="tab" href="#lose" role="tab" aria-controls="contact" aria-selected="false">잃은 포인트[경향]</a>
		  </li>
		</ul>
		
		<div class="tab-content" id="myTabContent">
		
		  <div class="tab-pane fade show active" id="total" role="tabpanel" aria-labelledby="home-tab">
		  	<div id="div-1">
				<canvas id="myChart"></canvas>
			</div>
			<div id="total-total">
				
			</div>
		  </div>
		
		  <div class="tab-pane fade" id="earn" role="tabpanel" aria-labelledby="profile-tab">
		  	<div id="div-2">
				<canvas id="myPie1"></canvas>
			</div>
			<div id="plus-total">
				
			</div>
		  </div>
		  
		  <div class="tab-pane fade" id="lose" role="tabpanel" aria-labelledby="contact-tab">
		  	<div id="div-3">
				<canvas id="myPie2"></canvas>
			</div>
			<div id="minus-total">
				
			</div>
		  </div>
		  
		</div>
		
	</div>
</div>


	
	
</div>
</body>
<script>


$(function(){

	
	var showPoint = [];
	var total = 0;
	var plus = 0;
	var minus = 0;
	var arraySize = $("#size").val();
	
	
	for(var i=0; i<arraySize; i++){
		showPoint.push(parseFloat($("#total-value-" + i).text()));
		
	}
	
	for(var i=0; i<showPoint.length; i++){
		total += showPoint[i];
		if(showPoint[i] > 0){
			plus += showPoint[i];
		}else {
			minus += showPoint[i];
		}
	}
	
	$("#total-total").text(total);
	$("#plus-total").text(plus);
	$("#minus-total").text(minus);
	
	totalChart();
	
	
	$("#total-point").click(function(){
		totalChart();

	});
	
	$("#earn-point").click(function(){
		earnChart();

	});
	
	$("#lose-point").click(function(){
		loseChart();

	});
	
	
	
	
	//총 포인트 차트
	function totalChart(){
		
		var pointInOut = [];
		var pointList = [];
		var size = $("#size").val();

		var colorStore = ['rgba(252,12,12,0.2)', 'rgba(252,128,12, 0.2)','rgba(252,228,12,0.2)', 'rgba(88,252,12,0.2)','rgba(12,252,216,0.2)','rgba(12,80,252,0.2)', 'rgba(116,12,252,0.2)', 'rgba(252,12,240,0.2)', 'rgba(252,12,136,0.2)', 'rgba(232,127,7,0.2)', 'rgba(177,253,174,0.2)', 'rgba(85,247,250,0.2)']
		var borderStore = ['rgba(252,12,12,1)', 'rgba(252,128,12, 1)','rgba(252,228,12,1)', 'rgba(88,252,12,1)','rgba(12,252,216,1)','rgba(12,80,252,1)', 'rgba(116,12,252,1)', 'rgba(252,12,240,1)', 'rgba(252,12,136,1)', 'rgba(232,127,7,1)', 'rgba(177,253,174,1)', 'rgba(85,247,250,1)']
		var backgroundColor = [];
		var borderColor= [];
		
		
		
		for(var i=0; i<size; i++){
			pointInOut.push($("#total-key-" + i).text());
			pointList.push($("#total-value-" + i).text());
			backgroundColor.push(colorStore[i]);
			borderColor.push(borderStore[i]);
		}
		console.log(pointInOut);
		console.log(pointList);
		
	
		var ctx = document.getElementById('myChart'); 
		var myChart = new Chart(ctx, { type: 'bar', 
								data: { labels: pointInOut, 
								datasets: [{ label: '# 포인트', 
									data: pointList, 
									backgroundColor: backgroundColor, 
									borderColor: borderColor, 
									borderWidth: 1 }] }, options: { scales: { yAxes: [{ ticks: { beginAtZero: true } }] } } });
	}
	
	//얻은 포인트 차트
	function earnChart(){
		
		var pointInOut = [];
		var pointList = [];

		var size2 = $("#size2").val();

		var colorStore = ['rgba(252,12,12,0.2)', 'rgba(252,128,12, 0.2)','rgba(252,228,12,0.2)', 'rgba(88,252,12,0.2)','rgba(12,252,216,0.2)','rgba(12,80,252,0.2)', 'rgba(116,12,252,0.2)', 'rgba(252,12,240,0.2)', 'rgba(252,12,136,0.2)', 'rgba(232,127,7,0.2)', 'rgba(177,253,174,0.2)', 'rgba(85,247,250,0.2)']
		var borderStore = ['rgba(252,12,12,1)', 'rgba(252,128,12, 1)','rgba(252,228,12,1)', 'rgba(88,252,12,1)','rgba(12,252,216,1)','rgba(12,80,252,1)', 'rgba(116,12,252,1)', 'rgba(252,12,240,1)', 'rgba(252,12,136,1)', 'rgba(232,127,7,1)', 'rgba(177,253,174,1)', 'rgba(85,247,250,1)']
		var backgroundColor = [];
		var borderColor= [];
		
		
		for(var i=0; i<size2; i++){
			pointInOut.push($("#earn-key-" + i).text());
			pointList.push($("#earn-value-" + i).text());
			backgroundColor.push(colorStore[i]);
			borderColor.push(borderStore[i]);
		}
	
		var ctx1 = $("#myPie1");
		var myPie = new Chart(ctx1, {type: 'pie',
			data: {labels: pointInOut,
			  datasets: [{
			    label: 'My First Dataset',
			    data: pointList,
			    backgroundColor: borderColor,
			    hoverOffset: 4
			  }]
			}});
	}
	
	
	//잃은 포인트 차트
	function loseChart(){
		
		var pointInOut = [];
		var pointList = [];

		var size3 = $("#size3").val();
		var colorStore = ['rgba(252,12,12,0.2)', 'rgba(252,128,12, 0.2)','rgba(252,228,12,0.2)', 'rgba(88,252,12,0.2)','rgba(12,252,216,0.2)','rgba(12,80,252,0.2)', 'rgba(116,12,252,0.2)', 'rgba(252,12,240,0.2)', 'rgba(252,12,136,0.2)', 'rgba(232,127,7,0.2)', 'rgba(177,253,174,0.2)', 'rgba(85,247,250,0.2)']
		var borderStore = ['rgba(252,12,12,1)', 'rgba(252,128,12, 1)','rgba(252,228,12,1)', 'rgba(88,252,12,1)','rgba(12,252,216,1)','rgba(12,80,252,1)', 'rgba(116,12,252,1)', 'rgba(252,12,240,1)', 'rgba(252,12,136,1)', 'rgba(232,127,7,1)', 'rgba(177,253,174,1)', 'rgba(85,247,250,1)']
		var backgroundColor = [];
		var borderColor= [];
		
		
		
		for(var i=0; i<size3; i++){
			pointInOut.push($("#lose-key-" + i).text());
			pointList.push($("#lose-value-" + i).text());
			backgroundColor.push(colorStore[i]);
			borderColor.push(borderStore[i]);
		}
		
		var ctx2 = $("#myPie2");
		var myPie = new Chart(ctx2, {type: 'pie',
			data: {labels: pointInOut,
			  datasets: [{
			    label: 'My First Dataset',
			    data: pointList,
			    backgroundColor: borderColor,
			    hoverOffset: 4
			  }]
			}});
		
	}
	
	
});


</script>
</html>