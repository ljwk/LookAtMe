<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일보내기</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
	$(function(){
		$("#footer").load("../resources/footer.jsp");
	    $("#navdiv").load("../resources/nav.jsp");
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
	#navdiv {height:130px;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: black; text-decoration: none;}
</style>
</head>
<body>
<div id="navdiv">
</div>
	<form action="/board/user/send" method="post">
		<fieldset>
		<legend>글쓴이에게 메일보내기</legend>
		<input type="hidden" name="receiver1" value="${email}">
		<table>
			<tr>
				<th>보내는사람</th><td><input type="text" id="send" name="send"></td>
			</tr>	
			<tr id="bb">
				<th>제목</th><td><input type="text" id="title" name="title"></td>
			</tr>
			<tr id="aa">
				<th>내용</th><td><textarea id="contents" name="contents"></textarea></td>
			</tr>		
		</table>
		</fieldset>
		<br><br>
		<button type="submit" class="btn btn-default">보내기</button>
	</form>
	<div id="footer"></div>
</body>
</html>