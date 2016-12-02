<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글</title>
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
	
	function reboard() {
		if(confirm('답글을 등록하시겠습니까?')){
 			var jsonObj = $('#reForm').serialize();

 			$.ajax({
				url : 'reple',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
					if(res.success){
			 			alert('추가 성공');	
			 			location.href='desc?num='+res.num;
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
	table {border: 1px solid black; border-spacing: 0px; margin: 0px auto ; width: 500px;}
	th, td {padding: 5px;}
	th {border: 1px solid black; text-align: center; background: rgb(176, 187, 190);}
	td {border: 1px solid black;}
	#aa {height: 420px;}
	#bb {height: 50px;}
	#contents {width: 400px; height: 400px;}
	#title {width: 400px;}
	#navdiv {height:130px;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no{position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
<div id="navdiv">
</div>
	<form id="reForm" action="boardDesc.jsp">
		<fieldset>
		<legend>답글</legend>
		<input type="hidden" name="ref"  value="${ref}">
		<input type="hidden" name="id" value="<sec:authentication property="name"/>">
		<table>
			<tr id="bb">
				<th>제목</th><td><input type="text" id="title" name="title"></td>
			</tr>
			<tr id="aa">
				<th>내용</th><td><textarea id="contents" name="contents"></textarea></td>
			</tr>			
		</table>
		</fieldset>
	</form>
	<br><br><br>
	<button type="button" class="btn btn-default" onclick="reboard();">저 장</button>
	<a href="desc?num=${ref}"><button type="button" class="btn btn-default">취 소</button></a>	
	<div id="footer"></div>
</body>
</html>