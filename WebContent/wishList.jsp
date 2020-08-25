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
<link rel="stylesheet" href="css/my1.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css" />
<link rel="stylesheet" href="css/maincss/common.css">

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

	function needLogin() {
		alert('로그인이 필요한 항목입니다.');
		location.href="userLogin.bo";
	}
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
		$.jart.common.cart.getWishList().done(function(data){
			if(data && data.length > 0) {
				$('#hCartCnt').html(data.length);
				$('#hCartCnt').closest('.cart').addClass('active');
			}
		});
		$(".fixmenu .plus").click(function(){
			location.href = "/"
		});
	})
	
		function  checkAll(theForm){
			if(theForm.remove.length == undefined){
				theForm.remove.checked = theForm.allCheck.checked;
			}else{
				for(var i=0; i<theForm.remove.length; i++){
					theForm.remove[i].checked = theForm.allCheck.checked;
				}
			}
		}
		
		function checkQty(name,qty){
			if(qty != 1){
				location.href="prdCartQtyDown.vo?name="+name;
			}
		}
	</script> 

	<!-- 와이드 메뉴 -->	
	<div id="container">
		<!-- 맨 위 메뉴 -->
	 	<div class="wideContent">
			<div class="upMenu" id="up">
				<div class="menu">
					<h2 class="topTitle">
				 		<a href="myPage.bo">마이페이지</a>
				 	</h2>
					<p><a href="myPageManage1.bo">정보관리</a></p>
					<!-- <p><a href="orderList.vo">주문조회</a></p> -->
					<p><a href="wishList.jsp" id="on">위시리스트</a></p>
				</div>
			</div>
		
		<!-- 마이페이지 콘텐츠  -->
		<div class="contents">
	 		<div class="wishList">
	 			<p class="wishTit">나의 위시리스트</p>
	 			<div class="wishPrd">
	 			
		 			<% String user_id = (String)session.getAttribute("user_id"); %>
		 			<c:if test="${wishList == null }">
						<p>위시리스트 상품이 없습니다.</p>
					</c:if>
					<c:if test="${wishList != null}">
						<form id="order_Form" action="OrderList.jsp" method="post">
						<div class="tbl_order borderT tbl_wishList" name="wishListArea">
							<table summary="위시 리스트 내역">
								<caption>위시 리스트 내역 표</caption>
								<colgroup>
									<col width="120px">
									<col width="*">
									<col width="170px">
									<col width="200px">
								</colgroup>
								<thead>
									<tr>
										<th class="th_thumb">
										<!--<span class="inp_check">
											    <input name="allCheck" id="allCheck" type="checkbox" onclick="checkAll(this.form)" style="opacity: 1"/>
											    <span class="blind">전체선택</span>
											</span>
								            <span class="blind">상품이미지</span>	-->
								        </th>
										<th class="th_prd">
								            <span>상품 명</span>
								        </th>
										<th class="th_price">금액</th>
										<th class="th_btn">
											<!-- <span class="blind">주문하기 / 삭제</span> --> 
										</th>
									</tr>
								</thead>
			 
								<c:forEach var="wish" items="${wishList }"  varStatus="status">
								<tbody id="wishlist">
									<tr name="prdtItem" data-prdmngseq="21228" data-prdcncrseq="90277" data-prdseq="21772" data-prdno="SET0332K1" data-erpno="" data-prdkonm="솔라바이옴™앰플 특별 기획세트 " data-mblprdkonm="솔라바이옴™앰플 특별 기획세트 " data-eventprchfl="N" data-eventprchqty="0" data-eventprchpmtqty="0" data-rwrdprcfl="N" data-rwrdprcmngseq="163" data-rwrdprcprdseq="1539" data-stkqty="1455" data-salstatcd="001">
									<td class="td_thumb">
									<!--<span class="inp_check" >
											<input type="checkbox" id="remove" name="remove" value="remove" style="opacity: 1" />
											<span class="blind">선택${wish_name}</span>
										</span> -->
										<a style='cursor:default;' href="javascript:;" class="opt_thumb" name="item_detail">
											<img src="img/${wish.wish_image}" width="120" alt="상품명">
										</a>
									</td>
									<td class="td_prd">
										<a style='cursor:default;' href="javascript:;" class="opt_detail" name="item_detail">
											<p class="opt_prdinfo">${wish.wish_content }</p>
											<p class="opt_prdname">${wish.wish_name }</p>
										</a>
									</td>
									<td class="td_price">
										<div class="opt_price">
											<span class="normal">${wish.wish_price } 원</span> 
										</div>
									</td>
									<td class="td_btn">
									<!--<div class="iconwrap">
											<button type="submit"><span class="ju">주문하기</span></button>
											<span class="sak">
												<a href="orderRemove.vo"><img src="img/ex.svg" alt="삭제"/></a>
											</span>
										</div> -->
									</td>
								</tr>
							</tbody>
							</c:forEach>	
						</table>
					</div>
	
					<div class="but_">
					<!--<a href="prdCartRemove.vo" class="button-3">
							<div class="eff-3"></div>
							<span>선택 상품 삭제</span>
						</a> -->
						<button onclick="subMit();" class="button-4">
							<div class="eff-4"></div>
							<span>선택 상품 주문</span>
						</button>
					</div>
					
					<script type="text/javascript">
						function subMit() {
							alert("주문 페이지로 이동합니다.");
							form.submit();
							
						}
					</script>		
				</form>
			</c:if>
	 	</div>
	 </div>
</div>

					<!-- 페이징 처리 -->
				
			<%-- <div id="paging">
				<c:if test="${startPage!=1}">
					<a href='list.do?page=${startPage-1}'>[이전]</a>
				</c:if>
				<c:if test="${startPage==1}">
					<a href='#'>[이전]</a>
				</c:if>
				<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
					<a href='list.do?page=${pageNum}'>${pageNum}&nbsp;</a>
				</c:forEach>
				<c:if test="${endPage!=totalPage}">
					<a href='list.do?page=${endPage+1}'>[다음]</a>
				</c:if>
				<c:if test="${endPage==totalPage}">
					<a href='#'>[다음]</a>
				</c:if>
			</div>
			 --%>

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
					 	<span>개인정보관리책임자 : 신재원 팀장</span>
					 	<span>&nbsp;&nbsp;&nbsp;고객만족센터 : 1234-5678 ( 운영시간 : 09:00~18:00, 점심시간 : 11:50~12:50 )</span>
					 	<span>&nbsp;&nbsp;&nbsp;FAX : 12-3456-7891</span>
					 </p>				 
					 <p>
					 	<span>전자우편주소 : &nbsp;<a href="mailto:shjaewon.dev@gmail.com" class="mail" style="color: #999999">qmffkrql1108@gmail.com</a></span> 
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