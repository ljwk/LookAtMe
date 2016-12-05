<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
		if(('${id}')!=""){
			alert('EMAIL 인증이 완료되었습니다');
		}
	});
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
	
	function change(){
		if(confirm("비밀번호를 변경하시겠습니까?")){			
			var jsonObj = {};

			jsonObj.id = '${id}';			
			jsonObj.pwd = $('[name=pwd]').val();		

			$.ajax({
				url : 'change',
				data : jsonObj,
				type : 'post',
				dataType : 'json',
				success : function(res) {
					if(res.success){
						alert('비밀번호변경 완료');
						location.href="login";
					}else{
						alert('실패');
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
	<h3 style="margin-right: 480px; font:bold 32px none;">${id}님의 비밀번호 변경 페이지입니다.</h3>
	<hr style="width: 600px; border:1px solid lightgray; margin-bottom:50px;">
	<div id="content" class="panel panel-default">	
		<div class="panel-heading">변경하실 비밀번호를 입력해주세요.</div>
		<table>
			<tr><th>PWD</th><td><input type="password" name="pwd"></td></tr>
		</table>	
	</div>	
	<br>
	<button onclick="change();" class="btn btn-default" >변경</button>	 
	<div id="footer"></div>
</body>
</html>