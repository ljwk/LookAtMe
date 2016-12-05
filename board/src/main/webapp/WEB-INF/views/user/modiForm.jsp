<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<script src="//code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
	$(function(){
	    $("#navdiv").load("../resources/nav.jsp");
	    $("#footer").load("../resources/footer.jsp");
	});
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
	
	function pwdModi(){
		if(confirm("정말로 비밀번호를 수정 하시겠습니까?")){			
			var jsonObj = {};
			jsonObj.id = '${info.id}';
			jsonObj.pwd =  $('[name=pwd]').val();
			
			$.ajax({
				url : 'pwdModi',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
				 	if(res.success){
			 			alert('비번 수정 성공');
			 			location.href="info?id=<sec:authentication property="name"/>";
					} 
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			}); 					
		}
	}
	     
	function emailModi(){
		if(confirm("정말로 이메일을 수정 하시겠습니까?")){			
			var jsonObj = {};
			jsonObj.id = '${info.id}';
			jsonObj.email =  $('[name=email]').val();
			 
			$.ajax({
				url : 'emailModi',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
				 	if(res.success){
			 			alert('이메일 수정 성공');
			 			location.href="info?id=<sec:authentication property="name"/>";
					} 
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			}); 					
		}
	}
	
	function drop(){
		if(confirm("정말로 회원탈퇴를 하시겠습니까?")){			
			var jsonObj = {};
			jsonObj.id = '${info.id}';
			
			$.ajax({
				url : 'drop',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
				 	if(res.success){
			 			alert('탈퇴 성공');
			 			location.href="<c:url value='/logout' />";
					} 
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			}); 					
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	#navdiv {height:100px;}
	.panel-heading{background: rgb(252, 252, 252);}
	table {border-spacing: 0px;	margin: 0px auto;}
	th, td {padding: 5px;}
	th {width: 100px;border-bottom:1px solid lightgray;background: rgb(252, 252, 252); text-align: center;}
	td {border-bottom:1px solid lightgray;text-align: left;}
	#content {width: 450px; margin: 0px auto;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no {position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
	<div id="navdiv"></div>
	<h3 style="margin-right: 410px; font:bold 32px none;">회원정보 확인</h3>
	<hr style="width: 600px; border:1px solid lightgray; margin-bottom:50px;">
	<div id="content" class="panel panel-default">	
		<div class="panel-heading">회원가입시 입력하신 email을 입력해주세요!</div>		 	
		<table class="table">
			<tr><th>ID</th><td>${info.id}</td></tr>
			<tr><th>비밀번호</th><td><input type="password" name="pwd">&nbsp; <button onclick="pwdModi(); " class="btn btn-default" >수정</button></td></tr>
			<tr><th>이메일</th><td><input type="text" value="${info.email}" name="email">&nbsp; <button onclick="emailModi();" class="btn btn-default" >수정</button></td></tr>			
		</table>
	</div>	
	<br>
	<button onclick="drop();" class="btn btn-default" >회원탈퇴</button>
	<a href="info?id=${info.id}"><button class="btn btn-default" >나가기</button></a>
	
	<div id="footarea">
	<div id="footer"></div>
	</div>
</body>
</html>