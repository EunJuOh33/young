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
	
	<!-- CSS -->
	<link rel="stylesheet" href="css/userCss/usernormal.css">
	<link rel="stylesheet" href="css/userCss/joinform.css" />
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
				<li class="first">01 이용약관</li>
				<li class="on">02 정보입력</li>
				<li>03 가입완료</li>
			</ol>
		</div>
	</div>
	
	
	<section class="clearFix">
		<div class="joinSection_top">
<!--		<div class="joinSection_img"> -->

			<img src="https://image.drjart.com/front/ko/images/util/icon_loginJoin.gif" alt="icon" id="icon" />
				<!-- <img src="images/tv.svg" alt="tvIcon" id="tvIcon" /> -->
				<!-- <img src="images/user-plus.svg" alt="userIcon" id="userIcon" /> -->
<!-- 		</div> -->
			<div class="joinSection_title">
				<span>회원 가입</span>
			</div>
		</div>
	</section>
	
	
	<article>
		<form name="joinForm" action="userJoinAction.bo" method="post">
		<!-- 전송할 페이지는 userJoinAction.do -->
			<!-- 왼쪽 -->
			<div class="joinArticle_L">
				<div class="joinArticle_title">회원정보 입력</div>
				<div class="L_form">
					<!-- 아이디 -->
					<ul>
						<li id="info"><span>*</span>아이디</li>
						<li id="blank">
							<input type="text" name="user_id" id="user_id" maxlength="20" placeholder="영문 소문자/숫자 조합 6 ~ 20자" autocomplete="off" autofocus required />
							<div class="btn_dup" id="dup" onclick="idDupChkMd();">중복확인</div>
						</li>
					</ul>
					<small class="hideTx" id="idTx1">아이디를 입력해주세요.</small>
					<small class="hideTx" id="idTx2">공백없이 6~20자 이내 영문 소문자/숫자 조합이 가능합니다.</small>
					<small class="hideTx" id="idTx3">중복확인을 해주세요.</small>
					<!-- 비밀번호 -->
					<ul>
						<li id="info"><span>*</span>비밀번호</li>
						<li id="blank">
							<input type="password" name="user_pw" id="user_pw" class="pw" maxlength="20" size="20" placeholder="영문자/숫자 조합 10 ~ 20자" autocomplete="off" required />
						</li>
					</ul>
					<small class="hideTx" id="pwTx1">비밀번호를 입력해주세요.</small>				
					<small class="hideTx" id="pwTx2">공백없이 10~20자 이내 영문자/숫자 조합이 가능합니다.</small>				
					<small id="ex">&#149; 특수문자는 !@#$%^*+=- 만 가능합니다</small>
					<!-- 비밀번호 재확인 -->
					<ul>
						<li id="info"><span>*</span>비밀번호 재확인</li>
						<li id="blank"><input type="password" id="user_pw2" class="pw" placeholder="입력하신 비밀번호를 다시 한번 입력해주세요." autocomplete="off" /></li>
					</ul>
					<small class="hideTx" id="pw_no">입력하신 비밀번호를 다시 한번 입력해주세요.</small>
					<small class="hideTx" id="pw_again">입력된 비밀번호와 일치하지 않습니다.</small>
					<!-- 이름 -->
					<ul>
						<li id="info"><span>*</span>이름</li>
						<li id="blank_name"><input type="text" name="user_name" id="user_name" maxlength="9" size="10" autocomplete="off" required /></li>
					</ul>
					<small class="hideTx" id="nameTx1">이름을 입력해주세요.</small>
					<small class="hideTx" id="nameTx2">이름을 정확하게 입력해주세요.</small>
					<!-- 생년월일 -->
					<ul>
						<li id="info"><span>*</span>생년월일</li>
						<li id="blank_select_birth">	<!-- 제이쿼리 -->
							<select class="user_birth user_year" name="user_birth">
							    <option value="" selected="selected">년</option>
							</select>
							<select class="user_birth user_month" name="user_birth">
							    <option value="">월</option>
							    <option value="01">01월</option>
							    <option value="02">02월</option>
							    <option value="03">03월</option>
							    <option value="04">04월</option>
							    <option value="05">05월</option>
							    <option value="06">06월</option>
							    <option value="07">07월</option>
							    <option value="08">08월</option>
							    <option value="09">09월</option>
							    <option value="10">10월</option>
							    <option value="11">11월</option>
							    <option value="12">12월</option>
							</select>
							<select class="user_birth user_day" name="user_birth">
							    <option value="" selected="selected">일</option>
							    <option value="01">01일</option>
							    <option value="02">02일</option>
							    <option value="03">03일</option>
							    <option value="04">04일</option>
							    <option value="05">05일</option>
							    <option value="06">06일</option>
							    <option value="07">07일</option>
							    <option value="08">08일</option>
							    <option value="09">09일</option>
							</select>
						</li>
					</ul>
					<small class="hideTx" id="birthTx">생년월일을 선택해주세요.</small>
					<!-- 휴대전화 -->
					<ul>
						<li id="info"><span>*</span>휴대전화</li>
						<li id="blank_select">
							<select class="user_phone" id="user_phone1" name="user_phone">
							    <option value="010" selected="selected">010</option>
							    <option value="011">011</option>
							    <option value="016">016</option>
							    <option value="019">019</option>
							</select>
							<div>
								<span>-</span><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4" name="user_phone" class="user_phone" id="user_phone2" size="4" autocomplete="off" />
								<span>-</span><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4" name="user_phone" class="user_phone" id="user_phone3" size="4" autocomplete="off" />
							</div>
						</li>
					</ul>
					<small class="hideTx" id="phoneTx1">휴대전화 번호를 입력해주세요.</small>
					<small class="hideTx" id="phoneTx2">휴대전화 번호를 정확하게 입력해주세요.</small>
					<!-- 이메일 -->
					<ul>
						<li id="info"><span>*</span>이메일</li>
						<li id="blank_select_email">
							<div>
								<input type="text" name="user_email1" id="user_email1" size="4" autocomplete="off" required /><span>@</span>
								<input type="text" name="user_email2" id="user_email2" size="4" autocomplete="off" required /><span id="span_small"> </span>
							</div>
							<select id="user_email3" onChange="mailcheck()">
							    <option value="" selected="selected">직접입력</option>
							    <option value="naver.com">naver.com</option>
							    <option value="hanmail.net">hanmail.net</option>
							    <option value="daum.net">daum.net</option>
							    <option value="nate.com">nate.com</option>
							    <option value="gmail.com">gmail.com</option>
							    <option value="hotmail.com">hotmail.com</option>
							</select>
						</li>
					</ul>
					<small class="hideTx" id="emailTx1">이메일을 입력해주세요.</small>
					<small class="hideTx" id="emailTx2">이메일 주소 형식에 맞지 않습니다. 다시 확인해주세요.</small>
					<!-- 주소 -->
					<ul class="address">
						<li id="info">주소</li>
						<li id="blank_addr">
							<div>	<!-- name 모두 같게 하여 배열로 받는다. -->
								<input type="text" name="user_zip" id="user_zip" maxlength="5" size="5" style="background-color: #EEEEEE; color: #999999;" readonly />	<!-- disable하면 form으로 데이터가 넘어가지 않는다. -->
								<div class="btn_addr" onclick="openZipSearch()">우편번호검색</div>
							</div>
							<input type="text" name="user_addr" id="user_addr1" class="addr_b" style="background-color: #EEEEEE; color: #999999;" readonly />
							<input type="text" name="user_addr" id="user_addr2" class="addr_b" autocomplete="off" />
						</li>
					</ul>
				</div>
			</div>
			
			
			<!-- 오른쪽 -->
			<div class="joinArticle_R">
				<div class="joinArticle_title">추가정보입력</div>
				<div class="R_form">
					<p>추가정보를 입력해주시면 사이트 이용시, 추천 상품과 이벤트 혜택정보를 제공<br/> 받을 수 있습니다.</p>
					<div class="R_check1">
						<ul>
							<li id="check_info">성별</li>
							<li id="check_gender">	<!--name은 똑같이 한다. --> <!-- id 남,여 다르게 했다. -->
								<input type="radio" name="user_gender" id="user_genderM" value="남" />
								<label for="user_genderM">&nbsp;남성</label>
							</li>
							<li id="check_gender">	
								<input type="radio" name="user_gender" id="user_genderW" value="여" />
								<label for="user_genderW">&nbsp;여성</label>
							</li>
							<li id="check_genderN">	
								<input type="radio" name="user_gender" id="user_genderN" value="" checked="checked" />
								<label for="user_genderN">&nbsp;선택 안함</label>
							</li>
						</ul>
						<ul>	
							<li id="check_info">관심있는 제품</li>
							<li>
								<select name="select_p" id="selectP">	<!-- select에만 name적는다. -->
							        <option value="" selected="selected">선택하세요.</option>
							        <option value="스킨케어">스킨케어</option>
							        <option value="메이크업">메이크업</option>
							        <option value="바디케어">바디케어</option>
							        <option value="헤어케어">헤어케어</option>
							        <option value="향수/디퓨저">향수/디퓨저</option>
							        <option value="미용소품">미용소품</option>
							        <option value="남성">남성</option>
							        <option value="건강/위생용품">건강/위생용품</option>
							        <option value="건강식품">건강식품</option>
							        <option value="일반식품">일반식품</option>
							        <option value="반려동물">반려동물</option>
							        <option value="베이비">베이비</option>
							        <option value="잡화">잡화</option>
							     </select>
							</li>
						</ul>
					</div>	
					<div class="R_check2">	
						<div>
							<input type="checkbox" name="rcv_agree" id="email_agree" value="이메일수신동의" checked />
							<label for="email_agree">&nbsp;&nbsp;이메일 수신 동의(선택)</label>
						</div>
						<div>
							<input type="checkbox" name="rcv_agree" id="sms_agree" value="SMS수신동의" checked />
							<label for="sms_agree">&nbsp;&nbsp;SMS 수신 동의(선택)</label>
						</div>	
						<div>
							<input type="checkbox" name="rcv_agree" id="post_agree" value="우편물수신동의" checked />
							<label for="post_agree">&nbsp;&nbsp;우편물 수신 동의(선택)</label>
						</div>
					</div>	
				</div>
			</div>
			
			
			<!-- 버튼 -->
			<div class="joinArticle_B">
				<div class="joinBtn">
					<div class="btn_all btn_join" id="modal_joinBtn" onclick="chkForm();">회원가입</div>	<!-- 클릭하면 함수 실행 -->
					<div class="btn_all btn_cancel" id="modal_open">취소</div>
				</div>
			</div>
		</form>
	</article>
	
	
	<!-- 회원가입 모달 -->
	<div class="modal" id="joinMd">
	    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
	    
	    <div class="modal_content">
	        <h2 id="modal_text">회원가입 하시겠습니까?</h2>
	        <div class="containerBtn">
		        <div class="styleBtn attrBtn" id="md_joinBtn">확인</div>
		        								<!-- onClick="location.href='javascript:joinForm.submit()'" -->
		        <div class="styleBtn attrBtn" id="offBtn3">취소</div>
	        </div>
	    </div>	    
	</div>
	
	<!-- 취소버튼 모달 -->
	<div class="modal" id="cancelMd">
	    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
	    
	    <div class="modal_content">
	        <h2 id="modal_text">회원가입을 취소하시겠습니까?</h2>
	        <div class="containerBtn">
		        <div class="styleBtn attrBtn" id="confirmBtn">확인</div>
		        <div class="styleBtn attrBtn" id="offBtn">취소</div>
	        </div>
	    </div>	    
	</div>
	
	<!-- 아이디 중복체크 모달 -->
	<div class="modal" id="idDupMd">
	    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
	    
	    <div class="modal_content">
	        <h2 id="modal_text">사용가능한 아이디 입니다.</h2>
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
	
	
	
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
	<!-- 주소찾기 API 다음 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<!-- 아이디 -->
	<script>
		/* 아이디 영문, 숫자만 입력되도록 하기 */
		$(document).ready(function() {
			  $("input[name=user_id]").keyup(function(event) { 
			   
			  	if (!(event.keyCode >=37 && event.keyCode<=40)) {
		    		var inputVal = $(this).val();
		    		$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
		   		}
			 });
		});
		
		
		$('#user_id').focusout(function() {	// id값이 user_id인 요소가 선택됐을 때, 요소를 벗어나면 이벤트 핸들러 실행
			
			/* 아이디 입력 여부 확인 */
			var id = $("#user_id").val();
		
			if (id == '') {	// id를 입력하지 않았을 경우
	        	$("#idTx1").css('display', 'inline-block');
	        	$("#user_id").css('border', '1px solid #FA5855');	/* 빨간색 */
	        	$("#idTx2").css('display', 'none');	// 글자 나타나서 지워줌
	        	$("#idTx3").css('display', 'none');
        	} else {
        		$("#idTx1").css('display', 'none');
        		$("#idTx3").css('display', 'none');
        		$("#user_id").css('border', '1px solid #cacece');	/* 회색 */
        	}
			
			
			/* 아이디 숫자, 영문 소문자 조합 확인 */	
			if(id != '') {	// null이 아닐 때만 검사한다.		        
		        if(!/^[a-z0-9]{6,20}$/.test(id)) {	
		        	// a-z나 0~9가 포함, 6~20글자가 아니라면(대문자를 가려낸다.)
		        	// 하지만 a-z, 0~9 중 하나라도 포함되면 맞다고 처리함
		        	$("#user_id").css('border', '1px solid #FA5855');
					$("#idTx2").css('display', 'inline-block');
		        	$("#idTx3").css('display', 'none');
	        	} else {
	        		$("#user_id").css('border', '1px solid #FA5855');
	        		$("#idTx3").css('display', 'inline-block');
	        		$("#idTx2").css('display', 'none');
	        	}
		        
		        var chk_num = id.search(/[0-9]/g);
	        	var chk_eng = id.search(/[a-z]/ig);
		        if(chk_num < 0 || chk_eng < 0) {	// 둘 중 하나라도 없다면
		        	$("#user_id").css('border', '1px solid #FA5855');
		        	$("#idTx2").css('display', 'inline-block');
		        	$("#idTx3").css('display', 'none');
		        }
			}
		});
	</script>
	
	<!-- 아이디 중복체크 모달 -->
	<script type="text/javascript">
		/* 모달창 열어도 되는지 확인 */
		// return 값은 true / false
		function idDupCheck() {  
		// .value를 붇이면 문자열 변수가 되는데 name만 받으면 해당 name 자체를 다 가리킴.
			 var id = document.joinForm.user_id;
			 var idStr = id.value;
			 var idLen = idStr.length;	// 길이
			 
			 // 1. 입력여부 검사
			 if(id.value == '') {
				 return false;
			 }
			 // 2. 정상 길이 검사
			 if(idLen >= 6 && idLen <= 20) {	 
			 } else {
				 return false ;
			 }
			 // 3. {(a-z, 0-9)}가 포함, (10~20글자수)}가 아니라면,
			 if(!/^[a-z0-9]{6,20}$/.test(idStr)) {
            	return false;
		     }
			 // 4. 영어, 숫자 둘 중 하나라도 없다면 flase
			 var chk_num = idStr.search(/[0-9]/g);
	         var chk_eng = idStr.search(/[a-z]/ig);
	         if(chk_num < 0 || chk_eng < 0) {
	        	 return false;
	         }
	         
	         return true;
		}

		/* 모달창 열어도 되는지 확인 - 버튼 누르면 이 함수가 실행된다. */
		function idDupChkMd() {	
			var idDupChk = idDupCheck();
			if(idDupChk == false) return;
	        
			// idDupChk가 true라면 아래 코드가 실행된다.
	        var user_id =  $("#user_id").val();	// Ajax에 사용할 변수
	        
	        $.ajax({
	            async: true,	// Ajax을 동기 방식으로 처리하고 싶을 때는 false
	            type : 'POST',
	            data : {user_id : user_id},	// 넘기고자 하는 데이터의 이름을 정해주고(파라미터 변수), 값을 넣어준다. -> user_id이름에 user_id데이터 값을 넣어서 보낸다
	            url : "idCheckAction.aj",	// 해당 url로 data를 넘겨준다. : 앞에 슬러쉬(/) 넣지 말길! olive프로젝트 경로를 못찾음
	            dataType : "json",
	            success : function(result) {	// 성공적으로 수행되었다면 result로 값 반환 : url 에서 넘겨준 결과값
	            	
	            	// console.log("입력한 아이디: " + user_id);
	            	// console.log(result + " / 0(사용불가), (1사용가능), -2(dupId null), -1(db오류)");
	            	
	                if (result == 1) {			// 사용 가능한 아이디입니다.
	                	$('#idDupMd #modal_text').html('사용 가능한 아이디입니다.');
	                	$("#idDupMd").css("display", "block");
	        			$('body').css("overflow", "hidden");
	        			$("#user_id").css('border', '1px solid #cacece');
	        			$("#idTx3").css('display', 'none');	// 중복확인 글자
	                    
	                } else if(result == 0) {	// 사용할 수 없는 아이디입니다.
	                	$('#idDupMd #modal_text').html('사용할 수 없는 아이디입니다.');
	                	$("#idDupMd").css("display", "block");
	        			$('body').css("overflow", "hidden");
	        			$("#user_id").css('border', '1px solid #FA5855');
	        			$("#idTx3").css('display', 'inline-block');	// 중복확인 글자
	        			$('#user_id').val('');	// 입력한 내용이 사라진다.
	                } else {					// 아마 -1인 경우
	                	$('#idDupMd #modal_text').html('에러가 발생했으니 다시 시도해주세요.');
	                	$("#idDupMd").css("display", "block");
	                	$('body').css("overflow", "hidden");
	                	$("#user_id").css('border', '1px solid #FA5855');
	                	$("#idTx3").css('display', 'inline-block');	// 중복확인 글자
	                	$('#user_id').val('');	// 입력한 내용이 사라진다.
	                }
	            },
	            // 에러처리
	            error : function(error) {
	            	$('#idDupMd #modal_text').html('에러가 발생했으니 관리자에게 문의해주세요.');
                	$("#idDupMd").css("display", "block");
                	$('body').css("overflow", "hidden");
                	$("#user_id").css('border', '1px solid #FA5855');
                	$("#idTx3").css('display', 'inline-block');	// 중복확인 글자
                	$('#user_id').val('');	// 입력한 내용이 사라진다.
	            }
	        });
		}
	    
	    /* 모달창의 확인 버튼 누르면 모달창이 닫힌다. */
	    document.getElementById("offBtn2").onclick = function() {
	    	$("#idDupMd").css("display", "none");
	        $('body').css("overflow", "auto");
	    }
	</script>
	
	
	<!-- 비밀번호 -->
	<script>
		$('#user_pw').focusout(function() {
		// id값이 user_pw인 요소가 선택됐을 때, 요소를 벗어나면 이벤트 핸들러 실행
		
			/* 비밀번호 입력여부 확인 */
			var pw = $("#user_pw").val();
			var pw2 = $("#user_pw2").val();
		
			if (pw == '') {	// pw를 입력하지 않았을 경우
	        	$("#pwTx1").css('display', 'inline-block');
	        	$("#user_pw").css('border', '1px solid #FA5855');
	        	// 공백없이~글자 나타나서 지워줌
		        $("#pwTx2").css('display', 'none');	
		        $("#pw_no").css('display', 'none');	// 재입력~
		        $("#user_pw2").css('border', '1px solid #cacece');
        	} else {
        		$("#pwTx1").css('display', 'none');
        		$("#user_pw").css('border', '1px solid #cacece');	/* 회색 */
        	}
			
			if(pw2 != "") {
				if(pw == pw2) {
					$("#pw_again").css('display', 'none');	// 재입력~
					$("#user_pw2").css('border', '1px solid #cacece');
				}
			}
		
			/* 비밀번호 숫자, 영문조합 확인 */	
			if(pw != '') {	// null이 아닐 때만 검사한다.
				if(!/^[a-zA-Z0-9!@#$%^*+=-]{10,20}$/.test(pw)) {
				// {(a-z, A-Z, 0-9, 특수문자)하나라도 포함 그리고 (10~20글자수)}가 아니라면,	
					$("#pwTx2").css('display', 'inline-block');
		        	$("#user_pw").css('border', '1px solid #FA5855');
	        		
	        		$("#pw_no").css('display', 'none');	// 재입력~
			        $("#user_pw2").css('border', '1px solid #cacece');
	            	return false;
	        	} else {
	        		$("#pwTx2").css('display', 'none');
	        		$("#user_pw").css('border', '1px solid #cacece');
	        	}
				
				var chk_num = pw.search(/[0-9]/g);
	        	var chk_eng = pw.search(/[a-z]/ig);
	
		        if(chk_num < 0 || chk_eng < 0) {	// 둘 중 하나라도 없다면
		        	$("#pwTx2").css('display', 'inline-block');
		        	$("#user_pw").css('border', '1px solid #FA5855');
		        	
	        		$("#pw_no").css('display', 'none');	// 재입력~
			        $("#user_pw2").css('border', '1px solid #cacece');
		            return false;
		        }
			}	
		});
		
		
		/* 비밀번호 일치 확인 */
		$('#user_pw2').focusout(function () {
		// focusout : 특정 엘리먼트가 선택됐을 때 해당 엘리먼트를 벗어나는 경우 이벤트를 동작시킨다.
	        var pwd1 = $("#user_pw").val();
	        var pwd2 = $("#user_pw2").val();
	        
	        if(pwd1 == '') {	// 비밀번호 입력을 안했을 때
	        	$("#user_pw2").val('');	// 입력 못함
	        	$("#user_pw2").css('border', '1px solid #cacece');
	        	$("#pw_again").css('display', 'none');
	        }
	 
	        if ( pwd1 != '' && pwd2 == '' ) {	// 비밀번호만 입력되어 있을 때
	        	$("#pw_no").css('display', 'inline-block');
	        	$("#user_pw2").css('border', '1px solid #FA5855');
	        	$("#pw_again").css('display', 'none');
	            
	        } else if (pwd1 != "" && pwd2 != "") {	// 둘 다 입력했을 때
	            if (pwd1 == pwd2) {	//비밀번호가 같다면
	            	$("#pw_no").css('display', 'none');
	                $("#pw_again").css('display', 'none');
	                $("#user_pw2").css('border', '1px solid #cacece');
	            } else {	// 비밀번호가 다르다면
	            	$("#pw_no").css('display', 'none');
	                $("#pw_again").css('display', 'inline-block');
	                $("#user_pw2").css('border', '1px solid #FA5855');
	            }
	        }
	        
	        
	        /* 비밀번호 숫자, 영문조합 확인 - 재입력칸 입력 불가 */	
			if(pwd1 != '') {	// null이 아닐 때만 검사한다.
				if(!/^[a-zA-Z0-9!@#$%^*+=-]{10,20}$/.test(pwd1)) {
				// {(a-z, A-Z, 0-9, 특수문자)하나라도 포함 그리고 (10~20글자수)}가 아니라면,	
					$("#user_pw2").val('');	// 입력 못함
	        		$("#pw_no").css('display', 'none');
	        		$("#pw_again").css('display', 'none');
			        $("#user_pw2").css('border', '1px solid #cacece');
	        	} else {
	        		
	        	}
				
				var chk_num = pwd1.search(/[0-9]/g);
	        	var chk_eng = pwd1.search(/[a-z]/ig);
	
		        if(chk_num < 0 || chk_eng < 0) {	// 둘 중 하나라도 없다면
		        	$("#user_pw2").val('');	// 입력 못함
	        		$("#pw_no").css('display', 'none');	// 재입력~
	        		$("#pw_again").css('display', 'none');	// 재입력~
			        $("#user_pw2").css('border', '1px solid #cacece');
		        }
			}
	    });
	</script>	
	
	<!-- 이름 -->
	<script>
		$('#user_name').focusout(function() {
			/* 이름 입력 여부 확인 1 */
			var name = $("#user_name").val();
			
			// 이름 입력하지 않았을 경우
			if (name == '') {
	        	$("#nameTx1").css('display', 'inline-block');
	        	$("#user_name").css('border', '1px solid #FA5855');
	        	$("#nameTx2").css('display', 'none');	// 정확히 입력~은 숨긴다.
        	} else {
        		$("#nameTx1").css('display', 'none');
        		$("#user_name").css('border', '1px solid #cacece');	/* 회색 */
        	}
		
			/* 이름에 한글, 영어만 입력 */
			if(name != '') {	// ''이 아닐 때만 검사한다.
				var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20a-zA-Z])/i;
				var blank_pattern = /[\s]/g;
				var chkName = pattern.test($("#user_name").val());

				if(chkName) {	
					$("#nameTx2").css('display', 'inline-block');
		        	$("#user_name").css('border', '1px solid #FA5855');
				} else {
	        		$("#nameTx2").css('display', 'none');
	        		$("#user_name").css('border', '1px solid #cacece');
	        	}
				
				if(name.length < 2) {	// 2글자 이하일 때
					$("#nameTx2").css('display', 'inline-block');
		        	$("#user_name").css('border', '1px solid #FA5855');
				}
				
				// 공백 불가
				if( blank_pattern.test(name) == true) {
					$("#nameTx2").css('display', 'inline-block');
					$("#user_name").css('border', '1px solid #FA5855');
				}
			}
		});
	</script>
	
	<!-- 생년월일 -->
	<script>
		/* 생년월일 선택 여부 확인 */
		$('.user_year').focusout(function() {
			var birthY = $('.user_year').val();
			var birthM = $('.user_year').val();
			var birthD = $('.user_year').val();
			if(birthY == '') {
				$("#birthTx").css('display', 'inline-block');
	        	$(".user_year").css('border', '1px solid #FA5855');
			} else {
	        	$(".user_year").css('border', '1px solid #cacece');
			}
		});
		
		$('.user_month').focusout(function() {
			var birthM = $('.user_month').val();
			if(birthM == '') {
				$("#birthTx").css('display', 'inline-block');
	        	$(".user_month").css('border', '1px solid #FA5855');
			} else {
	        	$(".user_month").css('border', '1px solid #cacece');
			}
		});
		
		$('.user_day').focusout(function() {
			var birthD = $('.user_day').val();
			if(birthD == '') {
				$("#birthTx").css('display', 'inline-block');
	        	$(".user_day").css('border', '1px solid #FA5855');
			} else {
	        	$(".user_day").css('border', '1px solid #cacece');
			}
		});
		
		$('.user_birth').focusout(function() { 
			var birthY = $('.user_year').val();
			var birthM = $('.user_month').val();
			var birthD = $('.user_day').val();

			if(birthY != '' && birthM != '' && birthD != '') {
				$("#birthTx").css('display', 'none');
			}
		});
	

		/* select박스 years, months */
		$(function() {
	       // years select box
	       for (i = new Date().getFullYear(); i >= 1900; i--) {
	           $('.user_year').append($('<option />').val(i).html(i + "년"));
	           // append : 선택된 요소의 마지막에 새로운 요소나 콘텐츠를 추가한다. ()괄호 안에 추가할 요소가 들어간다.
	       }
	       //Days select box
	       for (i = 10; i < 32; i++) {
	    	   $('.user_day').append($('<option />').val(i).html(i + "일"));
	       }
		});
	</script>	
	
	<!-- 휴대폰 -->
	<script>
		/* 휴대폰번호 숫자만 입력 가능 */
		function onlyNumber(event) {
	    	event = event || window.event;
		    var keyID = (event.which) ? event.which : event.keyCode;
		    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		        return;
		    else
		        return false;
		}
	 
		function removeChar(event) {
		    event = event || window.event;
		    var keyID = (event.which) ? event.which : event.keyCode;
		    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		        return;
		    else
		        event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
		
		/* 휴대폰번호 입력여부 확인 */
		$('#user_phone2, #user_phone3').focusout(function() {
			var phone2 = $('#user_phone2').val();
			var phone3 = $('#user_phone3').val();
			if(phone2 == '' && phone3 == '') {
				$("#user_phone2").css('border', '1px solid #FA5855');
				$("#user_phone3").css('border', '1px solid #FA5855');
				$("#phoneTx").css('display', 'inline-block');
			}
			if(phone2 != '' && phone3 != '') {
				$("#phoneTx1").css('display', 'none');
			}
		});
		
		$('#user_phone2').focusout(function() {
			var phone2 = $('#user_phone2').val();
			if(phone2 == '') {
				$("#phoneTx1").css('display', 'inline-block');
	        	$("#user_phone2").css('border', '1px solid #FA5855');
	        	$("#phoneTx2").css('display', 'none');	// 계속 같이 떠서 지움
			} else {
	        	$("#user_phone2").css('border', '1px solid #cacece');
			}
			

			// 3자리 이상 입력 확인
			var phone2Len = phone2.length;
			if(phone2 != '') {	// null이 아닐 때만
				if(phone2Len < 3) {	// 3자리 이상 입력 가능
					$("#phoneTx1").css('display', 'none');	// 헷갈려서
					$("#phoneTx2").css('display', 'inline-block');
					$("#user_phone2").css('border', '1px solid #FA5855');
				} else {
					$("#phoneTx2").css('display', 'none');
					$("#user_phone2").css('border', '1px solid #cacece');
				}
			}	
		});
		
		
		$('#user_phone3').focusout(function() {
			var phone3 = $('#user_phone3').val();
			if(phone3 == '') {
				$("#phoneTx1").css('display', 'inline-block');
	        	$("#user_phone3").css('border', '1px solid #FA5855');
	        	$("#phoneTx2").css('display', 'none');	// 계속 같이 떠서 지움
			} else {
	        	$("#user_phone3").css('border', '1px solid #cacece');
			}
			
			// 3자리 이상 입력 확인
			var phone3Len = phone3.length;
			if(phone3 != '') {	// null이 아닐 때만
				if(phone3Len < 4) {	// 4자리 이상 입력 가능
					$("#phoneTx1").css('display', 'none');	// 헷갈려서
					$("#phoneTx2").css('display', 'inline-block');
					$("#user_phone3").css('border', '1px solid #FA5855');
				} else {
					$("#phoneTx2").css('display', 'none');
					$("#user_phone3").css('border', '1px solid #cacece');
				}
			}
		});
	</script>	
	
	<!-- 이메일 -->
	<script>	
		/* 이메일 입력방식 바뀜 */
		$('#user_email3').change(function() { 
			$("#user_email3 option:selected").each(function() { 
				if($(this).val() == '') { //직접입력일 경우 
					$("#user_email2").val(''); //값 초기화 
					$("#user_email2").attr("readonly",false); //활성화 
					$("#user_email2").css("color", "#5A5555"); // 검정글씨
					$("#user_email2").css("background-color", "white"); // 회색배경
				} else { //직접입력이 아닐경우 
					$("#user_email2").val($(this).val()); // 선택값 입력
					$("#user_email2").attr("readonly",true); //비활성화 
					$("#user_email2").css("color", "#999999"); // 회색글씨
					$("#user_email2").css("background-color", "#EEEEEE"); // 회색배경
				} 
			}); 
		});
		
		
		/* 입력여부 확인 - email1*/
		$('#user_email1').focusout(function () {
			var email1 = $('#user_email1').val();
			var email2 = $('#user_email2').val();
			if(email1 == '') {
	        	$("#user_email1").css('border', '1px solid #FA5855');
				$("#emailTx1").css('display', 'inline-block');
	        	$("#emailTx2").css('display', 'none');	// 계속 같이 떠서 지움
			} else {
				$("#user_email1").css('border', '1px solid #cacece');
				$("#emailTx1").css('display', 'none');
			}
			
			/* emil1 한글입력 불가, 2글자 이상 입력 */
			if(email1 != '') {	// null이 아닐 때만 검사한다.
				var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
				var chkEmail = pattern.test($("#user_email1").val());	
				// test() : 찾는 문자열이 들어있는지 아닌지를 알려준다.
				// true를 리턴하면 한글이 아니고, false를 리턴하면 한글이다.
				
				// 한글입력 불가
				if(!chkEmail) {	
					$("#emailTx1").css('display', 'none');
					$("#emailTx2").css('display', 'inline-block');
		        	$("#user_email1").css('border', '1px solid #FA5855');
				} else {
	        		$("#emailTx2").css('display', 'none');
	        		$("#user_email1").css('border', '1px solid #cacece');
	        	}
				
				// 2글자 이상 입력
				if(email1.length < 2) {
					$("#emailTx1").css('display', 'none');
					$("#emailTx2").css('display', 'inline-block');
		        	$("#user_email1").css('border', '1px solid #FA5855');
				}
			}
		});
		
		/* 입력여부 확인 - email2*/
		$('#user_email2, #user_email3').focusout(function () {
			var email1 = $('#user_email1').val();
			var email2 = $('#user_email2').val();
			if(email2 == '') {
				$("#emailTx1").css('display', 'inline-block');
	        	$("#user_email2").css('border', '1px solid #FA5855');
	        	$("#emailTx2").css('display', 'none');	// 계속 같이 떠서 지움
	        	if(email1 == '') {
	        		$("#user_email1").css('border', '1px solid #FA5855');	// 2입력 안하면 1도 빨간박스
	        		$("#emailTx1").css('display', 'inline-block');
	        	}
			} else {
				if(email1 == '') {
	        		$("#user_email1").css('border', '1px solid #FA5855');	// 2입력 했을 때 1도 빨간박스
	        		$("#emailTx1").css('display', 'inline-block');
	        	} else {
	        		$("#user_email2").css('border', '1px solid #cacece');
	        		$("#emailTx1").css('display', 'none');
	        	}	
			}
			
			/* email2 이메일 형식 입력 */
			if(email2 != '') {
				var pattern2 = /^([a-zA-Z]+)(\.[a-zA-Z]{1,4})/;	// .다음에 글자 2개 이상
				var chkEmail2 = pattern2.test($("#user_email2").val());      
				if(!chkEmail2) {	
					$("#emailTx1").css('display', 'none');
					$("#emailTx2").css('display', 'inline-block');
		        	$("#user_email2").css('border', '1px solid #FA5855');
				} else {
	        		$("#emailTx2").css('display', 'none');
	        		$("#user_email2").css('border', '1px solid #cacece');
	        	}
			}
			
			// email2 공백사용 불가
			var blank_pattern = /[\s]/g;
			if(blank_pattern.test(email2) == true) {
				$("#user_email2").css('border', '1px solid #FA5855');
				$("#emailTx2").css('display', 'inline-block');
				$("#emailTx1").css('display', 'none');
			}
		});
	</script>	
		
	<!-- 주소 -->	
	<script>	
		/* 주소찾기 API 다음 */
		function openZipSearch() {	// 이름 설정
			new daum.Postcode({
				oncomplete: function(data) {
					$('#user_zip').val(data.zonecode); // 우편번호 (5자리)
			
					if(data.buildingName != "") {
						$('#user_addr1').val(data.address + " (" + data.buildingName + ") ");	// 주소
					} else {
						$('#user_addr1').val(data.address + data.buildingName + " ");
					}
				}
			}).open();
		$('#user_addr2').focus();	// 주소 선택 후 바로 입력할 수 있도록
		}
	</script>
	
	<!-- 버튼 모달 -->
	<script>
		/* 회원가입 버튼 모달 */
		// 확인버튼
		document.getElementById("md_joinBtn").onclick = function() {
			document.joinForm.submit();
		}	
		
		// 취소버튼
		document.getElementById("offBtn3").onclick = function() {
	    	$("#joinMd").css("display", "none");
	        $('body').css("overflow", "auto");
	    }
	
		/* 취소 버튼 모달 */
		document.getElementById("modal_open").onclick = function() {
			$("#cancelMd").css("display", "block");
	        $('body').css("overflow", "hidden");
		}	
	   	
		// 확인, 취소 버튼
		document.getElementById("confirmBtn").onclick = function() {
			location.href = 'main.jsp';
	    }
	    document.getElementById("offBtn").onclick = function() {
	    	$("#cancelMd").css("display", "none");
	        $('body').css("overflow", "auto");
	    }
	</script>	
	
	<!-- submit -->
	<script>
	// 조건을 만족하지 않으면 submit작동 안함
		/* 아이디 */
		function idCheck() {  
		// .value를 붇이면 문자열 변수가 되는데 name만 받으면 해당 name 자체를 다 가리킴.
			 var id = document.joinForm.user_id;
			 var idStr = id.value;
			 var idLen = idStr.length;	// 길이
			 
			 if(id.value == '') {
				 id.focus();
				 return false;
			 }

			 if(idLen >= 6 && idLen <= 20) {	// 맞으면 정상 길이	 
			 } else {
				 id.focus();
				 return false ;
			 }
			 
			if(!/^[a-z0-9]{6,20}$/.test(idStr)) {
			// {(a-z, 0-9)하나라도 포함 그리고 (6~20글자수)}가 아니라면
				id.focus();
            	return false;
		     }
			 
			 var chk_num = idStr.search(/[0-9]/g);
	         var chk_eng = idStr.search(/[a-z]/ig);
	         if(chk_num < 0 || chk_eng < 0) {	// 둘 중 하나라도 없다면
	        	 id.focus();
	        	 return false;
	         }
	         return true;
		}
		
		/* 아이디 중복 */
		function idSubDupCheck() {
//			var user_id =  $("#user_id").val();	// Ajax에 사용할 변수
//			var tf = false;
//	        $.ajax({
//	            async: false,	// ajax는 기본적으로 비동기 방식이므로, return값을 얻고 싶다면 false로 바꿔준다.
//	            type : 'POST',
//	            data : {user_id : user_id},	
//	            url : "idCheckAction.aj",
//	            dataType : "json",
//	            success : function(result) {
//	                if (result == 1) {			// 사용 가능한 아이디입니다.
//	                	tf = true;
//	                } else {
//	                	$("#user_id").val("");
//	                	tf = false;
//	                }
//	            },
//	            // 에러처리
//	            error : function(error) {
//	            	console.log("아이디 중복검사 error");
//	            	tf = false;
//	            }
//	        });
//			
//	        console.log(tf);
//			return tf;
			
			if($("#idTx3").css("display") == "inline-block") {
				return false;
				$("#user_id").focus();
			}
			else {
				return true;
			}
		}
		
		/* 패스워드 */
		function pwCheck() {
			var pw = document.joinForm.user_pw;
			var pwStr = pw.value;
			var pwLen = pwStr.length;
			
			if(pw.value == ''){
				pw.focus();
				return false;
			}
			
			if(pwLen >= 10 && pwLen <= 20) {	// 맞으면 정상 길이	 
			 } else {
				 pw.focus();
				 return false ;
			 }
			
			if(!/^[a-zA-Z0-9!@#$%^*+=-]/.test(pwStr)) {
				// {(a-z, A-Z, 0-9, 특수문자)하나라도 포함 그리고 (10~20글자수)}가 아니라면, (공백불가)
					pw.focus();
	            	return false;
	        }
				
			var chk_num = pwStr.search(/[0-9]/g);
        	var chk_eng = pwStr.search(/[a-z]/ig);

	        if(chk_num < 0 || chk_eng < 0) {	// 둘 중 하나라도 없다면
	        	pw.focus();
	            return false;
	        }

			return true;
		}
		
		/* 비밀번호 재입력 */
		function pw2Check() {
			var pw1 = document.joinForm.user_pw;
			var pw1Str = pw1.value;
			var pw2 = document.joinForm.user_pw2;
			var pw2Str = pw2.value;
			
			if(pw2.value == ''){
				pw2.focus();
				return false;
			}
			
			if (pw1Str != "" || pw2Str != "") {	// 둘 다 입력했을 때
	            if (pw1Str != pw2Str) {	//비밀번호가 같다면
	            	pw2.focus();
	            	return false;
	            }
			}
			
			return true;
		}
		
		/* 이름 */
		function nameCheck() {
			var name = document.joinForm.user_name;
			var nameStr = name.value;
			
			if(name.value == ''){
				name.focus();
				return false;
			}
			
			var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20a-zA-Z])/i;	// 영어, 한글만 사용 가능
			var chkName = pattern.test(nameStr);
			if(chkName) {	
				name.focus();
				return false;
			}
			
			if(nameStr.length < 2) {	// 2글자 이하일 때
				name.focus();
				return false;
			}
			
			var blank_pattern = /[\s]/g;	// 공백 사용 불가
			if( blank_pattern.test(nameStr) == true) {
			    name.focus();
			    return false;
			}
			
			return true;
		}
		
		/* 생년월일 */
		function birthCheck() {
			var birthY = $(".user_year");
			var birthM = $(".user_month");
			var birthD = $(".user_day");
			
			if(birthY.val() == '' || birthM.val() == '' || birthD.val() == '') {
				if(birthY.val() == '') {
					birthY.focus();
				} else if (birthM.val() == '') {
					birthM.focus();
				} else {
					birthD.focus();
				}
				return false;
			}
			
			return true;
		}
		
		/* 휴대전화 */
		function phoneCheck() {
			var phone2 = $("#user_phone2");
			var phone3 = $("#user_phone3");
			
			// 둘 중 하나라도 null이라면
			if(phone2.val() == '' || phone3.val() == '') {
				if(phone2.val() == '') {
					phone2.focus();
				} else {
					phone3.focus();
				}
				return false;
			}
			
			// 3자리 이상 입력 확인
			var phone2Len = phone2.val().length;
			var phone3Len = phone3.val().length;
			
			if(phone2Len < 3) {	// 3자리 이상 입력 가능
				phone2.focus();
				return false;
			}

			if(phone3Len < 4) {	// 4자리 이상 입력 가능
				phone3.focus();
				return false;
			}
			
			return true;
		}
		
		
		/* 이메일 */
		function emailCheck() {
			var email1 = $("#user_email1");
			var email2 = $("#user_email2");
			
			// 둘 중 하나라도 null이라면
			if(email1.val() == '' || email2.val() == '') {
				if(email1.val() == '') {
					email1.focus();
				} else {
					email2.focus();
				}
				return false;
			}
			
			// email1 한글입력 불가
			var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
			var chkEmail = pattern.test(email1.val());	// true를 리턴하면 한글이 아니고, false를 리턴하면 한글이다.
			if(!chkEmail) {	
				email1.focus();
				return false;
			}
			
			// email1 2글자 이상 입력
			email1Str = email1.val();
			if(email1Str.length < 2) {
				email1.focus();
				return false;
			}
			
			// 이메일 형식 입력
			var pattern2 = /^([a-zA-Z]+)(\.[a-zA-Z]{1,4})/;	// .다음에 글자 1개 이상
			var chkEmail2 = pattern2.test($("#user_email2").val());      
			if(!chkEmail2) {
				email2.focus();
				return false;
			}
			
			// email2 공백사용 불가
			var blank_pattern = /[\s]/g;
			if( blank_pattern.test(email2.val()) == true) {
			    email2.focus();
			    return false;
			}
			
			return true;
		}

		
		// submit확인
		function chkForm() {	
			var idChk = idCheck();
			if(idChk == false) return;
			
			var idDupChk = idSubDupCheck();
			if(idDupChk == false) return;
		
			var pwChk = pwCheck();
			if(pwChk == false) return;
			
			var pw2Chk = pw2Check();
			if(pw2Chk == false) return;
			
			var nameChk = nameCheck();
			if(nameChk == false) return;

			var birthChk = birthCheck();
			if(birthChk == false) return;
			
			var phoneChk = phoneCheck();
			if(phoneChk == false) return;
			
			var emailChk = emailCheck();
			if(emailChk == false) return;

			$("#joinMd").css("display", "block");
	        $('body').css("overflow", "hidden");
			// true라면 모달창 오픈
		}
	</script>
</body>
</html>