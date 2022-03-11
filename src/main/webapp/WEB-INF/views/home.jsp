<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/reply.js"></script>
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
	  	  	<c:if test="${reply.bindent != 0 }">
		  	  ㄴ
		  	<c:forEach var="i" begin="0" end="${reply.bindent }">
	    		<c:out value=">" />
			</c:forEach>
			</c:if>
	  	  	<c:out value="${reply.bstep } 번 대댓글"/><br>
  	  	</c:if>
  	  	<c:out value="${reply.bcontent }"/></td>
	  	  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${reply.bdate }"/></td>
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

<div>
	<ul class="chat">
	</ul>
</div>
<script type="text/javascript">
$(document).ready(function(){
	
	var replyUL = $('.chat');
	
	showList();
	
	function showList(){
		replyService.getList(function(list){
			console.log(list);
			
			var str = "";
			
			if(list == null || list.length == 0){
				return;
			}
			for(var i = 0, len = list.length || 0; i<len; i++){
 				str += "<li class='left clearfix' data-rno='";
				str += list[i].bid+"'>";
				str += "  <div><div class='header'><strong class='primary-font'>";
				if(list[i].bindent != 0){
					str += "└";
					for(var j=0; j<list[i].bindent; j++){
						str += "－ ";
					}
					str += "("+list[i].bstep+")번의 댓글";
				}
				str += " [";
				str += list[i].bid+"] "+list[i].bname+"</strong>";
				str += "	<small class='pull-right text-muted'>"+replyService.displayTime(list[i].bdate)
				+"</small></div>";
				str += "	<p>"+list[i].bcontent+"</p></div></li>"; 
			}
			
			replyUL.html(str);
			
			showReplyList();
		});
	} // end showList
	
	function showReplyList(){
		
	}
});
</script>
</body>
</html>
