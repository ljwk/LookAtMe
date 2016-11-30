<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel-heading"><h3>게 시 판 !</h3></div>
<table class="table" id="tablee">
	<tr>
		<th>글번호</th><th>제목</th><th>작성자</th>	<th>작성일</th>	<th>조회수</th>
	</tr>
	<c:forEach var="e" items="${list}">
	<tr id="jul">
		<td>${e.num}</td><td id="title"><a href="desc?num=${e.num}">${e.title}</a></td><td id="author">${e.id}</td><td>${e.regdate}</td><td>${e.hitcnt}</td>
	</tr>
	</c:forEach>
</table>