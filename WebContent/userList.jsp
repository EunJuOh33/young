<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<%@ page import="java.util.*" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
	<link rel="stylesheet" href="css/userCss/userlist.css" />
	<link rel="stylesheet" href="css/userCss/usermanage.css" />
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
		
		
		<div id="container">
			<div class="wide_menu">
				<div class="menu">
					<h2><a href="userListAction.bo">회원관리</a></h2>
					<p>회원목록</p>
				</div>
			</div>
		
			<article>
				<h2>회원목록</h2>

				<!-- 리스트 -->
				<div class="userListArea">
					<table>
						<caption>회원목록 표</caption>
						<colgroup>
							<!-- 너비를 지정해서 table-layout: fixed -->
							<!-- 체크박스 <col width="100px"> -->
							<col width="460px">
							<col width="320px">
							<col width="200px">
						</colgroup>
						<thead>
							<tr>
								<!-- 체크박스<th class="th_thumb">
									<input type="checkbox" id="allChk" value="allCheck" />
									<label for="allChk"><span class="blind">전체선택</span></label>
								</th>-->
								<th class="th_id">아이디</th>
								<th class="th_name">이름</th>
								<th class="th_btn"></th>
							</tr>
						</thead>
						<tbody>
							<!-- items="{리스트가 받아올 배열이름}" var="for문 내부에서 사용할 변수" varStatus="반복index 변수" -->
							<c:forEach var="list" items="${userList }" varStatus="status" >
							<c:set var="test" value="${status.current }" />
							<tr>
								<!-- 체크박스 <td class="td_thumb">
									<input type="checkbox" class="oneCheck" id="oneCheck_${list.user_id }" value="${list.user_id }" />
									<label for="oneCheck_${list.user_id }"><span class="blind">회원아이디</span></label>
								</td>-->
								<td class="td_id">
									<a href="userViewAction.bo?id=${list.user_id }">${list.user_id }</a>
								</td>
								<td class="td_name">
									<p>${list.user_name }</p>
								</td>
								<td class="td_btn">
									<button class="icon_del" data-id="${list.user_id }">
										<!-- onclick="return confirm('회원을 삭제하시겠습니까?') -->
									</button>
								</td>
							</tr>
							</c:forEach>
							<tr class="noAdmin" style="display: none;">
								<td><p>등록된 회원이 없습니다.</p></td>
							</tr>	
						</tbody>
					</table>
				</div>
				
			<!--<div class="paging">
					<span class="first">
						<a href="javascript:void(0);" title="맨처음"><img src="https://image.drjart.com/front/ko/images/common/arr_pageFirst.png" alt="First" /></a>				
					</span>
					<span class="prev">
						<a href='#'><img src="https://image.drjart.com/front/ko/images/common/arr_pagePrev.png" alt="Previous"></a>
					</span>
					<span class="current">	
						<a href='#'>1</a>
					</span>	
					<a href="javascript:void(0);">2</a>
					<span class="next">
						<a href="#"><img src="https://image.drjart.com/front/ko/images/common/arr_pageNext.png" alt="Next"></a>
					</span>	
					<span class="last">
						<a href="javascript:void(0);" title="맨 마지막"><img src="https://image.drjart.com/front/ko/images/common/arr_pageLast.png" alt="Last"></a>
					</span>
				</div>	-->
				
				<!-- 버튼 -->
			<!--<div class="delBtn">
					<div class="styleBtn3" id="userDelChk_Btn">선택회원 삭제</div>
				</div>	-->
			</article>
		</div>	<!-- container 끝 -->
		
		
		<!-- 비밀번호 체크 모달 -->
		<div class="modal" id="userDelMd">
		    <div class="modal_layer"></div>	<!-- 검은반투명 배경 -->
		    
		    <div class="modal_content userDelMd_content">
		        <h2 id="modal_text">회원을 삭제하시겠습니까?</h2>
		        <div class="containerBtn">
			        <div class="styleBtn" id="userDelMd_confirmBtn">확인</div>
			        <div class="styleBtn2" id="userDelMd_offBtn">취소</div>
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
	</div>	<!-- wrap 닫음 -->
	
	
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
	
	<!-- 삭제 모달 -->
	<script>
		var delId = "";
	
		$(function() {			
			$(".icon_del").on("click", function(e) {
				$("#userDelMd").css("display", "block");
		        $('body').css("overflow", "hidden");
		        
		        delId = $(this).attr("data-id");	// data-id속성 값을 가져온다.
		        $("#userDelMd #modal_text").html("<span style='color: #999999';>" + delId + "</span><br/>회원을 삭제하시겠습니까?");
			});
			
			// 모달 창 안 확인버튼 : 회원을 삭제한다.
			$("#userDelMd_confirmBtn").on("click", function(e) {
				location.href='userDeleteAction.bo?id=' + delId;
			});
		});
	</script>
	
	<script>
		// 취소 버튼 : 모달 창이 닫힌다.
		document.getElementById("userDelMd_offBtn").onclick = function() {
	    	$("#userDelMd").css("display", "none");
	        $('body').css("overflow", "auto");
	    }
	</script>
	
	<!-- 체크박스 -->
	<script>   
		/* 체크박스 전체 선택 */ 
		function allCheckFunc(obj) {
			$(".oneCheck").prop("checked", $(obj).prop("checked") );
		}
		
		/* 체크박스 개별 체크시 전체선택 체크 여부 */
		function oneCheckFunc(obj) {
			var allObj = $("#allChk");
		
			if($(obj).prop("checked")) {
				checkBoxLength = $(".oneCheck").length;
				checkedLength = $(".oneCheck:checked").length;
		
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
			$("#allChk").click(function() {
				allCheckFunc( this );
			});
			$(".oneCheck").each(function() {
				$(this).click(function() {
					oneCheckFunc( $(this) );
				});
			});
		});
	</script>
</body>
</html>