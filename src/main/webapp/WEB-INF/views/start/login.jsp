<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<div class="container">
	
	 <!-- 바탕에 구름 그림 삽입-->
		<div class="d-flex justify-content-center mt-3">
			<img src="<%=request.getContextPath() %>/resources/img/구름.png" alt=".">
		</div>


        <!-- 모달을 이용해서 로그인 -->
		<div class="d-flex justify-content-center mt-3">
			<button type="button" class="btn btn-primary btn-lg"
				data-toggle="modal" data-target="#exampleModal">로그인</button>
		</div>

		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"
							style="text-align: center;">Login</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<form action="<%=request.getContextPath() %>/login" method="post">
						<div class="form-group row">
							<div class="col-3"></div>
							<div class="col">
								<label for="id" class="col-form-label">아이디:</label> <input
									type="text" class="form-control" id="id" size="40" name="id">
							</div>
							<div class="col-3"></div>
						</div>
						<div class="form-group row">
							<div class="col-3"></div>
							<div class="col">
								<label for="password" class="col-form-label">비밀번호:</label> <input
									type="password" class="form-control" id="password" size="40"
									name="password"></input>
							</div>
							<dlv class="col-3"></dlv>
						</div>
						<div class="row">
							<div class="col"></div>
							<div class="col-3">
							<!-- 버튼을 누르면 회원가입 페이지로 이동 -->
								<button type="submit" class="btn btn-primary">확인</button>
								<button type="button" class="btn btn-secondary"
									onclick="location.href='${appRoot}/start/acc'">회원가입</button>
							</div>
							<div class="col"></div>
						</div>
					</form>


				</div>
			</div>
		</div>
	
</div>
</body>
</html>