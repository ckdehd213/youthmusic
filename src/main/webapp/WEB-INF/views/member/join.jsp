<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet" href="/resources/css/bootstrap.min.css"> 지우기-->

</head>
<body>

  <!--:: header part ::-->
 <%@include file="/WEB-INF/views/include/header.jsp" %>
   
  
   <!-- acoustic_guitar start-->
   
    <div style="width:auto; height:500px; background-image: url('/resources/img/acoustic_guitar.png'); background-repeat: no-repeat; background-position: center; background-size: cover; ">
      <div class="image-box" style="text-align: center; line-height: 230px;">
		<div>&nbsp;</div>
			<h1>Join</h1>
                 <h5>Youth Music <span> - </span> join</h5>                 
	  </div> 
    </div>
   
    <!-- acoustic_guitar start-->
<!-- <img src="/resources/img/acoustic_guitar.png" alt=""> -->

<div class="container">
	
<form action="/member/join" method="post" id="joinForm">
  <div class="form-row" >
 	 <div class="col-md-10">
   		 <label for="mem_id">아이디</label>
   		 <input type="text" class="form-control" id="mem_id" name="mem_id" >
    </div>
    <div class="col-md-2">
    	<label id="idUseState">&nbsp;</label>
   		<button type="button" class=" form-control" id="btnUseIDChk" >중복체크</button>
    </div>
  </div>
  <div class="form-group">
    <label for="mem_pw">비밀번호</label>
    <input type="password" class="form-control" id="mem_pw" name="mem_pw">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">비밀번호 확인</label>
    <input type="password" class="form-control" id="exampleInputEmail1">
  </div>
  <div class="form-group">
    <label for="mem_name">이름</label>
    <input type="text" class="form-control" id="mem_name" name="mem_name">
  </div>
  
  <div class="form-row">
 	 <div class="col-md-6">
   		 <label for="mem_email">전자우편</label>
   		 <input type="email" class="form-control" id="mem_email" name="mem_email" >
    </div>
    <div class="col-md-2">
    	<label for="btnMailAuthReq">메일확인바랍니다.</label>
   		<button type="button"  class=" form-control" id="btnMailAuthReq" >메일인증요청</button>
    </div>
    <div class="col-md-2">
   		 <label for="auth_mail">메일인증코드입력</label>
   		 <input type="text" class="form-control" id="auth_mail" name="auth_mail" >
    </div>
    <div class="col-md-2">
    	<label id="authMailState">&nbsp;</label>
   		<button type="button"  class=" form-control" id="btnMailAuthConfirm" >메일인증확인</button>
    </div>
  </div>
  
   <div class="form-row">
    <div class="col-md-4">
      <label for="mem_addr">기본주소</label>
      <input type="text" class="form-control" id="mem_addr" name="mem_addr">
    </div>
    <div class="col-md-4">
      <label for="mem_addr2">나머지주소</label>
      <input type="text" class="form-control" id="mem_addr2" name="mem_addr2">
      <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
    </div>
    <div class="col-md-2">
      <label for="mem_post">우편번호</label>
      <input type="text" class="form-control" id="mem_post" name="mem_post">
    </div>
    <div class="col-md-2">
      <label for="btnPostCode">&nbsp;</label>
      <input type="button" class="form-control" id="btnPostCode" name="btnPostCode"  value="우편번호찾기" onclick="sample2_execDaumPostcode()">
    </div>
   </div>
   
  <div class="form-group">
    <label for="mem_phone">전화번호</label>
    <input type="text" class="form-control" id="mem_phone" name="mem_phone">
  </div>
  <div class="form-group form-check">
    <input type="checkbox" class="form-check-input" id="mem_echk" name="mem_echk">
    <label class="form-check-label" for="mem_echk">메일수신여부</label>
  </div>
  
  <button type="submit" class="btn btn-primary">회원가입</button>
</form>
 
 
 <%@include file="/WEB-INF/views/include/footer.jsp" %>
 </div>
 <script>

  $(document).ready(function(){
    
	  let isCheckID = false;
	  let isMailAuthConfirm = false;
	  
  // 회원가입 전송
  	$("#joinForm").on("submit", function(){
  		
  	  if(isCheckID == false){
  		  alert("아이디 중복체크 확인바람 ")
  		  $("mem_id").focus();
  		  return false;
  	  }
		
   	  if(isMailAuthConfirm == false){
		  alert("메일인증요청 확인바람 ")
		  $("btnMailAuthReq").focus();
		  return false;
	  }
   	  
	});
	  
	  
  // 아이디중복체크
    $("#btnUseIDChk").on("click", function(){
      isCheckID = false;
      let mem_id = $("#mem_id");
	
      if(mem_id.val() == "" || mem_id.val() == null){
        alert("아이디를 입력하세요");
        mem_id.focus();
        return;
      }

      $.ajax({
        url: '/member/checkID',
        type: 'get',
        dataType: 'text',
        data: { mem_id: mem_id.val() },
        success: function(data){
        	
        	 console.log("테스트: " + data);
        	 
          $("#idUseState").css("color","red");
         if(data == "Y"){
        	 isCheckID = true;
            $("#idUseState").html("아이디 사용가능");
         }else if(data == "N"){
            mem_id.val("");
            $("#idUseState").html("아이디 사용불가능");
          }
        }
      });
    });
    
  // 메일인증요청
    $("#btnMailAuthReq").on("click", function(){
      isMailAuthConfirm = false;
      let mem_email = $("#mem_email");

      if(mem_email.val() == "" || mem_email.val() == null){
        alert("메일주소를 입력하세요");
        mem_email.focus();
        return;
      }

      $.ajax({
        url: '/member/sendMailAuth',
        type: 'get',
        dataType: 'text',
        data: { mem_email: mem_email.val() },
        success: function(data){

          
          if(data == "success"){
        	isMailAuthConfirm = true;
            alert("인증요청메일 발송됨.");
          }else if(data == "fail"){
        	alert("인증요청메일 발송 에러.");
          }
        }
      });
    });
  
  
  // 메일인증확인
    $("#btnMailAuthConfirm").on("click", function(){

      let auth_mail = $("#auth_mail");

      if(auth_mail.val() == "" || auth_mail.val() == null){
        alert("인증코드를 입력하세요");
        auth_mail.focus();
        return;
      }

      $.ajax({
        url: '/member/mailAuthConfirm',
        type: 'get',
        dataType: 'text',
        data: { uAuthCode: auth_mail.val() },
        success: function(data){

          
          if(data == "success"){
            alert("인증요청 성공.");
          }else if(data == "fail"){
        	alert("인증요청 에러\n 인증코드를 다시 확인하여주세요.");
        	auth_mail.val("");
          }
        }
      });
    });
  });

</script>

<!--우폅번호 DAUM API-->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
  <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
  
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
      // 우편번호 찾기 화면을 넣을 element
      var element_layer = document.getElementById('layer');
  
      function closeDaumPostcode() {
          // iframe을 넣은 element를 안보이게 한다.
          element_layer.style.display = 'none';
      }
  
      function sample2_execDaumPostcode() {
          new daum.Postcode({
              oncomplete: function(data) {
                  // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
  
                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var addr = ''; // 주소 변수
                  var extraAddr = ''; // 참고항목 변수
  
                  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                      addr = data.roadAddress;
                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
                      addr = data.jibunAddress;
                  }
  
                  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                  if(data.userSelectedType === 'R'){
                      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                          extraAddr += data.bname;
                      }
                      // 건물명이 있고, 공동주택일 경우 추가한다.
                      if(data.buildingName !== '' && data.apartment === 'Y'){
                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                      }
                      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                      if(extraAddr !== ''){
                          extraAddr = ' (' + extraAddr + ')';
                      }
                      // 조합된 참고항목을 해당 필드에 넣는다.
                      document.getElementById("sample2_extraAddress").value = extraAddr;
                  
                  } else {
                      document.getElementById("sample2_extraAddress").value = '';
                  }
  
                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('mem_post').value = data.zonecode;
                  document.getElementById("mem_addr").value = addr;
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("mem_addr2").focus();
  
                  // iframe을 넣은 element를 안보이게 한다.
                  // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                  element_layer.style.display = 'none';
              },
              width : '100%',
              height : '100%',
              maxSuggestItems : 5
          }).embed(element_layer);
  
          // iframe을 넣은 element를 보이게 한다.
          element_layer.style.display = 'block';
  
          // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
          initLayerPosition();
      }
  
      // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
      // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
      // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
      function initLayerPosition(){
          var width = 300; //우편번호서비스가 들어갈 element의 width
          var height = 400; //우편번호서비스가 들어갈 element의 height
          var borderWidth = 5; //샘플에서 사용하는 border의 두께
  
          // 위에서 선언한 값들을 실제 element에 넣는다.
          element_layer.style.width = width + 'px';
          element_layer.style.height = height + 'px';
          element_layer.style.border = borderWidth + 'px solid';
          // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
          element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
          element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
      }
  </script>



</body>
</html>