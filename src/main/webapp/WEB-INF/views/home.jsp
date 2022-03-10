<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<div align="center">
  <h1>댓글 목록</h1>
  <table border="1">
  	<thead>
  	  <tr>
  	  	<td>댓글번호</td>
  	  	<td>내용</td>
  	  	<td>날짜</td>
  	  	<td>조회수</td>
  	  	<td>게시글 번호(부모)</td>
  	  	<td>이어서 달리는 댓글</td>
  	  	<td>들여쓰기</td>
  	  </tr>
  	</thead>
  	<tbody>
  	<c:forEach var="reply" items="${list }">
  	  <tr>
  	  	<td><c:out value="${reply.bid }"/></td>
  	  	<td>
  	  	<c:if test="${reply.bstep != 0 }">
	  	  	<c:out value="${reply.bstep } 번 대댓글"/><br>
  	  	</c:if>
  	  	<c:out value="${reply.bcontent }"/></td>
  	  	<c:if test="${reply.bindent != 0 }">
	  	  <td>ㄴ
	  	<c:forEach var="i" begin="0" end="${reply.bindent }">
    		<c:out value=">" />
		</c:forEach>
	  	  <fmt:formatDate pattern="yyyy-MM-dd" value="${reply.bdate }"/></td>
  	  	</c:if>
  	  	<c:if test="${reply.bindent eq 0 }">
	  	  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${reply.bdate }"/></td>
  	  	</c:if>
  	  	<td><c:out value="${reply.bhit }"/></td>
  	  	<td><c:out value="${reply.bgroup }"/></td>
  	  	<td><c:out value="${reply.bstep }"/></td>
  	  	<td><c:out value="${reply.bindent }"/></td>
  	  </tr>
  	 </c:forEach>
  	</tbody>
  </table>
</div>
</body>
</html>
