<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#cancelTransactionFromPublisher").click(function(){
			if(confirm("거래를 취소하시겠습니까?")){
				var tradeId = "${requestScope.tradePostVO.tradeId}";
				var memberVOId = "${sessionScope.member.id}";
				var url = "${pageContext.request.contextPath}";
				var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
				$("#trade").attr("action", url+"/trade/cancelTransaction.do");
				$("#tradeId").attr("value",tradeId);
				$("#memberVOId").attr("value",memberVOId);
				$("#tradePostNo").attr("value",tradePostNo);
				$("#trade").submit();
			}
		});
		
		$("#cancelTransactionFromApplicant").click(function(){
			if(confirm("거래를 취소하시겠습니까?")){
				var tradeId = "${sessionScope.member.id}";
				var memberVOId = "${requestScope.tradePostVO.memberVO.id}";
				var url = "${pageContext.request.contextPath}";
				var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
				$("#trade").attr("action", url+"/trade/cancelTransaction.do");
				$("#tradeId").attr("value",tradeId);
				$("#memberVOId").attr("value",memberVOId);
				$("#tradePostNo").attr("value",tradePostNo);
				$("#trade").submit();
			}
		});
		
		$("#cancelTransaction").click(function(){
			if(confirm("거래를 취소하시겠습니까?")){
				var url = "${pageContext.request.contextPath}";
				var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
				$("#trade").attr("action", url+"/trade/cancelTransaction2.do");
				$("#tradePostNo").attr("value",tradePostNo);
				$("#trade").submit();
			}
		});
		
		$("#applyBuyView").click(function(){
				var url = "${pageContext.request.contextPath}";
				var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
				$("#trade").attr("action", url+"/trade/applyBuyView.do");
				$("#tradePostNo").attr("value",tradePostNo);
				$("#trade").submit();
		});
		
		$("#applySellView").click(function(){
			var url = "${pageContext.request.contextPath}";
			var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
			$("#trade").attr("action", url+"/trade/applySellView.do");
			$("#tradePostNo").attr("value",tradePostNo);
			$("#trade").submit();
		});
		
		$("#updateTradePostView").click(function(){
			var url = "${pageContext.request.contextPath}";
			var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
			$("#trade").attr("action", url+"/trade/updateTradePostView.do");
			$("#tradePostNo").attr("value",tradePostNo);
			$("#trade").submit();
		});
		
		$("#deleteTradePost").click(function(){
			var url = "${pageContext.request.contextPath}";
			var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
			$("#trade").attr("action", url+"/trade/deleteTradePost.do");
			$("#tradePostNo").attr("value",tradePostNo);
			$("#trade").submit();
		});
		
		$("#updateDeliveryTradeHistory").click(function(){
			if(confirm("물품배송을 완료하였습니까?")){
				var url = "${pageContext.request.contextPath}";
				var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
				var memberVOId = "${requestScope.tradePostVO.memberVO.id}";
				$("#trade").attr("action", url+"/trade/updateDeliveryTradeHistory.do");
				$("#memberVOId").attr("value",memberVOId);
				$("#tradePostNo").attr("value",tradePostNo);
				$("#trade").submit();
			}
		});
		
		$("#completeTransaction").click(function(){
			var url = "${pageContext.request.contextPath}";
			var tradeId = "${requestScope.tradePostVO.tradeId}";
			var memberVOId = "${requestScope.tradePostVO.memberVO.id}";
			var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
			$("#trade").attr("action", url+"/trade/completeTransaction.do");
			$("#memberVOId").attr("value",memberVOId);
			$("#tradeId").attr("value",tradeId);
			$("#tradePostNo").attr("value",tradePostNo);
			$("#trade").submit();
		});
		
		$("#deposit").click(function(){
			var url = "${pageContext.request.contextPath}";
			var tradeId = "${requestScope.tradePostVO.memberVO.id}";
			var memberVOId = "${requestScope.tradePostVO.tradeId}";
			var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
			$("#trade").attr("action", url+"/trade/deposit.do");
			$("#memberVOId").attr("value",memberVOId);
			$("#tradeId").attr("value",tradeId);
			$("#tradePostNo").attr("value",tradePostNo);
			$("#trade").submit();
		});
		
		$("#completeTransaction2").click(function(){
			var url = "${pageContext.request.contextPath}";
			var memberVOId = "${requestScope.tradePostVO.tradeId}";
			var tradeId = "${requestScope.tradePostVO.memberVO.id}";
			var tradePostNo = "${requestScope.tradePostVO.tradePostNo}";
			$("#trade").attr("action", url+"/trade/completeTransaction.do");
			$("#memberVOId").attr("value",memberVOId);
			$("#tradeId").attr("value",tradeId);
			$("#tradePostNo").attr("value",tradePostNo);
			$("#trade").submit();
		});
		
		/* 목록으로 돌아가기 */
		$("#listBtn").click(function() {
			location.href="${pageContext.request.contextPath}/trade/list_trade_post.do?pageNo=${requestScope.pageNo}&boardTypeNo=${requestScope.boardTypeNo}&categoryNo=${requestScope.categoryNo}";
		});
		
	});//ready
</script>


<form action="" id="trade" method="post">
<input type="hidden" name="tradePostNo" id="tradePostNo">
<input type="hidden" name="tradeId" id="tradeId">
<input type="hidden" name="id" id="memberVOId">
<input type="hidden" name="boardTypeNo" id="boardTypeNo" value="${requestScope.tradePostVO.boardTypeNo}">
</form>

<div class="product-details">
	<!--product-details-->
	<div class="col-sm-5">
		<div class="view-product">
			<c:choose>
				<c:when test="${ imgAddress eq 'noPhoto'}">
					<img src="${pageContext.request.contextPath}/resources/upload/images/default.png" >
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/resources/upload/postImg/${imgAddress }" >
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="col-sm-7">
		<div class="product-information">
			<!--/product-information-->
			<div class="row" align="left">
				<div class="col-sm-12">
					<span style="font-size: 30px">${requestScope.tradePostVO.title}</span>
				</div><hr>
			</div>
			<div class="row">
				<div class=col-sm-12><br><br><hr></div>
			</div>
			<div class="row" align="left">
				<div class="col-sm-12">
					<span>희망가격&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.tradePostVO.price}원</span>
				</div>
			</div>
			<div class="row" align="left">
				<div class="col-sm-12">
					<span>작성자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.tradePostVO.memberVO.name}</span>
						<c:if test="${sessionScope.member.id != requestScope.tradePostVO.memberVO.id && !empty member}">
							<button id="message_btn" class="fa fa-envelope"></button>
						</c:if>
				</div>
			</div>
			<div class="row" align="left">
				<div class="col-sm-3">
					<span>등록일시&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </span>
				</div>
				<div class="col-sm-7">
					<span>${requestScope.tradePostVO.regdate}</span>
				</div>
				<div class="col-sm-12"><br></div>
				<div class="col-sm-12"><br></div>
			</div>
			<!-- 2차 버전<div class="row">
				<div class="col-sm-5">
					<span>평점 : </span>
				</div>
				<div class="col-sm-7">
					<span>* * * * *</span>
				</div>
			</div> -->
			
		</div>
		<!-- 삽니다 게시판 버튼 -->
		<c:if test="${requestScope.tradePostVO.boardTypeNo eq '1'}">
			<c:choose>
				<%-- 게시자(구매자)면 --%>
				<c:when test="${sessionScope.member.id==requestScope.tradePostVO.memberVO.id}">
					<c:choose>
						<%-- 신청이 없으면 --%>
						<c:when test="${requestScope.tradePostVO.tradeId eq NULL}">
							<div class="btn-group">
								<span><button type="button" class="btn btn-primary">${requestScope.tradePostVO.status}</button></span>
							</div>
						</c:when>
						<%-- 신청이 있으면 --%>
						<c:otherwise>
							<div class="btn-group">
							<c:choose>
								<c:when test="${requestScope.historyStatus eq '거래중'}">
									<span><button type="button" id="applyBuyView" class="btn btn-info3">입금하기</button></span>
									<span><button type="button" id="cancelTransaction" class="btn btn-info3">거래취소</button></span>
								</c:when>
								<c:when test="${requestScope.historyStatus eq '물품배송'}">
									<span><button type="button" id="completeTransaction2" class="btn btn-info3">거래완료</button></span>
								</c:when>
								<c:otherwise>
									<span><button type="button" class="btn btn-info3">${requestScope.tradePostVO.status}</button></span>
								</c:otherwise>
							</c:choose>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>
				
				<%-- 게시자(구매자)가 아니면 --%>
				<c:otherwise>
					<c:choose>
						<%-- 신청이 없으면 --%>
						<c:when test="${requestScope.tradePostVO.tradeId eq NULL}">
							<div class="btn-group">
								<span><button type="button" id="applySellView" class="btn btn-info3">거래신청</button></span>
							</div>
						</c:when>
						<%-- 신청이 있으면 --%>
						<c:otherwise>
							<c:choose>
								<%-- 신청자 본인이면 --%>
								<c:when test="${requestScope.tradePostVO.tradeId eq sessionScope.member.id}">
									<div class="btn-group">
										<c:choose>
											<c:when test="${requestScope.historyStatus eq '거래중'}">
												<span><button type="button" id="cancelTransaction" class="btn btn-info3">거래취소</button></span>
											</c:when>
											<c:when test="${requestScope.historyStatus eq '입금완료'}">
												<span><button type="button" id="updateDeliveryTradeHistory" class="btn btn-info3">물품배송</button></span>
											</c:when>
											<c:otherwise>
												<span><button type="button" class="btn btn-info3">${requestScope.tradePostVO.status}</button></span>
											</c:otherwise>
										</c:choose>
									</div>
								</c:when>
								<%-- 신청자 본인이 아니면 --%>
								<c:otherwise>
									<c:choose>
										<c:when test="${requestScope.historyStatus eq '물품배송' or requestScope.historyStatus eq '입금완료'}">
											<span><button type="button" class="btn btn-info3" id="completeTransaction">거래중</button></span>
										</c:when>
										<c:otherwise>
											<span><button type="button" class="btn btn-info3">${requestScope.tradePostVO.status}</button></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>						
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:if>

		<!-- 팝니다 게시판 버튼 -->
		<c:if test="${requestScope.tradePostVO.boardTypeNo eq '2'}">
		<c:choose>
			<c:when test="${sessionScope.member.id==requestScope.tradePostVO.memberVO.id}">
				<c:choose>
					<c:when test="${requestScope.tradePostVO.tradeId eq NULL}">
						<div class="btn-group">
							<span><button type="button" class="btn btn-primary">${requestScope.tradePostVO.status}</button></span>
						</div>
					</c:when>
					<c:otherwise>
						<div class="btn-group">
							<c:choose>
								<c:when test="${requestScope.tradePostVO.status eq '거래완료'}">
									<span><button type="button" class="btn btn-info3">${requestScope.tradePostVO.status}</button></span>
								</c:when>
								<c:when test="${requestScope.historyStatus eq '물품배송'}">
									<span><button type="button" class="btn btn-info3">배송완료</button></span>
								</c:when>
								<c:otherwise>
									<span><button type="button" id="updateDeliveryTradeHistory" class="btn btn-info3">물품배송</button></span>
									<span><button type="button" id="cancelTransactionFromPublisher" class="btn btn-info3">거래취소</button></span>
								</c:otherwise>
							</c:choose>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${requestScope.tradePostVO.tradeId eq NULL}">
						<div class="btn-group">
							<span><button type="button" id="applyBuyView" class="btn btn-info3">거래신청</button></span>
						</div>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${requestScope.tradePostVO.tradeId eq sessionScope.member.id}">
								<div class="btn-group">
								<c:choose>
									<c:when test="${requestScope.tradePostVO.status eq '거래완료'}">
										<span><button type="button" class="btn btn-info3">${requestScope.tradePostVO.status}</button></span>
									</c:when>
									<c:when test="${requestScope.historyStatus eq '물품배송'}">
										<span><button type="button" class="btn btn-info3" id="completeTransaction">거래완료</button></span>
									</c:when>
									<c:otherwise>
										<span><button type="button" class="btn btn-info3" id="cancelTransactionFromApplicant">거래취소</button></span>
									</c:otherwise>
								</c:choose>
								</div>
							</c:when>
							<c:otherwise>
								<div class="btn-group">
								<c:choose>
									<c:when test="${requestScope.tradePostVO.status eq '물품배송'}">
										<span><button type="button" class="btn btn-info3" id="completeTransaction">거래중</button></span>
									</c:when>
									<c:otherwise>
										<span><button type="button" class="btn btn-info3">${requestScope.tradePostVO.status}</button></span>
									</c:otherwise>
								</c:choose>
								</div>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
		</c:if>
	</div>
</div>

<div class="category-tab">
	<h1 align="left">DETAIL INFO</h1><hr>
	<div style="text-align: left;">
	<pre>${requestScope.tradePostVO.content}</pre>
	</div>
</div><hr>
<c:if test="${requestScope.tradePostVO.suggestContent ne NULL}">
<p>판매자 상품 정보</p>
<div class="category-tab">
	<pre>${requestScope.tradePostVO.suggestContent}</pre>
</div>
</c:if>
<div class="row">
	<img src="${pageContext.request.contextPath}/resources/upload/images/detailfooter.png" alt=""/>
</div><br><br>
<div class="row">
	<button type="button" name="button" class="btn btn-info6 pull-right" id="listBtn">목록으로</button>
	<input type="hidden" name="boardTypeNo" value="${requestScope.tradePostVO.boardTypeNo}"> 
	<input type="hidden" name="categoryNo" value="${requestScope.tradePostVO.categoryNo}">
	<input type="hidden" name="pageNo" value="${requestScope.pageNo}">
</div>
<div class="row">
	<div class="col-sm-12"><br><br></div>
</div>
<c:if test="${sessionScope.member.id==requestScope.tradePostVO.memberVO.id || sessionScope.member.grade == 'admin'}">
	<div class="row">
		<div class="col-sm-11">
			<div align="center">
				<button name="button" class="btn btn-info2" id="updateTradePostView">글수정</button>
				<button name="button" class="btn btn-info3" id="deleteTradePost">글삭제</button>
			</div>
		</div>
	</div>
		<div class="row">
			<div class=col-sm-12><br><br><br><br>
		</div>
	</div>
</c:if>


<!-- 
<div class="modal fade" id="passwordModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">판매자 평가</h4>
			</div>

			<div class="modal-body">
				<p>별점을 입력해 주세요.</p>
				<div>
					<form id="exgForm" action="exchangePoint.do">
						<input type="password" min="0" name="password" id="password"
							class="form-control" placeholder="password"
							style="width: 30%; margin: 0 auto;" required="required">
						<input type="button" class="btn btn-info form-control" id="exgBtn"
							style="width: 30%; margin: 0 auto;" data-dismiss="modal"
							value="확인">
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

 -->

