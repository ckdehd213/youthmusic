<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
<style>
	 #star_grade a {
      	font-size: 22px;
      	text-decoration: none;
      	color: lightgray;
      }
      
      #star_grade a.on {
      	color: red;
      }
      .pagination {
      	margin-left: 22%;
      }
      
</style>
</head>

    <!--::header part start::-->
 <%@include file="/WEB-INF/views/include/header.jsp" %>
    <!-- Header part end-->
     <!-- acoustic_guitar start-->
   
    <div style="width:auto; height:500px; background-image: url('/resources/img/acoustic_guitar.png'); background-repeat: no-repeat; background-position: center; background-size: cover; ">
      <div class="image-box" style="text-align: center; line-height: 230px;">
		<div>&nbsp;</div>
			<h1>Product</h1>
                 <h5>Youth Music <span> - </span>product</h5>                 
	  </div> 
    </div>
   <br><br>
    <!-- acoustic_guitar start-->
<body>
    <!-- product_Detail start-->
 
 
 	<div class="product_image_area section_padding">
    <div class="container">
      <div class="row s_product_inner justify-content-between">
        <div class="col-lg-7 col-xl-4">
          <div class="product_slider_img">
            <div id="vertical">
              <div >
                <img name="proudctImage" width="100%" height="225" src="/product/displayFile?fileName=<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
              </div>
              <!--
              <div data-thumb="img/product/single-product/product_1.png">
              <img src="img/product/single-product/product_1.png" />
              </div>
               -->
                 
            </div>
          </div>
        </div>
        <div class="col-lg-5 col-xl-6">
          <div class="s_product_text">
            <input type="hidden" name="pro_num" id="pro_num" value="${productVO.pro_num }">
            <h3>${productVO.pro_name }</h3>
            <h2>￦${productVO.pro_price }</h2>
            <ul class="list">
             <!-- 
              <li>
                <a class="active" href="#">
                  <span>Category</span> : ${cg_code }</a>
              </li>
                -->
              <li>
                <a href="#"> <span>Availibility</span> : &nbsp; ${productVO.pro_stock }</a>
              </li>
            </ul>
            <p>
             ${productVO.pro_content }
            </p>
            <div class="card_area d-flex justify-content-between align-items-center">
             
              <div class="product_count">
                <!-- <span class="inumber-decrement"> <i class="ti-minus"></i></span> -->
                <span>Amount &nbsp; : &nbsp;</span><input class="input-number" type="number" name="pro_stock" id="pro_stock"  value="1" min="0" max="10">
                <!-- <span class="number-increment"> <i class="ti-plus"></i></span> -->
              </div>
              <input type="hidden" name="pro_num" value="${productVO.pro_num }">
              <a href="#" class="btn_3 add_cart" id="add_cart">add to cart</a>
              <!--  <a href="#" class="like_us"> <i class="ti-heart"></i> </a>-->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  	
  <!--  priduct_review part -->
  <section class="product_description_area" id="product_review" class="row">
  </section>
 
 
 	<form id="actionForm" action="" method="get">
        <!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
        
        <!-- Criteria클래스가 기본생성자에 의하여 기본값으로 파라미터가 사용 -->
        
        <c:if test="${type == 'Y' }">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">
        </c:if>
        
        <input type="hidden" name="cg_code" value="${cg_code}">
			  <!-- 상품코드 동적추가작업 -->
   	 </form>
 
    <!--  product_Detail part end-->
    <!--::footer_part start::-->
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
    <!--::footer_part end::-->
    
    
    <script>
    // 상품후기
    let getProductReview = function() {
    	$("#product_review").load("/review/productReview?pro_num=" + ${productVO.pro_num });
	}
    getProductReview();
    
    $(function() {
    	
      let actionForm = $("#actionForm");
		
	  //장바구니 담기	
   	  $("a.add_cart").on("click", function(e){
   		e.preventDefault();
   		
   		let pro_num = $(this).parents("div.align-items-center").find("input[name='pro_num']").val();
   		
   
   		$.ajax({
   			url: '/cart/cartAdd',
   			type: 'post',
   			dataType: 'text',
   			data: {pro_num : ${productVO.pro_num }, cart_amount : $("#pro_stock").val() },
   			success: function(data) {
   				if(data == "success") {
   					if(confirm("장바구니에 추가되었습니다.\n 지금 확인하시겠습니까?")){
   						location.href = "/cart/cartList";
   					}
   				}
   			}
   			
   		});
   	  });
	  
	  // 상품별점클릭
	  $("#product_review").on("click", "#star_grade a", function(e) {
		e.preventDefault();
		console.info("별");
		$(this).parent().children("a").removeClass("on");
		$(this).addClass("on").prevAll("a").addClass("on");
		
		scoreCount();
	});
	  
	  let scoreCount = function(){
		  let point = 0;
		  
		  $("#star_grade a").each(function() {
			if($(this).attr("class") == "on"){
				point += 1
			}
		});
		  $("#reviewScore").val(point);
	  }
	  
	  // 상품후기등록 클릭 (#btnReviewAdd)
	  $("#product_review").on("click", "#btnReviewAdd", function() {
		  console.log("상품후기 클릭");
		  
		  $.ajax({
			 url: '/review/productReviewWrite',
			 type: 'post',
			 dataType: 'text',
			 data: {
				 pro_num : ${productVO.pro_num },
				 rev_content : $("#reviewContent").val(),
				 rev_score : $("#reviewScore").val()
			 },
			 success: function(data) {
				 if(data == "success"){
					 alert("상품리뷰가 등록됨");
					 getProductReview();
				 }
			}	 
		  });
	   });
	  // 후기수정
	  $("#product_review").on("click", "#btnReviewEdit", function() {
          //console.log("상품후기 클릭");

          $("#btnReviewAdd").show(); // 상품후기등록버튼 보이기
          $("#btnReviewEdit").hide(); // 상품후기수정버튼 숨기기
          
          $.ajax({
              url: '/review/productReviewEdit',
              type:'post',
              dataType: 'text',
              data:  {
                rev_num : $("#reviewNum").val(),
                pro_num : ${productVO.pro_num }, 
                rev_content : $("#reviewContent").val(), 
                rev_score : $("#reviewScore").val()
              },
              success: function(data){
                if(data == "success") {
                  alert("상품후기가 수정됨");
                  getProductReview();
                  //reviewLoad();
                }
              }
            });
          });
	  
	  // 상품후기 수정을 위한 버튼(Modal)(btnReviewEditModal)
	  $("#product_review").on("click", "button[name='btnReviewEditModal']", function(){
		 
		  $("#btnReviewAdd").hide(); // 상품후기등록버튼 숨기기
          $("#btnReviewEdit").show(); // 상품후기수정버튼 보이기
          
        //리뷰 번호
          let rev_num = $(this).parent().parent().find("[name='rev_num']").val();
          $("#reviewNum").val(rev_num);
          //리뷰 별점
          let rev_score = $(this).parent().parent().find("[name='rev_score']").val();
          $("#reviewScore").val(rev_score);
		  
          console.log("스코어" + rev_score);
          
          //리뷰 내용
          let rev_content = $(this).parent().parent().find("[name='rev_content']").val();
          $("#reviewContent").val(rev_content);
          $("#btnReview").text("상품후기 수정");
          
   	      // a태그가 5개
          $("#star_grade a").each(function(index, item) {
            if(index<rev_score) {
              $(item).addClass("on");
            }else {
              $(item).removeClass("on");
            }
          });
          
	  });
	  
	  
	  
	  
	  // 상품후기 삭제(Modal)(btnReviewDelModal)
      $("#product_review").on("click", "button[name='btnReviewDelModal']", function() {
    	  
    	  if(!confirm("상품후기를 삭제하시겠습니까?")) return;
    	  
    	  //리뷰번호 찾기
    	  let rev_num = $(this).parent().parent().find("[name='rev_num']").val();
    	  $("#reviewNum").val(rev_num);
    	  
    	  $.ajax({
    		 url: '/review/productReviewDel',
    		 type: 'post',
    		 dataType: 'text',
    		 data: {
    			 rev_num : $("#reviewNum").val()
    		 },
    		 success: function(data) {
				if(data == "success"){
					alert("상품후기가 삭제되었습니다.");
					pageNum = 1;
					reviewLoad();
				}
			}
    	  });
		
      });
    
      //상품후기목록 페이지 번호클릭시
      let pageNum, pro_num;
      $("#product_review").on("click", "ul.pagination a.page-link", function(e){
          e.preventDefault();
          pro_num = $("#pro_num").val();
          pageNum = $(this).attr("href");
          
          reviewLoad();
   	  });
      
      let reviewLoad = function() {
		let reviewForm = $("#reviewForm");
		let amount = reviewForm.find("input[name=amount]").val();
		
		// 상품코드,  페이징정보
		$("#product_review").load("/review/productReview?pro_num="+pro_num+"&pageNum="+pageNum+"&amount="+ amount);
	  }
      
});
    </script>

   
   
</body>
</html>