<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){
		/*
		$("#btnSearch").on("click", function(){
			$.ajax({
				url: '/api/searchCity',
				type:'get',
				dataType: 'text',
				data:  {
					city : $("#city").val()
				},
				success: function(data){
					console.log(data);
				}
			});
		});
		*/
		
	});

</script>
</head>
<body>
<h4>공공데이타 : 기상청 단기예보 조회서비스 Open API : 유창동</h4>
	<p>다음 보기에 나오는 도시명을 입력하여, 기상단기예보를 확인하세요.(서울,부산,대전,대구,광주,인천,세종)</p>
	<form action="/api/cityWeather" method="post">
		<input type="text" name="city" id="city">
		<input type="submit" id="btnSearch" value="검색">
	</form>

</body>
</html>