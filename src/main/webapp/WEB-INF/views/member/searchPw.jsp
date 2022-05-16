<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>


<!-- acoustic_guitar start-->
   
    <div style="width:auto; height:500px; background-image: url('/resources/img/acoustic_guitar.png'); background-repeat: no-repeat; background-position: center; background-size: cover; ">
      <div class="image-box" style="text-align: center; line-height: 230px;">
		<div>&nbsp;</div>
			<h1>Search Pw</h1>
                 <h5>Youth Music <span> - </span> search pw</h5>                 
	  </div> 
    </div>
   
    <!-- acoustic_guitar start-->
<!-- 
<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <h1 class="display-4">Pricing</h1>
  <p class="lead">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>
</div>
 -->
<div class="container"> 
 
   <div class="row">
    <div>&nbsp;</div>
    <div class="container">
      <form>
        <div class="form-group row">
          <label for="mem_email" class="col-sm-2 col-form-label"> 전자우편 주소입력</label>
          <div class="col-sm-12">
            <input type="text" class="form-control" id="mem_email" name="mem_email" placeholder="abc@youthmusic.com">
          </div>
        </div>
                
        <div class="form-group row">
          <div class="col-sm-12">
            <button type="button" id="btnMailSend" class="btn btn-primary">메일전송하기</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


  <script>
	$(document).ready(function(){
		
		$("#btnMailSend").on("click", function() {
			
			let mem_email = $("#mem_email");
			
			if(mem_email.val() == "" || mem_email.val() == null){
				alert("가입하신 메일 주소를 입력하세요.");
				mem_email.focus();
				return;
			}
			
			$.ajax({
				url: '/member/searchPw',
				type: 'post',
				dataType: 'text',
				data: { mem_email : mem_email.val() },
				success: function(data) {
					
					if(data == "success"){
						alert("임시 비밀번호가 가입하신 메일주소로 발송되었습니다.");
					}else if(data == "fail"){
						alert("메일발송시 문제가 발생했습니다. 다시 진행해주세요.");
					}else if(data == "noMail"){
						alert("메일 주소를 확인해주세요.");
					}
					
				}
			});
		});
		
	});
  </script>
    
  </body>
</html>
