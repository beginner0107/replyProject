<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="${pageContext.request.contextPath }/resources/js/reply.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<%-- <div align="center">
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
	  	  	<c:if test="${reply.bindent eq 0 }">
		  	  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${reply.bdate }"/></td>
	  	  	</c:if>
	  	  	<c:out value="${reply.bstep } 번 대댓글"/><br>
  	  	</c:if>
  	  	<c:out value="${reply.bcontent }"/></td>
	  	  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${reply.bdate }"/></td>
  	  	<td><c:out value="${reply.bhit }"/></td>
  	  	<td><c:out value="${reply.bgroup }"/></td>
  	  	<td><c:out value="${reply.bstep }"/></td>
  	  	<td><c:out value="${reply.bindent }"/></td>
  	  </tr>
  	 </c:forEach>
  	</tbody>
  </table>
</div> --%>
<h1 align="center">댓글 목록</h1>
<div>
	<ul class="chat">
	</ul>
</div>
 <form method="post" role="form" action="/register">
<div align="center">
  <table class="table" >
	<tr>
	  <td colspan="2">
	    작성자 : <input type = "text" name = "bname" id="bname"/>
	  </td>
	  <td colspan="2">
	    댓글제목 : <input type = "text" name = "btitle" id="btitle"/>
	  </td>
	  <td colspan="4"></td>
	</tr>
	<tr>
	  <td colspan="7">
	    <div>
	  	댓글내용 : 
	  	</div>
		<textarea id="bcontent" name="bcontent" rows="5" cols="100" id="bcontent"></textarea>
	  </td>
	  <td>
	    <input type="submit" style="width:150;height:150;" value="등록" class="btn btn-primary">
	  </td>
	</tr>
  </table>
  <input type="hidden" name="bstep" value="0">
  <input type="hidden" name="bindent" value="0" >
</div>
</form>
<script type="text/javascript">
function read(bid){
	$.ajax({
		url : "/read",
		data : {bid : bid},
		type : "GET",
		dataType : "json",
		success : function(data){
			console.log(data);
			$("#bname").val(data.bname);
			$("#bname").attr("readonly",true);
			$("#btitle").val(data.btitle);
			$("#btitle").attr("readonly",true);
			$("#bcontent").val(data.bcontent);
			$("#bstep").val(data.bstep);
			$("#bindent").val(data.bindent);
			$(".btn").val("수정");
		},
		error : function(){
			console.log('에러');
		}
	});
}
function eliminate(bid){
	$.ajax({
		url : "/delete",
		data : {bid : bid},
		type : "POST",
		success : function(){
			location.reload();
		}
	})
}
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
 				str += "<li data-rno='";
				str += list[i].bid+"'>";
				str += "  <div><div class='header'><strong class='primary-font'>";
				if(list[i].bindent != 0){
					str += "└";
					for(var j=0; j<list[i].bindent; j++){
						str += "－ ";
					}
					str += "<font color ='green'>("+list[i].bstep+")번의 댓글</font>";
				}
				str += " [";
				str += list[i].bid+"]_작성자 : "+list[i].bname+"</strong>";
				str += "&nbsp&nbsp&nbsp<input type='button' onclick='read("+list[i].bid+")' id='modify' value='수정'>";
				str += "&nbsp&nbsp<input type='button' onclick='eliminate("+list[i].bid+")' id='delete' value='삭제'>";
				str += "<small class='pull-right text-muted'>"+replyService.displayTime(list[i].bdate)
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
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		var act = $(this).val();
		alert(act);
		if(act == "등록"){
			formObj.submit();
		}
		else if(act == "수정"){
			formObj.attr("action", "/update");
			formObj.submit();
		}
		//formObj.submit();
	});
	
/* 	$(".chat").on("click", "li #modify", function(e){
		  var rno = $(this).data("rno");
		  alert(rno);
	});	 */
	
	/* $(".chat").on("click", "li", function(e){
		  var rno = $(this).data("rno");
		  
		  alert("테스트: " + rno);		  
	}); */	
});
</script>
</body>
</html>
