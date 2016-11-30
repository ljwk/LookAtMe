<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
	$(function() {		
 		if('${desc.filename}'==""){
			$('#DOWN').attr('disabled',true); 
		}else{
			$('#DOWN').attr('disabled',false); 
		} 
	});
	
	function deleteBoard(){
		if(confirm('정말로 삭제하시겠어요?')){ 
 			var dateObj = {};
			dateObj.num=${desc.num};
			 
			$.ajax({
				url : 'delete' , 
				data : dateObj,
				type : 'post',
				dataType : 'json', 
				success : function(res) {
					if(res.success){
			 			alert('삭제 성공');	
			 			location.href='main';
					}else{
						alert('답글이 있는 글은 삭제할 수 없습니다.');
					}
				}, 
				error(xhr, status, error){
					alert(error);
				} 
			});  
		}
	}
	
	function abcdeff(){
		location.href='download?filename=${desc.filename}';
	}
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	table {border: 1px solid black;	border-spacing: 0px;	margin: 0px auto; width: 800px;}
	th, td {padding: 5px;}
	h3{text-align: center;}
	th {width: 200px;	border: 1px solid black; background: rgb(176, 187, 190); text-align: center;}
	td {border: 1px solid black; width: 400px;}
	#contents{height: 400px}
	#aaaa{text-align: left;}
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
					<sec:authorize access="isAuthenticated()">
						<li><a href="<c:url value='/cctv/list' />">CCTV</a></li>
					</sec:authorize>		  					
  					<li><a href="/board/notice/main">Notice</a></li>
					<li><a href="/board/free/main">Board</a></li>
					<sec:authorize access="! isAuthenticated()">	      	
						<li><a href="/board/user/joinForm">Join</a></li>
						<li><a href="/board/user/login">Login</a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li><a href="javascript:logout();">Logout</a></li>
					</sec:authorize>						
				</ul>
			</div>	    
		</div>
	</nav>
	<br><br><br><br><br><br><br>
	<h3>상세정보 페이지</h3>
	<p>
	<table>	
		<tr>
			<th>글번호</th>	<td>${desc.num}</td>	<th>제목</th><td>${desc.title}</td><th>작성자</th><td>${desc.id}</td>
		</tr>
		<tr id="file" >
			<th >작성자 메일</th><td colspan="5" ><a href="mail?email=${desc.email}">${desc.email}</a></td>
		</tr>
		<tr id="contents" >
			<th >내용</th><td colspan="5" id="aaaa">${desc.contents}</td>
		</tr>
		<sec:authorize access="isAuthenticated()">		
			<tr id="file" >
				<th >첨부파일</th><td colspan="5" >${desc.filename} <button type="button" value="DOWNLOAD" id="DOWN"  class="btn btn-default" onclick="abcdeff();">DOWNLOAD</button></td>
			</tr>					
		</sec:authorize>		
	</table>		
	<p><br>	
	<a href="main" ><button type="button" class="btn btn-default">목록으로</button></a>
	<sec:authorize access="isAuthenticated()">
		<a href="readd?ref=${desc.num}" ><button type="button" class="btn btn-default" >답글</button></a>
	</sec:authorize>		
	
	<sec:authentication property="name" var="secName"/>
	 
	<sec:authorize access="${secName==desc.id}">	
		<a href="modi?num=${desc.num}" ><button type="button" class="btn btn-default">수정</button></a>
		<button type="button" class="btn btn-default" onclick="deleteBoard();">삭제</button>
	</sec:authorize>			
	
</body>
</html>