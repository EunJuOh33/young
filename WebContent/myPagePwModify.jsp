<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>마이페이지 정보관리</title>
	
	<!-- style CSS -->
	<link rel="stylesheet" href="css/userCss/footer.css" />
	<link rel="stylesheet" href="css/userCss/mypagepwmodify.css" />
</head>
<body>
	<div id="wrap">
		<nav style="background-color:#F9F9F9;">메뉴바</nav>
		
		
		<div id="container">
			<header>
				<div class="menu">
					<h2><a href="myPage1.bo">마이페이지</a></h2>
					<p>정보관리</p>
				</div>
			</header>
		
			<article>
				<h2>정보관리</h2>
				<div class="tabSmallMenu">
					<ul>
						<li><a href="myPage1.bo">회원정보 수정</a></li>
						<li class="on"><a href="myPage3.bo">비밀번호 수정</a></li>
					</ul>
				</div>

				<div class="contents">
					<!-- 비밀번호 입력 -->
					<div class="modifyPwForm">
						<div class="modifyTop">
							<div class="title">현재 비밀번호</div>
							<div class="box">
								<input type="password" name="nowPw" id="nowPw" maxlength="20" autocomplete="off" required />
								<p class="hideTx">비밀번호를 입력해주세요.</p>
							</div>
						</div>
						<div class="modifyBtn">
							<form name="newPwForm" action="newPwAction.do" method="post">
								<div class="title">새 비밀번호</div>
								<div class="box">
									<input type="password" name="newPw" id="nowPw" maxlength="20" autocomplete="off" required />
								</div>
								<div class="title">새 비밀번호 확인</div>
								<div class="box">
								<input type="password" id="newPw2" maxlength="20" autocomplete="off" required />
								</div>
							</form>
						</div>
					</div>
					<!-- 아래 -->
					<div class="sub">
						<div>
							<p>&#183;&nbsp;&nbsp;개인정보 보호를 위해 비밀번호는 주기적 (최소 3개월) 으로 변경해 주세요. 타인에게 비밀번호가 노출되지 않도록 주의해 주세요.</p>
						</div>
					</div>
					<div class="btn">
						<div>
							<div class="confirmBtn" onclick="">확인</div>
							<div class="cancelBtn" onclick="">취소</div>
						</div>
					</div>
				</div>
			</article>
		</div>	<!-- container 끝 -->
		
		
		<!-- 푸터 -->
		<footer id="footer">
			<div class="footerT">
				<div class="foot_menu">
					<ul>
						 <li class="m1">
							<a href="#" target="blank">회사소개</a>	
						 </li>		
						 <li class="m2">
							<a href="#" target="blank">이용약관</a>	
						</li>		
						 <li class="m3">
							<a href="#" target="blank">개인정보 처리방침</a>	
						</li>		
						 <li class="m3">
							<a href="#" target="blank">이메일 주소 무단수집 거부</a>	
						</li>			
						 <li class="m4">
							<a href="#" target="blank">고객만족센터</a>	
						</li>		
					</ul>
					<div class="sitemap">
						<button class="tit"><span>Site map</span></button>
					</div>
					<div class="familysite">
						<button class="tit"><span>Family Site</span></button>
					</div>
					<div class="korean">
						<button class="tit"><span>Korean</span></button>
					</div>
				</div>				
			</div>
		
			<div class="footerM">
				<div class="footInfo">
					<div class="address">
						<p>
					 		<span>서울특별시 강남구 역삼동 769-8 엠스페이스빌딩, 도로명 주소 ( 서울특별시 강남구 논현로72길 13 M-SPACE 빌딩 해브앤비 )</span>
					 		<span>대표이사 : 크리스토퍼 킨더슬리 우드</span>
					 	</p>
						<p>
							 <span>상호명 : 해브앤비(주)</span>
							 <span>사업자 등록번호 : 214-87-63681</span>
							 <span>통신판매업 신고번호 : 2008 서울 강남-2284호</span>	
						</p>
						<p>
						 	<span>개인정보관리책임자 : 엄정식 팀장</span>
						 	<span>고객만족센터 : 1544-5453 ( 운영시간 : 09:00~18:00, 점심시간 : 11:50~12:50 )</span>
							<span>FAX : 02-3462-9051</span>
						</p>
					 	<p><span>전자우편주소 : <a href="mailto:webmaster@drjart.com" class="mail">webmaster@drjart.com</a></span> </p>
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
					 	<li>
					 		<img src="#" alt="" /><span>iso9001,14001<br/>환경경영인증 획득</span>
					 	</li>
					 	<li>
					 		<img src="#" alt="" /><span>기업 부설<br/>디자인 연구소 인정</span>
					 	</li>
					 	<li>
					 		<img src="#" alt="" /><span>에스크로 서비스<br/>환경경영인증 획득</span>
					 	</li>
			 		</ul>
				</div>
			</div>
		</footer>
	</div>	<!-- wrap 끝 -->
	
	
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
</body>
</html>