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
		$("table > tbody:last")
				.append(
						'<tr class="add" id=' + addsize + '>'
								+ '<td><input name="id"></td>'
								+ '<td><input name="cctvip"></td>'
								+ '<td><input name="cctvname"></td>'
								+ '<td><select name="authority">'
								+ '<option value="ADMIN" selected="selected">관리자</option>'
								+ '<option value="USER">사용자</option>'
								+ '</select></td>' 
// 								+ '<td><button type="button" onclick="check(' + addsize + ');">테스트</button></td>'
								+ '</tr>');
	}
	
	function check(id) {
		
		$.ajax({
		});
		
	}

	function save() {
		var array = [];
		var i = 0;
// 		for (var i = 0; i < size; i++) {
		while($(".line:eq(" + i + ") > td > [name=num]").val() != undefined) {
			var obj = {};
			if ($(".line:eq(" + i + ") > td > [name=authority]").val() != undefined) {
				console.log($(".line:eq(" + i + ") > td > [name=cctvname]").val());
				obj.num = $(".line:eq(" + i + ") > td > [name=num]").val();
				obj.cctvip = $(".line:eq(" + i + ") > td > [name=cctvip]").val();
				obj.cctvname = $(".line:eq(" + i + ") > td > [name=cctvname]").val();
				obj.authority = $(".line:eq(" + i + ") > td > [name=authority]").val();
				obj.id = $(".line:eq(" + i + ") > td > [name=id]").val();

				array.push(JSON.stringify(obj));
			}
// 			console.log(array[i]);
			i++;
		}

		for (var i = 0; i < addsize; i++) {
			var obj = {};
			obj.id = $(".add:eq(" + i + ") > td > [name=id]").val();
			obj.cctvip = $(".add:eq(" + i + ") > td > [name=cctvip]").val();
			obj.cctvname = $(".add:eq(" + i + ") > td > [name=cctvname]").val();
			obj.authority = $(".add:eq(" + i + ") > td > [name=authority]").val();
			obj.num = -1;

			array.push(JSON.stringify(obj));
			console.log(array[size + i]);
		}

		array.push("");

		var obj = {};
		obj.arr = array;

		$.ajax({
			url : "addCCTV",
			data : obj,
			type : "post",
			success : function(result) {
				location.href="addCCTV"
			},
			error : function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
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

	<div id="centerdiv">
	<h3 style="margin-right: 650px; font:bold 32px none;">CCTV 관리</h3>
	<hr style="width: 800px; border:1px solid lightgray;">
	<div>
		<a href="list"><button class="btn btn-default" type="button">CCTV 보기</button></a>
		<a style="margin-right: 600px;"href="addCCTV"><button class="btn btn-default" type="button">CCTV 관리</button></a>
		<br>
		<br>
	</div>
		<form action="addCCTV" method="post">
			<div id="content" class="panel panel-default">
			<table>
				<tr>
					<th>ID</th>
					<th>CCTV IP</th>
					<th>CCTV 이름</th>
					<th>권한</th>
				</tr>
				<c:forEach var="item" items="${list}">
					<tr class="line">
						<td id="num"><input name="num" type="hidden" value="${item.num}"></td>
						<c:if test="${item.authority eq 'ADMIN'}">
							<c:choose>
								<c:when test="${item.id eq id}">
									<td id="id"><input name="id" value="${item.id}"></td>
									<td>${item.id}</td>
								</c:when>
								<c:when test="${!(item.id eq id)}">
									<td><input name="id" value="${item.id}"></td>
								</c:when>
							</c:choose>
							<td><input name="cctvip" value="${item.cctvip}"></td>
							<td><input name="cctvname" value="${item.cctvname}"></td>
							<td><select name="authority">
									<option value="ADMIN" ${item.authority eq 'ADMIN' ? 'selected="selected"' : ''}>관리자</option>
									<option value="USER" ${item.authority eq 'USER' ? 'selected="selected"' : ''}>사용자</option>
							</select></td>
						</c:if>
						<c:if test="${item.authority eq 'USER'}">
							<c:choose>
								<c:when test="${item.id eq id}">
									<td>${item.id}</td>
									<td>${item.cctvip}</td>
									<td>${item.cctvname}</td>
									<c:if test="${item.authority eq 'ADMIN'}">
										<td>관리자</td>
									</c:if>
									<c:if test="${item.authority eq 'USER'}">
										<td>사용자</td>
									</c:if>
								</c:when>
								<c:when test="${!(item.id eq id)}">
									<td><input name="id" value="${item.id}"></td>
									<td><input name="cctvip" value="${item.cctvip}"></td>
									<td><input name="cctvname" value="${item.cctvname}"></td>
									<td><select name="authority">
											<option value="ADMIN" ${item.authority eq 'ADMIN' ? 'selected="selected"' : ''}>관리자</option>
											<option value="USER" ${item.authority eq 'USER' ? 'selected="selected"' : ''}>사용자</option>
									</select></td>
								</c:when>
							</c:choose>

						</c:if>
					</tr>
				</c:forEach>
			</table>
			</div>
			<br>
			<button type="button" onclick="addone();" class="btn btn-default">추가</button>
			<button type="button" onclick="save();" class="btn btn-default">적용</button>
		</form>
	</div>
	<div id="footarea">
		<div id="footer"></div>
	</div>
</body>
</html>