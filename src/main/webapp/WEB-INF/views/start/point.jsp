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
	<input id="input" value="${a }">
	
	<c:forEach items="${inout }" var="inout" varStatus="status">
		<input  value="${inout }" id="${status.index }" >
	</c:forEach>
	
	<c:forEach items="${point.pointList }" var="list">
		<input value="${list }">
	</c:forEach>
	
	<c:forEach items="${point.pointMap }" var="entry">
		${entry.key } :${entry.value } <br>
	</c:forEach>

	
	<div>${point.userId }</div>
	<div>${point.regdate }</div>
	<div id="point">${member.point }</div>
	<div>
	<canvas id="myChart"></canvas>
	</div>
</div>
</body>
<script>

var ctx = document.getElementById('myChart'); 
var myChart = new Chart(ctx, { type: 'bar', 
						data: { labels: ['Re', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'], 
						datasets: [{ label: '# of Vote', 
							data: [50, 19, 3, 5, 2, -3], 
							backgroundColor: [ 'rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)', 'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)', 'rgba(255, 159, 64, 0.2)' ], 
							borderColor: [ 'rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)' ], 
							borderWidth: 1 }] }, options: { scales: { yAxes: [{ ticks: { beginAtZero: true } }] } } });

$(function(){
	$("#point").click(function(){
		console.log(point);
	});
	
	var pointList = ${point.pointList};
	console.log(pointList);
	
//	var pointInOut = ${point.pointInOut};

	//console.log(pointInOut);
	
	var a = ${a};
	console.log(a);
	var b = '${b}';
	console.log(b);
	var point = [];
	var inout = ${inout};
	console.log(inout);
	

	
	for(var i=0; i<pointList.length; i++){
		point.push(pointList[i]);
		console.log(pointList[i]);
		inout.push($("#" + i).val());
		
	}
	console.log(point);
	console.log(inout);

});


</script>
</html>