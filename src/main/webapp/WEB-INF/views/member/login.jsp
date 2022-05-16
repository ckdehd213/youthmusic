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
			<h1>Login</h1>
                 <h5>Youth Music <span> - </span> login</h5>                 
	  </div> 
    </div>
   
    <!-- acoustic_guitar start-->

<!-- 
<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  <h1 class="display-4">Pricing</h1>
  <p class="lead">Quickly build an effective pricing table for your potential customers with this Bootstrap example. It’s built with default Bootstrap components and utilities with little customization.</p>
</div>
 -->
<br>
<div class="container">
  <div class="row">
    <div class="container">
      <form>
        <div class="form-group row">
          <label for="mem_id" class="col-sm-2 col-form-label">ID</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="ID">
          </div>
        </div>
        <div class="form-group row">
          <label for="mem_pw" class="col-sm-2 col-form-label">Password</label>
          <div class="col-sm-10">
            <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="Password">
          </div>
        </div>
		
	    <div class="form-group row">
          <label class="col-sm-2"></label>
          <div class="col-sm-10">
          <button type="button" class="btn btn-link" id="btnSerachPw">Search Pw</button>
          </div>
        </div>
        
        <div class="form-group row">
          <div class="offset-sm-2 col-sm-10">
            <button type="button" class="btn btn-primary" id="btnLogin">Sign in</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


  <script>
	$(document).ready(function(){
		
		//로그인
		$("#btnLogin").on("click", function(){
			
			let mem_id = $("#mem_id");
			let mem_pw = $("#mem_pw");
			
			if(mem_id.val() == "" || mem_id.val() == null){
				alert("아이디를 입력하세요.");
				mem_id.focus();
				return;
			}
			if(mem_pw.val() == "" || mem_pw.val() == null){
				alert("비밀번호를 입력하세요.");
				mem_pw.focus();
				return;
			}
			
			$.ajax({
				url: '/member/login',
				type: 'post',
				dataType: 'text',
				data: { mem_id : mem_id.val(), mem_pw : mem_pw.val() },
				success: function(data){
					
					if(data == "success"){
						alert("로그인 성공.");
						location.href = "/";
					}else if(data == "idFail"){
						alert("아이디를 확인해주세요.");
						mem_id.focus();
					}else if(data == "pwFail"){
						alert("비밀번호를 확인해주세요.");
						mem_pw.focus();
					}
				}
			});
		});
		
		// 비밀번호 찾기
		$("#btnSerachPw").on("click", function(){
			location.href = "/member/searchPw";
		});
	});
  </script>
    
  </body>
</html>
