<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="zxx">


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
    <!-- product_list start-->
 <div class="container">
      <div class="row">
 
		<c:forEach items="${productList }" var="productVO" varStatus="status">
   			  <div class="col-lg-3 col-sm-6">
                    <div class="single_product_item">
                    
                    	<a href="${productVO.pro_num}" class="proDetail">
                        	<img name="proudctImage" src="/product/displayFile?fileName=s_<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
                        </a>	
                        
                        <div class="single_product_text">
                        	<div class="card-text">
	                            <h4><c:out value="${ productVO.pro_name }"></c:out></h4>
	                            <h3><fmt:formatNumber type="currency" value="${productVO.pro_price }"></fmt:formatNumber></h3>
	                            <input type="hidden" name="pro_num" value="${productVO.pro_num }">
                            </div>
                            <div class="btn-group">
	                             <a href="#" id="cartAdd" class="add_cart">+ add to cart</a> 
	                            <%--<button type="button" name="btnCartAdd" class="add_cart">+ add to cart</button> --%>
                            </div>
                        </div>
                        
                    </div>
                </div>
		</c:forEach>
			
	  </div>
	  
	  <!-- 페이징 기능 -->
	  
	  <div class="row">
      	 <div class="col-sm-5"></div>  
      	
      	<div class="col-sm-7">								
			<div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
				<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class='paginate_button previous ${pageMaker.prev ? "": "disabled" }'
						id="example2_previous"><a href="${pageMaker.startPage - 1}"
						aria-controls="example2" data-dt-idx="0" tabindex="0">Previous</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">	
					<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }' style="font-size: 20px"><a href="${num}"
						aria-controls="example2" data-dt-idx="1" tabindex="0">${num}</a></li>
						<div> &nbsp;&nbsp; </div>
				</c:forEach>
				<c:if test="${pageMaker.next }">	
					<li class="paginate_button next" id="example2_next"><a
						href="${pageMaker.endPage + 1}" aria-controls="example2" data-dt-idx="7"
						tabindex="0">Next</a></li>
				</c:if>
				</ul>
			</div>
			
		</div>
		<!--prev,page number, next 를 클릭하면 아래 form이 작동된다.-->
		<form id="actionForm" action="/product/productList" method="get">
			<!--list.jsp 가 처음 실행되었을 때 pageNum의 값을 사용자가 선택한 번호의 값으로 변경-->
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="cg_code" value="${cg_code}">
			
			<!--글번호추가-->
		</form>
		<!-- <div class="col-sm-5"></div> -->
      </div>
	  
</div>
    <!--  product_list part end-->
    <!--::footer_part start::-->
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
    <!--::footer_part end::-->
    
    
    <script>
    $(function() {
		
	  //장바구니 담기	
   	  $("a.add_cart").on("click", function(e){
   		e.preventDefault();
   		
   		let pro_num = $(this).parents("div.single_product_text").find("input[name='pro_num']").val();
   		
   		$.ajax({
   			url: '/cart/cartAdd',
   			type: 'post',
   			dataType: 'text',
   			data: {pro_num : pro_num, cart_amount : 1 },
   			success: function(data) {
   				if(data == "success") {
   					if(confirm("장바구니에 추가되었습니다.\n 지금 확인하시겠습니까?")){
   						location.href = "/cart/cartList";
   					}
   				}
   			}
   			
   		});
   	  });
    
      
      let actionForm = $("#actionForm");
  		//페이지번호 클릭시 : 선택한 페이지번호, 페이징정보, 검색정보
  		$(".paginate_button a").on("click", function(e){
  			e.preventDefault(); // <a href="">기능취소
  			//기존 페이지번호를 사용자가 선택한 페이지번호로 변경
  			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
  			actionForm.submit();
      });

      //상세페이지 이동
      $("a.proDetail").on("click", function(e){
        e.preventDefault();
        let pro_num = $(this).attr("href");
        actionForm.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>");
        actionForm.attr("action", "/product/productDetail");
        actionForm.submit();

      });
    
    });
    </script>

   
   
</body>
</html>