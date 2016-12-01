<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CCTV</title>
<script src="//code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
$(function(){
    $("#navdiv").load("../resources/nav.jsp");
});
function logout(){
	if(confirm("로그아웃 하시겠습니까?")){			
		location.href="<c:url value='/logout' />";
	}
}
</script>
<style type="text/css">
#navdiv{height:130px;}
a:hover {color: red;}
a:active {color: gold}
a {color: gray; text-decoration: none;}
.no{
	position: relative;
    display: block;
    padding: 12px 15px;
}
</style>
</head>
<body>
<div id="navdiv">
</div>

	<h3>CCTV</h3>
	<br><br>
	<button>←</button>
	<button>→</button>
</body>
</html>