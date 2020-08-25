<%@ page import = "com.shop.bean.*, com.shop.dao.PrdDAO, java.util.List, java.text.SimpleDateFormat, java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OLIVE YOUNG</title>
<link rel="stylesheet" href="css/maincss/common.css">
<link rel="stylesheet" href="css/maincss/slick.css">
<link  rel="stylesheet" href="css/maincss/jquery-ui.css">
<link  rel="stylesheet" href="css/maincss/jquery.mCustomScrollbar.min.css">
<link  rel="stylesheet" href="css/maincss/order.css">
<link rel="stylesheet" href="css/maincss/main.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.js"></script>
<script src="https://www.jsviews.com/download/jsrender.min.js"></script>
<script src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.js"></script>
<script src="js/easings.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.inview.js"></script>
<script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
<script src="js/json2.js"></script>
<script src="js/slick.js"></script>

<script src="js/ul.js"></script>
<script src="js/young.main.js"></script>
<script>
	function  checkAll(theForm){
		if(theForm.remove.length == undefined){
			theForm.remove.checked = theForm.allCheck.checked;
		}else{
			for(var i=0; i<theFrom.remove.length; i++){
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
</head>
<body class="loading">
	<div class="skipNavi">
		<ul>
			<li><a href="#header">주메뉴 바로가기</a></li>
			<li><a href="#container">본문 바로가기</a></li>
			<li><a href="#footer">하단메뉴 바로가기</a></li>
		</ul>
	</div>
	<div class="MAIN" id="wrap">
		<div class="textBanner" id="topBnr" style="background: rgb(0, 184, 186); display: none;">
			<div id="topBnrList">
		</div>
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
		
	<section>
		<div class="order" id="container">
			<div class="wideContents">
				<div class="order_step">
					<ol>
						<li class="s1 on"><span>01</span> 장바구니</li>
						<li class="s2"><span>02</span> 결제진행</li>
						<li class="s3"><span>03</span> 주문완료</li>
					</ol>
				</div>
				<div class="pageTitArea">
					<img alt="" src="https://image.drjart.com/front/ko/images/order/ico_cart.gif">
					<h2 class="tit_en">장바구니</h2> 
				</div>
			</div>
			<div class="contents aside_con">
				<c:if test="${cartList == null }">
					<div class="noData border" id="noCrtData">
						<p>장바구니에 담긴 상품이 없습니다.</p>
					</div>
				</c:if>
				<c:if test="${cartList != null && cartList.size() >0}">
					<div class="tbl_order borderT" id="crtDataArea" >
						<form method="post">
							<table summary="장바구니 내역">
								<caption>장바구니 내역 표</caption>
								<colgroup>
									<col width="120px">
									<col width="*">
									<col width="150px">
									<col width="110px">
									<col width="45px">
								</colgroup>
								<thead>
									<tr>
										<th class="th_thumb">
											<span class="inp_check">
								            <!--<input name="allCheck" id="allCheck" type="checkbox" onclick="checkAll(this.form)" style="opacity: 1"/>
								                <span class="blind">전체선택</span> -->
								            </span>
								            <span class="blind">상품이미지</span>
								        </th>
										<th class="th_prd">
								            상품<span class="blind">정보</span>
								        </th>
										<th class="th_qty">수량</th>
										<th class="th_price">가격</th>
										<th class="th_btn">
											<!--<span class="blind">삭제</span> -->
										</th>
									</tr>
								</thead>
								<c:forEach var="cart" items="${cartList }"  varStatus="status">
								<tbody id="crtListArea">
									<tr class="crtP1015">
										<td class="td_thumb">
											<span class="inp_check" >
											<!--<input type="checkbox"  id="remove" name="remove" value="remove" style="opacity: 1" />
												<span class="blind">선택</span> -->
											</span>
											<div class="opt_thumb">
												<img src="img/${cart.image}" alt="-"  style="width:120px;"/>
											</div>
										</td>
										<td class="td_prd">
											<div class="opt_detail">
												<p class="opt_prdname">${cart.name }</p>
											</div>
										</td>
										<td class="td_qty">
											<div class="inp_qty1">
												<a href="prdCartQtyUp.vo?name=${cart.name }">
													<img alt="수량추가" src="img/up1.png" />
												</a>
												<br>${cart.qty }<br>
												<a href="javascript:checkQty('${cart.name }', ${cart.qty })">
													<img alt="수량감소" src="img/down1.png" />
												</a>
											</div>
										</td>
										<td class="td_price">
												<div class="opt_price">
													<span class="cost">${cart.price }</span>
												</div>
										</td>
										<td class="td_btn">
									<!--	<div class="btn_wrap">
												<a href="prdCartRemove.vo" class="btnTypeIcon btn_delete delCrtBtn">
												<img src="img/clear.png" alt="" /><span class="blind">삭제</span></a>
											</div> -->
										</td>
									</tr>
								</tbody>
								</c:forEach>
							</table>
						</form>
					</div>
				</c:if>
			<!--<div class="btn_wrap" id="crtDelBtns" >
					<a class="btn btnType4 btnSizeS" id="selCrtDel" href="prdCartRemove.vo">
						<span>선택상품 삭제</span>
					</a>
				</div> -->
				<!-- 담긴상품 있음 : E -->
				<div class="btn_wrap btn_shopping al_c">
					<a class="btn btnType4 btnSizeM" href="prdList.vo">
						<span>쇼핑 계속하기</span>
					</a>
				</div>

			<!--<div class="shopping_noti">
				    <dl>
				        <dt>꼭 확인해주세요!</dt>
				        <dd>- 장바구니에 담긴 상품은 최대 30일 동안 보관되며 이후에는 삭제됩니다.</dd>
				        <dd>- SNS 간편 로그인, 네이버페이, 비회원 구매 시 닥터자르트 회원혜택이 적용되지 않습니다.</dd>
				        <dd>- 장바구니에 담긴 상품 중 품절, 단종으로 판매 상태 변경 시 장바구니에서 비활성화 처리되며, 구매가 불가합니다.</dd>
				    </dl>
				</div>	-->

				<div class="aside_area" id="sideInfoArea">
					<div class="order_total">
						<div class="sec">
							<dl class="pdtPrice">
								<dt>총 상품 금액</dt>
								<dd><em class="cost type2" id="totlPrdSellPrc">${totalMoney }</em></dd>
							</dl>
							<dl class="discountPrice">
								<dt>총 할인 금액</dt>
								<dd><span class="cost txt_red" id="totlSalePrc">0</span></dd>
							</dl>
						</div>
						<div class="sec">
							<dl class="payPrice">
								<dt>예상 결제 금액</dt>
								<dd><strong class="cost type2" id="finalSttlPrc">${totalMoney }</strong></dd>
							</dl>
						</div>
						<div class="sec sec_btn">
							<div class="btn_wrap">
								<a class="btn btnType2 btnSizeL disabled" id="ordrBtn" href="#">
									<span>선택상품 주문하기</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<div class="layerPop layerConfirm" id="layer_alert">
		<div class="layerBody">
			<p class="txt"></p>
			<div class="btn_wrap">
				<button class="btn btnType2 btnSizeM ok" onclick="hideLayer('layer_alert');return false;"><span>확인</span></button>
			</div>
			</div>  
		</div>
		<div class="layerPop layerConfirm" id="layer_confirm">
			<div class="layerBody">
				<p class="txt"></p>
				<div class="btn_wrap">
					<button class="btn btnType2 btnSizeM ok" onclick="hideLayer('layer_confirm');return false;"><span>확인</span></button>
					<button class="btn btnType4 btnSizeM cancel" onclick="hideLayer('layer_confirm');return false;"><span>취소</span></button>
				</div>
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