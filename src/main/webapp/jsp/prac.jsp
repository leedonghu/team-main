<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<button id="btn1">버튼</button>
	<iframe src="https://coinone.co.kr/exchange/trade/btc/krw" width="450" height="350" scrolling="auto"></iframe>
</div>

<button id="numberbtn" type="button">버튼1</button>
<input type="text" value="60" id="number">
<input type="text" id="space">
<input type="text" id="score">

<script>
	$(function(){
		$("#btn1").click(function(){
			$.ajax({
				type:"get",
				url:'https://api.upbit.com/v1/ticker?markets=KRW-BTC',
				header: 'Accept: application/json',
				success:function(data){
					console.log("성공");
					console.log(data);
					
					
					
				},
				error:function(){
					console.log("실패");
				}
			});
		});
		
		var num = parseInt($("#number").val());
		$("#numberbtn").click(function(){
			console.log("뺴1");
			$("#spcae").focus();
			
			let score = 0;
			$("#space").change(function(){
				score = score + 1 ;
				$("#score").val(score);
			});
			var countdown =	setInterval(function(){
				num = num-1;
				$("#number").val(num);
				if(num == 0){
					//setInterval 종료시킴
					clearInterval(countdown);
				}
			}, 1000);
		});

		
	})
</script>
</body>
</html>