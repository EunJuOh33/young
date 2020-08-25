<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
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
	<link rel="stylesheet" href="css/userCss/usermanage.css" />
	<link rel="stylesheet" href="css/userCss/userinfo.css" />
	
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
		
		
		<div id="container">
			<div class="wide_menu">
				<div class="menu">
					<h2><a href="userListAction.bo">회원관리</a></h2>
					<p>회원정보</p>
				</div>
			</div>
		
			<article>
				<h2>회원정보</h2>
				<div class="userInfoArea">
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
											<div class="td_name"><span>${bean.user_name }</span></div>
										</td>
									</tr>
									<tr>
										<th>아이디</th>
										<td>
											<div class="td_id"><span>${bean.user_id }</span></div>
										</td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td>
											<div class="td_birth">
												<span>
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
												<span>
													<c:set var = "phone_length" value = "${fn:length(bean.user_phone)}" />
													${fn:substring(bean.user_phone, 0, 3) } -
													<c:choose>
														<c:when test="${phone_length == '10'}">
															${fn:substring(bean.user_phone, 3, 6) } -
														</c:when>
														<c:otherwise>	
															${fn:substring(bean.user_phone, 3, 7) } -
														</c:otherwise>
													</c:choose>
													${fn:substring(bean.user_phone, phone_length -4, phone_length) } 
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
											<div class="td_email">
												<span>
													${fn:substringBefore(bean.user_email, '@') }
													@
													${fn:substringAfter(bean.user_email, '@') }
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<th>주소</th>
										<td class="addrArea">
											<div class="td_zip">
												<c:choose>
													<c:when test="${bean.user_zip eq '0'}">
														<span>없음</span>
													</c:when>
													<c:otherwise>	
														<span>${bean.user_zip }</span>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="td_addr">
												<c:choose>
													<c:when test="${bean.user_addr == null}">
														<span></span>
													</c:when>
													<c:otherwise>	
														<span>${bean.user_addr }</span>
													</c:otherwise>
												</c:choose>
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
											<input type="radio" name="gender" id="m" value="남" checked disabled="disabled" />
											<label for="m">남성</label>
										</div>
										<div>
											<input type="radio" name="gender" id="w" value="여" disabled="disabled" />
											<label for="w">여성</label>
										</div>
										<div class="noRadio">
											<input type="radio" name="gender" id="n" value="" disabled="disabled" />
											<label for="n">선택안함</label>
										</div>
									</c:when>
									<c:when test="${bean.user_gender eq '여'}">
										<div>
											<input type="radio" name="gender" id="m" value="남" disabled="disabled" />
											<label for="m">남성</label>
										</div>
										<div>
											<input type="radio" name="gender" id="w" value="여" checked disabled="disabled" />
											<label for="w">여성</label>
										</div>
										<div class="noRadio">
											<input type="radio" name="gender" id="n" value="" disabled="disabled" />
											<label for="n">선택안함</label>
										</div>
									</c:when>
									<c:otherwise>	
										<div>
											<input type="radio" name="gender" id="m" value="남" disabled="disabled" />
											<label for="m">남성</label>
										</div>
										<div>
											<input type="radio" name="gender" id="w" value="여" disabled="disabled" />
											<label for="w">여성</label>
										</div>
										<div class="noRadio">
											<input type="radio" name="gender" id="n" value="" checked disabled="disabled" />
											<label for="n">선택안함</label>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="add_titB">관심있는 제품</div>
							<div class="product">
								<c:choose>
									<c:when test="${bean.select_p == null}">
										<input type="text" id="select_p" value="선택안함" readonly />
									</c:when>
									<c:otherwise>	
										<input type="text" id="select_p" value="${bean.select_p }" readonly />
									</c:otherwise>
								</c:choose>
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
														<input type="radio" id="emailRecv_y" value="Y" checked disabled="disabled" />
														<label for="emailRecv_y">수신</label>
													</span>
													<span class="radioArea">
														<input type="radio" id="emailRecv_n" value="N" disabled="disabled" />
														<label for="emailRecv_n">미수신</label>
													</span>
												</c:when>
												<c:otherwise>
													<span class="radioArea">
														<input type="radio" id="emailRecv_y" value="Y" disabled="disabled" />
														<label for="emailRecv_y">수신</label>
													</span>
													<span class="radioArea">
														<input type="radio" id="emailRecv_n" value="N" checked disabled="disabled" />
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
														<input type="radio" id="smsRecv_y" value="Y" checked disabled="disabled" />
														<label for="smsRecv_y">수신</label>
													</span>
													<span class="radioArea">
														<input type="radio" id="smsRecv_n" value="N" disabled="disabled" />
														<label for="smsRecv_n">미수신</label>
													</span>
												</c:when>
												<c:otherwise>
													<span class="radioArea">
														<input type="radio" id="smsRecv_y" value="Y" disabled="disabled" />
														<label for="smsRecv_y">수신</label>
													</span>
													<span class="radioArea">
														<input type="radio" id="smsRecv_n" value="N" checked disabled="disabled" />
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
														<input type="radio" id="postRecv_y" value="Y" checked disabled="disabled" />
														<label for="postRecv_y">수신</label>
													</span>
													<span class="radioArea">
														<input type="radio" id="postRecv_n" value="N" disabled="disabled" />
														<label for="postRecv_n">미수신</label>
													</span>
												</c:when>
												<c:otherwise>
													<span class="radioArea">
														<input type="radio" id="postRecv_y" value="Y" disabled="disabled" />
														<label for="postRecv_y">수신</label>
													</span>
													<span class="radioArea">
														<input type="radio" id="postRecv_n" value="N" checked disabled="disabled" />
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
							<div class="styleBtn2" id="listBack_Btn" onClick="location.href='userListAction.bo'">회원목록</div>
						</div>
					</div>	
				</div>	
			</article>
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
	</div>
	
	
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
</body>
</html>