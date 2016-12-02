<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
	var oldId = "";
	
	$(function() {
		$("#navdiv").load("../resources/nav.jsp");
		$('#JOIN').attr('disabled',true);
		$('#ID').attr('disabled',true);
		$('#PWD').attr('disabled',true);
		$('#ICHK').attr('disabled',true);
		if(('${email}')!=""){
			alert('EMAIL 인증이 완료되었습니다');
			$('#ID').attr('disabled',false);
			$('#PWD').attr('disabled',false);
			$('#ICHK').attr('disabled',false);
			$('#CHK').attr('disabled',true);
		}
	});

	function join(){
		var dateObj = {};
		dateObj.id=$('[name=id]').val();
		dateObj.pwd=$('[name=pwd]').val();
		dateObj.email=$('[name=email]').val();
				
		if(dateObj.id=="" || dateObj.pwd=="" || dateObj.email==""){
			alert('모든항목을 입력해주세요');
			return;
		}	
			
		if(!(oldId==dateObj.id)){
			alert('중복확인 완료한 아이디로 가입해주세요.');
			return;
		}
		$.ajax({
			url : '/board/user/join' , 
			data : dateObj,
			type : 'post',
			dataType : 'json', 
			success : function(res) {
				if(res.success){
					alert('회원가입 성공');
					location.href='/board/user/login';
				}else{
					alert('회원가입 실패');
				}
			}, 
			error(xhr, status, error){
				alert(error);
			} 
		}); 
	}
	
	function chkId(){
		var dateObj = {};
		dateObj.id=$('[name=id]').val();
			 
		$.ajax({
			url : '/board/user/chk' , 
			data : dateObj,
			type : 'post',
			dataType : 'json', 
			success : function(res) {
				if(res.success){
					alert('회원가입이 가능합니다.');
					$('#JOIN').attr('disabled',false);
					oldId = dateObj.id
				}else{
					alert('중복된 아이디입니다.');
				}
			}, 
			error(xhr, status, error){
				alert(error);
			}  
		}); 
	}
	
	function chk(){
		var jsonObj = {};
		jsonObj.email = $('[name=email]').val();
		
		$.ajax({
			url : '/board/user/chkResult' ,
			type : 'post',
			data : jsonObj, 
			dataType : 'json',  
			success : function(jsObj) {	
 				if(jsObj.result){
 					alert('메일이 전송되었습니다. 남은 가입단계를 메일에서 진행해주세요.');
 				}else{
 					alert('메일 전송에 실패했습니다.');
 				}
			} ,
			error : function(xhr, status, error){
				alert(error);
			} 
		});
	}
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	#navdiv{height:130px;}
	table {border-spacing: 0px; margin: 0px auto ;}
	th, td {padding: 5px;}
	th {border: 1px solid black; text-align: center;}
	td {border: 1px solid black; text-align: left;}
	#content {width: 450px; margin: 0px auto;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no{position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
<div id="navdiv">
</div>
	<div id="content" class="panel panel-primary">
		<div class="panel-heading">회원가입 폼</div>
		<table class="table" id="tablee">
			<tr>
				<th>E-MAIL</th><td><input type="email" name="email" id="EMAIL" value="${email}"> <button type="button" class="btn btn-default"  onclick="chk();" id="CHK">이메일 인증</button></td></tr>
				<tr><th>ID</th><td><input type="text" name="id" id="ID" > <button type="button" class="btn btn-default" onclick="chkId();" id="ICHK">아이디 중복검사</button></td></tr>
				<tr><th>PASSWORD</th><td><input type="password" name="pwd" class="cls1" id="PWD"></td>
			</tr>			
		</table>
	</div>
	<br><br>
	<button class="btn btn-default" onclick="join();" id="JOIN">회원가입</button>
	<a href=/board/index.jsp><button class="btn btn-default">취소</button></a>
</body>
</html>