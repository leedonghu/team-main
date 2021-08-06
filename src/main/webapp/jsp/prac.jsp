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
					
					$.ajax
					
				},
				error:function(){
					console.log("실패");
				}
			});
		});
	})
</script>
</body>
</html>