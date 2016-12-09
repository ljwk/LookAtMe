<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html >

<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<%-- <script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script> --%>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<!-- <script type="text/javascript" src="/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> -->
<script type="text/javascript" src="<c:url value="/resources/smarteditor/js/HuskyEZCreator.js"/>" charset="utf-8"></script>

<script type="text/javascript">
	$(function(){
		var oEditors = [];

		nhn.husky.EZCreator.createInIFrame({

			oAppRef : oEditors,

			elPlaceHolder : "content", //textarea에서 지정한 id와 일치해야 합니다.

			sSkinURI : "resources/smarteditor/SmartEditor2Skin.html",

			fCreator : "createSEditor2"

		});
	});

	</script>
</head>
<body>

	<textarea name="content" id="content" rows="30"> </textarea>

</body>

</html>