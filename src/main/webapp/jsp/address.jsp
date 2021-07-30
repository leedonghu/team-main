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
	<input id="post" type="text" readonly>
	<button id="button">coin</button>
	<button id="button2">coin2</button>
</div>
<script>
$(function(){
	$("#post").click(function(){
		
    	new daum.Postcode({
        	oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            
            var roadAdd = data.roadAddress;
            $("#post").val(roadAdd);
    	    }
	    }).open();
	});
	
	$("#button").click(function(){
		$.ajax({
			type:"get",
			url:"https://api.bithumb.com/public/ticker/all",
			success:function(data){
				console.log(data);
			},
			error:function(){
				console.log("실패");
			}
		});
	});
	
	$("#button2").click(function(){
		$.ajax({
			type:"get",
			url:"https://sandbox-apigw.koscom.co.kr/v2/market/stocks/kospi",
			success:function(data){
				console.log(data);
			},
			error:function(){
				console.log("실패");
			}
		});
	});
});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>