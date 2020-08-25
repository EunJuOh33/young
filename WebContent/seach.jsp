<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OLIVE YOUNG</title>

<link  rel="stylesheet" href="css/maincss/jquery.mCustomScrollbar.min.css">
<link  rel="stylesheet" href="css/maincss/jquery-ui.css">
<link rel="stylesheet" href="css/maincss/slick.css">
<link rel="stylesheet" href="css/maincss/slick-theme.css">
<link rel="stylesheet" href="css/maincss/common.css">
<link  rel="stylesheet" href="css/maincss/search.css">
<link rel="stylesheet" href="css/maincss/ain.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="js/jquery.mousewheel.min.js"></script>
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
<script src="js/ul.js"></script>
<script src="js/dr.common.js"></script>
<script src="js/dr.cart.js"></script>
<script src="js/jart.common.js"></script>
<script src="js/dr.search.js"></script>
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
			<div id="topBnrList"></div>
		</div>
		
		<!-- 왼쪽 메뉴 -->
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
		
		<div class="searchAll" id="container">
			<div class="wideContents">
				<div class="topGnb">
					<p class="topGnbTitle">
						<a href="#">검색</a>
					</p>
				</div>
				<div class="maxContents">
					<div class="unifiedSch">
						<div class="unified_search">
							<input aria-hidden="true" style="display: none; type:password" />
							<input name="inputText" id="inputText" type="text" placeholder="수분크림" />
							<a class="btn_sch" href="javascript:;">
								<span class="blind">검색</span>
							</a>
						</div>
					</div>
				</div>
				<div class="schKeyword" style="height: 415px;">
					<p class="schKeyword_tit">
						<span>이런 검색어는 어떠세요?</span>
					</p>
					<div class="schRolling">
						<div class="rolling slick-slider slick-vertical" style="height:415px;">
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="세라마이딘">세라마이딘</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="미세먼지">미세먼지</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a  href="javascript:;" data-poplrtext="시카페어">시카페어</a>
									</div>
									<div  class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="바디케어">바디케어</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="컨트롤에이">컨트롤에이</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="보습">보습</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="강제방콕">강제방콕</a>
									</div>
									<div class="slick-slide "  style="width: 418px;">
										<a href="javascript:;" data-poplrtext="슬리페어">슬리페어</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="세라마이딘">세라마이딘</a>
									</div>
									<div class="slick-slide " style="width: 418px;">
										<a href="javascript:;" data-poplrtext="미세먼지">미세먼지</a>
									</div>
									<div class="slick-slide" style="width: 418px;" >
										<a href="javascript:;" data-poplrtext="시카페어">시카페어</a>
									</div>
									<div class="slick-slide"  style="width: 418px;">
										<a href="javascript:;" data-poplrtext="바디케어">바디케어</a>
									</div>
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="컨트롤에이">컨트롤에이</a>
									</div>
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="보습">보습</a>
									</div>
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="강제방콕">강제방콕</a>
									</div>
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="슬리페어">슬리페어</a>
									</div>
									<div class="slick-slide"  style="width: 418px;">
										<a href="javascript:;" data-poplrtext="세라마이딘">세라마이딘</a>
									</div>
									<div class="slick-slide"  style="width: 418px;">
										<a href="javascript:;" data-poplrtext="미세먼지">미세먼지</a>
									</div>
									<div class="slick-slide"  style="width: 418px;">
										<a href="javascript:;" data-poplrtext="시카페어">시카페어</a>
									</div>
									<div class="slick-slide"  style="width: 418px;">
										<a href="javascript:;" data-poplrtext="바디케어">바디케어</a>
									</div>
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="컨트롤에이">컨트롤에이</a>
									</div>
									<div class="slick-slide" style="width: 418px;">
										<a href="javascript:;" data-poplrtext="보습">보습</a>
									</div>
								</div>
							</div>
							
							<script type="text/javascript">
								$(function(){
									$('.slick-slider').slick({
										slide: 'div',
										dots: false,
										infinite: true,
										arrows: false,
										vertical: true,
										speed: 1000,
										autoplay: true,
										autoplaySpeed: 500,
										slidesToShow: 5,
										slidesToScroll: 1,
										pauseOnFocus: false,
										cssEase: 'ease-in-out',
										verticalSwiping: true
									});
								});
							</script>
							
						</div>
					</div>
				</div>
				
				<script id="poplrListItemTemplate" type="text/x-jsrender" data-jsv-tmpl="jsvTmpl">
					{{for list}}
					<div><a href="javascript:;" data-poplrtext="{{:srchw_ko_nm}}">{{:srchw_ko_nm}}</a></div>
					{{/for}}
				</script>
				
				<script type="text/javascript">
					$(function(){
						$.jart.search.index.setIndex();
						
						$(document).on('keyup', function (event){
							if(event.keyCode === 13){
								$('.btn_sch').trigger('click');
							}	
						});
					});
				</script>
				
				<div class="layerPop layerConfirm" id="layer_alert">
					<div class="layerBody">
						<p class="txt"></p>
						<div class="btn_wrap">
							<button class="btn btnType2 btnSizeM ok" onclick="hideLayer('layer_alert');return false;">
								<span>확인</span>
							</button>
						</div>
					</div>  
				</div>
				<div class="layerPop layerConfirm" id="layer_confirm">
				<div class="layerBody">
					<p class="txt"></p>
					<div class="btn_wrap">
						<button class="btn btnType2 btnSizeM ok" onclick="hideLayer('layer_confirm');return false;">
							<span>확인</span>
						</button>
						<button class="btn btnType4 btnSizeM cancel" onclick="hideLayer('layer_confirm');return false;">
							<span>취소</span>
						</button>
					</div>
				</div>  
			</div>
		</div>
		<div class="layerPop loginPop" id="loginPop">
				<div class="layerTit">
					<h4>로그인</h4>
					<button class="btn_closeLayer" onclick="hideLayer('loginPop');">
						<span class="blind">레이어팝업 닫기</span>
					</button>
				</div>
				<div class="layerBody">
					<div class="loginCon">
					<!-- 회원로그인 : S -->
					<div class="login_cont loginBox on">
						<div class="inp_text">
						<input name="layer_login_id" id="layer_login_id" type="text" placeholder="아이디">
						<p class="error" style="display: none;">아이디를 입력해주세요.</p>
					</div>
					<div class="inp_text">
						<input name="layer_login_pw" id="layer_login_pw" type="password" placeholder="비밀번호">
						<p class="error" style="display: none;">비밀번호를 입력해주세요.</p>
					</div>
					<ul class="loginInfo_find">
						<li class="find_id"><a href="javascript:void(0);">아이디 찾기</a></li>
						<li class="find_pw"><a href="javascript:void(0);">비밀번호 찾기</a></li>
					</ul>
					<div class="btn_wrap">
						<a class="btn btnType2 btnSizeL" href="javascript:void(0);"><span>로그인</span></a>
						<a class="btn btnType4 btnSizeL" href="javascript:void(0);"><span>회원가입</span></a>
					</div>
					<p class="error al_c" style="display: none;">아이디 또는 비밀번호가 일치하지 않습니다.</p>
				</div>
				
				<!-- 회원로그인 : E -->
				<div class="snsLogin">
					<p>소셜 계정으로 로그인</p>
					<ul class="sns_sign">
						<li class="sns_fabook"><a href="javascript:void(0);">
							<span class="blind">facebook</span></a>
						</li>
						<li class="sns_katalk"><a href="javascript:void(0);">
							<span class="blind">kakaotalk</span></a>
						</li>
						<li class="sns_line"><a href="javascript:void(0);">
							<span class="blind">naver line</span></a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class=" fb_reset" id="fb-root">
		<div style="top: -10000px; width: 0px; height: 0px; position: absolute;">
			<div></div>
		</div>
	</div>
	
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
</body>
</html>