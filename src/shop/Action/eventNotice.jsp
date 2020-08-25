<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>이벤트 당첨자 발표</title>

<!-- Style -->
<link rel="stylesheet" href="css/content3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css" />
<link rel="stylesheet" href="css/common.css">

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
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
	
	<!-- 왼쪽 메뉴창 -->
	<header id="header">
					<div class="header">
		<div class="fixmenu">
			<a class="plus" href="javascript:void(0);">
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
					<li class="login">
						<a href="#">
							<img src="img/user.svg" alt="login" />
							<em>로그인</em>
						</a>
					</li>
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
						<li>
							<a href="#">제품</a>
						</li>
						<li>
							<a href="main.do">이벤트</a>
						</li>
						<li>
							<a href="#">스토리</a>
						</li>
						<li>
							<a href="#">필터 스페이스</a>
						</li>
						<li>
							<a href="#">브랜드</a>
						</li>
						<li>
							<a href="#">JARTV</a>
						</li>
					</ul>
					<ul class="gnb_util">
						<li>
							<a href="#">멤버십</a>
						</li>
						<li>
							<a href="#">고객만족센터</a>
						</li>
						<li>
							<a href="#">매장안내</a>
						</li>
						<li class="merge_mbr">
							<a class="btn btnType3 btnSizeS"  href="javascript:void(0);">
								<span>통합회원 전환</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<ul class="language">
				<li class="on">
					<a href="javascipt:;">
						<span>KR</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>EN</span>
					</a>
				</li>
				<li>
					<a href="#">
						<span>CN</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
	</header>
	<script type="text/javascript">
		$(document).ready(function() {
			$.jart.common.cart.getCartList().done(function(data) {
				if (data && data.length > 0) {
					$('#hCartCnt').html(data.length);
					$('#hCartCnt').closest('.cart').addClass('active');
				}
			});
			$(".fixmenu .plus").click(function() {
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
					<li id="on"><a href="eventNotice.jsp">당첨자 발표</a></li>		
					<li><a href="list.do">이벤트 리뷰</a></li>		
				</ul>
				</div>	
			</div>
				<div class="contents">
				 <h2 class="conTitle">이벤트</h2>
				 	<div class="conSub">
				 	<ul>
				 		<li><a href="main.do">진행 중인 이벤트</a></li>
				 		<li class="on1"><a href="#">당첨자 발표</a></li>
				 		<li><a href="#">종료된 이벤트</a></li>
				 	</ul>
				 	</div>
				
				
				<!-- 이벤트 리뷰 게시판 상단 네비 -->
		<div class="board">
			<div class="listTotal">
				<p class="totalCnt">전체(10)</p>
				<div class="sortArea">
						
			<div class="searchText">
				<input type="text" id="searchText" placeholder="검색어를 입력하세요" autocomplete="off">
					<a href="#" id="serchBtn">검색</a>
							
				</div>
			</div>
		</div>
					
					<!-- 게시판 목록 -->
						<div class="boardList">
							<table>
							<colgroup>
								<col style="width:*">
								<col style="width:13.8%">
							</colgroup>
							<thead>
								<tr>
								 <th>제목</th>
								 <th>작성일</th>
							 	</tr>	
							</thead>
						<tbody id="listBox">
							<tr>
							 <td class="a1_1"><a href="#">
							 <span class="evt_cate">[당첨자 발표]</span>
							 솔라바이옴 런칭이벤트 당첨자를 발표합니다.</a></td>
							 <td>2020-06-01 14:47</td>
							</tr>
						</tbody>
							</table>
						</div>
					
				
				
				<!-- 페이징 아이콘 -->
					<div class="paging">
					  <span class="first">
					  	<a href="#">
					  	 <img src="img/chevrons-left.svg" />
					  	</a>
					  </span>
					  
					  <span class="prev">
					  	<a href="#">
					  	 <img src="img/chevron-left.svg" />
					  	</a>
					  </span>
					  
					  <span class="current">
					  	1
					  </span>
					  	<a href="#">2</a>
					  
					  <span class="next">
					  	<a href="#">
					  	 <img src="img/chevron-right.svg" />
					  	</a>
					  </span>
					  
					  <span class="last">
					  	<a href="#">
					  	 <img src="img/chevrons-right.svg" />
					  	</a>
					  </span>
					
					</div>
				
				<!-- 이벤트 후기 -->
				
				
				</div>
			</div>	
		</div>
			
			<footer id="footer">
			 <div class="footerT">
				<div class="foot_menu">
					<ul>
					 <li class="m1">
						<a href="#" target="blank">
						회사소개</a>	
					 </li>		
					 
					 <li class="m2">
						<a href="#" target="blank">
						이용약관</a>	
					</li>		
					
					 <li class="m3">
						<a href="#" target="blank">
						개인정보 처리방침</a>	
					</li>		
					 
					 <li class="m3">
						<a href="#" target="blank">
						이메일 주소 무단수집 거부</a>	
					</li>		
					
					 <li class="m4">
						<a href="#" target="blank">
						고객만족센터</a>	
					</li>		
				</ul>
			<div class="sitemap">
				<button class="tit">
					<span>Site map</span>
				</button>
			</div>
			
			<div class="familysite">
				<button class="tit">
					<span>Family Site</span>
				</button>
			</div>
			
			<div class="korean">
				<button class="tit">
					<span>Korean</span>
				</button>
			</div>
			
			
		</div>
						
			</div>
			
			
	<div class="footerM">
		<div class="footInfo">
			<div class="address">
				<p>
				 <span>서울특별시 강남구 역삼동 769-8 엠스페이스빌딩, 
				 	도로명 주소 ( 서울특별시 강남구 논현로72길 13 M-SPACE 빌딩 해브앤비 )
				 </span>
				 <span>
				  대표이사 : 크리스토퍼 킨더슬리 우드
				 </span>
				 </p>
				
				<p>
				 <span>상호명 : 해브앤비(주)</span>
				 <span>사업자 등록번호 : 214-87-63681</span>
				 <span>통신판매업 신고번호 : 2008 서울 강남-2284호
				 <a href="#" target="_blank" class="btn btnType3 btnSizeXS busnessinfo">
				 	<span class="arr-right">
				 	사업자 정보 확인
				 	</span>
				 </a>
				 </span>	
				</p>
				 
				 
				 <p>
				 	<span>개인정보관리책임자 : 엄정식 팀장</span>
				 	<span>고객만족센터 : 1544-5453 ( 운영시간 : 09:00~18:00, 점심시간 : 11:50~12:50 )</span>
				 	<span>FAX : 02-3462-9051</span>
				 </p>
				 
				 <p>
				 <span>전자우편주소 : 
				 <a href="mailto:webmaster@drjart.com" class="mail">webmaster@drjart.com</a></span> 
				 </p>
				</div>
				
				<small class="copyright">Copyrightⓒ Have&amp;Be co., Ltd. All rights reserved.</small>
			</div>
			
			<!-- sns -->
			<div class="foot_sns">
				<a href="https://www.instagram.com/drjart_kr/" class="sns1" target="_blank">
				<img src="img/instagram.svg" alt="" /></a>
				
				<a href="https://ko-kr.facebook.com/DrJartPage/" class="sns2" target="_blank">
				<img src="img/facebook.svg" alt="" /></a>
			
				
				<a href="https://twitter.com/drjartkr/" class="sns3" target="_blank">
				<img src="img/twitter.svg" alt="" /></a>
				
			</div>
			
		</div>
		
		<div class="footerB">
			<div class="footMaker">
			 <ul>
			 	<li><img src="#" alt="" />
			 	<span>
			 	iso9001,14001<br/>
			 	환경경영인증 획득</span>
			 	</li>
			 	
			 	<li><img src="#" alt="" />
			 	<span>
			 	기업 부설<br/>
			 	디자인 연구소 인정
			 	</span>
			 	</li>
			 	
			 	<li><a href="#"><img src="#" alt="" />
			 	<span>
			 	에스크로 서비스<br/>
			 	환경경영인증 획득
			 	</span>
			 	</a>
			 	</li>
			 	
			 </ul>
			</div>
		</div>
					</footer>
	
	
	
	
	
	
		
		
		
		
		<!-- 진행 중인 이벤트 사진 -->
		
		
		
		<!-- 이벤트 당첨자 후기 리스트 -->
		
		
	
	
	
</body>
</html>