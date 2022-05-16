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
			<h1>Order Info</h1>
                 <h5>Youth Music <span> - </span>order info</h5>                 
	  </div> 
    </div>
   <br><br>
    <!-- acoustic_guitar start-->
<body>

	<!--================Checkout Area =================-->
  <section class="checkout_area padding_top">
    <div class="container">
     <form action="/order/orderAction" method="post" id="orderForm">
      <div class="billing_details">
        <div class="row">
          <div class="col-lg-8">
            <h3>Order Info</h3>
            
            <div class="col-md-12 form-group p_star">
          	    <label for="mem_name">이름</label>
                <input type="text" class="form-control" id="mem_name" name="mem_name" value="${sessionScope.loginStatus.mem_name}" readonly/>
            </div>
            <div class="col-md-12 form-group p_star">
          	    <label for="mem_email">이메일</label>
                <input type="text" class="form-control" id="mem_email" name="mem_email" value="${sessionScope.loginStatus.mem_email}" readonly/>
            </div>
            <div class="col-md-12 form-group p_star">
          	    <label for="mem_phone">연락처</label>
                <input type="text" class="form-control" id="mem_phone" name="mem_phone" value="${sessionScope.loginStatus.mem_phone}" readonly/>
            </div>
            
            <div class="col-md-12 form-group p_star">
            	<div><label for="mem_addr">주소</label></div>
                <input type="text" style="width: 100px" class="form-control" id="mem_post" name="mem_post" value="${sessionScope.loginStatus.mem_post}" />
                <input type="text" class="form-control" id="mem_addr" name="mem_addr" value="${sessionScope.loginStatus.mem_addr}"  />
                <input type="text" class="form-control" id="mem_addr2" name="mem_addr2" value="${sessionScope.loginStatus.mem_addr2}"  />
           </div>
           
           <hr>
           <h3>Shipping Info</h3>
            &nbsp;&nbsp;&nbsp;<input type="checkbox" id="orderInfoCopy">위정보와 같음
           
           <br><br><br>
           <div class="col-md-12 form-group p_star">
         	    <label for="ord_name">이름</label>
               <input type="text" class="form-control" id="ord_name" name="ord_name" />
           </div> 
           <div class="col-md-12 form-group p_star">
         	    <label for="ord_phone">연락처</label>
               <input type="text" class="form-control" id="ord_phone" name="ord_phone" />
           </div> 
           <div class="col-md-12 form-group p_star">
            	<label for="ord_addr">주소</label>
            	<div style="display:flex; flex-direction: row; justify-content: flex-start; ">
	                <input type="text" style="width: 100px" class="form-control" id="ord_post" name="ord_post" placeholder="우편번호">
	                
	                <span>&nbsp;&nbsp;&nbsp;</span>
	                <input type="button" class="form-control genric-btn primary-border circle small" id="btnPostCode" name="btnPostCode"  value="우편번호찾기" 
	                onclick="sample2_execDaumPostcode()" style="width: 140px;">
                </div>
                <input type="text" class="form-control" id="ord_addr" name="ord_addr" placeholder="기본주소" />
                <input type="text" class="form-control" id="ord_addr2" name="ord_addr2" placeholder="상세주소" />
                <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
           </div>
            
            <div class="col-md-12 form-group p_star">
         	    <label for="ord_message">배송메세지(50자 내외)</label>
               <textarea rows="1" cols="3" class="form-control" id="ord_message" name="ord_message"></textarea> 
           </div> 
            <div class="col-md-12 form-group p_star">
         	    <label for="ord_depositor">무통장 입금자명</label>
               <input type="text" class="form-control" id="ord_depositor" name="ord_depositor" />(주문자와 같을경우 생략가능)
           </div> 
          </div>
          
          
          <div class="col-lg-4">
            <div class="box">
              <h2>Your Order</h2>
              <div>
                <c:if test="${not empty orderInfo}">
				<c:forEach items="${orderInfo }" var="orderInfoVO" varStatus="status">
             	   <ul class="list" style="list-style-type: none; display: inline-block;">
	              	<!-- <li>
	              		<input type="hidden" value='<c:out value="${orderInfoVO.pro_num }"></c:out>' readonly>
	              		<img name="proudctImage" src="/order/displayFile?fileName=s_<c:out value="${orderInfoVO.pro_img }"></c:out>&uploadPath=<c:out value="${orderInfoVO.pro_uploadpath }"></c:out>">
	              	</li>
	              	 -->
		                <li >
		                	<input type="text" value='<c:out value="${orderInfoVO.pro_name }"></c:out>' style="border:none;" readonly>
							<input type="hidden" name="orderDetailList[${status.index }].pro_num" value='<c:out value="${orderInfoVO.pro_num }"></c:out>'>
		                </li>
		                <li >
		                	수량: <input type="text" name="orderDetailList[${status.index }].ord_amount" value='<c:out value="${orderInfoVO.cart_amount }"></c:out>' style="border:none;" readonly>
		                </li>
		                
		                <li >
		                	가격: <input type="text" class="order_each_price" name="orderDetailList[${status.index }].ord_price" value='<c:out value="${orderInfoVO.orderprice }" ></c:out>' style="border:none;">
		                </li>
		                
	                </ul>
           		 		 <hr>
                </c:forEach>
                
                
	                <ul>
	                	<li style="font-weight: bold;">
	                		Total Price: <input type="text" name="ord_total_price" style="border:none;" readonly>
	                	</li>
	                </ul>
                </c:if>
            </div>

			<br>
		
			<input class="btn_3" type="submit" style="width: 250px" value="주문하기"><br>
			<!-- <a><img src="/resources/img/payment_icon_yellow_medium.png" id="btn_kakaopay" style="cursor:pointer;"></a> -->
			
              <!-- <div class="payment_item">
                <div class="radion_btn">
                  <input type="radio" id="f-option5" name="selector" />
                  <label for="f-option5">Check payments</label>
                  <div class="check"></div>
                </div>
                <p>
                  Please send a check to Store Name, Store Street, Store Town,
                  Store State / County, Store Postcode.
                </p>
              </div>
              <div class="payment_item active">
                <div class="radion_btn">
                  <input type="radio" id="f-option6" name="selector" />
                  <label for="f-option6">Paypal </label>
                  <img src="/resources/img/product/single-product/card.jpg" alt="" />
                  <div class="check"></div>
                </div>
                <p>
                  Please send a check to Store Name, Store Street, Store Town,
                  Store State / County, Store Postcode.
                </p>
              </div>
              
               
              
              
              <div class="creat_account">
                <input type="checkbox" id="f-option4" name="selector" />
                <label for="f-option4">I’ve read and accept the </label>
                <a href="#">terms & conditions*</a>
              </div>
              	<input class="btn_3" type="submit" style="width: 250px" value="주문하기">-->
              <!-- <a class="btn_3" href="#">Proceed to Paypal</a> -->
            </div>
          </div>
          
          
        </div>
      </div>
      </form>
    </div>
  </section>
  <!--================End Checkout Area =================-->

 	<!--::footer_part start::-->
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
    <!--::footer_part end::-->
    
  <script>
    
    $(document).ready(function() {
		
    	//주문정보 복사
    	$("#orderInfoCopy").on("click", function() {
    		
			$("#ord_name").val($("#mem_name").val());
			$("#ord_phone").val($("#mem_phone").val());
			
			$("#ord_post").val($("#mem_post").val());
			$("#ord_addr").val($("#mem_addr").val());
			$("#ord_addr2").val($("#mem_addr2").val());
			
			//console.log("주문내용복사" + mem_name);
		});
    	
    	//주문 총 금액
    	let orderTotalPrice = function() {

    	      let totalPrice = 0;
    	      $(".order_each_price").each(function(){
    	        totalPrice += parseInt($(this).val());
    	      });
    	      
    	      $("input[name=ord_total_price]").val(totalPrice);

    	    }

    	    orderTotalPrice();

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
                  document.getElementById('ord_post').value = data.zonecode;
                  document.getElementById("ord_addr").value = addr;
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("ord_addr2").focus();
  
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
  
  
  <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <script>
	$("#check_module").click(function () {
		var IMP = window.IMP; // 생략가능
		//IMP.init('가맹점식별코드'); 
		IMP.init('INIpayTest'); 
		// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
		// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
		IMP.request_pay({
			pg: 'kakaopay',
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			/* 
			 *  merchant_uid에 경우 
			 *  https://docs.iamport.kr/implementation/payment
			 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
			 */
			name: '주문명 : 아메리카노',
			// 결제창에서 보여질 이름
			// name: '주문명 : ${auction.a_title}',
			// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
			amount: 2000,
			// amount: ${bid.b_bid},
			// 가격 
			buyer_name: '이름',
			// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
			// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
			buyer_postcode: '123-456',
			}, function (rsp) {
				console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '결제 금액 : ' + rsp.paid_amount;
				// success.submit();
				// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
				// 자세한 설명은 구글링으로 보시는게 좋습니다.
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
		});
	});
</script>



</body>
</html>