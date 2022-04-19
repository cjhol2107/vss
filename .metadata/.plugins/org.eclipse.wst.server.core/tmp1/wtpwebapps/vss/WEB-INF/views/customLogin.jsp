<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link href='http://www.openhiun.com/hangul/nanumbarungothic.css'
	rel='stylesheet' type='text/css'>

<title>VNTG Skill Sharing - LOGIN1</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<style type="text/css">
.label {
	font-family: 'Nanum Barun Gothic', sans-serif;
}
</style>

</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="loginLogo">
					<img src="/resources/img/VSS_logo.png" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-4" style="margin-top: -30px;">
				<div class="login-panel panel panel-default">
					<div class="panel-body">  
						<form role="form" method='post' action="/login">
							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="아이디를 입력해주세요."
										name="username" type="text" autofocus>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="비밀번호를 입력해주세요."
										name="password" type="password" value="">
								</div>
								<div class="checkbox">
									<label> <input name="remember-me" type="checkbox">
										아이디저장
									</label>
								</div>
								<!-- Change this to a button or input when using this as a form -->
								<a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>



<!-- jQuery -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/resources/dist/js/sb-admin-2.js"></script>

<c:if test="${error != null}">
	<script>
		$(document).ready(function() {
			alert("로그인에 실패했습니다.");
		});
	</script>
</c:if>

<script>
	$(".btn-success").on("click", function(e) {
	
		e.preventDefault();
		$("form").submit();
	
	});
</script>

<c:if test="${param.logout != null}">
	<script>
		$(document).ready(function() {
			alert("로그아웃하였습니다.");
		});
	</script>
</c:if>

</body>

</html>
