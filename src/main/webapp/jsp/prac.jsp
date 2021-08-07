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
<input type="number" value="60" id="number">

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
		
		var num = $("#number").val();
		$("#numberbtn").click(function(){
			console.log("뺴1");
			if(num != 0){
				console.log("뺴2");
			minusNum();
			}
		});
		function minusNum(){
			console.log("뺴");
			num = num - 1;
			setTimeout(function(){minusNum();}, 1000);

		}
		
	})
</script>
</body>
</html>