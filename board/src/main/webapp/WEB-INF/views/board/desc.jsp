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
		$("#footer").load("../resources/footer.jsp");
		$("#navdiv").load("../resources/nav.jsp");
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
	#navdiv {height:100px;}
	table {border-spacing: 0px;	margin: 0px auto; width: 800px;}
	th, td {padding: 5px;}
	h3{text-align: center;}
	th {width: 130px;border-bottom:1px solid lightgray;background: rgb(252, 252, 252); text-align: center;}
	td {width: 400px;border-bottom:1px solid lightgray;text-align: left;}
	#content {width: 800px; margin: 0px auto;}
	#file{text-align: left;}
	#contents {height: 100px;}
	#aaaa {text-align: left;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no{position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
	<div id="navdiv"></div>
	<h3 style="margin-right: 680px; font:bold 32px none;">상세정보</h3>
	<hr style="width: 800px; border:1px solid lightgray; margin-bottom:50px;">
	
	<div id="content" class="panel panel-default">
	<table>	
		<tr>
		<th>제목</th><td colspan="5">${desc.title}</td>
		</tr>
		<tr>
			<th>번호</th>	<td>${desc.num}</td>
			
			<th>작성자</th><td>${desc.id}</td>
		</tr>
		<tr id="file" >
			<th >메일</th><td colspan="5" ><a href="mail?email=${desc.email}">${desc.email}</a></td>
		</tr>
		<tr id="contents">
			<th>내용</th><td colspan="5" id="aaaa" align=left valign=top>${desc.contents}</td>
		</tr>
		<sec:authorize access="isAuthenticated()">
					<tr id="file" >
					<th >첨부파일</th><td >${desc.filename} <button type="button" value="DOWNLOAD" id="DOWN"  class="btn btn-default" onclick="abcdeff();">DOWNLOAD</button></td>
				</tr>			
		</sec:authorize>
</table>
	</div>
	<br>
	<a href="main" ><button type="button" class="btn btn-default">목록으로</button></a>
	<sec:authorize access="isAuthenticated()">
		<a href="readd?ref=${desc.num}" ><button type="button" class="btn btn-default" >답글</button></a>
	</sec:authorize>		
	
	<sec:authentication property="name" var="secName"/>
	 
	<sec:authorize access="${secName==desc.id}">	
		<a href="modi?num=${desc.num}&id=${desc.id}" ><button type="button" class="btn btn-default">수정</button></a>
		<button type="button" class="btn btn-default" onclick="deleteBoard();">삭제</button>
	</sec:authorize>			
	<div id="footarea">
	<div id="footer"></div>
	</div>
</body>
</html>