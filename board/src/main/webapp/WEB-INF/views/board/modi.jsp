<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
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
	
	function modiboard() {
		if(confirm('글을 수정하시겠습니까?')){
 			var jsonObj = $('#modiboard').serialize();

 			$.ajax({
				url : 'modisave',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
				 	if(res.success){
			 			alert('수정 성공');	
			 			location.href='desc?num='+${num};
					} 
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			}); 
		} 
	}
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	#navdiv {height:100px;}
	table {border-spacing: 0px;	margin: 0px auto; width: 800px;}
	th, td {padding: 5px;}
	th {width: 100px;border-bottom:1px solid lightgray;background: rgb(252, 252, 252); text-align: center;}
	td {border-bottom:1px solid lightgray;text-align: left;}
	#content {width: 800px; margin: 0px auto;}
	textarea{resize: none;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no {position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
	<div id="navdiv"></div>
	<h3 style="margin-right: 730px; font:bold 32px none;">수정</h3>
	<hr style="width: 800px; border:1px solid lightgray; margin-bottom:50px;">
	
	<form id="modiboard" action="boardDesc.jsp">
	<div id="content" class="panel panel-default">
		<input type="hidden" name="num"  value="${num}">
		<table>
			<tr id="bb">
				<th>제목</th><td><input type="text" id="title" name="title" maxlength="40" size="90%"></td>
			</tr>
			<tr id="aa">
				<th>내용</th><td><textarea id="contents" name="contents" rows="15" cols="92%" maxlength="400"></textarea></td>
			</tr>			
		</table>
		</div>
	</form>
	<br>
	<button type="button" class="btn btn-default" onclick="modiboard();">수 정</button>
	<a href="desc?num=${num}"><button type="button" class="btn btn-default">취 소</button></a>	
	<div id="footer"></div>
</body>
</html>