<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>board</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      <script type="text/javascript">
    $(document).ready(function(){
    	$("#deleteBtn").click(function(){ 
    		if(confirm("게시물을 삭제하시겠습니까?"))
    		location.href="${pageContext.request.contextPath}/deleteBoard.do?bayPostNo=${pvo.bayPostNo}";
    	});
    	$("#updateBtn").click(function(){  
    		if(confirm("게시물을 수정하시겠습니까?"))
    		location.href="${pageContext.request.contextPath}/updateBoard.do?bayPostNo=${pvo.bayPostNo}";
    	});
    });	
</script>
</head>
<body>
<!-- container-fluid: 화면 너비와 상관없이 항상 100% -->
<div class="container-fluid">
  <div class="row header">
    <div class="col-sm-2" ></div>
    <div class="col-sm-8" align="right">
    </div>
    <div class="col-sm-2" ></div>
  </div>
  <div class="row main">
    <div class="col-sm-2" ></div>
    <div class="col-sm-8">
<table  class="table">
	<tr>
			<td>글번호 ${requestScope.pvo.bayPostNo }</td>
			<td>제목: ${requestScope.pvo.title} </td>
			<td>작성자:  ${requestScope.pvo.memberVO.id }</td>
			<td>${requestScope.pvo.regdate }</td>
		</tr>		
		<tr>
			<td colspan="5" class="content">
			<pre>${requestScope.pvo.content}</pre>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="btnArea">
			 <c:if test="${requestScope.pvo.memberVO.id==sessionScope.member.id}">
			 <button type="button" id="updateBtn">수정</button>
			 <button type="button" id="deleteBtn">삭제</button>
			 </c:if>
			 </td>
		</tr>
	</table>
    </div>
    <div class="col-sm-2" ></div>
  </div>
</div>
</body>
</html>