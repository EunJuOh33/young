<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.eee{
		font-size: 13px;
		text-indent: 4px; /* 들여쓰기 */
		color: #fa5855;
	}
</style>
</head>
<body>
<script src=https://code.jquery.com/jquery-3.5.1.min.js></script>
	<form id="fd" action="write.do">
	<div>
	<span>
	<input type="text" placeholder="제목을 작성해주세요">
	</span>
	<p class="eee" style="display:none">텍스트 필수입니다. </p>
	</div>
	
	<div>
	<span>
	<input type="text" placeholder="제목을 작성해주세요">
	</span>
	<p class="eee" style="display:none">파일 필수 </p>
	</div>
	
	<button type="submit" >전송</button>
	</form>

	<script>

		
	
		$("input").focus(function() {
			$(".eee").css("display", "none");
		});
		
		$("input").blur(function() {
			$(".eee").css("display", "block");
		
		});
		
	</script>
	
	
</body>
</html>