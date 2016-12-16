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

	function save() {
		var array = [];

		for (var i = 0; i < size; i++) {
			var obj = {};
			if ($(".line:eq(" + i + ") > td > [name=authority]").val() != null) {
				obj.num = $(".line:eq(" + i + ") > td > [name=num]").val();
				obj.cctvip = $(".line:eq(" + i + ") > td > [name=cctvip]").val();
				obj.cctvname = $(".line:eq(" + i + ") > td > [name=cctvname]").val();
				obj.authority = $(".line:eq(" + i + ") > td > [name=authority]").val();

				array.push(JSON.stringify(obj));
			}
			console.log(array[i]);
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
				console.log(result);
			},
			error : function(xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}
	
	var ip = '${vo.cctvip}';
	function right() {
		$.ajax("http://" + ip.split(':')[0] + ":8084?key=ddddd&id=${sessionid}");
	};

	function left() {
		$.ajax("http://" + ip.split(':')[0] + ":8084?key=aaaaa&id=${sessionid}");
	};
	
	function flash() {
		$.ajax("http://" + ip.split(':')[0] + ":8084?key=flash&id=${sessionid}");
	};
</script>
<style type="text/css">
body {
	text-align: center;
}

#navdiv {
	height: 130px;
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
</style>
</head>
<body>
	<div id="navdiv"></div>
	<div>
		<a href="list">CCTV 보기</a>
		<a href="addCCTV">CCTV 관리</a>
	</div>
	<div id="centerdiv">
		<div id="view">
		<img style='-webkit-user-select: none'
			src='http://${vo.cctvip}/?id=${sessionid}&ip=${vo.cctvip}'>
	</div>
	<c:if test="${vo.authority eq 'ADMIN'}">
		<div>
			<button id="left" onclick="left();" class="btn btn-default" >←</button>
			<button id="right" onclick="right();" class="btn btn-default" >→</button>
			<button id="right" onclick="flash();" class="btn btn-default" >플래시</button>
		</div>
	</c:if> 
	</div>
	<div id="footarea">
		<div id="footer"></div>
	</div>
</body>
</html>