<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
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
	
	function findId(){
		location.href="findID";
	}
	
	function findPwd(){
		location.href="findPWD";
	}
</script>
<style type="text/css">
	body {text-align: center;}
	#navdiv {height:100px;}
	body {text-align: center;}
	.panel-heading{background: rgb(252, 252, 252);}
	table {border-spacing: 0px; margin: 0px auto ;}
	th, td {padding: 5px;}
	th {text-align: center;}
	td {text-align: left;}
	input{width: 100%;}
	#content {width: 450px; margin: 0px auto;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no {position: relative; display: block; padding: 12px 15px;}

</style>
</head>
<body>
	<div id="navdiv"></div>
	<h3 style="margin-right: 510px; font:bold 32px none;">로그인</h3>
	<hr style="width: 600px; border:1px solid lightgray; margin-bottom:50px;">
	<c:if test="${not empty param.error}">
		<span id="errMsg">오류: ${SPRING_SECURITY_LAST_EXCEPTION.message}</span>
	</c:if>
	<h4 style="margin-bottom: 20px">Look Out에 오신 것을 환영합니다.</h4>
	<form action="<c:url value='/user/login'/>" method="post">
	
	<div id="content" class="panel panel-default">
	 <div class="panel-heading">로그인</div>
		<table class="table" id="tablee">
			<tr><th>ID</th><td><input type="text" name="id" value="SH"></td><td rowspan="2"><button class="btn btn-default" type="submit" style="padding: 25px;">로그인</button></td></tr>
			<tr><th>PASSWORD</th><td><input type="password" name="pwd" value="1111"></td></tr>
					
		</table>
	  </div>
		 </form>
		 <br>
		<button class="btn btn-default" onclick="findId();">ID 찾기</button>
	 	<button class="btn btn-default" onclick="findPwd();">PASSWORD 찾기</button>

	<div id="footarea">
	<div id="footer"></div>
	</div>
</body>
</html>