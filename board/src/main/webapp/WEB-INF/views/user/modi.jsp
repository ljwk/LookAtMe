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
	
	function modiForm(){
		var jsonObj = 	$('#modiForm').serialize(); 

 		$.ajax({
			url : 'modiLogin',
			data : jsonObj,
			type : 'post',
			dataType : 'json',
			success : function(res) {
			 	if(res.success){
					location.href="modiForm?id=<sec:authentication property="name"/>";
				} else{
					alert('비밀번호를 확인해주세요')
				}
			},
			error : function(xhr, status, error) {
				alert(error);
			}
		}); 		
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
	<h3>회원정보 확인</h3>
	<sec:authentication property="name"/>님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.
	<form id="modiForm">
		<input type="hidden" name="id" value="<sec:authentication property="name"/>">
		<table>		
			<tr><th>ID</th><td><sec:authentication property="name"/></td></tr>
			<tr><th>비밀번호</th><td><input type="password" name="pwd"></td></tr>
		</table>
	</form>
	<button onclick="modiForm();">확인</button>
</body>
</html>