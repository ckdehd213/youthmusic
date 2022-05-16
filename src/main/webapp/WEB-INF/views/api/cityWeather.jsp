<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>공공데이타 : 기상청 단기예보 조회서비스 Open API : 유창동</h3>
<h4>도시 날씨정보: ${city}</h4>
<c:forEach items="${weatherList }" var="vo">
	
	<c:if test="${vo.category == '하늘상태'}"> 
		<c:choose>
			<c:when test="${vo.fcstValue  == 1}">
				<b>맑음</b>
			</c:when>
			<c:when test="${vo.fcstValue  == 3}">
				<b>구름많음</b>
			</c:when>
			<c:when test="${vo.fcstValue == 4}">
				<b>흐림</b>
			</c:when>
		</c:choose>
	</c:if>
	<br>
	<c:if test="${vo.category == '강수형태'}"> 
		<c:choose>
			<c:when test="${vo.fcstValue  == 0}">
				<b>눈,비,소나기 없음</b>
			</c:when>
			<c:when test="${vo.fcstValue  == 1}">
				<b>비</b>
			</c:when>
			<c:when test="${vo.fcstValue == 2}">
				<b>비/눈</b>
			</c:when>
			<c:when test="${vo.fcstValue == 3}">
				<b>눈</b>
			</c:when>
			<c:when test="${vo.fcstValue == 4}">
				<b>소나기</b>
			</c:when>
		</c:choose>
	</c:if>
	<c:if test="${vo.category == '최저기온'}">
		${vo.fcstValue} ℃
	</c:if>
	<c:if test="${vo.category == '최고기온'}">
		${vo.fcstValue} ℃
	</c:if>
</c:forEach>
</body>
</html>