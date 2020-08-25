<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품페이지</title>
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
<header id="header">
	<div class="header">
		<div class="fixmenu">
			<a class="plus" href="javascript:void(0);">
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
					<li class="login">
						<a href="login.jsp">
							<img src="img/user.svg" alt="login" />
							<em>로그인</em>
						</a>
					</li>
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
						<li>
							<a href="prdList.vo">제품</a>
						</li>
						<li>
							<a href="main.do">이벤트</a>
						</li>
						
						<c:if test="${id!=null}">
						<li>
							<a href="myPageAction.bo">마이페이지</a>
						</li>
						</c:if>
						
						
					</ul>
					<ul class="gnb_util">
						<li>
							<a href="#">멤버십</a>
						</li>
						<li>
							<a href="#">고객만족센터</a>
						</li>
						<li>
							<a href="#">매장안내</a>
						</li>
						<li class="merge_mbr">
							<a class="btn btnType3 btnSizeS"  href="javascript:void(0);">
								<span>통합회원 전환</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<ul class="language">
				<li class="on">
					<a href="javascipt:;">
						<span>KR</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>EN</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>CN</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
</header>
<div class="shopmain" id="container">
	<div  class="wideContents">
		<div class="topGnb shopGnb" id="topGnb">
			<p class="topGnbTitle">
				<a href="#">제품</a>
			</p>
			<ul data-activetopgnb="all">
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
			</ul>
		</div>
	</div>
</div>
<div class="topVisual slick-slider">
		<div class="item slick-slide" >
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595983667066.jpg" style="height: 100%;"/>
				<div class="con">
					<p class="txt">77한 월간 닥자와 퀴즈 풀고<br/>럭키한 혜택을 확인해보세요</p>
					<p class="subtxt">월간 닥자 오직 회원만 즐길 수 있는 특별한 파티<br />럭키럭키한 이벤트를 지금 바로 확인해보세요!<br /></p>
					<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;"><span>자세히 보기</span></span>			
				</div>
			</a>
		</div>
		<div class="item slick-slide">
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1594880991821.jpg"/>
				<div class="con">
					<p class="txt">
					WATERFUL
					<br />
					SUMMER
					</p>
					<p class="subtxt">
					여름철 무더위에 지친 피부를 위한
					<br />
					공홈만의 특별한 수분 3종 혜택받으세요!
					<br />
					</p>
					<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
						<span>자세히 보기</span>
					</span>			
				</div>
			</a>
		</div>
		<div class="item slick-slide">
			<a style="color: rgb(255,255,255);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595578309313.jpg" />
					<div class="con">
						<p class="txt">
						닥자랑 힐링 픽셀아트해요
						<br />
						영광의 당선작을 발표합니다.
						</p>
						<p class="subtxt">
						두근두근 힐링픽셀아트의 수상작을 함께 만나보세요!
						</p>
						<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
							<span>자세히 보기</span>
						</span>			
					</div>
			</a>
		</div>
		<div class="item slick-slide">
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595551573841.gif"/>
					<div class="con">
						<p class="txt">
						Healthy Skin,
						<br />
						Healthy Earth
						</p>
						<p class="subtxt">
						건강한 아름다움을 위한 닥터자르트의 약속!
						<br />
						친환경 패키지로 바꿔갈 모습을 기대해 주세요
						<br />
						</p>
						<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
							<span>자세히 보기</span>
						</span>			
					</div>
			</a>
		</div>
		<div class="item slick-slide">
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595380262636.jpg"/>
					<div class="con">
						<p class="txt">
						티트리먼트로
						<br />
						스팟고민 ALL KILL!
						</p>
						<p class="subtxt">
						아침부터 저녁까지 자극으로 예민해진 내 피부,
						<br />
						티트리먼트로 케어하세요!
						</p>
						<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
							<span>자세히 보기</span>
						</span>			
					</div>
			</a>
	</div>
	<div class="item slick-slide">
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595207154531.jpg"/>
					<div class="con">
						<p class="txt">
						당신이 잠든 사이
						<br />
						수분으로 깨어나는 피부
						</p>
						<p class="subtxt">
						밤 사이 지친 피부를 관리하는 #딥슬립크림팩
						<br />
						나이트 테라피 마스크를 만나보세요!
						</p>
						<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
							<span>자세히 보기</span>
						</span>			
					</div>
			</a>
	</div>
	<div class="item slick-slide">
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1593565883862.jpg"/>
					<div class="con">
						<p class="txt">
						7월 첫 만남을
						<br />
						기념하는 선물
						</p>
						<p class="subtxt">
						닥터자르트 공홈에서 첫 구매하고
						<br />
						베스트 제품을 체험해보세요!
						</p>
						<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
							<span>자세히 보기</span>
						</span>			
					</div>
			</a>
	</div>
	<div class="item slick-slide">
			<a style="color: rgb(0,0,0);" href="#">
				<img class="bgImg" alt=""  src="https://image.drjart.com/img/008/1595206805240.jpg"/>
					<div class="con">
						<p class="txt">
						더 예쁜 내일을 위한
						<br />
						바이옴으로 셀프 홈케어해요
						<br />
						<br />
						<br />
						</p>
						<p class="subtxt">
						수분 바이옴과 함께하는 셀프 홈케어로 민감함은 지우고 촉촉한 피부로 가꿔보세요!
						</p>
						<span class="btn btnType5 btnSizeM" style="border-color: inherit; color: inherit;">
							<span>자세히 보기</span>
						</span>			
					</div>
			</a>
	</div>
</div>
<div class="section bestseller" id="best">
	<div class="title">
		<h3>베스트셀러 TOP5</h3>
	</div>
	<div class="pdtListArea">
		<ul class="pdtList public" id="pdtList">
			<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
						<div class="pdtThumb">
							<span class="opt_thumb">
								<img src="https://image.drjart.com/img/001/1560475092450.png" />
							</span>
						</div>
						<div class="opt_flag">
							<span class="flag new">NEW</span>
							<span class="flag best">BEST</span>
							<span class="flag gift">GIFT</span>
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
						<a class="btn btnType1 btnSizeM wish" href="addWishlist.bo?id=${prd.id }">
						<img src="img/heart.svg">
							<span>관심상품</span>
						</a>
					</div>
				</div>
			</li>
			<li class="pdtItem">
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
			</li>
			<li class="pdtItem">
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
			</li>
			<li class="pdtItem">
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
			</li>
			<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
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
			</li>
		</ul>
	</div>
</div>
<div class="section promoBan slick-slider">
	<div class="item slick-active">
		<a href="#" style="color: rgb(255,255,255);">
			<img src="https://image.drjart.com/img/008/1593566975913.jpg"  class="bgImg"/>
			<div class="con">
				<p class="txt">
				Only Drjart,com
				<br />
				Membership Chance
				</p>
				<p class="subtxt">
				닥터자르트 멤버십만 받을 수 있는 특별 구매 금액대별 사은품
				</p>
				<span class="btn btnType5 btnSizeM" style="border-color:inherit; color: inherit;">
					<span>자세히 보기</span>
				</span>
			</div>
		</a>
	</div>
	<div class="item slick-active">
		<a href="#" style="color: rgb(255,255,255);">
			<img src="https://image.drjart.com/img/008/1593566624062.jpg" class="bgImg"/>
			<div class="con">
				<p class="txt">
				소중한 고객님의
				<br />
				생일을 축하드립니다.
				</p>
				<p class="subtxt">
				7월 생일이신 프리미엄 등급 고객님께 수분 바이옴 키트를 드립니다.
				</p>
				<span class="btn btnType5 btnSizeM" style="border-color:inherit; color: inherit;">
					<span>자세히 보기</span>
				</span>
			</div>
		</a>
	</div>
</div>
<div class="section recommend" id="recommend">
	<div class="title">
		<h3>온라인 헤택제품</h3>
	</div>
	<div class="pdtListArea">
		<ul class="pdtList public" id="pdtList">
			<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
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
			</li>
				<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
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
					<div class="opt_buying">
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
					</div>
				</div>
			</li>
				<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
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
			</li>
				<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
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
			</li>
				<li class="pdtItem">
				<div class="pdtWrap">
					<a name="btaDtlView" href="#">
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
			</li>
		</ul>
	</div>
</div>
 <div class="section" id="personalization">
 	<div class="inside" id="insideArea">
 		<div class="insec">
 			<div class="con">
 				<span class="cate">NEW PRODUCT STORY</span>
 				<h3 class="tit">
 					태양에 맞서는
 					<br />
 					강력한 차단의 힘
 				</h3>
 				<div class="txt">
 					<p>
 						지구의 솔라스트레스에 맞서는
 						<br />
 						#우주선크림 솔라바이옴의
 						<br />
 						강력한 피부보호막을 경험해보세요.
 					</p>
 					<a class="btn_view" href="#">자세히 보기</a>
 				</div>
 			</div>
 			<div class="vod" style="background-image: url('https://image.drjart.com/img/009/1585722838875.jpg');">
 				<a class="btn_vod" href="#">
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
 					<em>고객님</em>
 					과 동일한 피부타입의 고객이
 					<br />
 					가장 많이 구매한 상품입니다.
 				</p>
 				<p class="subtit" id="recopickUser" style="display:none;">
 					<em>고객님</em>
 					에게 추천하는 상품입니다.
 				</p>
 				<p class="subtit" id="recopickNonUser" >
 					닥터자르트가 추천하는 상품입니다.
 				</p>
 			</div>
 			<div class="pdtListArea">
 				<div class="pdtList slick-slider" id="pdtList">
 					<div class="pdtItem">
 						<div class="pdtWrap">
							<a name="btaDtlView" href="#">
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
										<img src="https://image.drjart.com/img/001/1560475092450.png" />
									</span>
								</div>
								<div class="opt_flag">
									<span class="flag new">NEW</span>
									<span class="flag best">BEST</span>
									<span class="flag gift">GIFT</span>
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
 		<h3>베스트 포토리뷰</h3>
 		<p class="subtit">
 			고객님들께서 제품 사용 후 남겨주신 베스트 리뷰를 확인하세요.
 		</p>
 	</div>
 </div>
 <div class="section fp-auto-height fp-section fp-table" id="sec5" style="height: 859px;">
	<div class="fp-tableCell" style="height: 859px;">
         <footer id="footer">
			<div class="footerT">
				<div class="foot_menu">
					<ul>
						<li class="m1"><a href="https://haveandbe.recruiter.co.kr/appsite/company/callSubPage?code1=3000&amp;code2=3100&amp;code3=3110" target="_blank">회사소개</a></li>
						<li class="m2"><a href="javascript:void(0);">이용약관</a></li>
						<li class="m3"><a href="javascript:void(0);">개인정보처리방침</a></li>
						<li class="m4"><a href="javascript:void(0);">이메일주소 무단 수집거부</a></li>
						<li class="m5"><a href="/ko/cs/index">고객만족센터</a></li>
					</ul>
				</div>
				<div class="sitemap">
					<button class="tit">
						<span>Site map</span>
					</button>
					<div class="sitemap_menu">
						<ul>
							<li class="dep1 shop">
								<p><a href="prductmain.jsp">제품</a></p>
								<ul>
									<li><a href="/ko/prd/all">모든제품</a></li>
									<li><a href="/ko/prd/solution?catSeq=63">민감피부솔루션</a></li>
									<li><a href="/ko/prd/item">유형별</a></li>
									<li><a href="/ko/prd/line">라인별</a>
									<li><a href="/ko/prd/special?catSeq=58">온라인세트</a></li>
									<li><a href="/ko/prd/revw/photo/list">제품 리뷰</a></li>
								</ul>
							</li>
							<li class="dep1 event">
								<p><a href="/ko/event/general/progress/list">이벤트</a></p>
								<ul>
									<li><a href="/ko/event/general/progress/list">이벤트</a></li>
									<li><a href="/ko/event/culture/progress/list">문화처방전</a></li>
									<li><a href="/ko/event/general/win/list">당첨자 발표</a></li>
									<li><a href="/ko/event/revw/list">이벤트 리뷰</a></li>
								</ul>
							</li>
							<li class="dep1 inside">
								<p><a href="/ko/jartinside/product/story">스토리</a></p>
								<ul>
									<li><a href="/ko/jartinside/product/story">제품 스토리</a></li>
									<li><a href="/ko/brand/channel/list">소셜채널</a></li>
								</ul>
							</li>
					<li class="dep1 beauty">
						<p><a href="/ko/brand/fltrspce/cmpgn/ing">필터 스페이스</a></p>
						<ul>
							<li><a href="/ko/brand/fltrspce/cmpgn/ing">진행중인 캠페인</a></li>
							<li><a onclick="$.jart.brand.fltrspce.cmpgn.moveToApntPage('view');" href="javascript:void(0);">나의 예약확인</a></li>
							<li><a href="/ko/brand/fltrspce/cmpgn/intro">소개</a></li>
						</ul>						
					</li>
					<li class="dep1 brand">
						<p><a href="/ko/brand/story">브랜드</a></p>
						<ul>
							<li><a href="/ko/brand/story">브랜드 이야기</a></li>
						</ul>
					</li>
					<li class="dep1 cs">
						<p><a href="/ko/cs/index">고객만족센터</a></p>
						<ul>
							<li><a href="/ko/cs/faq/list">FAQ</a></li>
							<li><a href="javascript:$.jart.login.layer.show(function(){location.href='/ko/cs/qna/insert';});">1:1 문의</a></li>
							<li><a href="/ko/cs/notc/list">공지사항</a></li>
							<li><a href="/ko/cs/membership">멤버십 안내</a></li>
							<li><a href="/ko/cs/store/ko/list">매장 안내</a></li>
						</ul>
					</li>
					<li class="dep1 util">
						<p><a href="javascript:$.jart.login.layer.show(function(){location.href='/ko/mypage/index';});">유틸리티</a></p>
						<ul>
							<li><a href="/ko/cstm/joinus01">회원가입</a></li>
							<li><a href="javascript:$.jart.login.layer.show(function(){location.href='/ko/mypage/index';});">마이페이지</a></li>
							<li><a href="ShoppingCart.jsp">장바구니</a></li>
							<li><a href="/ko/mypage/prd/cncr/list">위시리스트</a></li>
							<li><a href="seach.jsp">검색</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div class="familysite">
			<button class="tit">
				<span>Family Site</span>
			</button>
			<ul>
				<li><a href="http://www.dtrtmen.com/" target="_blank">DTRT</a></li>
				<li><a href="http://us.drjart.com/" target="_blank">Dr.Jart US</a></li>
			</ul>
		</div>
		<div class="language">
			<button class="tit">
				<span>Korean</span>
			</button>
			<ul>
				<li><a href="javascript:;">Korean</a></li>
				<li><a href="/en/main/index?lang=en">English</a></li>
				<li><a href="/zh/main/index?lang=zh">Chinese</a></li>
			</ul>
		</div>
	</div>
	<div class="footerM">
		<div class="foot_info">
			<div class="address">
				<p>
					<span>서울특별시 강남구 역삼동 769-8 엠스페이스빌딩, 도로명 주소 ( 서울특별시 강남구 논현로72길 13 M-SPACE 빌딩 해브앤비 )</span>
					<span>대표이사 : 크리스토퍼 킨더슬리 우드</span>
				</p>
				<p>
					<span>상호명 : 해브앤비(주)</span>
					<span>사업자 등록번호 : 214-87-63681</span>
					<span>통신판매업 신고번호 : 2008 서울 강남-2284호
						<a class="btn btnType3 btnSizeXS busnessinfo" href="#" target="_blank"><span class="arr-right">사업자 정보 확인</span></a>
					</span>
				</p>
				<p>
					<span>개인정보관리책임자 : 엄정식 팀장</span>
					<span>고객만족센터 : 1544-5453 ( 운영시간 : 09:00~18:00, 점심시간 : 11:50~12:50 )</span>
					<span>FAX : 02-3462-9051</span>
				</p>
				<p>
					<span>전자우편주소 : <a class="mail" href="mailto:webmaster@drjart.com">webmaster@drjart.com</a></span>
				</p>
			</div>
			<small class="copyright">Copyrightⓒ Have&amp;Be co., Ltd. All rights reserved.</small>
		</div>
		<div class="foot_sns">
			<a class="sns_is" href="https://www.instagram.com/drjart_kr/" target="_blank"><span class="blind">Instagram</span></a>	
			<a class="sns_fb" href="https://www.facebook.com/DrJartPage?fref=photo" target="_blank"><span class="blind">Facebook</span></a> 
			<a class="sns_nv" href="http://post.naver.com/my.nhn?memberNo=2470585" target="_blank"><span class="blind">Naver Blog</span></a>
		</div>
	</div>		
	<div class="footerB">
		<div class="foot_mark">
			<ul>
				<li><i class="mark mark1"></i><span>iso9001,14001 <br>환경경영인증 획득</span></li>
				<li><i class="mark mark2"></i><span>기업 부설 <br>디자인 연구소 인정</span></li>
				<li><a class="btn" onclick="render_pop_escrow();return false;" href="#"><i class="mark mark3"></i><span class="arr-right2">에스크로 서비스 <br>가입사실 확인</span></a></li>
			</ul>
		</div>
	</div>
	
</footer>
</div>
</div>
</body>
</html>