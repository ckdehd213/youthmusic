<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <link rel="stylesheet" href="/resources/css/bootstrap.min.css"> 지우기-->


	<script>
  	
  	let msg = '${msg}'; 
  	if(msg == 'editFail'){
  		alert("비밀번호를 확인바랍니다.");
  	}
  
  </script>

</head>
<body>

  <!--:: header part ::-->
 <%@include file="/WEB-INF/views/include/header.jsp" %>
   
   
  <!-- acoustic_guitar start-->
   
    <div style="width:auto; height:500px; background-image: url('/resources/img/acoustic_guitar.png'); background-repeat: no-repeat; background-position: center; background-size: cover; ">
      <div class="image-box" style="text-align: center; line-height: 230px;">
		<div>&nbsp;</div>
			<h1>My Page</h1>
                 <h5>Youth Music <span> - </span> my page</h5>                 
	  </div> 
    </div>
   
    <!-- acoustic_guitar start-->
<!-- <img src="/resources/img/acoustic_guitar.png" alt=""> -->

<div class="container">
<div>&nbsp;</div>
  <div class="form-row" >
 	 <div class="col-md-10">
   		 <label for="mem_id">아이디</label>
   		 <input type="text" class="form-control" id="mem_id" name="mem_id" value='<c:out value="${memberVO.mem_id }" />' readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="mem_name">이름</label>
    <input type="text" class="form-control" id="mem_name" name="mem_name" value='<c:out value="${memberVO.mem_name }" />' readonly>
  </div>
  
  <div class="form-row">
 	 <div class="col-md-12">
   		 <label for="mem_email">전자우편</label>
   		 <input type="email" class="form-control" id="mem_email" name="mem_email" value='<c:out value="${memberVO.mem_email }" />' readonly>
    </div>
  </div>
  
   <div class="form-row">
    <div class="col-md-5">
      <label for="mem_addr">기본주소</label>
      <input type="text" class="form-control" id="mem_addr" name="mem_addr" value='<c:out value="${memberVO.mem_addr }" />' readonly>
    </div>
    <div class="col-md-5">
      <label for="mem_addr2">나머지주소</label>
      <input type="text" class="form-control" id="mem_addr2" name="mem_addr2" value='<c:out value="${memberVO.mem_addr2 }" />' readonly>
      <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
    </div>
    <div class="col-md-2">
      <label for="mem_post">우편번호</label>
      <input type="text" class="form-control" id="mem_post" name="mem_post" value='<c:out value="${memberVO.mem_post }" />' readonly>
    </div>
   </div>
   
  <div class="form-group">
    <label for="mem_phone">전화번호</label>
    <input type="text" class="form-control" id="mem_phone" name="mem_phone" value='<c:out value="${memberVO.mem_phone }" />' readonly>
  </div>
  
  <div class="form-row">
    <div class="col-md-6">
      <label for="mem_echk">메일수신여부</label>
      <input type="text" class="form-control" id="mem_echk" name="mem_echk" value='<c:out value="${memberVO.mem_echk == 'Y' ? '가능': '불가능' }" />' readonly>
    </div>
    <div class="col-md-6">
      <label for="mem_point">포인트</label>
      <input type="text" class="form-control" id="mem_point" name="mem_point" value='<c:out value="${memberVO.mem_point }" />' readonly>
    </div>
   </div>
   
   
   <hr>
   
   <div class="form-row">
    <div class="col-md-5">
	    <label for="current_mem_pw">현재 비밀번호</label>
	    <input type="password" class="form-control" id="current_mem_pw" name="current_mem_pw">
	</div>
	<div class="col-md-5">
	    <label for="changed_mem_pw">변경 비밀번호</label>
	    <input type="password" class="form-control" id="changed_mem_pw" name="changed_mem_pw">
  	</div>
  	<div class="col-md-2">
  		<label for="btnChangePw">&nbsp;</label>
   		<button type="button" class="form-control" id="btnChangePw">비밀번호 변경</button>
    </div>
  </div>
  
  <div class="form-row">
    <div class="col-md-5">
	    <label for="mem_pw">현재 비밀번호</label>
	    <input type="password" class="form-control" id="mem_pw" name="mem_pw">
	</div>
	<div class="col-md-2">
  		<label for="btnMemDelete">&nbsp;</label>
   		<button type="button" class="form-control" id="btnMemDelete">회원 탈퇴</button>
    </div>
  </div>
  
   

 
 
 <%@include file="/WEB-INF/views/include/footer.jsp" %>
 </div>
 
 <script>

  $(document).ready(function(){
    
	  // 비밀번호 변경
  	$("#btnChangePw").on("click", function(){
  		
  		
  	  let current_mem_pw = $("#current_mem_pw");
  	  let changed_mem_pw = $("#changed_mem_pw");
  	 
  	  
  	  
  	  if(current_mem_pw.val() == "" || current_mem_pw.val() == null){
  		  alert("현재비밀번호를 입력하세요");
  		current_mem_pw.focus();
  		  return;
  	  }
  	  
      if(changed_mem_pw.val() == "" || changed_mem_pw.val() == null){
		  alert("변경할 비밀번호를 입력하세요");
		  changed_mem_pw.focus();
		  return;
	  }
  	  
  	  $.ajax({
  		 url: '/member/changePw',
  		 type: 'post',
  		 dataType: 'text',
  		 data: { current_mem_pw : current_mem_pw.val(), changed_mem_pw : changed_mem_pw.val() },
  		 success: function(data){
  			 
  			 if(data == "success"){
  				 alert("비밀번호가 변경되었습니다.")
  			 }else if(data == "noPw"){
  				 alert("현재 비밀번호가 다릅니다. 확인해주세요.");
  				current_mem_pw.val("");
  				current_mem_pw.focus();
  			 }
  		   }
  	  });
	});
  	
  	
  	//회원탈퇴
  	$("#btnMemDelete").on("click", function(){
  		
  		
    	  let mem_pw = $("#mem_pw");
    	  
    	  if(mem_pw.val() == "" || mem_pw.val() == null){
    		  alert("현재비밀번호를 입력하세요");
    		  mem_pw.focus();
    		  return;
    	  }
    	  
    	  
    	  $.ajax({
    		 url: '/member/memDelete',
    		 type: 'post',
    		 dataType: 'text',
    		 data: { mem_pw : mem_pw.val() },
    		 success: function(data){
    			 
    			 if(data == "1"){
    				 alert("회원탈퇴가 되었습니다.");
    				 location.href = "/";
    			 }else if(data == "0"){
    				 alert("현재 비밀번호가 다릅니다. 확인해주세요.");
    				 mem_pw.val("");
    				 mem_pw.focus();
    			 }
    		   }
    	  });
  	});
	
  	
  	
  });

</script>

</body>
</html>