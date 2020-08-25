<%@ page import="com.board.bean.BbsBean" %> 
<%@ page import="com.board.dao.BoardDAO" %>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>OLIVE YOUNG</title>

	<!-- Style -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css" />
	<link rel="stylesheet" href="css/userCss/usernormal.css">
	<link rel="stylesheet" href="css/userCss/mypagerepw.css" />
	<link rel="stylesheet" href="css/userCss/mypagemodal.css" />
	
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
			
	<!-- 본 메뉴 -->
	<div id="container">
			<div class="wide_menu">
				<div class="menu">
					<h2><a href="myPage.bo">마이페이지</a></h2>
					<p><a href="myPageManage1.bo" id="on">정보관리</a></p>
					<!-- <p><a href="orderList.vo">주문조회</a></p> -->
					<p><a href="wishList.jsp">위시리스트</a></p>
				</div>
			</div>
		
			<article>
				<h2>정보관리</h2>
			<!--<div class="tabSmallMenu">
					<ul>
						<li class="on"><a href="myPage1.do">회원정보 수정</a></li>
						<li><a href="myPage3.do">비밀번호 수정</a></li>
					</ul>
				</div>	-->
				<div class="pwReConfirm">
					<h3>회원님의 비밀번호를 한 번 더 확인해주세요.</h3>
					<div class="pwReConfirmForm">
						<form name="rePwForm" action="rePwCheckAction.do" method="post">
							<div class="fieldL">비밀번호 재확인</div>
							<div class="fieldR">
								<input type="password" name="rePw" id="rePw" maxlength="20" size="20" autocomplete="off" />
								<div class="confirmBtn" onclick="rePwCheck();">확인</div>
								<small class="hideTx">비밀번호를 입력해주세요.</small>	<!-- 숨겨져있음 -->
							</div>
						</form>
						<div class="sub">
						<!--<p>&#183;&nbsp;&nbsp;개인정보 보호를 위해 주기적으로 비밀번호를 변경해 주시고, 타인에게 비밀번호가 노출되지 않도록 주의해 주세요</p> -->
							<p>&#183;&nbsp;&nbsp;엔터를 누르지 마시고, 버튼을 클릭해주세요.</p>
						</div>
					</div>
				</div>
			</article>
		</div>	<!-- container 끝 -->
		
		
		<!-- 비밀번호 체크 모달 -->
		<div class="modal" id="RePwMd">
		    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
		    
		    <div class="modal_content">
		        <h2 id="modal_text">현재 비밀번호가 일치하지 않습니다.<br/>다시 입력하여 주세요.</h2>
		        <div class="containerBtn">
			        <div class="styleBtn" id="offBtn2">확인</div>
		        </div>
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
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
	
	<script>
		/* 비밀번호 모달창 안 버튼 */
		// 확인 버튼 : 모달 창이 닫힌다.
		document.getElementById("offBtn2").onclick = function() {
	    	$("#RePwMd").css("display", "none");
	        $('body').css("overflow", "auto");
	    }
	</script>
	
	<!-- 비밀번호 입력창 -->
	<script type="text/javascript">
		/* 자바스크립트의 예약어 return의 역할
		 * 1. 함수를 사용할 때 반환값을 얻어낸다.
		 * 2. 함수 내부의 변수들은 전역변수가 아닌 지역변수를 사용하게 되는데, 
		 	  지역 변수의 값을 알아야 하는 경우에도 return을 사용해 반환시켜서 알 수 있다.
		 * 3. 해당 함수를 싱행중에 중지시키는 역할도 한다. 즉, 아직 실행해야 할 코드들이 남은 상태에서도 원하는 경우 escape 할 수 있다. 
		 */
		function nullCheck() {
			var rePw = $("#rePw");
			
			if(rePw.val() == '') {
				rePw.css('border', '1px solid #FA5855');	/* 빨강 */
				$('.hideTx').css('display', 'block');
				return false;
			} else {
				// 뭐라도 입력했다면
				rePw.css('border', '1px solid #dcdcdc');	/* 회색 */
				$('.hideTx').css('display', 'none');
			}
			return true;
		} 

		function rePwCheck() {
			var nullChk = nullCheck();
			if(nullChk == false) return;
				
			var rePw =  $("#rePw").val();	// Ajax에 사용할 변수
			
			$.ajax({
	            async: true,	// Ajax을 동기 방식으로 처리하고 싶을 때는 false
	            type : 'POST',
	            data : {rePw : rePw},	// 넘기고자 하는 데이터의 이름을 정해주고(파라미터 변수), 값을 넣어준다.
	            url : "rePwCheckAction.aj",	// 해당 url로 data를 넘겨준다. : 앞에 슬러쉬(/) 넣지 말길! olive프로젝트 경로를 못찾음
	            dataType : "json",
	            success : function(result) {	// 성공적으로 수행되었다면 result로 값 반환 : url 에서 넘겨준 결과값
	            	// console.log("입력한 비밀번호 : " + rePw);
	            
	                if (result == 1) {			// 비밀번호가 일치합니다. -> 다음 화면으로 넘긴다.
	                	location.href = 'myPageManage2.bo';
	                    
	                }else if(result == 0) {		// 비밀번호가 일치하지 않는다.
	                	$('#RePwMd #modal_text').html('현재 비밀번호가 일치하지 않습니다.<br/>다시 입력하여 주세요.');
	                	$("#RePwMd").css("display", "block");
	        			$('body').css("overflow", "hidden");
	        			$('#rePw').val('');
	                }else {
	                	$('#RePwMd #modal_text').html('에러가 발생했습니다.<br/>다시 시도해 주세요.');
	                	$("#RePwMd").css("display", "block");
	        			$('body').css("overflow", "hidden");
	        			$('#rePw').val('');
	                }
	            },
	            // 에러처리
	            error : function(error) {
	            	$('#RePwMd #modal_text').html('에러가 발생했으니 관리자에게 문의해주세요.');
                	$("#RePwMd").css("display", "block");
                	$('body').css("overflow", "hidden");
                	$('#rePw').val('');	// 입력한 내용이 사라진다.
	            }
	        });
		}	
	</script>
</body>
</html>