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
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script type="text/javascript">
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
form { width: 300px; }
#abc { text-align: center; width: 400px; margin: 0px auto; }
body { text-align: center; }
</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="alert alert-info">
			<div class="navbar-header">
				<a class="navbar-brand" href="/board/index.jsp">Main</a>
			</div>
		
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
				<sec:authorize access="! isAuthenticated()">	      	
					<li><a href="/board/home/join">Join</a></li>
					<li><a href="/board/home/login">Login</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li><a href="javascript:logout();">Logout</a></li>
				</sec:authorize>		        
					<li><a href="/board/home/main">Board</a></li>
				</ul>
			</div>	    
		</div>
	</nav>
	<br><br><br><br><br><br><br>
	<c:if test="${not empty param.error}">
		<span id="errMsg">오류: ${SPRING_SECURITY_LAST_EXCEPTION.message}</span>
	</c:if>
	
	<div class="panel panel-primary" id="abc">
	  <div class="panel-heading">Login</div>
	  <div class="panel-body">
		<form action="<c:url value='/user/login'/>" method="post">
			<div>
				아이디 <input type="text" name="id">
			</div>
			<br>
			<div>
				암 호 <input type="password" name="pwd">
			</div>
			<br>
			<div>
				<button type="submit" class="btn btn-default btn-lg">
  					<span class="glyphicon glyphicon-saved" aria-hidden="true"></span> 로그인
				</button>
			</div>
		</form>	    
	  </div>
	</div>	
</body>
</html>