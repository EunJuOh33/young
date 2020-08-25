<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.dao.UserDAO" %>
<%@ page import="com.user.bean.UserBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OLIVE YOUNG</title>
<link rel="stylesheet" href="css/maincss/common.css">
<link rel="stylesheet" href="css/maincss/fullpage.css">
<link rel="stylesheet" href="css/maincss/main.css">
<link rel="stylesheet" href="css/maincss/slick.css">


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.js"></script>
<script src="js/jquery.cookie.js"></script>
<script src="js/easings.js"></script>
<script src="js/fullpage.js"></script>
<script src="js/slick.js"></script>
<script src="https://www.jsviews.com/download/jsrender.min.js"></script>
<script src="js/json2.js"></script>
<script src="js/jquery.mousewheel.min.js"></script>				
<script src="js/ul.js"></script>
<script src="js/ul_main2.js"></script>
<script src="js/ui.shopmain_layer.js"></script>
<script src="js/dr.scrn.js"></script>
<script src="js/dr.main.js"></script>
<script src="js/dr.bnr.cont.js"></script>
<script src="js/young.main.js"></script>
<script src="js/map.js"></script>
<script src="js/id.common.js"></script>
<script src="js/date.js"></script>
<script src="js/valid.js"></script>
<script src="js/paging.js"></script>
<script src="js/dr.common.js"></script>
<script src="js/dr.cart.js"></script>
<script src="js/dr.topBnr.js"></script>
<script src="jsar.common.js"></script>
<script type="text/javascript">

$.views.helpers({ib: $.ib});
$.context = "";

main = true;

</script>


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
				<!--<ul class="gnb_util">
						<li><a href="#">멤버십</a></li>
						<li><a href="#">고객만족센터</a></li>
						<li><a href="#">매장안내</a></li>
						<li class="merge_mbr"><a class="btn btnType3 btnSizeS"  href="javascript:void(0);"><span>통합회원 전환</span></a></li>
					</ul>	-->
				</div>
			</div>
		<!--<ul class="language">
				<li class="on"><a href="javascipt:;"><span>KR</span></a></li>
				<li><a href="#"><span>EN</span></a></li>
				<li><a href="#"><span>CN</span></a></li>
			</ul>	-->
		</div>
	</div>
</header>

<script type="text/javascript">
$(document).ready(function(){
	$.jart.common.cart.getCartList().done(function(data){
		if(data && data.length > 0) {
			$('#hCartCnt').html(data.length);
			$('#hCartCnt').closest('.cart').addClass('active');
		}
	});
	$(".fixmenu .plus").click(function(){
		location.href = "/"
	});
})
</script>

<div id="container">
	<div id="main">
		<div class="quickNavi">
			<ul>
				<li><a href="prdList.vo">제품</a></li>
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
							<li><a href="mypage.bo">마이페이지</a></li>
				<%		
						}
					}
				%>
			</ul>
		</div>
		<div class="mainNavi">
			<ul>
				<li class="">
					<a href="#sec1">
						<i>1</i>
					</a>
				</li>
				<li class="">
					<a href="#sec2">
						<i>2</i>
					</a>
				</li>
				<li class="">
					<a href="#sec3">
						<i>3</i>
					</a>
				</li>
				<li class="">
					<a href="#sec4">
						<i>4</i>
					</a>
				</li>
			</ul>
		</div>
		<div class="mainWrap fullpage-wrapper" style="height: 100%; position: relative; -ms-touch-action: none; transform: translate3d(0px, 0px, 0px); touch-action: none;">
			<div class="section secVisual fp-section fp-table active fp-completely" id="sec1" >
				<div class="fp-tableCell" style="height: 859px;">
					<div class="secIn mVisualWrap slick-slider slick-dotted" >
								<div class="item slick-slide" id="slick-slide20" role="tabpanel" aria-describedby="slick-slide-control20">
									<br style="clear:both;" />
									<img name="attchImg" title="01_main_01_visual_W.gif" class="bgImg" alt=""  src="https://image.drjart.com/img/009/1592871071033.gif" attch_seq="410265" />
									<div class="con">
										<p class="subject">멤버십데이 첫 런칭!<br/>올리브영이 드립니다.</p>
										<p class="subtxt">단 3일간! 무더위에 지친 마음과 피부를 위한<br />혜택을 드립니다.!</p>
									</div>
								</div>
								<div class="item slick-slide " id="slick-slide21" role="tabpanel" aria-describedby="slick-slide-control21" >
									<br style="clear: both;">
									<img name="attchImg" title="title=" class="bgImg" alt="" src="https://image.drjart.com/img/009/1591774231272.gif" attch_seq="409821" >
                                       <div class="con">
                                       	<p class="subject">피부 고민별로 PICK! <br/> 233억에센스+바이옴샷 </p>
                                        <p class="subtxt">바이옴 에센스+바이옴 샷으로<br />내 피부고민에 맞는 피부레시피를 만들어보세요!</p>
									</div>
								</div>
								<div class="item slick-slide" id="slick-slide22" role="tabpanel" aria-describedby="slick-slide-control22" >
                               			<br style="clear: both;">
                               			<img name="attchImg" title="01_main_01_visual_W.jpg" class="bgImg" alt="" src="https://image.drjart.com/img/009/1591678426951.jpg" attch_seq="409758">
                               			<div class="con">
                                			<p class="subject">유튜버 회사원A 꾸준템 <br>바이옴 에센스+블루 샷 </p>
                              				<p class="subtxt">회사원A 추천템 구매하고 <br> 공식몰 추가 혜택도 놓치지마세요!</p>
										</div>
								</div>
								<div class="item slick-slide" id="slick-slide23" role="tabpanel" aria-describedby="slick-slide-control23">
                               		<br style="clear: both;">
                              		<img name="attchImg" title="01_main_01_visual_W.jpg" class="bgImg" alt="" src="https://image.drjart.com/img/009/1591931914157.jpg" attch_seq="409907">
                             		<div class="con">
                            			<p class="subject"> 디렉터파이가 선정한<br />Top of Top 선케어</p>
                             			<p class="subtxt">솔라바이옴 앰플 사용하고 <br />겉바속촉 피부를 느껴보세요!</p>
									</div>
								</div>
								<div class="item slick-slide" id="slick-slide24" role="tabpanel" aria-describedby="slick-slide-control24" >
									<br style="clear: both;">
									<img name="attchImg" class="bgImg" alt="" src="https://image.drjart.com/img/009/1592437221751.jpg" attch_seq="410138">
                                	<div class="con">
                                    	<p class="subject">크라이오러버로 <br />#셀프홈케어♥</p>
                                        <p class="subtxt">크라이오 러버 마스크로 피부 열감은 낮추고<br />자극 받은 피부 결은 시카페어 세럼으로 진정하세요!</p>
									</div>
								</div>
								<div class="item slick-slide" id="slick-slide25" role="tabpanel" aria-describedby="slick-slide-control25" >
                                    <br style="clear: both;">
                                    <img name="attchImg" title="01_main_01_visual_W_01.gif" class="bgImg" alt="" src="https://image.drjart.com/img/009/1591780771253.gif" attch_seq="409851">
                                    <div class="con">
                                        <p class="subject"> 귀차니즘들의 <br />클렌징 해결책! </p>
                                        <p class="subtxt">피부를 건강하게 해주는 <br> 바이옴클렌저로 클렌징 루틴을 바꿔보세요! </p>
									</div>
								</div>
								<div class="item slick-slide" id="slick-slide26" role="tabpanel" aria-describedby="slick-slide-control26" >
									<br style="clear: both;">
                               		<img title="01_main_01_visual_W.jpg" class="bgImg" alt="" src="https://image.drjart.com/img/009/1592301248099.jpg" attch_seq="410017">
                              		 	<div class="con">
                               			<p class="subject">기분 좋은 <br />첫 만남을 위한 선물!</p>
										<p class="subtxt">첫 구매하고,촉촉 수분 케어! <br />#수분고정크림을 체험해 보세요!</p>
									</div>
								</div>
								<div class="item slick-slide" id="slick-slide27" role="tabpanel" aria-describedby="slick-slide-control27" >
	                                <br style="clear: both;">
	                                <img name="attchImg" title="01_main_01_visual_W.jpg" class="bgImg" alt="" src="https://image.drjart.com/img/009/1592266183185.jpg" attch_seq="409994">
	                                <div class="con">
	                                	<p class="subject">여름엔 촉촉 바이옴과<br />커피 한잔의 여유♥</p>
										<p class="subtxt">바이탈하이드라솔루션과 함께 나만의 시원한 홈까페를 즐겨보세요!</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="section secArtist fp-section fp-table active fp-completely"  id="sec2" style="height: 859px;">
						<div class="fp-tableCell" style="height: 859px;">
            				<div class="secIn">
								<div class="artistWrap slick-initialized slick-slider slick-dotted">          		
									<div class="slick-list draggable">
										<div class="slick-track" style="width: 1682px; opacity: 1;">
											<div tabindex="0" class="item slick-slide slick-current slick-active slickAni " id="slick-slide10" role="tabpanel" aria-hidden="false"
									 		aria-describedby="slick-slide-control10" style="left: 0px; top: 0px; width: 1682px; position: relative; z-index: 99; opacity: 1; 
									 		background-image: url('https://image.drjart.com/img/009/1584351429576.jpg');" data-slick-index="0">
												<div class="con" style="color: rgb(0, 0, 0);">
													<span class="t"><br style="clear: both;" />PROJECT #12</span>
													<p class="subject">Vital Hydra Solution<br />#Biome</p>
													<p class="subtxt">우리의 피부 수분체질 개선을 돕기 위해<br />필터스페이스에 바이옴™4총사가 도착했습니다.</p>
												</div>
											</div>
										</div>
                   		 			 </div>
                        			<ul class="slick-dots" role="tablist" >
                        				<li class="slick-active" role="presentation">
                       			 			<button tabindex="0" id="slick-slide-control10" role="tab" aria-selected="true" aria-controls="slick-slide10" aria-label="1 of 1" type="button" >1</button>
                        				</li>
                        			</ul>
                  				</div>
                 			</div>
            			</div>
        			</div>
					<div class="section secStudio fp-section fp-table active fp-completely" id="sec3" style="height: 859px;">
						<div class="fp-tableCell" style="height: 859px;">
               				<div class="secIn">
                				<div class="studioWrap slick-initialized slick-slider slick-dotted">
									<div class="slick-list draggable">
										<div class="slick-track" style="width: 1682px; opacity: 1;">
											<div tabindex="0" class="item slick-slide slick-current slick-active slickAni" id="slick-slide00" role="tabpanel" aria-hidden="false" 
											aria-describedby="slick-slide-control00" style="left: 0px; top: 0px; width: 1682px; position: relative; z-index: 99; opacity: 1;" data-slick-index="0">
												<div class="con" style="color: rgb(34, 34, 34);">
													<span class="t">NEW Product Movie</span>
													<p class="subject">태양에 맞서는<br />강력한 차단의 힘</p>
													<p class="subtxt">지구의 솔라스트레스에 맞서는<br />#우주선크림 솔라바이옴의<br/>강력한 피부보호막을 경험해보세요.</p>
												</div>
											<div class="vod">
												<a style='cursor:default; background-image: url("https://image.drjart.com/img/009/1585722443572.jpg");' href="#" alt="vod">
													<img alt="play" src="img/whiteplay.png"  style= "width: 50px; height: 50px;">
												</a>
											</div>
										</div>
									</div>
								</div>
								<ul class="slick-dots" role="tablist">
									<li class="slick-active" role="presentation">
										<button tabindex="0" id="slick-slide-control00" role="tab" aria-selected="true" aria-controls="slick-slide00" aria-label="1 of 1" type="button">1</button>
									</li>
								</ul>
							</div>
							<div class="vodArea">
							<iframe width="100%" height="100%" title="YouTube video player" class="vodplayer" id="player1"
							src=""  frameborder="0" allowfullscreen="1" allow="accelerometer; autoplay; emcrypted-media; gyroscope; picture-in-picture">
							</iframe>
							<div class="cover">
								<button class="btnStop" onclick="stopVideo();">
									<span class="blind">영상정지</span>
								</button>
							</div>
						</div>
					</div>
           		</div>
         	</div>
			<div class="section secEvt fp-section fp-table active fp-completely" id="sec4" style="height: 859px;">
				<div class="fp-tableCell" style="height: 859px;">
                	<div class="secIn" >
	                    <div class="event_list">
                        <ul>
							<li>
								<a style='cursor:default;' href="javascript:gtag('event', '세라룸', { 'event_category' : 'Ban'}); document.location.href ='/ko/brand/channel/list';">
									<div class="ban">
										<img alt="" src="https://image.drjart.com/img/008/1508994989898.jpg">
										<span></span>
									</div>
									<span class="cate">OLIVE YOUNG Channel</span>
									<p class="subject">신뢰가는 OLIVE YOUNG과 유쾌한 Art 요소들로 만들어가는 뷰티 그램</p>
								</a>
							</li>
							<li>
								<a style='cursor:default;' href="javascript:gtag('event', '세라룸', { 'event_category' : 'Ban'}); document.location.href ='/ko/jartinside/product/story';">
									<div class="ban">
										<img alt="" src="https://image.drjart.com/img/008/1552613750448.jpg">
										<span></span>
									</div>
									<span class="cate">Product Zoom-in</span>
									<p class="subject">시카 스토리, 시카 뮤지엄 등 시카에 대한 모든 이야기</p>
								</a>
							</li>
							<li>
								<a style='cursor:default;' href="javascript:gtag('event', '세라룸', { 'event_category' : 'Ban'}); document.location.href ='/ko/brand/fltrspce/cmpgn/intro';">
									<div class="ban">
										<img alt="" src="https://image.drjart.com/img/008/1508995257263.jpg">
										<span></span>
									</div>
									<span class="cate">Filter Space</span>
									<p class="subject">'물','공기','빛'의 경험! 올리브영 플래그쉽 스토어 </p>
								</a>
							</li>
							<li>
								<a style='cursor:default;' href="javascript:gtag('event', '세라룸', { 'event_category' : 'Ban'}); document.location.href ='/ko/cs/membership';">
									<div class="ban">
										<img alt="" src="https://image.drjart.com/img/008/1508995370143.jpg">
										<span></span>
									</div>
									<span class="cate">Membership</span>
									<p class="subject">다양한 혜택의 올리브영 멤버십 안내!</p>
								</a>
							</li>
						</ul>
         			</div>
					<div class="paging">
					<!--<span class="first">
							<a title="맨 처음" href="javascript:void(0);">
								<img alt="First" src="https://image.drjart.com/front/ko/images/common/arr_pageFirst.png">
							</a>
						</span> 
						<span class="prev">
							<a title="이전 5페이지" href="javascript:void(0);">
								<img alt="Previous" src="https://image.drjart.com/front/ko/images/common/arr_pagePrev.png">
							</a>
						</span> 
						<span class="current">1</span>
						<span class="next">
							<a title="다음 5페이지" href="javascript:void(0);">
								<img alt="Next" src="https://image.drjart.com/front/ko/images/common/arr_pageNext.png">
							</a>
						</span> 
						<span class="last">
							<a title="맨 마지막" href="javascript:void(0);">
								<img alt="Last" src="https://image.drjart.com/front/ko/images/common/arr_pageLast.png">
							</a>
						</span>	-->
					</div>
				</div>
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
					<script>
						function render_pop_escrow() {
							var status  = "width=500 height=450 menubar=no,scrollbars=no,resizable=no,status=no";
							window.open('http://admin.kcp.co.kr/Modules/escrow/kcp_pop.jsp?site_cd=K2959', 'kcp_pop', status);
						}
				
						$('.foot_menu .m2 a').click(function(){
							window.open('/ko/util/service','company1','width=700, height=700, left=0, top=0, location=no, menubar=no, status=no, toolbar=no, scrollbars=yes');
							return false;
						});
						$('.foot_menu .m3 a').click(function(){
							window.open('/ko/util/privacy','company2','width=700, height=700, left=0, top=0, location=no, menubar=no, status=no, toolbar=no, scrollbars=yes');
							return false;
						});
						$('.foot_menu .m4 a').click(function(){
							window.open('/ko/util/emrefuse','company3','width=700, height=525, left=0, top=0, location=no, menubar=no, status=no, toolbar=no');
							return false;
						});
						
					</script>
				</footer>	
			</div>
		</div>
	</div>
</div>
</div>
<script src="ui.shopmain_layer.js"></script>

<script type="text/javascript">
	$.jart.main.bnr.bnr_seq = '34';
	$.jart.main.scrn.cl_cd_main = '001';
	$.jart.main.scrn.scrn_cd_first = '001';
	$.jart.main.scrn.scrn_cd_second = '002';
	$.jart.main.scrn.scrn_cd_third = '003';
	$.jart.main.setIndex()
</script>
<div class="layerPop layerConfirm" id="layer_alert">
			<div class="layerBody">
				<p class="txt"></p>
				<div class="btn_wrap">
					<button class="btn btnType2 btnSizeM ok" onclick="hideLayer('layer_alert');return false;"><span>확인</span></button>
				</div>
			</div>  
		</div>
		<div class="layerPop layerConfirm" id="layer_confirm">
			<div class="layerBody">
				<p class="txt"></p>
				<div class="btn_wrap">
					<button class="btn btnType2 btnSizeM ok" onclick="hideLayer('layer_confirm');return false;"><span>확인</span></button>
					<button class="btn btnType4 btnSizeM cancel" onclick="hideLayer('layer_confirm');return false;"><span>취소</span></button>
				</div>
			</div>  
		</div>
</div>

</body>
</html>