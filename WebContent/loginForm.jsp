<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>OLIVE YOUNG</title>
	
	<!-- style CSS -->
	<link rel="stylesheet" href="css/userCss/usernormal.css">
	<link rel="stylesheet" href="css/userCss/loginidx.css" />
	
	<script src=https://code.jquery.com/jquery-3.5.1.min.js></script>	
	<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.js"></script>
	<script src="js/jquery.cookie.js"></script>
	<script src="js/easings.js"></script>
	<script src="js/fullpage.js"></script>
	<script src="js/slick.js"></script>
	<script src="https://www.jsviews.com/download/jsrender.min.js"></script>
	<script src="js/json2.js"></script>
	<script src="js/jquery.mousewheel.min.js"></script>
	<script src="js/dr.common.js"></script>
	<script src="js/ul.js"></script>
	<script src="js/dr.scrn.js"></script>
	<script src="js/dr.main.js"></script>
	<script src="js/dr.bnr.cont.js"></script>
	<script src="js/dr.cart.js"></script>
	<script src="js/dr.topBnr.js"></script>
	<script src="js/young.main.js"></script>
	<script src="js/map.js"></script>
	<script src="js/id.common.js"></script>
	<script src="js/date.js"></script>
	<script src="js/valid.js"></script>
	<script src="js/paging.js"></script>
	<!-- 슬라이드 배너  -->
	
	<style>
	.rollBanner>a { 
		height:40px; 
	  	display:block; 
	  	font-size:15px; 
	  	text-align:center; 
	  	line-height:40px; 
	 }
	</style>
	
	<script>
		$.views.helpers({ib: $.ib});
		$.context = "";
	
		main = true;
	
		$(document).ready(function(){ 
		$('.eventView_box .opt_txt').each(function(){ 
			if ($(this).text().length > 220) 
			$(this).text($(this).text().substr(0,220)+"  ...  더보기"); 
			}); 
		});
	</script>
</head>
<body>			
	<div id="wrap">	
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
						<a href="home.jsp"><img src="img/logo.jpg" alt="logo" /></a>
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
		
		
		<div id="container_login">
			<div class="contents">
				<div class="pageTitArea">
					<img src="https://image.drjart.com/front/ko/images/util/icon_loginJoin.gif" alt="">
					<h2 class="title">로그인</h2>
				</div>
				<div class="loginFormArea">
					<div class="loginBox">
						<form name="loginform" action="userLoginAction.bo" method="post">
							<div class="inp_text">
								<input type="text" class="textBox" id="user_id" name="user_id" placeholder="아이디" maxlength="20" autocomplete="off" required />
								<p class="error er_id" style="display: none;">아이디를 입력해주세요.</p>
							</div>
							<div class="inp_text">
								<input type="password" class="textBox" id="user_pw" name="user_pw" placeholder="비밀번호" maxlength="20" size="20" autocomplete="off" required />
								<p class="error er_pw" style="display: none;">비밀번호를 입력해주세요.</p>
							</div>
						</form>
						<p class="error er_c" style="display: none;">아이디 또는 비밀번호가 일치하지 않습니다.</p>
						<div class="btn_wrap">
							<div class="btn_all btnA" id="login_btn" onclick="loginFunc();">로그인</div>
							<div class="btn_all btnB" id="goJoin_btn">회원가입</div>
						</div>			
					</div>	<!-- 회원로그인 끝 -->
				</div>	<!-- loginCon 끝 -->
			</div>	<!-- contents 끝 -->
		</div>	<!-- container 끝 -->
		
		
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
						 	<span>개인정보관리책임자 : 오은주 팀장</span>
						 	<span>&nbsp;&nbsp;&nbsp;고객만족센터 : 1234-5678 ( 운영시간 : 09:00~18:00, 점심시간 : 11:50~12:50 )</span>
						 	<span>&nbsp;&nbsp;&nbsp;FAX : 12-3456-7891</span>
						 </p>				 
						 <p>
						 	<span>전자우편주소 : &nbsp;<a href="mailto:eunjuoh.dev@gmail.com" class="mail" style="color: #999999">eunjuoh.dev@gmail.com</a></span> 
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
	</div>	<!-- wrap 끝 -->
	
	
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
	
	<!-- 버튼 -->
	<script>
		// '회원가입' 버튼
		document.getElementById("goJoin_btn").onclick = function() {
			location.href = 'userJoin1.bo';
	    }
	</script>
	
	<!-- 로그인 버튼 -->
	<script>
		/* 아이디와 비밀번호가 null인지 아닌지 체크하는 함수 */
		function idCheck() {
			var id = $('#user_id');
			
			if(id.val() == "") {
				$('#user_id').css('border', '1px solid #fa5855');
				$('#user_id').css('outline', 'none');	
				// outline은 focus했을 때 테두리가 진하게 변하는 설정을 했었다.
				// outline과 border은 다른 개념이기 때문에 focus 했을 때 두 줄(검은 줄, 빨간 줄)이 생기는 것을 막으려면 없애는 설정을 해줘야 한다.
				$('.er_id').css('display', 'block');
				return false;
				
			} else {
				$('#user_id').css('border', '1px solid #dcdcdc');
				$('.er_id').css('display', 'none');
			}
			return true;
		}
		
		function pwCheck() {
			var pw = $('#user_pw');
			
			if(pw.val() == "") {
				$('#user_pw').css('border', '1px solid #fa5855');
				$('#user_pw').css('outline', 'none');	
				$('.er_pw').css('display', 'block');
				return false;
			} else {
				$('#user_pw').css('border', '1px solid #dcdcdc');
				$('.er_pw').css('display', 'none');
			}		
			return true;
		}
		
		
		/* 로그인버튼 누르면 실행되는 함수 */
		function loginFunc() {
			var idChk = idCheck();	
			var pwChk = pwCheck();
			// 오른쪽 함수가 먼저 실행되고 실행 결과가 왼쪽 변수에 대입되기 때문에 위의 함수들도 실행된다.
			
			if((idChk == false) || (pwChk == false)) return;
			// 둘 중 하나라도 false면 return 한다.
			
			document.loginform.submit();
		}
	</script>
</body>
</html>