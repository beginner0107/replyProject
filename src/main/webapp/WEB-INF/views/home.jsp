<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/reply.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1 align="center">댓글 목록</h1>
<div>
	<ul class="chat">
	</ul>
</div>
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
	    <input type="button" id="crud" style="width:100;height:100;" value="등록" class="btn btn-primary">
	    <input type="button" id="reset" style="width:100;height:100; display:none;" value="취소" class="btn btn-warning">
	  </td>
	</tr>
  </table>
  <input type="hidden" id="bid" value="">
  <input type="hidden" id="bstep" name="bstep" value="0">
  <input type="hidden" id = "bindent" name="bindent" value="0" >
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
 				str += "<li data-rid='";
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
				str += "&nbsp&nbsp&nbsp<input type='button' data-bid='"+list[i].bid+"' id='modify' value='수정'>";
				str += "&nbsp&nbsp<input type='button' id='delete' data-bname='"+list[i].bname+"' data-bid='"+list[i].bid+"' value='삭제'>";
				str += "&nbsp&nbsp<input type='button' id='reply' data-bid='"+list[i].bid+"' data-bindent='"+list[i].bindent+"' value='대댓글'>";
				str += "<small class='pull-right text-muted'>"+replyService.displayTime(list[i].bdate)
				+"</small></div>";
				if(list[i].bindent != 0){
					str += "<p>";
					for(var j=0; j<list[i].bindent; j++){
						str += "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
					}
					str += list[i].bcontent+"</p></div></li>"; 
				}else{
					str += "<p>"+list[i].bcontent+"</p></div></li>"; 
				}
				
			}
			
			replyUL.html(str);
			
		});
	} // end showList
	
	var formObj = $("form[role='form']");
	
	$("input[type='button']").on("click", function(e){
		var act = $(this).val();
		if(act == "등록"){
		  var reply = {
			  bname: $("#bname").val(),
			  btitle: $("#btitle").val(),
			  bcontent: $("#bcontent").val(),
			  bstep: $("#bstep").val(),
			  bindent: $("#bindent").val()
		   };
		  
		  console.log(reply);
		  
		  replyService.add(reply, function(result){
				 alert(result);
				 $("#bcontent").val("");
				 $("#bname").val("");
				 $("#btitle").val("");
				 $("#bstep").val("");
				 $("#bindent").val("");
				 showList();
			  });
		}
		else if(act == "수정"){
		   var reply = {
			  bid: $("#bid").val(), 
			  bcontent: $("#bcontent").val()
		   };
		   replyService.update(reply, function(result){
			  alert(result);
			  $("#bid").val("");
			  $("#bcontent").val("");
			  $("#bname").val("");
			  $("#bid").val("");
			  
			  showList();
		  });
		}
	});
	
 	$(".chat").on("click", "li #modify", function(e){
		  var bid = $(this).data("bid");
		  replyService.get(bid, function(reply){
			  $("#bname").val(reply.bname);
			  $("#bname").attr("readonly",true);
		      $("#btitle").val(reply.btitle);
			  $("#btitle").attr("readonly",true);
			  $("#bcontent").val(reply.bcontent);
			  $("#bstep").val(reply.bstep);
			  $("#bindent").val(reply.bindent);
			  $("#bid").val(reply.bid);
			  $("#crud").val("수정");
			  $("#reset").show();
			  $("#bcontent").focus();
		});
	});	 
 	$(".chat").on("click", "li #delete", function(e){
		  var bid = $(this).data("bid");
		  if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			var bname = $(this).data("bname");
		  	var input = prompt('작성자의 이름과 일치해야 삭제', '');
		  	if(input  === bname){
				replyService.remove(bid, function(result){
				  alert(result);
				  showList();
				});
		  	}else{
		  		alert('작성자의 이름과 일치하지 않습니다.')
		  		return false;
		  	}
			 
		  }else{   //취소
		     return false;
		  }
	});	 
 	
 	$(".chat").on("click", "li #reply", function(e){
 		var bid = $(this).data("bid");
 		var bindent = $(this).data("bindent");
 		alert(bid + " 댓글에 대한 답글");
 		
 		console.log(bindent);
 		$("#bname").focus();
 		$("#bstep").val(bid);
 		$("#bindent").val(parseInt(bindent) + 1);
 		
	});	
 	
 	$("#reset").on("click", function(e){
 		  $("#bid").val("");
 		  $("#bname").val("");
 		  $("#btitle").val("");
 		  $("#bcontent").val("");
 		  $("#bstep").val("");
 		  $("#bindent").val("");
 		
	});	
});
</script>
<script type="text/javascript">
$(document).ready(function(){

	
});
</script>
</body>
</html>
