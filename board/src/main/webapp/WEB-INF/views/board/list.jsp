<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="table" id="tablee">
	<tr>
		<th id="tnum">번호</th>
		<th id="ttitle">제목</th>
		<th id="tauthor">작성자</th>	
		<th id="tdate">작성일</th>	
		<th id="tnum">조회수</th>
	</tr>
	<c:forEach var="e" items="${list}">
	<tr id="jul">
		<td>${e.num}</td>
		<td id="title"><a href="desc?num=${e.num}">${e.title}</a></td>
		<td id="author">${e.id}</td>
		<td>${e.regdate}</td>
		<td>${e.hitcnt}</td>
	</tr>
	</c:forEach>
</table>
