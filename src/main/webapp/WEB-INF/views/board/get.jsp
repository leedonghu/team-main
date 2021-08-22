<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pr" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>

<script>
$(function(){
	//삭제버튼 눌렀을 때
	var removeUrl = "${appRoot}/board/remove";
	$("#board-remove-btn1").click(function(){
		if(confirm("삭제 하시겠습니까?")){
			$("#modify-form1").attr("action", removeUrl);
			$("#modify-form1").submit();
		}
	});
	
	var userId = "${pinfo.member.userId}";
	var writer = "${board.writer}";
	
	if(userId == writer){
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
	}

	
});
</script>

</head>
<body>
<div class="container">
<pr:navbar></pr:navbar>
<div class="row">
	<!--       왼쪽 nav          -->
	
	<div class="col-2">	
		<nav class="nav flex-column">
		<br>
  			<a class="nav-link active" href="${appRoot }/board/list">글 목록</a>
  			<a class="nav-link" href="${appRoot }/board/register">글 쓰기</a>

		</nav>
	</div>
	
	<div class="col-10">
		<h3>글 보기</h3>
		<form id="modify-form1" action="${appRoot }/board/modify" method="post">
	         <div class="form-group">
	         	<label for="input1">제목</label>         
	            <input class="form-control" id="input1" name="title" value="${board.title }" readonly="readonly">
	         </div>
	         <div class="form-group">
	         	<label for="textarea1">내용</label>         
	            <textarea id="textarea1" class="form-control" name="content" readonly="readonly"><c:out value="${board.content }"></c:out></textarea>
	         </div>

	         
	         <div class="form-group">
	            <label for="input2">작성자</label>
	         	<input name="writer" class="form-control" id="input2" value="${board.writer }" readonly="readonly">
	         	
	         </div>
	        
	         <input hidden name="pageNum" value="${cri.pageNum }"/>
	         <input hidden name="amount" value="${cri.amount }"/>
	         <input hidden name="type" value="${cri.type }"/>
	         <input hidden name="keyword" value="${cri.keyword }"/>
	         <input hidden name="bno" value="${board.bno }"/>
	        
	        <c:if test="${pinfo.member.userId eq board.writer }">
		        <input type="submit" value="수정" class="btn btn-warning" />
	         	<input id="board-remove-btn1" type="button" value="삭제" class="btn btn-danger"/>
	        </c:if>
	        
	      </form>
	      <br>
	      <hr>
	      <!-- 댓글 달리는 곳 -->
	      <div class="container">
			<div class="row">
				<div class="col-12">
					<h5>댓글</h5>
					<sec:authorize access="isAuthenticated()">
						<div class="input-group mb-3">
  							<input id="reply-register-input1" name="content" type="text" class="form-control" placeholder="댓글" aria-label="Recipient's username" aria-describedby="button-addon2">
  							<div class="input-group-append">
    						<button class="btn btn-outline-secondary" type="button" id="reply-register-button1">댓글 작성</button>
  							</div>
  							<input hidden name="replyer" value="${pinfo.member.userId }" id="reply-register-input2">
  							<input hidden name="bno" value="${board.bno }" id="reply-register-input3">
						</div>
					</sec:authorize>
					<ul class="list-unstyled" id="reply-list-container">
			
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 댓글 스크립트 -->

 <script>
 /* 댓글 입력 버튼 처리 */
 $(function(){
	 var state = 1;
	$("#reply-register-button1").click(function() {
		var content = $("#reply-register-input1").val();
		var replyer = $("#reply-register-input2").val();
		var bno = $("#reply-register-input3").val();
		
		var data = {
			bno: bno,
			replyer: replyer,
			content: content
		};
		
		$.ajax({
			type: "post",
			url: "${appRoot}/reply/register",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				console.log("입력 성공");
				
				// 댓글리스트 가져오고
				getReplyList();
				
				
			},
			error: function() {
				console.log("입력 실패");
			}
		});
	});
	
	function getReplyList(){
		$.ajax({
			type: "get",
			url:  "${appRoot}/reply/list/${board.bno}",
			success: function(list){
				console.log(list);
				showReplyList(list);
			},
			error: function(){
				console.log("댓글 가져오기 실패");
			}
		});
	}
	
	function showReplyList(list) {
		var container = $("#reply-list-container").empty();
		var userId = "${pinfo.member.userId}";
		
		
		for (var reply of list) {
			var replyHTML = `
				<li class="media"  id="reply\${reply.rno}" data-rno="\${reply.rno}">
					<div class="media-body">
						<div class="my-4 replyer">
							<span>\${reply.replyer}</span>
							<span>(\${reply.replyerName})</span>
						</div>
						<div class="reply">
							<span>\${reply.content}<span>
						</div>
						<div class="date">
							<small>\${reply.replyDate}</small>
						</div>
						<div class="tool">
							<span><a class="reply-reply-write" href="#">답글</a></span>
							<div>
								<a href="#" class="reply-good"><i class="fas fa-thumbs-up"></i></a><span>\${reply.good}</span>
								<a href="#" class="reply-bad"><i class="fas fa-thumbs-down"></i></a><span>\${reply.bad}</span>
							</div>
						</div>
					</div>
				</li>
				<hr>
				
				<div hidden id="reply-reply-input\${reply.rno}">
				<ul class="list-unstyled" id="reply-reply-list-container\${reply.rno}">
				
				</ul>
					
					<div class="input-group mb-3">
						<input id="reply-reply-register-input1\${reply.rno}" name="content" type="text" class="form-control" placeholder="댓글" aria-label="Recipient's username" aria-describedby="button-addon2">
						<div class="input-group-append">
							<button class="btn btn-outline-secondary reply-reply-register-button1" type="button" data-rno="\${reply.rno}">댓글 작성</button>
						</div>
						<input hidden name="r_replyer" value="\${userId }" id="reply-reply-register-input2\${reply.rno}">
						
					</div>
					
				</div>`;

			container.append(replyHTML);
		}
	}
	/* 클릭한 버튼이 어떤 버튼인지 this로 명시해줌*/
	$("#reply-list-container").on("click", ".reply-good", function(e){good(e, this);});
	
	$("#reply-list-container").on("click", ".reply-bad", function(e){bad(e, this);});

	
	/* 댓글 리스트 보여주기*/
	getReplyList();
	
	//good, bad 버튼
	//this로 받은 값을 넣어줌(elem)
	function good(e, elem){
		e.preventDefault();
		
		var rno = $(elem).closest("li").attr("data-rno");
		
		
		console.log("버튼 클릭");
		
		
		$.ajax({
			type: "post",
			url:"${appRoot}/reply/good/" + rno,
			success: function(){
				console.log("수정 성공");
				getReplyList();
			},
			error: function(){
				console.log("수정 실패")
			}
		});
	}
	
	function bad(e, elem){
		e.preventDefault();
		var rno = $(elem).closest("li").attr("data-rno");
		
		console.log("버튼 클릭");
		console.log(rno);
		
		$.ajax({
			type: "post",
			url:"${appRoot}/reply/bad/" + rno,
			success: function(){
				console.log("수정 성공");
				getReplyList();
			},
			error: function(){
				console.log("수정 실패")
			}
		});
	}
	
	//대댓글  관련 스크립트
	
	//답글 눌렀을때
	$("#reply-list-container").on("click", ".reply-reply-write", function(e){showInput(e, this);});
	
	function showInput(e, elem){
		e.preventDefault();
		
		
		var rno = $(elem).closest("li").attr("data-rno");
		
		if(state == 1){
			
			$("#reply-reply-input" + rno).removeAttr("hidden");
			getReply_ReplyList(rno);
			state = 0;
			console.log(state);
		}else{
			$("#reply-reply-input" + rno).attr("hidden", "hidden");
			state = 1;
			console.log(state);
		}
	}
	
	//대댓글 입력
	$("#reply-list-container").on("click", ".reply-reply-register-button1", function(e) {register(e, this)});
		
	function register(e, elem){
		e.preventDefault();
		var rno = $(elem).attr("data-rno");
		var r_content = $("#reply-reply-register-input1" + rno).val();
		var r_replyer = $("#reply-reply-register-input2" + rno).val();
		
		var data = {
			rno: rno,
			r_replyer: r_replyer,
			r_content: r_content
		};
		
		$.ajax({
			type: "post",
			url: "${appRoot}/reply/reply-register",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				console.log("입력 성공");
				
				// 댓글리스트 가져오고
				getReply_ReplyList(rno);
				
				
			},
			error: function() {
				console.log("입력 실패");
			}
		});
	}
	
	
	//대댓글 가져오기
	function getReply_ReplyList(rno){
		$.ajax({
			type: "get",
			url:  "${appRoot}/reply/list-list/" + rno,
			success: function(list){
				console.log(list);
				showReplyList_List(list, rno);
			},
			error: function(){
				console.log("댓글 가져오기 실패");
			}
		});
	}
	
	function showReplyList_List(list, rno) {
		 
		var container = $("#reply-reply-list-container" + rno).empty();
		
		for (var reply of list) {
			var reply_replyHTML = `
				<li class="media"  id="reply-reply\${reply.r_rno}" data-rno="\${reply.r_rno}">
					<div class="media-body">
						<div class="my-4 replyer">
							<span>&nbsp&nbsp&nbsp</span>
							<span>L<span>
							<span>\${reply.r_replyer}</span>
							<span>(\${reply.r_replyer})</span>
						</div>
						<div class="reply">
							<span>&nbsp&nbsp&nbsp</span>
							<span>\${reply.r_content}<span>
						</div>
						<div class="date">
							<span>&nbsp&nbsp&nbsp</span>
							<small>\${reply.r_replyDate}</small>
						</div>
					</div>
				</li>
			<hr>`;
			
			container.append(reply_replyHTML);
		}
	}	
	
 });
 </script>
</body>
</html>