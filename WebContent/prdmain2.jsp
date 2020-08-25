<%@ page import = "java.util.HashMap, com.shop.bean.Prd, java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OLIVE YOUNG</title>
<link rel="stylesheet" href="css/maincss/jquery.mCustomScrollbar.min.css">
<link rel="stylesheet" href="css/maincss/jquery-ui.css">
<link rel="stylesheet" href="css/maincss/slick.css">
<link rel="stylesheet" href="css/maincss/slick-theme.css">
<link rel="stylesheet" href="css/maincss/common.css">
<link rel="stylesheet" href="css/maincss/shoppingmainlist.css">

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="js/easings.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="js/jquery.inview.js"></script>
<script src="js/slick.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.js"></script>
<script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.js"></script>
<script src="https://www.jsviews.com/download/jsrender.min.js"></script>
<script src="js/json2.js"></script>
<script src="js/map.js"></script>
<script src="js/id.common.js"></script>
<script src="js/date.js"></script>
<script src="js/valid.js"></script>
<script src="js/paging.js"></script>
<script src="js/dr.common.js"></script>
<script src="js/dr.cart.js"></script>
<script src="js/jart.common.js"></script>
<script src="js/ul.js"></script>
<script src="js/ul_main"></script>
<script src="js/ptdslick.js"></script>
</head>
<body>
	<div class="skipNavi">
		<ul>
			<li><a href="#header">주메뉴 바로가기</a></li>
			<li><a href="#container">본문 바로가기</a></li>
			<li><a href="#footer">하단메뉴 바로가기</a></li>
		</ul>
	</div>

	<div class="MAIN" id="wrap">
		<div class="textBanner" id="topBnr" style="background: rgb(0, 184, 186); display: none;">
			<div id="topBnrList">
			</div>
		</div>
	
		<!-- 왼쪽메뉴 -->
		<header id="header">
			<div class="header">
				<div class="fixmenu">
					<a class="plus" href="home.jsp">
						<span></span>
						<span></span>
						<span class="blind">Home</span>
					</a>
					<a class="all-menu" href="javascript:void(0);">
						<span></span>
						<span></span>
						<span></span>
					</a>
					<div class="util">
						<ul>
							<li class="mypage">
								<%
								String id = (String)session.getAttribute("id");
								// System.out.println("home.jsp로 넘어올 때 id : " + id);	
									
								if(id == null) {
								%>
								<%
								} else {
									if(id.equals("admin")) {
								%>		
										<a href="userListAction.bo">
											<img src="img/user.svg" alt="userList" />
											<span class="blind">회원정보</span>
										</a>
								<%
									} else {
								%>	
										<a href="myPage.bo">
											<img src="img/user.svg" alt="myPage" />
											<span class="blind">마이페이지</span>
										</a>
								<%		
									}
								}
								%>
							</li>
							<li class="cart">
								<a href="ShoppingCart.jsp">
									<img src="img/shopping-cart.svg" alt="cart" />
									<span class="blind">장바구니</span>
									<span class="n" id="hCartCnt"></span>
								</a>
							</li>
							<li class="search">
								<a href="seach.jsp">
									<img src="img/search02.png" alt="search" />
									<span class="blind">검색</span>
								</a>
							</li>
							<c:if test="${id == null}">
							<li class="login">
								<a href="userLogin.bo">
									<img src="img/user.svg" alt="login" />
									<em>로그인</em>
								</a>
							</li>
							</c:if>
							<c:if test="${id!=null}">
							<li class="login">
								<a href="userLogoutAction.bo">
									<img src="img/user.svg" alt="logout" />
									<em>로그<br/>아웃</em>
								</a>
							</li>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="gnbwrap">
					<p class="logo">
						<a href="home.jsp">
							<img src="img/logo.jpg" alt="logo" />
						</a>
					</p>
					<div class="gnbIn">
						<div>
							<ul id="gnb">
								<li><a href="prdList.vo">제품</a></li>	<!-- prdmain2.jsp -->
								<li><a href="main.do">이벤트</a></li>
								<%	
									if(id == null) {
								%>
								<%
									} else {
										if(id.equals("admin")) {
								%>		
											<li><a href="userListAction.bo">회원정보</a></li>
								<%
										} else {
								%>	
											<li><a href="myPage.bo">마이페이지</a></li>
								<%		
										}
									}
								%>		
							</ul>
						</div>
					</div>
				</div>
			</div>
		</header>
		
		<div class="shopmain" id="container">
			<div  class="wideContents">
				<div class="topGnb shopGnb" id="topGnb">
					<p class="topGnbTitle">
						<a href="prdList.vo">제품</a>
					</p>
					<!-- 상단메뉴 -->
				<!--<ul data-activetopgnb="all">
						<li id="topGnb_all">
							<a href="#" >모든제품</a>
						</li>
						<li class="hasSub" id="topGnb_gift">
							<a href="#" style="color: rgb(204,0,102);">공식몰 단독 혜택</a>
							<div class="snb" style="height: 0px; z-index: 10;">
								<ul>
									<li class=""><a href="#">#자외선철벽방어</a></li>
									<li class=""><a href="#">여름철바디케어</a></li>
								</ul>
							</div>
						</li>
						<li class="hasSub" id="topGnb_solution">
							<a href="#">민감피부솔루션</a>
							<div class="snb">
								<ul>
									<li class=""><a href="#">회복진정</a></li>
									<li class=""><a href="#">수분공급</a></li>
									<li class=""><a href="#">트러블케어</a></li>
									<li class=""><a href="#">SUN 케어</a></li>
									<li class=""><a href="#">안티폴루션</a></li>
									<li class=""><a href="#">보습장벽케어</a></li>
									<li class=""><a href="#">커버케어</a></li>
									<li class=""><a href="#">미백&광채</a></li>
									<li class=""><a href="#">결/각질케어</a></li>
									<li class=""><a href="#">안티에이징</a></li>
									<li class=""><a href="#">스팟관리</a></li>
									<li class=""><a href="#">모공관리</a></li>
								</ul>
							</div>
						</li>
						<li class="hasSub" id="topGnb_item">
							<a href="#">유형별</a>
							<div class="snb">
								<ul>
									<li class=""><a href="#">토너/미스트</a></li>
									<li class=""><a href="#">세럼/에센스</a></li>
									<li class=""><a href="#">크림/로션</a></li>
									<li class=""><a href="#">마스크/팩</a></li>
									<li class=""><a href="#">선케어</a></li>
									<li class=""><a href="#">비비크림</a></li>
									<li class=""><a href="#">메이크업</a></li>
									<li class=""><a href="#">클렌징</a></li>
									<li class=""><a href="#">스크럽/필링</a></li>
									<li class=""><a href="#">바디케어</a></li>
									<li class=""><a href="#">립/아이</a></li>
									<li class=""><a href="#">ACC</a></li>
								</ul>
							</div>
						</li>
						<li class="hasSub" id="topGnb_line">
							<a href="#">라인별</a>
							<div class="snb">
								<ul>
									<li class=""><a href="#">바이탈 하이드라솔루션</a></li>
									<li class=""><a href="#">솔라바이옴</a></li>
									<li class=""><a href="#">시카페어</a></li>
									<li class=""><a href="#">크라이오 러버</a></li>
									<li class=""><a href="#">컨트롤에이</a></li>
									<li class=""><a href="#">세라마이딘</a></li>
									<li class=""><a href="#">에브리 선 데이</a></li>
									<li class=""><a href="#">더메이크업</a></li>
									<li class=""><a href="#">더마클리어</a></li>
									<li class=""><a href="#">더마스크</a></li>
									<li class=""><a href="#">V7</a></li>
									<li class=""><a href="#">펩타이딘</a></li>
									<li class=""><a href="#">알엑스</a></li>
									<li class=""><a href="#">포맨</a></li>
									<li class=""><a href="#">비 펩타이드</a></li>
								</ul>
							</div>
						</li>
						<li class="topGnb_special">
							<a href="#">온라인세트</a>
						</li>
						<li class="topGnb_prdRevw">
							<a href="#">제품 리뷰</a>
						</li>
					</ul> -->
				</div>
			</div>
		</div>
		<!-- 첫번째 배너 -->
		<div class="topVisual slick-slider">
			<div class="item slick-slide" >
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595983667066.jpg" style="height: 100%;"/>
				<div class="con">
					<p class="txt">올리브영과 퀴즈 풀고<br />럭키한 혜택을 확인해보세요</p>
					<p class="subtxt">올리브영 회원만 즐길 수 있는 특별한 파티<br />럭키럭키한 이벤트를 지금 바로 확인해보세요!<br /></p>		
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1594880991821.jpg"/>
				<div class="con">
					<p class="txt">WATERFUL<br />SUMMER</p>
					<p class="subtxt">여름철 무더위에 지친 피부를 위한<br />공홈만의 특별한 수분 3종 혜택받으세요!<br /></p>	
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595578309313.jpg" />
				<div class="con">
					<p class="txt">올리브영이랑 힐링 픽셀아트해요<br />영광의 당선작을 발표합니다.</p>
					<p class="subtxt">두근두근 힐링픽셀아트의 수상작을 함께 만나보세요!</p>			
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595551573841.gif"/>
				<div class="con">
					<p class="txt">Healthy Skin,<br />Healthy Earth</p>
					<p class="subtxt">건강한 아름다움을 위한 올리브영의 약속!<br />친환경 패키지로 바꿔갈 모습을 기대해 주세요<br /></p>		
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595380262636.jpg"/>
				<div class="con">
					<p class="txt">티트리먼트로<br />스팟고민 ALL KILL!</p>
					<p class="subtxt">아침부터 저녁까지 자극으로 예민해진 내 피부,<br />티트리먼트로 케어하세요!</p>		
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595207154531.jpg"/>
				<div class="con">
					<p class="txt">당신이 잠든 사이<br />수분으로 깨어나는 피부</p>
					<p class="subtxt">밤 사이 지친 피부를 관리하는 #딥슬립크림팩<br />나이트 테라피 마스크를 만나보세요!</p>		
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1593565883862.jpg"/>
				<div class="con">
					<p class="txt">첫 만남을<br />기념하는 선물</p>
					<p class="subtxt">올리브영 공홈에서 첫 구매하고<br />베스트 제품을 체험해보세요!</p>		
				</div>
			</div>
			<div class="item slick-slide">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595206805240.jpg"/>
				<div class="con">
					<p class="txt">더 예쁜 내일을 위한<br />바이옴으로 셀프 홈케어해요<br /><br /><br /></p>
					<p class="subtxt">수분 바이옴과 함께하는 셀프 홈케어로 민감함은 지우고 촉촉한 피부로 가꿔보세요!</p>		
				</div>
			</div>
		</div>
		<!-- 베스트 셀러 -->
		<div class="section bestseller" id="best">
			<c:if test="${prdList != null }">
			<div class="title">
				<h3>베스트셀러 TOP5</h3>
			</div>
			<div class="pdtListArea">
				<ul class="pdtList public" id="pdtList">
					<c:forEach var = "prd" items="${prdList }" varStatus="status">
					<li class="pdtItem">
						<div class="pdtWrap">
							<a name="btaDtlView">
								<div class="pdtThumb">
									<span class="opt_thumb">
										<img src="img/${prd.image}" />
									</span>
								</div>
								<div class="opt_flag">
									<span class="flag new">NEW</span>
									<span class="flag best">BEST</span>
									<span class="flag gift">GIFT</span>
								</div>
								<div class="pdtInfo">
									<p class="opt_msg">${prd.content }</p>
									<p class="opt_tit">${prd.name}</p>
									<span class="opt_price">
										<span class="cost type2">${prd.price}</span>
									</span>
								</div>
							</a>
							<div class="opt_buying">
							<!--<a class="btn_plus btnSizeM" href="#">
									<span class="fl"></span>
									<span class="sfl"></span>
									<span class="cross"></span>
									<i></i>
									<p>바로구매</p>
								</a> -->
								<a class="btn btnType1 btnSizeM cart" href="prdCartAdd.vo?id=${prd.id}">
									<img src="img/shopping-cart.svg">
									<span>장바구니</span>
								</a>
								<a class="btn btnType1 btnSizeM wish" href="addWishlist.vo?id=${prd.id}">
									<img src="img/heart.svg">
									<span>관심상품</span>
								</a>
							</div>
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
			</c:if>
		</div>
		<!-- 두 번째 배너 -->
		<div class="section promoBan slick-slider">
			<div class="item slick-active">
				<img src="https://image.drjart.com/img/008/1593566975913.jpg"  class="bgImg"/>
				<div class="con">
					<p class="txt">Only OLIVE YOUNG<br />Membership Chance</p>
					<p class="subtxt">올리브영 회원만 받을 수 있는 특별 구매 금액대별 사은품</p>
				</div>
			</div>
			<div class="item slick-active">
				<img src="https://image.drjart.com/img/008/1593566624062.jpg" class="bgImg"/>
				<div class="con">
					<p class="txt">소중한 고객님의<br />생일을 축하드립니다.</p>
					<p class="subtxt">생일이신 프리미엄 등급 고객님께 수분 바이옴 키트를 드립니다.</p>
				</div>
			</div>
		</div>
		<div class="section recommend" id="recommend">
			<div class="title">
				<h3>온라인 헤택제품<span style='color: #999; font-size: 16px; font-weight: 600;'> (구매불가) </span></h3>
			</div>
			<div class="pdtListArea">
				<ul class="pdtList public" id="pdtList">
					<li class="pdtItem">
						<div class="pdtWrap">
							<a name="btaDtlView">
								<div class="pdtThumb">
									<span class="opt_thumb">
										<img src="https://image.drjart.com/img/001/1589852789984.png"  alt=""/>
									</span>
								</div>
								<div class="opt_flag">
									<span class="flag new">NEW</span>
									<span class="flag sale">SALE</span>
								</div>
								<div class="pdtInfo">
									<p class="opt_msg">#시카리페어세럼</p>
									<p class="opt_tit">2세대 시카페어 세럼</p>
									<span class="opt_price">
										<span class="cost type2">
											<span class="normal">39,000</span>
										37,050
									</span>
								</span>
							</div>
						</a>
					<!--<div class="opt_buying">
							<a class="btn_plus btnSizeM" href="#">
								<span class="fl"></span>
								<span class="sfl"></span>
								<span class="cross"></span>
								<i></i>
								<p>바로구매</p>
							</a>
							<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
								<img src="img/shopping-cart.svg">
								<span>장바구니</span>
							</a>
							<a class="btn btnType1 btnSizeM wish" href="#">
								<img src="img/heart.svg">
								<span>관심상품</span>
							</a>
						</div> -->
					</div>
				</li>
				<li class="pdtItem">
					<div class="pdtWrap">
						<a name="btaDtlView">
							<div class="pdtThumb">
								<span class="opt_thumb">
									<img src="https://image.drjart.com/img/001/1594821291599.png"  alt=""/>
								</span>
							</div>
							<div class="opt_flag">
								<span class="flag new">NEW</span>
							</div>
							<div class="pdtInfo">
								<p class="opt_msg">#수분체질개선_에센스</p>
								<p class="opt_tit">바이탈 하이드라 솔루션 바이옴 에센스 5mL</p>
								<span class="opt_price">
									<span class="cost type2">49,000</span>
								</span>
							</div>
						</a>
					<!--<div class="opt_buying">
							<a class="btn_plus btnSizeM" href="#">
								<span class="fl"></span>
								<span class="sfl"></span>
								<span class="cross"></span>
								<i></i>
								<p>바로구매</p>
							</a>
							<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
								<span>장바구니</span>
							</a>
							<a class="btn btnType1 btnSizeM wish" href="#">
								<span>관심상품</span>
							</a>
						</div> -->
					</div>
				</li>
				<li class="pdtItem">
					<div class="pdtWrap">
						<a name="btaDtlView">
							<div class="pdtThumb">
								<span class="opt_thumb">
									<img src="https://image.drjart.com/img/001/1590393773811.png"  alt=""/>
								</span>
							</div>
							<div class="opt_flag">
								<span class="flag sale">SALE</span>
							</div>
							<div class="pdtInfo">
								<p class="opt_msg">#함께해서 15% SALE</p>
								<p class="opt_tit">티트리먼트 대용량 2종 세트</p>
								<span class="opt_price">
									<span class="cost type2">
										<span class="normal">67,000</span>
										56,950
									</span>
								</span>
							</div>
						</a>
					<!--<div class="opt_buying">
							<a class="btn_plus btnSizeM" href="#">
								<span class="fl"></span>
								<span class="sfl"></span>
								<span class="cross"></span>
								<i></i>
								<p>바로구매</p>
							</a>
							<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
								<img src="img/shopping-cart.svg">
								<span>장바구니</span>
							</a>
							<a class="btn btnType1 btnSizeM wish" href="#">
								<span>관심상품</span>
							</a>
						</div> -->
					</div>
				</li>
				<li class="pdtItem">
					<div class="pdtWrap">
						<a name="btaDtlView">
							<div class="pdtThumb">
								<span class="opt_thumb">
									<img src="https://image.drjart.com/img/001/1591091284160.png"  alt=""/>
								</span>
							</div>
							<div class="opt_flag">
								<span class="flag gift">GIFT</span>
								<span class="flag sale">SALE</span>
							</div>
							<div class="pdtInfo">
								<p class="opt_msg">#함께해서 15% SALE</p>
								<p class="opt_tit">티트리먼트 대용량 3종 세트</p>
								<span class="opt_price">
									<span class="cost type2">
										<span class="normal">94,000</span>
										79,900
									</span>
								</span>
							</div>
						</a>
					<!--<div class="opt_buying">
							<a class="btn_plus btnSizeM" href="#">
								<span class="fl"></span>
								<span class="sfl"></span>
								<span class="cross"></span>
								<i></i>
								<p>바로구매</p>
							</a>
							<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
								<img src="img/shopping-cart.svg">
								<span>장바구니</span>
							</a>
							<a class="btn btnType1 btnSizeM wish" href="#">
								<span>관심상품</span>
							</a>
						</div> -->
					</div>
				</li>
				<li class="pdtItem">
					<div class="pdtWrap">
						<a name="btaDtlView">
							<div class="pdtThumb">
								<span class="opt_thumb">
									<img src="https://image.drjart.com/img/001/1587022010571.png"  alt=""/>
								</span>
							</div>
							<div class="opt_flag">
								<span class="flag sale">SALE</span>
							</div>
							<div class="pdtInfo">
								<p class="opt_msg">#민감피부선크림</p>
								<p class="opt_tit">솔라바이옴 징크림 특별 기획세트</p>
								<span class="opt_price">
									<span class="cost type2">
										<span class="normal">29,000</span>
										26,100
									</span>
								</span>
							</div>
						</a>
					<!--<div class="opt_buying">
							<a class="btn_plus btnSizeM" href="#">
								<span class="fl"></span>
								<span class="sfl"></span>
								<span class="cross"></span>
								<i></i>
								<p>바로구매</p>
							</a>
							<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
								<img src="img/shopping-cart.svg">
								<span>장바구니</span>
							</a>
							<a class="btn btnType1 btnSizeM wish" href="#">
								<span>관심상품</span>
							</a>
						</div> -->
					</div>
				</li>
			</ul>
		</div>
	</div>
	<!-- 마지막 이미지 -->
 	<div class="section" id="personalization">
	 	<div class="inside" id="insideArea">
	 		<div class="insec">
	 			<div class="con">
	 				<span class="cate">NEW PRODUCT STORY</span>
	 				<h3 class="tit">태양에 맞서는<br />강력한 차단의 힘</h3>
	 				<div class="txt">
	 					<p>지구의 솔라스트레스에 맞서는<br/>#우주선크림 솔라바이옴의<br />강력한 피부보호막을 경험해보세요.</p>
	 				</div>
	 			</div>
	 			<div class="vod" style="background-image: url('https://image.drjart.com/img/009/1585722838875.jpg');">
	 				<a class="btn_vod">
	 					<img alt="play" src="img/whiteplay.png" />
	 				</a>
	 			</div>
 			</div>
 		</div>
	 	<div class="pick">
	 		<div class="insec">
	 			<div class="title">
	 				<h3>Today Pick's</h3>
	 				<p class="subtit" id="recopickSubTitleSkin" style="display: none;">
	 					<em>고객님</em>과 동일한 피부타입의 고객이<br />가장 많이 구매한 상품입니다.</p>
	 				<p class="subtit" id="recopickUser" style="display:none;">
	 					<em>고객님</em>에게 추천하는 상품입니다.
	 				</p>
	 				<p class="subtit" id="recopickNonUser" >
	 					올리브영이 추천하는 상품입니다.
	 				</p>
	 			</div>
	 			<div class="pdtListArea">
	 				<div class="pdtList slick-slider" id="pdtList">
	 					<div class="pdtItem">
	 						<div class="pdtWrap">
								<a name="btaDtlView">
									<div class="pdtThumb">
										<span class="opt_thumb">
											<img src="https://image.drjart.com/img/001/1589418738580.png" />
										</span>
									</div>
									<div class="opt_flag">
										<span class="flag best">BEST</span>
									</div>
									<div class="pdtInfo">
										<p class="opt_msg">#똑똑클렌저</p>
										<p class="opt_tit">바이옴 클렌저</p>
										<span class="opt_price">
											<span class="cost type2">22,000</span>
										</span>
									</div>
								</a>
							<!--<div class="opt_buying">
									<a class="btn_plus btnSizeM" href="#">
										<span class="fl"></span>
										<span class="sfl"></span>
										<span class="cross"></span>
										<i></i>
										<p>바로구매</p>
									</a>
									<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
										<img src="img/shopping-cart.svg">
										<span>장바구니</span>
									</a>
									<a class="btn btnType1 btnSizeM wish" href="#">
										<span>관심상품</span>
									</a>
								</div>  -->
							</div>
 						</div>
	 					<div class="pdtItem">
							<div class="pdtWrap">
								<a name="btaDtlView" href="#">
									<div class="pdtThumb">
										<span class="opt_thumb">
											<img src="https://image.drjart.com/img/001/1560475092450.png" />
										</span>
									</div>
									<div class="opt_flag">
									</div>
									<div class="pdtInfo">
										<p class="opt_msg">#탱글수분크림</p>
										<p class="opt_tit">바이탈 하이드라 솔루션 바이옴 워터 크림</p>
										<span class="opt_price">
											<span class="cost type2">38,000</span>
										</span>
									</div>
								</a>
								<div class="opt_buying">
									<a class="btn_plus btnSizeM" href="#">
										<span class="fl"></span>
										<span class="sfl"></span>
										<span class="cross"></span>
										<i></i>
										<p>바로구매</p>
									</a>
									<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
										<img src="img/shopping-cart.svg">
										<span>장바구니</span>
									</a>
									<a class="btn btnType1 btnSizeM wish" href="#">
										<span>관심상품</span>
									</a>
								</div>
							</div>
						</div>
						<div class="pdtItem">
							<div class="pdtWrap">
								<a name="btaDtlView" href="#">
									<div class="pdtThumb">
										<span class="opt_thumb">
											<img src="https://image.drjart.com/img/001/1594876474691.png" />
										</span>
									</div>
									<div class="opt_flag">
										<span class="flag best">BEST</span>
										<span class="flag sale">SALE</span>
									</div>
									<div class="pdtInfo">
										<p class="opt_msg">#223억에센스+톤업샷</p>
										<p class="opt_tit">바이옴 에센스&블루 샷</p>
										<span class="opt_price">
											<span class="cost type2">
												<span class="normal">42,000</span>
												35,700
											</span>
										</span>
									</div>
								</a>
								<div class="opt_buying">
									<a class="btn_plus btnSizeM" href="#">
										<span class="fl"></span>
										<span class="sfl"></span>
										<span class="cross"></span>
										<i></i>
										<p>바로구매</p>
									</a>
									<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
										<img src="img/shopping-cart.svg">
										<span>장바구니</span>
									</a>
									<a class="btn btnType1 btnSizeM wish" href="#">
										<span>관심상품</span>
									</a>
								</div>
							</div>
						</div>
						<div class="pdtItem">
							<div class="pdtWrap">
								<a name="btaDtlView" href="#">
									<div class="pdtThumb">
										<span class="opt_thumb">
											<img src="https://image.drjart.com/img/001/1591944934738.png" />
										</span>
									</div>
									<div class="opt_flag">
										<span class="flag best">BEST</span>
										<span class="flag sale">SALE</span>
									</div>
									<div class="pdtInfo">
										<p class="opt_msg">#수분선앰플</p>
										<p class="opt_tit">솔라바이옴 앰플 특별 기획세트</p>
										<span class="opt_price">
											<span class="cost type2">
												<span class="normal">39,000</span>
												35,100
											</span>
										</span>
									</div>
								</a>
								<div class="opt_buying">
									<a class="btn_plus btnSizeM" href="#">
										<span class="fl"></span>
										<span class="sfl"></span>
										<span class="cross"></span>
										<i></i>
										<p>바로구매</p>
									</a>
									<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
										<img src="img/shopping-cart.svg">
										<span>장바구니</span>
									</a>
									<a class="btn btnType1 btnSizeM wish" href="#">
										<span>관심상품</span>
									</a>
								</div>
							</div>
						</div>
						<div class="pdtItem">
							<div class="pdtWrap">
								<a name="btaDtlView" href="#">
									<div class="pdtThumb">
										<span class="opt_thumb">
											<img src="https://image.drjart.com/img/001/1587021615232.png" />
										</span>
									</div>
									<div class="opt_flag">
										<span class="flag best">BEST</span>
										<span class="flag sale">SALE</span>
									</div>
									<div class="pdtInfo">
										<p class="opt_msg">#프라이머선크림</p>
										<p class="opt_tit">솔라바이옴프라이머 특별기획세트</p>
										<span class="opt_price">
											<span class="cost type2">
												<span class="normal">29,000</span>
												26,100
											</span>
										</span>
									</div>
								</a>
								<div class="opt_buying">
									<a class="btn_plus btnSizeM" href="#">
										<span class="fl"></span>
										<span class="sfl"></span>
										<span class="cross"></span>
										<i></i>
										<p>바로구매</p>
									</a>
									<a class="btn btnType1 btnSizeM cart" href="ShoppingCart.jsp">
									<img src="img/shopping-cart.svg">
										<span>장바구니</span>
									</a>
									<a class="btn btnType1 btnSizeM wish" href="#">
										<span>관심상품</span>
									</a>
								</div>
							</div>
						</div>
 					</div>
 				</div>
 			</div>
 		</div>
	 </div>
 	<div class="section review">
	 	<div class="title">
	 	<!--<h3>베스트 포토리뷰</h3>
	 		<p class="subtit">
	 			고객님들께서 제품 사용 후 남겨주신 베스트 리뷰를 확인하세요.
	 		</p>	-->
	 	</div> 
 	</div>
 	<div class="section fp-auto-height fp-section fp-table" id="sec5" style="height: 859px;">
		<div class="fp-tableCell" style="height: 859px;">
	         <!-- footer  -->
			<footer id="footer">
				 <div class="footerT">
					<div class="foot_menu">
						<ul>
							 <li class="m1">
								<a href="mailto:shjaewon.dev@gmail.com" class="mail">신재원</a>	
							 </li>		
							 <li class="m1">
								<a href="mailto:eunjuoh.dev@gmail.com" class="mail">오은주</a>	
							</li>		
							 <li class="m1">
								<a href="mailto:qmffkrql1108@gmail.com" class="mail">최은비</a>	
							</li>		
						</ul>
					</div>		
				</div>	
				<div class="footerM">
					<div class="footInfo">
						<div class="address">
							<p>
								<span>(04323) 서울특별시 용산구 한강대로 366, 6층 (동자동, 트윈시티)</span>
								<span>&nbsp;&nbsp;&nbsp;대표이사 : 구창근</span>
							</p>
							<p>
								<span>상호명 : 씨제이올리브영 주식회사</span>
								<span>&nbsp;&nbsp;&nbsp;사업자 등록번호 : 809-81-01574</span>
								<span>&nbsp;&nbsp;&nbsp;통신판매업 신고번호 : 2019-서울용산-1428</span>	
							</p>			 
							 <p>
							 	<span>개인정보관리책임자 : 최은비 팀장</span>
							 	<span>&nbsp;&nbsp;&nbsp;고객만족센터 : 1234-5678 ( 운영시간 : 09:00~18:00, 점심시간 : 11:50~12:50 )</span>
							 	<span>&nbsp;&nbsp;&nbsp;FAX : 12-3456-7891</span>
							 </p>				 
							 <p>
							 	<span>전자우편주소 : &nbsp;<a href="mailto:qmffkrql1108@gmail.com" class="mail" style="color: #999999">qmffkrql1108@gmail.com</a></span> 
							 </p>
						</div>
						<small class="copyright">Copyright ⓒ 2019 CJ OliveYoung. All Rights Reserved.</small>
					</div>
				</div>
				<div class="footerB">
					<div class="footMaker">
						<ul>
							<li><span>정보보호 관리체계<br/>ISMS 인증획득</span></li>
						 	<li><span>인증범위 : <br/>온라인쇼핑몰운영(올리브영)</span></li>
						 	<li><span>2017-2019 국가고객만족도 NCSI<br/>NCSI 헬스앤뷰티전문점 부문 3년 연속 1위</span></li>
						 </ul>
					</div>
				</div>
			</footer>	
		</div>
	</div>
</body>
</html>