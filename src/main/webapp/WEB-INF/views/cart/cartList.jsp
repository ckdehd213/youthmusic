<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zxx">


    <!--::header part start::-->
 <%@include file="/WEB-INF/views/include/header.jsp" %>
 
    <!-- Header part end-->
     <!-- acoustic_guitar start-->
   
    <div style="width:auto; height:500px; background-image: url('/resources/img/acoustic_guitar.png'); background-repeat: no-repeat; background-position: center; background-size: cover; ">
      <div class="image-box" style="text-align: center; line-height: 230px;">
		<div>&nbsp;</div>
			<h1>Cart List</h1>
                 <h5>Youth Music <span> - </span>cartlist</h5>                 
	  </div> 
    </div>
   <br><br>
    <!-- acoustic_guitar start-->
<body>
   
   <!--================Cart Area =================-->
  <section class="cart_area padding_top">
    <div class="container">
      <div class="cart_inner">
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
              	
                <th scope="col">Product</th>
                <th scope="col">Price</th>
                <th scope="col">Quantity</th>
                <th scope="col">Total</th>
                <th><input type="checkbox" id="checkAll" name="checkAll"></th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${empty cartList }">
              	<tr>
              		<td colspan="6">장바구니에 담겨있는 물품이 없습니다.</td>
              	</tr>
              </c:if>
              
              <c:if test="${not empty cartList }">
              <c:forEach items="${cartList }" var="cartListVO" varStatus="status">
              	<tr>
              		<td>
              		<div class="media">
              			<div class="d-flex">
              				<a class="move" href="<c:out value="${cartListVO.pro_num }"></c:out>">
              					<img name="proudctImage" src="/cart/displayFile?fileName=s_<c:out value="${cartListVO.pro_img }"></c:out>&uploadPath=<c:out value="${cartListVO.pro_uploadpath }"></c:out>">
              				</a>
              			</div>
              			<div class="media-body">
              				<p><c:out value="${cartListVO.pro_name }"></c:out></p>
              			</div>
              		</div>
              		</td>
              		<td>
              			<div class="product_count">
		                    <span class="pro_price"><c:out value="${cartListVO.pro_price }"></c:out></span>
							<input type="hidden" name="" value="<c:out value="${cartListVO.pro_price }"></c:out>">
                	  	</div>
              		</td>
              		
              		<td>
              			 <input type="number" class="cart_amount" name="cart_amount" value='<c:out value="${cartListVO.cart_amount }"></c:out>' min="1" max="10" title="Quantity:" class="input-text qty input-number" />
              			 <input type="hidden" class="pre_cart_amount" value="${cartListVO.cart_amount }">
						 <input type="button" name="cart_amount_btn" class="btn btn-outline-dark btn-sm"  value="Edit">	
						 <input type="hidden" class="pro_num" name="pro_num" value="${cartListVO.pro_num }">				                    
              		</td>
              		
              		<td>
              			<span class="sum_price"><c:out value="${cartListVO.pro_price * cartListVO.cart_amount }"></c:out></span>
              		</td>
              		<td><input type="checkbox" class="check" value="<c:out value="${cartListVO.cart_code }" />"></td>
              	</tr>
              </c:forEach>	
             
              
              <tr class="bottom_button">
              <td></td>
              <td></td>
                <td>
                <div class="cupon_text float-right">
                  <a class="btn_1 checkDelete" href="#" id="btnCheckDelete">Delete Selection</a> 
                  </div>
                </td>
                <td></td>
                
                <td>
                  <div class="cupon_text float-right">
                    <a class="btn_1 allDelete" href="#" id="btnCartAllDelete">Empty Cart</a>
                  </div>
                </td>
              </tr>
             
              	<tr>
                <td></td>
                <td></td>
                <td>
                  <h5>Subtotal</h5>
                </td>
                <td>
                  <span id="cart_total_price"></span>
                </td>
              </tr>
              </c:if>
             
            </tbody>
          </table>
          
          <div class="checkout_btn_inner float-right">
            <a class="btn_1" href="#" id="btnOrderAdd">Check Out</a>
          </div>
        </div>
      </div>
      
  </section>
  <!--================End Cart Area =================-->
   

    <!--::footer_part start::-->
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
    <!--::footer_part end::-->
    
    
    
   <script>

    // 장바구니 전체금액
    let cartTotalPrice = function() {

		let totalPrice = 0;
		$("span.sum_price").each(function(){
			totalPrice += parseInt($(this).text());
		});
		
		$("#cart_total_price").text(totalPrice);
	}
    
    $(function(){
    	
    	let isCheck = true;
    	/*전체선택 체크박스 클릭*/
    	$("#checkAll").on("click", function() {
			$(".check").prop("checked", this.checked);
			
			isCheck = this.checked;
		});
    	
    	//데이터행 체크박스 클릭
    	$(".check").on("click", function() {
			
    		$("#checkAll").prop("checked", this.checked);
    			
    			$(".check").each(function() {
					if(!$(this).is(":checked")){
						$("#checkAll").prop("checked", false);
					}
				});
		});
    	
    	cartTotalPrice();
    	
    	// 장바구니 수량변경시 총가격변경
    	$("input[name='cart_amount']").on("change", function() {
			
    		let pro_price = $(this).parent().parent().find("td span.pro_price").text();
    		let sum_price = pro_price * $(this).val();
    		
    		$(this).parent().parent().find("td span.sum_price").text(sum_price);
    		
    		cartTotalPrice();
    	
		});

    	// 장바구니 수량Edit 클릭시
    	$("input[name='cart_amount_btn']").on("click", function() {
    		
    		
    		let pro_num = $(this).parent().find("[name='pro_num']").val();
    		let cart_amount2 = $(this).parent().find("[name='cart_amount']").val();
    		let cart_amount1 = $(this).parent().find(".pre_cart_amount").val();
    		

    		console.log("상품번호" + pro_num);
    		
    		//console.log("카트 수량" + cart_amount2);
    		//console.log("기존카트수량" + cart_amount1);
    		
    		$.ajax({
       			url: '/cart/cartAdd',
       			type: 'post',
       			dataType: 'text',
       			data: { pro_num : pro_num,  cart_amount : cart_amount2 - cart_amount1 },
       			success: function(data) {
       				if(data == "success") {
       					
       					alert("수량변경");
       					location.href = "/cart/cartList";
       					}
       				}
       			
       			
       		});
    		
		});
    	
    	
    	//장바구니 선택삭제
    	$("a.checkDelete").on("click", function() {
			if($(".check:checked").length == 0){
				alert("삭제할 상품을 선택하세요.");
				return;
			}
			
			let isDel = confirm("선택한 상품을 삭제하시겠습니까?");
			
			if(!isDel) return;
			
			let cart_codeArr = [];
			
			//선택된 체크박스 일 경우
			$(".check:checked").each(function() {
				let cart_code = $(this).val();
				cart_codeArr.push(cart_code);
			});

      $.ajax({
        url: '/cart/checkDelete',
        type: 'post',
        dataType: 'text',
        data: {
            cart_codeArr : cart_codeArr
        },
        success: function(data){
          if(data == "success"){
            alert("선택된 상품이 장바구니에서 제거되었습니다.");

            //테이블의 행을 의미하는 <tr>태그 제거.
            $(".check:checked").each(function(){
              $(this).parent().parent().remove();
            });

            cartTotalPrice();
          }
        }
      
      });

		});
    	//장바구니 비우기
      $("a.allDelete").on("click", function(){
    	  
        if(${fn:length(cartList) } == 0){
          alert("장바구니가 비어있습니다.");
          return;
        }

        if(!confirm("장바구니를 비우시겠습니까?")) return;

        location.href = "/cart/cartAllDelete";
      });
    	
    	
    });
    
  	//주문하기
	$("#btnOrderAdd").on("click", function(){
			
		location.href = "/order/orderInfo";
	});
   </script>

   
   
</body>
</html>