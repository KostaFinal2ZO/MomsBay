<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/prettyPhoto.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/price-range.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/responsive.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.scrollUp.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/price-range.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.prettyPhoto.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/websocket.js"></script>

<script type="text/javascript">
var getCookie = function(name) {
	  var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	  return value? value[2] : null;
	};

$(document).ready(function(){
	sessionId='${sessionScope.member.id}';
	getNewMessage();
	
	var uId = getCookie("mbId");
	var uToken = getCookie("mbToken");
		console.log(uId);
		console.log(uToken);

	<%-- 검색기능 jquery --%>
	var frm = $('#conditionSearchFrom'); //폼
	var searchBtn = $('#btn_search'); //search 버튼 
	searchBtn.on('click', function(){
		var boardTypeNo = $("#boardTypeNo").val();
		
		if(boardTypeNo == '1' || boardTypeNo == '2'){
			frm.attr("action","${pageContext.request.contextPath}/trade/list_trade_post.do");
		}else if(boardTypeNo == '5'){
			frm.attr("action","${pageContext.request.contextPath}/bay/list_bulletin_post.do");
		}else if(boardTypeNo == '6'){
			frm.attr("action","${pageContext.request.contextPath}/bay/list_qna_post.do");
		}else if(boardTypeNo == '3' || boardTypeNo == '4'){
			frm.attr("action","${pageContext.request.contextPath}/trade/list_share_post.do");
		}else{
			return;
		}
		if(boardTypeNo == ''){
			alert("카테고리 선택  후 조회하시기 바랍니다.");
			return;
		}
		
		frm.attr("method", "post").submit();
	});
});
</script>

<div class="header_top">
	<!--header_top-->
	<div class="container">
		<div class="row">
			<div class="col-sm-6">
				<div class="contactinfo">
					<ul class="nav nav-pills">
						<li><a href="#"><i class="fa fa-phone"></i> +2 95 01 88
								821</a></li>
						<li><a href="#"><i class="fa fa-envelope"></i>
								info@domain.com</a></li>
					</ul>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="social-icons pull-right">
					<ul class="nav navbar-nav">
						<li><a href="${pageContext.request.contextPath}/admin/test.do"><i class="fa fa-facebook"></i></a></li>
						<li><a href="${pageContext.request.contextPath}/a32fse.do"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
						<li><a href="#"><i class="fa fa-dribbble"></i></a></li>
						<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!--/header_top-->

<div class="header-middle">
	<!--header-middle-->
	<div class="container">
		<div class="row">
			<div class="col-sm-4">
				<div class="logo pull-left">
					<a href="${pageContext.request.contextPath}/home.do">
					<img src="${pageContext.request.contextPath}/resources/images/home/logo.png" alt="" />
					</a>
				</div>
				<div class="btn-group pull-right"></div>
			</div>
			<div class="col-sm-8">
				<div class="shop-menu pull-right">
					<ul class="nav navbar-nav">
					<%--세션에 멤버정보의 유무에 따라 구분  --%>
						<c:choose>
							<c:when test="${empty member}">
								<li><a href="${pageContext.request.contextPath}/member/login_view.do"><i class="fa fa-lock"></i> 로그인</a></li>
								<li><a href="${pageContext.request.contextPath}/member/register_terms.do"><i class="fa fa-user-plus"></i> 회원가입</a></li>
							</c:when>
							<c:otherwise>
								<c:if test="${member.grade eq 'member'}">
									<li><a href="${pageContext.request.contextPath}/myaccount/findMypointById.do"><i class="fa fa-user"></i> 내 계정</a></li>
									<li><a href="${pageContext.request.contextPath}/myaccount/findNowpointById.do"><i class="fa fa-usd"></i> 포인트 충전/환전</a></li>
									<li><a href="${pageContext.request.contextPath}/myaccount/findPickListById.do"><i class="fa fa-heart"></i> 찜목록</a></li>
								</c:if>
								<c:if test="${member.grade  eq 'admin'}">
									<li><a href="${pageContext.request.contextPath}/admin/getPeopleList.do"><i class="fa fa-user"></i> 관리자 페이지</a></li>
								</c:if>
								<li class="dropdown">
									<a href="#this" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> 쪽지 <span id="message-badge" class="badge"></span></a> 
									    <div class="dropdown-menu">
									        <div id="message-header" class="dropdown-header"></div>
										    <div class="divider"></div>
									        <div id="message-body">
									        </div>
									        <div class="divider"></div>
									        <div class="dropdown-menu-footer"><a href="/momsbay/message/getReceiveMessageList.do?id=${sessionScope.member.id }"><span>받은 메세지함에서 보기<span></a></div>
									    </div>
								</li>
								<li><a href="${pageContext.request.contextPath}/member/logout.do?id=${member.id }"><i class="fa fa-unlock"></i> 로그아웃</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!--/header-middle-->

<div class="header-bottom">
	<!--header-bottom-->
	<div class="container">
		<div class="row">
			<div class="col-sm-7">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<div class="mainmenu pull-left">
					<ul class="nav navbar-nav collapse navbar-collapse">
						<li><a href="${pageContext.request.contextPath}/home.do"
							class="active">Home</a></li>
						<li class="dropdown"><a href="#this">중고나라<i
								class="fa fa-angle-down"></i></a>
							<ul role="menu" class="sub-menu">
								<li><a href="${pageContext.request.contextPath}/trade/list_trade_post.do?boardTypeNo=1&categoryNo=1">삽니다</a></li>
								<li><a href="${pageContext.request.contextPath}/trade/list_trade_post.do?boardTypeNo=2&categoryNo=1">팝니다</a></li>
								<li><a href="${pageContext.request.contextPath}/trade/list_share_post.do?boardTypeNo=3&categoryNo=1">나눔</a></li>
								<li><a href="${pageContext.request.contextPath}/trade/list_share_post.do?boardTypeNo=4&categoryNo=1">교환</a></li>
							</ul></li>
						<li><a href="${pageContext.request.contextPath}/bay/list_bulletin_post.do?boardTypeNo=5">자유게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/bay/list_qna_post.do?boardTypeNo=6">Q &amp; A</a></li>
					</ul>
				</div>
			</div>
			<%--
			<!-- 검색기능 제거함 -->
			<!-- 카테고리별 검색 -->
			<form id="conditionSearchFrom">
			<div class="col-sm-5">
				<div class="search_box pull-right">
					<select name="boardTypeNo" id="boardTypeNo" style="width: 140px; height: 36.33px;">
						<option value="">- 카테고리 선택 -</option>
						<option value="1">삽니다</option>
						<option value="2">팝니다</option>
						<option value="3">나눔</option>
						<option value="4">교환</option>
						<option value="5">자유게시판</option>
						<option value="6">Q&amp;A게시판</option>
					</select>
					<input type="text" placeholder="제목 및 내용에 포함된 단어" name="searchWord" />
					<button class="btn searchform fa fa-search" type="button" id="btn_search"></button>
				</div>
			</div>
			</form> --%>
		</div>
	</div>
</div>
<!--/header-bottom-->