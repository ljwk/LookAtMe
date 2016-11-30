<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script src="//code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var options = { 
			success: function(res){
				if(res.success){
					alert('추가 성공');
					location.href='desc?num='+res.num;
				}
			},
			error: function(){
				alert('실패');
			}
		}; 	
		$("#saveForm").ajaxForm(options);	
	});		
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	table {border: 1px solid black; border-spacing: 0px; margin: 0px auto ; width: 500px;}
	th, td {padding: 5px;}
	th {border: 1px solid black; text-align: center; background: rgb(176, 187, 190);}
	td {border: 1px solid black;}
	#aa {height: 420px;}
	#bb {height: 50px;}
	#contents{width: 400px; height: 400px;}
	#title{width: 400px;}
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
				<sec:authorize access="isAuthenticated()">
					<li><a href="<c:url value='/cctv/list' />">CCTV</a></li>
				</sec:authorize>						
				</ul>
			</div>	    
		</div>
	</nav>
	<br><br><br><br><br><br><br>
	<form id="saveForm" method="post" action="save" enctype="multipart/form-data">
		<fieldset>
		<legend>글 쓰 기</legend>
		<input type="hidden" name="id" value="${id}">
		<table>
			<tr id="bb">
				<th>제목</th><td><input type="text" id="title" name="title"></td>
			</tr>
			<tr id="aa">
				<th>내용</th><td><textarea id="contents" name="contents"></textarea></td>
			</tr>		
			<tr>
				<th>첨부</th><td><input type="file" name="file"></td>
			</tr>	
		</table>
		<br><br><br>
		<button type="submit" class="btn btn-default">저 장</button>
		<a href="main"><button type="button" class="btn btn-default">취 소</button></a>
		</fieldset>
	</form>
</body>
</html>