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

	<button id="btn-1">1번차트</button>
	<button id="btn-2">2번차트</button>
	<button id="btn-3">3번차트</button>

	<div id="div-1">
	<canvas id="myChart"></canvas>
	</div>
	
	<div id="div-2">
	<canvas id="myPie1"></canvas>
	</div>
	
	<div id="div-3">
	<canvas id="myPie2"></canvas>
	</div>
	
		<!-- 전체 포인트 정보 -->
	<input hidden value="${size }" id="size">
	<c:forEach items="${point.pointMap }" var="entry" varStatus="status">
		<div hidden id="hole-key-${status.index }">${entry.key }</div> 
		<div hidden id="hole-value-${status.index }">${entry.value }</div> <br>
	</c:forEach>
	
	<!-- 얻은 포인트 정보 -->
	<input hidden value="${size2 }" id="size2">
	<c:forEach items="${earn.pointMap }" var="entry" varStatus="status">
		<div hidden id="earn-key-${status.index }">${entry.key }</div> 
		<div hidden id="earn-value-${status.index }">${entry.value }</div> <br>
	</c:forEach>
	
		<!-- 잃은 포인트 정보 -->
	<input hidden value="${size3 }" id="size3">
	<c:forEach items="${lose.pointMap }" var="entry" varStatus="status">
		<div hidden id="lose-key-${status.index }">${entry.key }</div> 
		<div hidden id="lose-value-${status.index }">${entry.value }</div> <br>
	</c:forEach>
</div>
</body>
<script>


$(function(){

	
	
	$("#btn-1").click(function(){
		holeChart();

	});
	
	$("#btn-2").click(function(){
		earnChart();

	});
	
	$("#btn-3").click(function(){
		loseChart();

	});
	
	
	
	
	//총 포인트 차트
	function holeChart(){
		
		var pointInOut = [];
		var pointList = [];
		var size = $("#size").val();

		var colorStore = ['rgba(252,12,12,0.2)', 'rgba(252,128,12, 0.2)','rgba(252,228,12,0.2)', 'rgba(88,252,12,0.2)','rgba(12,252,216,0.2)','rgba(12,80,252,0.2)', 'rgba(116,12,252,0.2)', 'rgba(252,12,240,0.2)', 'rgba(252,12,136,0.2)', 'rgba(232,127,7,0.2)', 'rgba(177,253,174,0.2)', 'rgba(85,247,250,0.2)']
		var borderStore = ['rgba(252,12,12,1)', 'rgba(252,128,12, 1)','rgba(252,228,12,1)', 'rgba(88,252,12,1)','rgba(12,252,216,1)','rgba(12,80,252,1)', 'rgba(116,12,252,1)', 'rgba(252,12,240,1)', 'rgba(252,12,136,1)', 'rgba(232,127,7,1)', 'rgba(177,253,174,1)', 'rgba(85,247,250,1)']
		var backgroundColor = [];
		var borderColor= [];
		
		
		
		for(var i=0; i<size; i++){
			pointInOut.push($("#hole-key-" + i).text());
			pointList.push($("#hole-value-" + i).text());
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