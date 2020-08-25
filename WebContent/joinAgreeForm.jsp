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
	<link rel="stylesheet" href="css/userCss/joinagreeform.css" />
	<link rel="stylesheet" href="css/userCss/modal.css" />
	
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


	<div class="right_menu">
		<div class="order">
			<ol>
				<li class="on first">01 이용약관</li>
				<li>02 정보입력</li>
				<li>03 가입완료</li>
			</ol>
		</div>
	</div>
	
	
	<section class="clearFix">
		<div class="joinSection_top">
		<!--	<div class="joinSection_img"> -->
			<img src="https://image.drjart.com/front/ko/images/util/icon_loginJoin.gif" alt="icon" id="icon" />
			<!-- <img src="images/tv.svg" alt="tvIcon" id="tvIcon" /> 
				<img src="images/user-plus.svg" alt="userIcon" id="userIcon" /> -->
		<!--	</div> -->
			<div class="joinSection_title">
				<span>회원 가입</span>
			</div>
		</div>
		
		<div class="joinSection_body">
			<div>
				<p>회원가입 및 정상적인 서비스 이용을 위해 아래 약관을 읽어 보시고, 동의 여부를 결정해 주세요<br/>
					<small>필수 약관을 동의 하셔야 회원가입이 가능합니다.</small>
				</p>
			</div>
		</div>
	</section>
	
	
	<article>
		<div class="joinArticle_top">
			<p>올리브영 회원 약관동의</p>
			<input type="checkbox" id="all_agree" value="전체동의" />
			<label for="all_agree"> &nbsp;전체 동의</label>
		</div>
		<div class="joinArticle_body">
			<span>서비스 이용약관</span>
			<div class="body_service">
				<div>
					<br/>
					<p>제1조(목적)</p><br/>
				    <ul>
				    	<li>
					      	이 약관은 CJ가 운영하는 올리브영 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라
							한다)를 이용함에 있어 사이버 몰과 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
						</li>
				    </ul>
					<br/><br/>	
					<p>제2조(정의)</p><br/>
					<ul>
				     	<li>
				      		①&nbsp;&nbsp;“몰”이란 CJ가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br/><br/>
						</li>
				     	<li>
				      		②&nbsp;&nbsp;“이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br/><br/>
						</li>
						<li>
							③&nbsp;&nbsp;“회원”이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.<br/><br/>
						</li>
						<li>
							④&nbsp;&nbsp;“비회원”이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다. 이용자가 비회원으로 재화 등을 구매하는 경우에도 회원 가입을 전제로 한 조항을 제외하고는 본 약관의 내용이 동일하게 적용됩니다.<br/><br/>
						</li>
				    </ul>
					<br/><br/>							
					<p>제3조 (약관 등의 명시와 설명 및 개정)</p><br/>
					<ul>
						<li>
							①&nbsp;&nbsp;“몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호·모사전송번호·전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 “몰”의 초기 서비스화면(전면) 하단에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br/><br/>
						</li>
						<li>
							②&nbsp;&nbsp;“몰”은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회·배송책임·환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br/><br/>
						</li>
						<li>
							③&nbsp;&nbsp;“몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br/><br/>
						</li>
					</ul>
				</div>
				<input type="checkbox" class="agree_check" id="service_agree" value="서비스동의" />
				<label for="service_agree"> &nbsp;서비스 이용약관 동의 (필수)</label>
			</div>
			<div class="body_privacy">
				<div>
					<p>
						<br/>
						CJ가 올리브영 사이버 몰 이용자로부터 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
						<br/>
						<span>1. 수집하는 개인정보</span><br/>
						회사는 이용자로부터 다음과 같은 개인정보를 수집합니다.<br/><br/>
					</p>
					<ul>
						<li>1)   회원가입 시 수집하는 개인정보는 아래와 같습니다.<br/>
							<ul>
								<li>&nbsp;&nbsp;- 필수 : 아이디, 비밀번호, 이름, 본인 확인 값(CI/DI), 생년월일, 유선전화, 휴대전화, 이메일</li>
							   	<li>&nbsp;&nbsp;- 선택 : 주소, 정보수신동의 여부(SMS, 이메일, 우편물)<br/><br/></li>
							</ul>
						</li>
						<li>
							2)   비회원이 구매 서비스 이용시 수집하는 개인정보는 아래와 같습니다.<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;비회원으로 주문하는 고객들의 E-mail, 연락처, 성명, 주소, 은행계좌번호, 신용카드번호
						</li>
					</ul>
				</div>
				<input type="checkbox" class="agree_check" id="privacy_agree" value="개인정보동의" />
				<label for="privacy_agree"> &nbsp;개인정보 수집/이용 동의 (필수)</label>
			</div>
		</div>
		<div class="joinArticle_btm">
			<div class="btn">
				<div class="btn_all btn_agree" id="modal_open">
					동의
				</div>
				<div class="btn_all btn_notagree" onClick="location.href='home.jsp'">
					동의하지 않음
				</div>
			</div>
		</div>
	</article>
	
	
	<div class="modal">	<!-- 동의버튼 모달 -->
	    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
	    
	    <div class="modal_content">
	        <h2 id="modal_text">서비스 이용약관 동의(필수) 체크 하여 주십시오.</h2>
	        <div class="styleBtn" id="btn_confirm">확인</div>
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

	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
	
	<script>
		/* 체크박스 체크에 따라 다른 모달창 */
		document.getElementById("modal_open").onclick = function() {
			// 둘 다 체크되어 있을 때
			if($("#privacy_agree").prop("checked") && $("#service_agree").prop("checked")) {
				location.href = 'userJoin2.bo';
			
			// '개인정보동의'만 체크되어 있을 때	
			} else if (($("#privacy_agree").is(":checked") == true) && ($("#service_agree").is(":checked") == false)) {
				$(".modal").css("display", "block");
		        $('body').css("overflow", "hidden");
		        $('#modal_text').text('서비스 이용약관 동의(필수) 체크 하여 주십시오.');
		     	// 스크롤이 사라지면서 사라진 공간만큼 body가 이동하는 현상이 생기지만 해결불가..
		    
		    // '서비스이용동의'만 체크되어 있을 때 	
			} else if (($("#privacy_agree").is(":checked") == false) && ($("#service_agree").is(":checked") == true)) {
				$(".modal").css("display", "block");
		        $('body').css("overflow", "hidden");
		        $('#modal_text').html("개인정보 수집/이용 동의 (필수) 체크 하여 <br/>주십시오.");
		        // html태그를 써야 <br/>이 먹힌다.
		        
		    // 아무것도 체크되어 있지 않을 때     
			} else {
				$(".modal").css("display", "block");
		        $('body').css("overflow", "hidden");
		        $('#modal_text').text('전체 동의 체크 하여 주십시오.');
			}
		}	
	   	
		/* 모달창 확인버튼 - 닫기 */
	    document.getElementById("btn_confirm").onclick = function() {
	    	$(".modal").css("display", "none");
	        $('body').css("overflow", "auto");
	    }
	</script>
	    
	<script>	    
		/* 체크박스 전체 선택 */ 
		function allCheckFunc(obj) {
			$(".agree_check").prop("checked", $(obj).prop("checked") );
		}
		
		/* 체크박스 개별 체크시 전체선택 체크 여부 */
		function oneCheckFunc( obj ) {
			var allObj = $("#all_agree");
		
			if($(obj).prop("checked")) {
				checkBoxLength = $(".agree_check").length;
				checkedLength = $(".agree_check:checked").length;
		
				if( checkBoxLength == checkedLength ) {
					allObj.prop("checked", true);
				} else {
					allObj.prop("checked", false);
				}
			} else {
				allObj.prop("checked", false);
			}
		}
		
		$(function() {
			$("#all_agree").click(function() {
				allCheckFunc( this );
			});
			$(".agree_check").each(function() {
				$(this).click(function() {
					oneCheckFunc( $(this) );
				});
			});
		});
	</script>
</body>
</html>