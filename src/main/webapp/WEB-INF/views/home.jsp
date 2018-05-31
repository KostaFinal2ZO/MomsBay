<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section id="slider">
	<!--slider-->
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div id="slider-carousel" class="carousel slide"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#slider-carousel" data-slide-to="0"
							class="active"></li>
						<li data-target="#slider-carousel" data-slide-to="1"></li>
						<li data-target="#slider-carousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="item active">
							<div class="col-sm-6">
								<h1>
									<span>E</span>-SHOPPER
								</h1>
								<h2>Free E-Commerce Template</h2>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua.</p>
								<button type="button" class="btn btn-default get">Get
									it now</button>
							</div>
							<div class="col-sm-6">
								<img src="resources/images/home/girl1.jpg" class="girl img-responsive"
									alt="" /> <img src="resources/images/home/pricing.png" class="pricing"
									alt="" />
							</div>
						</div>
						<div class="item">
							<div class="col-sm-6">
								<h1>
									<span>E</span>-SHOPPER
								</h1>
								<h2>100% Responsive Design</h2>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua.</p>
								<button type="button" class="btn btn-default get">Get
									it now</button>
							</div>
							<div class="col-sm-6">
								<img src="resources/images/home/girl2.jpg" class="girl img-responsive"
									alt="" /> <img src="resources/images/home/pricing.png" class="pricing"
									alt="" />
							</div>
						</div>
						<div class="item">
							<div class="col-sm-6">
								<h1>
									<span>E</span>-SHOPPER
								</h1>
								<h2>Free Ecommerce Template</h2>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
									sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua.</p>
								<button type="button" class="btn btn-default get">Get
									it now</button>
							</div>
							<div class="col-sm-6">
								<img src="resources/images/home/girl3.jpg" class="girl img-responsive"
									alt="" /> <img src="resources/images/home/pricing.png" class="pricing"
									alt="" />
							</div>
						</div>
					</div>

					<a href="#slider-carousel" class="left control-carousel hidden-xs"
						data-slide="prev"> <i class="fa fa-angle-left"></i>
					</a> <a href="#slider-carousel"
						class="right control-carousel hidden-xs" data-slide="next"> <i
						class="fa fa-angle-right"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!--/slider-->


<section>
		<div class="container">
			<div class="row">
				<div class="col-sm-12 padding-right">
					<div class="features_items"><!-- 최근 등록 상품 -->
						<h2 class="title text-center">최근 등록 상품</h2>
						<div class="col-sm-12">
							
						<div class="product-image-wrapper">
						<div class="single-products">
							<c:forEach items="${requestScope.mainList.list}" var="tpVO" varStatus="i">
								<%-- 게시물 1개 목록 --%>
								<div class="col-sm-4">
									<div class="product-image-wrapper">
										<div class="single-products">
											<div class="productinfo text-center">
												<c:if test="${tpVO.imgAddress eq 'noPhoto'}">
													<img src="${pageContext.request.contextPath}/resources/upload/images/default.png" >
												</c:if>
												<c:if test="${tpVO.imgAddress ne 'noPhoto'}">
													<img src="${pageContext.request.contextPath}/resources/upload/postImg/${tpVO.imgAddress }" >
												</c:if>
												<h4 style="width:100%; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${tpVO.title}</h4><hr>
												<p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;가격 &nbsp;&nbsp;: &nbsp;&nbsp;${tpVO.price}</p>
												<p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;등록일 &nbsp;&nbsp;: &nbsp;&nbsp;${tpVO.regdate}</p>
												<p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성자 &nbsp;&nbsp;: &nbsp;&nbsp;${tpVO.memberVO.name}</p>
											</div>
										</div>
										<div class="choose">
											<ul class="nav nav-pills nav-justified">
												<li><a class = "btn btn-primary" href="trade/detail_trade_post.do?tradePostNo=${tpVO.tradePostNo}">
													<i class="fa fa-plus-square"></i>상세보기
												</a></li>
											</ul>
										</div>
									</div>
								</div>	
							</c:forEach>
						</div>
						</div>
							
							<!-- <div class="product-image-wrapper">
								최근 상품1
							</div>
						<div class="col-sm-4">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img src="resources/images/home/product2.jpg" alt="" />
										<h2>$56</h2>
										<p>Easy Polo Black Edition</p>
										<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
									</div>
									<div class="product-overlay">
										<div class="overlay-content">
											<h2>$56</h2>
											<p>Easy Polo Black Edition</p>
											<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
										</div>
									</div>
								</div>
								<div class="choose">
									<ul class="nav nav-pills nav-justified">
										<li><a href="#"><i class="fa fa-plus-square"></i>Add to wishlist</a></li>
										<li><a href="#"><i class="fa fa-plus-square"></i>Add to compare</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img src="resources/images/home/product3.jpg" alt="" />
										<h2>$56</h2>
										<p>Easy Polo Black Edition</p>
										<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
									</div>
									<div class="product-overlay">
										<div class="overlay-content">
											<h2>$56</h2>
											<p>Easy Polo Black Edition</p>
											<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
										</div>
									</div>
								</div>
								<div class="choose">
									<ul class="nav nav-pills nav-justified">
										<li><a href="#"><i class="fa fa-plus-square"></i>Add to wishlist</a></li>
										<li><a href="#"><i class="fa fa-plus-square"></i>Add to compare</a></li>
									</ul>
								</div>
							</div>
						</div> -->
					</div><!-- 최근 등록 상품 -->
				</div>
			</div>
		</div>
					
		<div class="container">
			<div class="row">
				<div class="col-sm-12 padding-right">
					<div class="recommended_items"><!--  자녀추천  -->
						<h2 class="title text-center">{자녀이름} 추천 상품</h2>
						
						<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
							<div class="carousel-inner">
								<div class="item active">	
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="resources/images/home/recommend1.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="resources/images/home/recommend2.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="product-image-wrapper">
											<div class="single-products">
												<div class="productinfo text-center">
													<img src="resources/images/home/recommend3.jpg" alt="" />
													<h2>$56</h2>
													<p>Easy Polo Black Edition</p>
													<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
												</div>
												
											</div>
										</div>
									</div>
								</div>
							</div>
							 <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
								<i class="fa fa-angle-left"></i>
							  </a>
							  <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
								<i class="fa fa-angle-right"></i>
							  </a>			
						</div>
					</div><!-- 자녀 추천 아이템 -->
				</div>
			</div>
		</div>
	</div>
	</section>
