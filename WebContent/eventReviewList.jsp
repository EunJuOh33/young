<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>    
<%@ page import = "java.util.*" %>
<%@page import="com.user.dao.UserDAO" %>
<%@page import="com.user.bean.UserBean" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%	request.setCharacterEncoding("UTF-8"); %>     

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>OLIVE YOUNG</title>

<!-- Style -->
<link rel="stylesheet" href="css/content5.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css" />
<link rel="stylesheet" href="css/common.css">

<script src=https://code.jquery.com/jquery-3.5.1.min.js></script>	
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
.rollBanner>a 
{ height:40px; 
  display:block; 
  font-size:15px; 
  text-align:center; 
  line-height:40px; }
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
			
	<!-- 와이드 메뉴 -->	
	<div id="container">
	 	<div class="wideContent">
			<div class="upMenu" id="up">
				 <h2 class="topTitle">이벤트</h2>
				<ul>
					<li><a href="main.do">이벤트</a></li>		
					<!-- <li><a href="eventNotice.jsp">당첨자 발표</a></li> -->		
					<li id="on"><a href="list.do">이벤트 리뷰</a></li>		
				</ul>
			</div>	
		</div>
		
		<div class="contents">
			<h2 class="conTitle">이벤트 리뷰</h2>
			<!-- 이벤트 리뷰 제목 -->
			<div class="board">
				<div class="listTotal">
					<h3 class="listTi">${bean.title}</h3>
					<p class="evt_info">
						<span class="evt_name">
					 		${bean.writer}
					 	</span>
					 	<span class="evt_date">${bean.fdate}</span>
					</p>
				</div>
					
				<!-- 게시판 내용 -->
				<div class="boardList">
					<div class="boardCon">
						<p>${bean.content}</p>
					<div class="article">
					<c:if test="${bean.file!=null}">
						<!-- head는 사진 제목 뽑기. -->
						<c:set var="head" value="${fn:substring(bean.file, 0, fn:length(bean.file)-4)}"></c:set>
							<!-- pattern은 이미지 형식 뽑기. -->
						<c:set var="pattern" value="${fn:substring(bean.file, fn:length(head) +1, fn:length(bean.file))}"></c:set>
						<c:choose>
							<c:when test="${pattern == 'jpg' || pattern == 'gif' || pattern == 'png'}">
								<img src="UploadFolder/${head}.${pattern}" width="50%" height="50%"/><br/>
							</c:when>
							<c:otherwise>
								<c:out value="NO IMAGE"></c:out>
							</c:otherwise>
						</c:choose>
					</c:if>
					<div class="fileChum">
						파일첨부 : <a href='FileDownloadAction.do?file_name=${bean.file}'>${bean.file}</a>
					</div>
				</div>				 	
			 </div>
		</div>
	</div>

	<!-- 목록 아이콘 -->
	<div class="list_btn">
		<a href="list.do" class="btn_css">
			<div class="button-1">
				<div class="eff-1"></div>
				<span>목록</span>
			</div>
		</a>
	</div>
	<div class="list_btn_l">
				<!-- <input type="button" value="수정" onclick="doAction(0)" />
				<input type="button" value="삭제" onclick="doAction(1)" /> -->
				<c:if test="${id.equals(bean.writer)}">
				<a href="modifyForm.do?seq=${bean.seq}" class="button-4">
				<div class="eff-4"></div>
				<span>수정</span>
				</a>
				</c:if>
				
				<c:if test="${!id.equals(bean.writer)}">
				<a href="#" onClick="chanView(1);" class="button-3">
				<div class="eff-3"></div>
				<span>삭제</span>
				</a>
				</c:if>
				
				<c:if test="${id.equals(bean.writer)}">
				<a href="#" onClick="chanView(2);" class="button-3">
				<div class="eff-3"></div>
				<span>삭제</span>
				</a>
				</c:if>
				
				<c:if test="${!id.equals(bean.writer)}">
				<a href="#" onClick="chanView(3);" class="button-4">
				<div class="eff-4"></div>
				<span>수정</span>
				</a>
				</c:if>
				
				
			
			</div>	
				<script type="text/javascript">
					function chanView(value) {
						if(value=="1"){
							alert('글 작성자만 삭제 가능합니다.');
						}else if(value=="2"){
							alert('삭제하시겠습니까?');
							location.href = "delete.do?seq=${bean.seq}";
						}else if(value=="3"){
							alert('글 작성자만 수정 가능합니다.');
						}
					}
				
				</script>
				
				<!-- <script>
				$(".button-4").click(function doAction(value){
					if (value == 0) {
						if(alert('수정하시겠습니까?');
						location.href = "modifyForm.do?seq=${bean.seq}";
						}
					}

					function doAction(value) {
						if (value == 0) {
						if(alert('수정하시겠습니까?');
						location.href = "modifyForm.do?seq=${bean.seq}";
						
						} else if (value == 1) {
							alert('삭제하시겠습니까?');
							location.href = "delete.do?seq=${bean.seq}";
						}
					}
				</script> -->
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
		</footer>
		

		<!-- 진행 중인 이벤트 사진 -->
		
		
		
		<!-- 이벤트 당첨자 후기 리스트 -->
</body>
</html>