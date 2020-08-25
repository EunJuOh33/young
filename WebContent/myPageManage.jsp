<%@ page import="com.board.bean.BbsBean" %> 
<%@ page import="com.board.dao.BoardDAO" %>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>OLIVE YOUNG</title>

	<!-- Style -->
	<link rel="stylesheet" href="css/userCss/usernormal.css" />
	<link rel="stylesheet" href="css/userCss/usermanage.css" />
	<link rel="stylesheet" href="css/userCss/mypagemanage.css">
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
					</div>	<!-- div=util 끝 -->
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
				<div class="userInfoArea">
					<form name="modifForm" action="userModifAction.bo" method="post">
					<c:set var="bean" value="${bean }" />
						<div class="userInfo_default">
							<h3>기본정보</h3>
							<div class="defaultBox">
								<table>
									<caption>회원 정보 - ${bean.user_id }</caption>
									<colgroup>
										<col style="width: 20%">
										<col style="width: *">
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												<div class="td_name">
													<div class="box name_box">
														<input type="text" name="modif_name" id="modif_name" class="inp_txt" value="${bean.user_name }" maxlength="9" size="10" autocomplete="off" required />
													</div>
													<p class="error" id="error" style="display:none;">이름을 입력해 주세요.</p>
													<p class="error" id="error2" style="display:none;">이름을 정확히 입력해 주세요.</p>
												</div>
											</td>
										</tr>
										<tr>
											<th>아이디</th>
											<td>
												<div class="td_id">
													<span style='font-weight: 600;'>${bean.user_id }</span>
												</div>
											</td>
										</tr>
										<tr>
											<th>생년월일</th>
											<td>
												<div class="td_birth">
													<span style='font-weight: 600;'>
														<!-- 글자 자르기 -->
														${fn:substring(bean.user_birth, 0, 4) }년
														${fn:substring(bean.user_birth, 4, 6) }월
														${fn:substring(bean.user_birth, 6, 8) }일 
													</span>
												</div>
											</td>
										</tr>
										<tr>
											<th>휴대전화</th>
											<td>
												<div class="td_phone">
													<div class="box phone_box">
													<c:set var = "phone1" value = "${fn:substring(bean.user_phone, 0, 3) }" />
														<c:choose>
															<c:when test="${phone1 == '010'}">
																<select name="modif_phone" class="inp_txt" id="modif_phone1">
																    <option value="010" selected="selected">010</option>
																    <option value="011">011</option>
																    <option value="016">016</option>
																    <option value="019">019</option>
																</select>
															</c:when>
															<c:when test="${phone1 == '011'}">
																<select name="modif_phone" class="inp_txt" id="modif_phone1">
																    <option value="010">010</option>
																    <option value="011" selected="selected">011</option>
																    <option value="016">016</option>
																    <option value="019">019</option>
																</select>
															</c:when>
															<c:when test="${phone1 == '016'}">
																<select name="modif_phone" class="inp_txt" id="modif_phone1">
																    <option value="010">010</option>
																    <option value="011">011</option>
																    <option value="016" selected="selected">016</option>
																    <option value="019">019</option>
																</select>
															</c:when>
															<c:when test="${phone1 == '019'}">
																<select name="modif_phone" class="inp_txt" id="modif_phone1">
																    <option value="010">010</option>
																    <option value="011">011</option>
																    <option value="016">016</option>
																    <option value="019" selected="selected">019</option>
																</select>
															</c:when>
														</c:choose>
													</div>
													<c:set var="phone_length" value="${fn:length(bean.user_phone)}" />
													<span> - </span>
													<div class="box phone_box">
														<c:choose>
															<c:when test="${phone_length == '10'}">
																<input type="text" value="${fn:substring(bean.user_phone, 3, 6) }" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4" name="modif_phone" class="inp_txt" id="modif_phone2" size="4" autocomplete="off" />
															</c:when>
															<c:otherwise>	
																<input type="text" value="${fn:substring(bean.user_phone, 3, 7) }" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4" name="modif_phone" class="inp_txt" id="modif_phone2" size="4" autocomplete="off" />
															</c:otherwise>
														</c:choose>
													</div>
													<span> - </span>
													<div class="box phone_box">	
														<input type="text" value="${fn:substring(bean.user_phone, phone_length -4, phone_length) }" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' maxlength="4" name="modif_phone" class="inp_txt" id="modif_phone3" value="${fn:substring(bean.user_phone, phone_length -4, phone_length) }" size="4" autocomplete="off" />
													</div>
													<p class="error" id="error" style="display:none;">휴대전화 번호를 입력해 주세요.</p>
													<p class="error" id="error2" style="display:none;">휴대전화 번호를 정확히 입력해 주세요.</p>
												</div>
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<div class="td_email">
													<div class="box email_box">
														<input type="text" value="${fn:substringBefore(bean.user_email, '@') }" name="modif_email1" class="inp_txt" id="modif_email1" size="4" autocomplete="off" required />
													</div>
													<span>@</span>
													<div class="box email_box">	
														<input type="text" value="${fn:substringAfter(bean.user_email, '@') }" name="modif_email2" class="inp_txt" id="modif_email2" size="4" autocomplete="off" required />
													</div>
													<span class="small"></span>
													<div class="box email_box">	
														<select class="inp_txt" id="modif_email3" onChange="mailcheck()">
														    <option value="" selected="selected">직접입력</option>
														    <option value="naver.com">naver.com</option>
														    <option value="hanmail.net">hanmail.net</option>
														    <option value="daum.net">daum.net</option>
														    <option value="nate.com">nate.com</option>
														    <option value="gmail.com">gmail.com</option>
														    <option value="hotmail.com">hotmail.com</option>
														</select>
													</div>
													<!-- 이메일 값 출력하는 스크립트 -->
								     				<c:set var="email" value="${fn:substringAfter(bean.user_email, '@') }" />
													<script>
														/* 변수 선언, 출력 확인 */
												     	var email = '<c:out value="${email}" />';	// user_email 골벵이 뒤에 저장되어 있는 값
														// console.log("email의 값: " + email);
												     	var selectBox_email = document.getElementById("modif_email3");
														// console.log("selectBox_email 길이 : " + selectBox_email.length);	// 7출력
														
														for(i=0; i<selectBox_email.length; i++) { 
															var val_email = selectBox_email.options[i].value;	// for문 밖에서 선언하면 에러가 난다. i값이 정해지지 않았기 때문.
															// console.log("email 옵션" + i + " : " + val_email);
															if(email == val_email) {
																// 자바스크립트에서는 문자열 비교를 위해 기본적으로 '=='를 사용한다.
																$("#modif_email3").val(val_email).prop("selected", true);
																$("#modif_email2").val(val_email); // 선택값 입력
																$("#modif_email2").attr("readonly", true); //비활성화 
																$("#modif_email2").css("color", "#999999"); // 회색글씨
																$("#modif_email2").css("background-color", "#EEEEEE"); // 회색배경
																// console.log("email select할 옵션 : " + val_email);
																// console.log("email i값 : " + i);
															}
														}
													</script>
													<p class="error" id="error" style="display:none;">이메일을 입력해주세요.</p>
													<p class="error" id="error2" style="display:none;">이메일 주소 형식에 맞지 않습니다. 다시 확인해주세요.</p>
												</div>
											</td>
										</tr>
										<tr>
											<th>주소</th>
											<td class="addrArea">
												<div class="td_addr">
													<div class="box zip_box">	<!-- name 모두 같게 하여 배열로 받는다. -->
														<c:choose>
															<c:when test="${bean.user_zip eq '0'}">
																<input type="text" name="modif_zip" class="inp_txt" id="modif_zip" maxlength="5" size="5" style="background-color: #EEEEEE; color: #999999;" readonly />
															</c:when>
															<c:otherwise>	
																<input type="text" value="${bean.user_zip }" name="modif_zip" class="inp_txt" id="modif_zip" maxlength="5" size="5" style="background-color: #EEEEEE; color: #999999;" readonly />
															</c:otherwise>
														</c:choose>
													</div>
													<div class="box zip_box2">
														<div class="btn_zip" onclick="openZipSearch()">우편번호검색</div>
													</div>	
													<div class="box addr_box">
														<input type="text" value="${bean.user_addr }" name="modif_addr" id="modif_addr1" class="inp_txt" style="background-color: #EEEEEE; color: #999999;" readonly />
													</div>
													<div class="box addr_box">
														<input type="text" name="modif_addr" id="modif_addr2" class="inp_txt" autocomplete="off" />
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="userInfo_add">
							<h3>부가정보</h3>
							<div class="addBox">
								<div class="add_tit">성별</div>
								<div class="genderRadio">
									<c:choose>
										<c:when test="${bean.user_gender eq '남'}">
											<div>
												<input type="radio" name="modif_gender" id="m" value="남" checked />
												<label for="m">남성</label>
											</div>
											<div>
												<input type="radio" name="modif_gender" id="w" value="여" />
												<label for="w">여성</label>
											</div>
											<div class="noRadio">
												<input type="radio" name="modif_gender" id="n" value="" />
												<label for="n">선택안함</label>
											</div>
										</c:when>
										<c:when test="${bean.user_gender eq '여'}">
											<div>
												<input type="radio" name="modif_gender" id="m" value="남" />
												<label for="m">남성</label>
											</div>
											<div>
												<input type="radio" name="modif_gender" id="w" value="여" checked />
												<label for="w">여성</label>
											</div>
											<div class="noRadio">
												<input type="radio" name="modif_gender" id="n" value="" />
												<label for="n">선택안함</label>
											</div>
										</c:when>
										<c:otherwise>	
											<div>
												<input type="radio" name="modif_gender" id="m" value="남" />
												<label for="m">남성</label>
											</div>
											<div>
												<input type="radio" name="modif_gender" id="w" value="여" />
												<label for="w">여성</label>
											</div>
											<div class="noRadio">
												<input type="radio" name="modif_gender" id="n" value="" checked />
												<label for="n">선택안함</label>
											</div>
										</c:otherwise>
									</c:choose>
								</div>	
								<div class="add_titB">관심있는 제품</div>
								<div class="product">
									<select name="modif_p" class="inp_txt" id="modifP">	<!-- select에만 name적는다. -->
								        <option value="">선택하세요.</option>
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
								     <!-- 관심있는 제품 선택한 값 출력하는 스크립트 -->
								     <c:set var="user_p" value="${bean.select_p }" />
								     <script type="text/javascript">
								     	/* 변수 선언, 출력 확인 */
								     	var user_p = '<c:out value="${user_p}" />';	// select_p에 저장되어 있는 값
										// console.log("user_p의 값: " + user_p);
								     	var selectBox = document.getElementById("modifP");
										// console.log("길이 : " + selectBox.length);	// 14 출력
										
										for(i=0; i<selectBox.length; i++) { 
											var val_p = selectBox.options[i].value;	// for문 밖에서 선언하면 에러가 난다. i값이 정해지지 않았기 때문.
											// console.log("옵션" + i + " : " + val_p);
											if(user_p == val_p) {
												// 자바스크립트에서는 문자열 비교를 위해 기본적으로 '=='를 사용한다.
												// select_p에 저장되어 있던 값과 option의 value 값이 같은 경우, 해당 option을 select한다.
												$("#modifP").val(val_p).prop("selected", true);
												// console.log("select할 옵션 : " + val_p);
												// console.log("i값 : " + i);
											}
										}
									</script>
								</div>
							</div>
						</div>
						<div class="userInfo_agree">
							<h3>수신정보 동의</h3>
							<div class="agreeBox">
								<table>
									<caption>수신정보 동의</caption>
									<colgroup>
										<col style="width: 14%;">
										<col style="width: 19%;">
										<col style="width: 15%;">
										<col style="width: 19%;">
										<col style="width: 14%;">
										<col style="width: *;">
									</colgroup>
									<tbody>
										<tr>
											<th>이메일 수신동의</th>
											<td id="emailRecv">
												<c:choose>
													<c:when test="${fn:contains(bean.rcv_agree,'이메일수신동의')}">
														<span class="radioArea">
															<input type="radio" name="modif_email_rcv" id="emailRecv_y" value="이메일수신동의" checked />
															<label for="emailRecv_y">수신</label>
														</span>
														<span class="radioArea">
															<input type="radio" name="modif_email_rcv" id="emailRecv_n" value="" />
															<label for="emailRecv_n">미수신</label>
														</span>
													</c:when>
													<c:otherwise>
														<span class="radioArea">
															<input type="radio" name="modif_email_rcv" id="emailRecv_y" value="이메일수신동의" />
															<label for="emailRecv_y">수신</label>
														</span>
														<span class="radioArea">
															<input type="radio" name="modif_email_rcv" id="emailRecv_n" value="" checked />
															<label for="emailRecv_n">미수신</label>
														</span>
													</c:otherwise>
												</c:choose>
											</td>
											<th>SMS 수신동의</th>
											<td id="smsRecv">
												<c:choose>
													<c:when test="${fn:contains(bean.rcv_agree,'SMS수신동의')}">
														<span class="radioArea">
															<input type="radio" name="modif_sms_rcv" id="smsRecv_y" value="SMS수신동의" checked />
															<label for="smsRecv_y">수신</label>
														</span>
														<span class="radioArea">
															<input type="radio" name="modif_sms_rcv" id="smsRecv_n" value="" />
															<label for="smsRecv_n">미수신</label>
														</span>
													</c:when>
													<c:otherwise>
														<span class="radioArea">
															<input type="radio" name="modif_sms_rcv" id="smsRecv_y" value="SMS수신동의" />
															<label for="smsRecv_y">수신</label>
														</span>
														<span class="radioArea">
															<input type="radio" name="modif_sms_rcv" id="smsRecv_n" value="" checked />
															<label for="smsRecv_n">미수신</label>
														</span>
													</c:otherwise>
												</c:choose>
											</td>
											<th>우편물 수신동의</th>
											<td id="postRecv">
												<c:choose>
													<c:when test="${fn:contains(bean.rcv_agree,'우편물수신동의')}">
														<span class="radioArea">
															<input type="radio" name="modif_post_rcv" id="postRecv_y" value="우편물수신동의" checked />
															<label for="postRecv_y">수신</label>
														</span>
														<span class="radioArea">
															<input type="radio" name="modif_post_rcv" id="postRecv_n" value="" />
															<label for="postRecv_n">미수신</label>
														</span>
													</c:when>
													<c:otherwise>
														<span class="radioArea">
															<input type="radio" name="modif_post_rcv" id="postRecv_y" value="우편물수신동의" />
															<label for="postRecv_y">수신</label>
														</span>
														<span class="radioArea">
															<input type="radio" name="modif_post_rcv" id="postRecv_n" value="" checked />
															<label for="postRecv_n">미수신</label>
														</span>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- 버튼 -->
							<div class="BtnArea">
								<div class="styleBtn2 btnGreen" id="modifBtn" onclick="modifCheck();">회원정보 수정</div>
								<div class="styleBtn2 styleBtn3" id="cancelBtn" onclick="cancel();">취소</div>
							</div>
						</div>
					</form>
					
					<!-- 회원탈퇴 -->
					<div class="userInfo_out">
						<h3>회원탈퇴</h3>
						<p>회원탈퇴 시 올리브영 쇼핑몰을 이용하실 수 없습니다.</p>
						<div class="BtnArea">
							<div class="styleBtn2 styleBtn4" id="outBtn" onclick="out();">회원 탈퇴 하기</div>
						</div>
					</div>
				</div>	
			</article>
		</div>	<!-- container 끝 -->
		
		
		<!-- 회원정보 수정 모달 -->
		<div class="modal" id="modifMd">
		    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
		    <div class="modal_content manageMd">
		        <h2 id="modal_text">회원정보를 수정하시겠습니까?</h2>
		        <div class="containerBtn">
			        <div class="styleBtn shapeBtn" id="confirmBtn">확인</div>
			        <div class="styleBtn2 shapeBtn" id="offBtn">취소</div>
		        </div>
		    </div>
		</div>
		
		<!-- 취소 모달 -->
		<div class="modal" id="cancelMd">
		    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
		    <div class="modal_content manageMd">
		        <h2 id="modal_text">회원정보 수정을 취소하시겠습니까?</h2>
		        <div class="containerBtn">
			        <div class="styleBtn shapeBtn" id="confirmBtn">확인</div>
			        <div class="styleBtn2 shapeBtn" id="offBtn">취소</div>
		        </div>
		    </div>
		</div>
		
		<!-- 회원탈퇴 모달 -->
		<div class="modal" id="outMd">
		    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
		    <div class="modal_content manageMd">
		        <h2 id="modal_text">회원탈퇴를 진행하시겠습니까?</h2>
		        <div class="containerBtn">
			        <div class="styleBtn shapeBtn" id="confirmBtn">확인</div>
			        <div class="styleBtn2 shapeBtn" id="offBtn">취소</div>
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
	<!-- 주소찾기 API 다음 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<!-- 이름 입력 디자인 -->
	<script>
		$('#modif_name').focusout(function() {
				var name = $("#modif_name").val();
				
				/* 이름 입력 여부 확인 */
				if (name == '') {	// 이름을 입력하지 않았을 경우
		        	$(".td_name #error").css('display', 'block');
		        	$("#modif_name").css('border', '1px solid #FA5855');
		        	$(".td_name #error2").css('display', 'none');	// error2는 숨긴다.
	        	} else {			// 뭐라도 입력했을 경우
	        		$(".td_name #error").css('display', 'none');
	        		$("#modif_name").css('border', '1px solid #dcdcdc');	/* 회색 */
	        	}
			
				/* 한글과 영어만 입력, 2글자 이상 입력 */
				if(name != '') {	// null이 아닐 때만 검사한다.
					var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20a-zA-Z])/i;
					var blank_pattern = /[\s]/g;
					var patternName = pattern.test($("#modif_name").val());	// 문장 안에 한글이나 영어가 들어가 있으면 true
					
					// 이름에 한글, 영어만 입력
					if(patternName) {	
						$(".td_name #error2").css('display', 'block');
			        	$("#modif_name").css('border', '1px solid #FA5855');
					} else {
		        		$(".td_name #error2").css('display', 'none');
		        		$("#modif_name").css('border', '1px solid #dcdcdc');
		        	}
					
					// 2글자 이하일 때
					if(name.length < 2) {	
						$(".td_name #error2").css('display', 'block');
						$("#modif_name").css('border', '1px solid #FA5855');
					}
					
					// 공백 불가
					if( blank_pattern.test(name) == true) {
						$(".td_name #error2").css('display', 'block');
						$("#modif_name").css('border', '1px solid #FA5855');
					}
				}
			});
	</script>
	
	
	<!-- 휴대전화 번호 입력 디자인 -->
	<script>
		/* 숫자만 입력 가능 */
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
		
		/* 휴대전화 번호 입력여부 확인 */
		$('#modif_phone2, #modif_phone3').focusout(function() {
			var phone2 = $('#modif_phone2').val();
			var phone3 = $('#modif_phone3').val();
			
			// 둘 다 null인 경우
			if(phone2 == '' && phone3 == '') {	
				$("#modif_phone2").css('border', '1px solid #FA5855');
				$("#modif_phone3").css('border', '1px solid #FA5855');
				$(".td_phone #error").css('display', 'block');
			}
			
			// 둘 다 null이 아닌 경우
			if(phone2 != '' && phone3 != '') {
				$(".td_phone #error").css('display', 'none');
			}
		});
		
		/* 휴대전화 번호 입력여부 확인 - modif_phone2 */
		$('#modif_phone2').focusout(function() {
			var phone2 = $('#modif_phone2').val();
			
			if(phone2 == '') {
				$(".td_phone #error").css('display', 'block');
	        	$("#modif_phone2").css('border', '1px solid #FA5855');
	        	$(".td_phone #error2").css('display', 'none');	// 계속 같이 떠서 지움
			} else {
	        	$("#modif_phone2").css('border', '1px solid #dcdcdc');	// 회색
			}
			

			// 3자리 이상 입력 확인
			var phone2Len = phone2.length;
			if(phone2 != '') {	// null이 아닐 때만 여부확인
				if(phone2Len < 3) {	// 3자리 이상 입력 가능
					$(".td_phone #error").css('display', 'none');	// 헷갈려서
					$(".td_phone #error2").css('display', 'block');
					$("#modif_phone2").css('border', '1px solid #FA5855');
				} else {
					$(".td_phone #error2").css('display', 'none');
					$("#modif_phone2").css('border', '1px solid #dcdcdc');
				}
			}	
		});
		
		/* 휴대전화 번호 입력여부 확인 - modif_phone3 */
		$('#modif_phone3').focusout(function() {
			var phone2 = $('#modif_phone2').val();
			var phone3 = $('#modif_phone3').val();
			if(phone3 == '') {
				$(".td_phone #error").css('display', 'block');
	        	$("#modif_phone3").css('border', '1px solid #FA5855');
	        	$(".td_phone #error2").css('display', 'none');	// 계속 같이 떠서 지움
			} else {
	        	$("modif_phone3").css('border', '1px solid #dcdcdc');
			}
			
			// 3자리 이상 입력 확인
			var phone3Len = phone3.length;
			if(phone3 != '') {	// null이 아닐 때만
				if(phone3Len < 4) {	// 4자리 이상 입력 가능
					$(".td_phone #error").css('display', 'none');	// 헷갈려서
					$(".td_phone #error2").css('display', 'block');
					$("#modif_phone3").css('border', '1px solid #FA5855');
				} else {
					$(".td_phone #error2").css('display', 'none');
					$("#modif_phone3").css('border', '1px solid #dcdcdc');
				}
			}
		});
	</script>	
	
	
	<!-- 이메일 -->
	<script>
		/* 이메일 select한 것이 modif_email2로 들어오게 한다. */
		$('#modif_email3').change(function() { 
			$("#modif_email3 option:selected").each(function() {	// 이메일 select박스에 선택되어 있는 것을 대상으로 함수 실행 
				if($(this).val() == '') { // 직접입력을 선택한 경우 
					$("#modif_email2").val(''); //값 초기화 
					$("#modif_email2").attr("readonly",false); //활성화 
					$("#modif_email2").css("color", "#5A5555"); // 검정글씨
					$("#modif_email2").css("background-color", "white");
					
				} else { //직접입력이 아닐경우 
					$("#modif_email2").val($(this).val()); // 선택값 입력
					$("#modif_email2").attr("readonly", true); //비활성화 
					$("#modif_email2").css("color", "#999999"); // 회색글씨
					$("#modif_email2").css("background-color", "#EEEEEE"); // 회색배경
				} 
			}); 
		});
		
		
		/* email1 디자인 */
		$('#modif_email1').focusout(function () {
			var email1 = $('#modif_email1').val();
			var email2 = $('#modif_email2').val();
			
			// 입력여부 검사
			if(email1 == '') {
	        	$("#modif_email1").css('border', '1px solid #FA5855');
				$(".td_email #error").css('display', 'block');
	        	$(".td_email #error2").css('display', 'none');	// 계속 같이 떠서 지움
			} else {
				$("#user_email1").css('border', '1px solid #dcdcdc');	// 회색
				$(".td_email #error").css('display', 'none');
			}
			
			// 한글입력 불가, 2글자 이상 입력
			if(email1 != '') {	// null이 아닐 때만 검사한다.
				var pattern = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
				var chkEmail = pattern.test($("#modif_email1").val());	
				// test() : 찾는 문자열이 들어있는지 아닌지를 알려준다.
				// true를 리턴하면 한글이 아니고, false를 리턴하면 한글이다.
				
				// 한글입력 불가
				if(!chkEmail) {	
					$(".td_email #error").css('display', 'none');
					$(".td_email #error2").css('display', 'block');
		        	$("#modif_email1").css('border', '1px solid #FA5855');
				} else {
	        		$(".td_email #error2").css('display', 'none');
	        		$("#modif_email1").css('border', '1px solid #dcdcdc');
	        	}
				
				// 2글자 이상 입력
				if(email1.length < 2) {
					$(".td_email #error").css('display', 'none');
					$(".td_email #error2").css('display', 'block');
		        	$("#modif_email1").css('border', '1px solid #FA5855');
				}
			}
		});
		
		/* 입력여부 확인 - email2 */
		$('#modif_email2, #modif_email3').focusout(function () {
			var email1 = $('#modif_email1').val();
			var email2 = $('#modif_email2').val();
			
			if(email2 == '') {
				// email2만 null일 때
				$(".td_email #error").css('display', 'block');
	        	$("#modif_email2").css('border', '1px solid #FA5855');
	        	$(".td_email #error2").css('display', 'none');	// 계속 같이 떠서 지움
	        	
	        	if(email1 == '') {	// email1, email2 둘다 null이라면
	        		$("#modif_email1").css('border', '1px solid #FA5855');	// 2입력 안하면 1도 빨간박스
	        		$(".td_email #error").css('display', 'block');			// 입력하라는 글자
	        	}
			} else {
				if(email1 == '') {	// eamil1만 null일 때
	        		$("#modif_email1").css('border', '1px solid #FA5855');
	        		$(".td_email #error").css('display', 'block');
	        		
	        	} else {	// 둘 다 null이 아닐 때
	        		$("#modif_email2").css('border', '1px solid #dcdcdc');
	        		$(".td_email #error").css('display', 'none');
	        	}	
			}
			
			/* email2 이메일 형식 입력 */
			if(email2 != '') {
				var pattern2 = /^([a-zA-Z]+)(\.[a-zA-Z]{1,4})/;	// .다음에 글자 2개 이상
				var chkEmail2 = pattern2.test($("#modif_email2").val());      
				if(!chkEmail2) {	// false라면
					$(".td_email #error").css('display', 'none');
					$(".td_email #error2").css('display', 'block');
		        	$("#modif_email2").css('border', '1px solid #FA5855');
				} else {
	        		$(".td_email #error2").css('display', 'none');
	        		$("#modif_email2").css('border', '1px solid #dcdcdc');
	        	}
			}
			
			// email2 공백사용 불가
			var blank_pattern = /[\s]/g;
			if(blank_pattern.test(email2) == true) {
				$("#modif_email2").css('border', '1px solid #FA5855');
				$(".td_email #error2").css('display', 'block');
				$(".td_email #error").css('display', 'none');
			}
		});
	</script>
	
	<!-- 주소 -->	
	<script>	
		/* 주소찾기 다음 API 연결 */
		function openZipSearch() {	// 이름 설정
			new daum.Postcode({
				oncomplete: function(data) {
					$('#modif_zip').val(data.zonecode); // 우편번호 (5자리)
			
					if(data.buildingName != "") {
						// 만약 빌딩 이름이 존재한다면 괄호 안에 넣는다.
						$('#modif_addr1').val(data.address + " (" + data.buildingName + ") ");	// 주소
					} else {
						$('#modif_addr1').val(data.address + data.buildingName + " ");
					}
				}
			}).open();
		$('#modif_addr2').focus();	// 주소 선택 후 바로 입력할 수 있도록 focus한다.
		}
	</script>
	
	<!-- 이름, 휴대전화, 이메일 입력 확인 함수 -->
	<script type="text/javascript">
		/* 이름 */
		function nameCheck() {
			var name = document.modifForm.modif_name;
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
		
		/* 휴대전화 */
		function phoneCheck() {
			var phone2 = $("#modif_phone2");
			var phone3 = $("#modif_phone3");
			
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
			var email1 = $("#modif_email1");
			var email2 = $("#modif_email2");
			
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
			var chkEmail2 = pattern2.test($("#modif_email2").val());      
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
	</script>
	
	<!-- 회원정보 수정 버튼 -->
	<script type="text/javascript">
		function modifCheck() {		
			var nameChk = nameCheck();
			if(nameChk == false) return;
			
			var phoneChk = phoneCheck();
			if(phoneChk == false) return;
			
			var emailChk = emailCheck();
			if(emailChk == false) return;
			
			// true라면 모달창 오픈
			$("#modifMd").css("display", "block");
	        $('body').css("overflow", "hidden");
		}
	</script>
	
	<!-- 회원정보 수정버튼 모달 -->
	<script type="text/javascript">
		// 회원정보 수정 모달창 안 확인버튼
		$("#modifMd #confirmBtn").click(function() {
			document.modifForm.submit();
		});
		
		// 회원정보 수정 모달창 안 취소버튼
		$("#modifMd #offBtn").click(function() {
			$("#modifMd").css("display", "none");
	        $('body').css("overflow", "auto");
		});
	</script>
	
	<!-- 취소버튼 모달 -->
	<script type="text/javascript">
		function cancel() {	
			// 모달창 오픈
			$("#cancelMd").css("display", "block");
	        $('body').css("overflow", "hidden");
		}
		
		// 취소 모달창 안 확인버튼
		$("#cancelMd #confirmBtn").click(function() {
			location.href = 'myPageManage1.bo';
		});
		
		// 취소 모달창 안 취소버튼
		$("#cancelMd #offBtn").click(function() {
	    	$("#cancelMd").css("display", "none");
	        $('body').css("overflow", "auto");
		});
	</script>	
	
	<!-- 회원탈퇴 버튼 모달 -->
	<c:set var="delId" value="${bean.user_id }" />
	<script type="text/javascript">
		var delId = '<c:out value="${delId}" />';
		
		function out() {	
			// 모달창 오픈
			$("#outMd").css("display", "block");
	        $('body').css("overflow", "hidden");
		}
		
		// 탈퇴 모달창 안 확인버튼
		$("#outMd #confirmBtn").click(function() {
			// console.log("delId는? : " + delId);
			location.href='myPageDeleteAction.bo?id=' + delId;
		});
		
		// 탈퇴 모달창 안 취소버튼
		$("#outMd #offBtn").click(function() {
	    	$("#outMd").css("display", "none");
	        $('body').css("overflow", "auto");
		});
	</script>	
</body>
</html>