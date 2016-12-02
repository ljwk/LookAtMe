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
	});
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
	
	function modi(){
		if(confirm('정보를 수정하시겠습니까?')){
 			var jsonObj = 	$('#modiInfo').serialize(); 

 			$.ajax({
				url : 'modi',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
				 	if(res.success){
			 			alert('수정 성공');	
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
	#navdiv {height:130px;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no {position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
	<div id="navdiv"></div>
	<h3>My Page</h3>
	<form id="modiInfo">
		<input type="hidden" name="id" value="${info.id}">
		<table>
			<tr><th>id</th><td>${info.id}</td></tr>
			<tr><th>비밀번호</th><td><input type="password" name="pwd"></td></tr>
			<tr><th>email</th><td><input type="text" value="${info.email}" name="email"></td></tr>
		</table>			
		<button type="button" onclick="modi();">정보 수정</button>
	</form>	
	<br><br>
	<button onclick="drop();">회원탈퇴</button>
</body>
</html>