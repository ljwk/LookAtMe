<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CCTV</title>
<script src="<c:url value="/resources/jquery-3.1.1.min.js"/>"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<!-- <script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script> -->
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>

<c:set var="size" value="0" />
<c:forEach var="item" items="${list}">
	<c:if test="${item.authority eq 'ADMIN'}">
		<c:set var="size" value="${size + 1}" />
	</c:if>
</c:forEach>
<script type="text/javascript">
	var size = ${size};
	var addsize = 0;
	$(function() {
		$("#navdiv").load("../resources/nav.jsp");
		$("#footer").load("../resources/footer.jsp");
	});

	function logout() {
		if (confirm("로그아웃 하시겠습니까?")) {
			location.href = "<c:url value='/logout' />";
		}
	}

	function addone() {
		addsize = addsize + 1;
		console.log(addsize);
		$("table > tbody:last").append('<tr class="add" id=' + addsize + '>'
										+ '<td><input name="id"></td>'
										+ '<td><input name="cctvip"></td>'
										+ '<td><input name="cctvname"></td>'
										+ '<td><select name="authority">'
										+ '<option value="ADMIN" selected="selected">관리자</option>'
										+ '<option value="USER">사용자</option>'
										+ '</select></td>' 
										+ '<td><button type="button" onclick="check(' + addsize + ');">테스트</button></td>'
										+ '</tr>'
										);
	}
	
	function check(id) {
		
		$.ajax({
		});
		
	}
</script>
<style type="text/css">
body {
	text-align: center;
}


#navdiv {
	height: 130px;
}
table {
	border-spacing: 0px;
	margin: 0px auto; width: 800px;
}
th, td {
	padding: 5px;
}
th {
	width: 100px;
	border-bottom:1px solid lightgray;
	background: rgb(252, 252, 252);
	text-align: left;
}
td {
	border-bottom:1px solid lightgray;text-align: left;
}
#content {
	width: 805px;
	margin: 0px auto;
}

a:hover {
	color: red;
}

a:active {
	color: gold
}

a {
	color: gray;
	text-decoration: none;
}

.no {
	position: relative;
	display: block;
	padding: 12px 15px;
}

.line>#num {
	display: none;
}

.line>#id {
	display: none;
}
</style>
</head>
<body>
	<div id="navdiv"></div>
	<div>
		<a href="list">CCTV 보기</a>
		<a href="addCCTV">CCTV 관리</a>
	</div>
	<div id="content" class="panel panel-default">
		<table>
			<tr>
				<th>CCTV 이름</th>
				<th>권한</th>
			</tr>
			<c:forEach var="item" items="${list}">
				<tr>
					<td><a href="view?num=${item.num}&id=${item.id}">${item.cctvname}</a></td>
					<td>${item.authority}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="footarea">
		<div id="footer"></div>
	</div>
</body>
</html>