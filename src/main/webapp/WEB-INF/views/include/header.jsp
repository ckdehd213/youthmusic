<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/plugin_js.jsp" %> 

<!DOCTYPE html>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<!-- animate CSS -->
    <link rel="stylesheet" href="/resources/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="/resources/css/all.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="/resources/css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="/resources/css/style.css">

  <%--    
<script>
	
	let msg = '${msg}';   
	if(msg == 'logoutOk'){
		alert("로그아웃 되었습니다.");
	}

</script>
  --%>
  
<header class="main_menu home_menu">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="navbar-brand" href="/"><img src="/resources/img/ymlogo3.png" alt="logo"></a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="menu_icon"><i class="fas fa-bars"></i></span>
                        </button>

                        <div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
                         
                            <ul class="navbar-nav">
 								<%--22/03/03 nav-item -> nav-it --%>                           
                                <li class="nav-it"> 
                                    <a class="nav-link" href="/">Home</a>
                                </li>
                      
                      		    <c:forEach items="${mainUserCategory}" var="categoryVO">
                      		  	<li class="nav-item dropdown">
	                      		  	<a class="nav-link dropdown-toggle"  data-toggle="dropdown" href="${categoryVO.cg_code }" role="button" aria-haspopup="true" aria-expanded="false">
	                      		  	${categoryVO.cg_name }
	                      		  	</a>
	                      		  	<div class="dropdown-menu" aria-labelledby="navbarDropdown_1" >
                                        <a class="dropdown-item" id="subCategory_${categoryVO.cg_code }"></a>
                                    </div>
                      		  	</li>
                      		    </c:forEach>	
                      
                      
                               <%--22/03/03 nav-item -> nav-it --%>
                                <li class="nav-it dropdown">
                                    <a class="nav-link dropdown-toggle" href="blog.html" id="navbarDropdown_3" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                       	회원관리
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown_2">
                                        
                                        <!--  로그인 이전상태 표시 -->
                                       <c:if test="${sessionScope.loginStatus == null }">
                                       		
                                       		<a class="dropdown-item" href="/member/login">Login</a>
	                                        <a class="dropdown-item" href="/member/join">Join</a>
	                                        <!-- <a class="dropdown-item" href="/member/login">My Page</a> -->
	                                        
	                                   </c:if>     
	                                        
	                                   <c:if test="${sessionScope.loginStatus != null }">      
                           				    
                           				    <a class="dropdown-item" href="/member/logout">Logout</a>
                           				    <a class="dropdown-item" href="/member/edit">Edit</a>
                           				   
                           				   
	                                   </c:if>    
                                       
                                        <a class="dropdown-item" href="/member/mypage">My Page</a>
                                        <!--  <a class="dropdown-item" href="/member/mypage">My Page</a>-->
                                        <!-- <a class="dropdown-item" href="tracking.html">shopping cart</a>  -->
                                        
                                        
                                    </div>
                                </li>   
                            </ul>
                        </div>
                        
                       
                        <div class="hearer_icon d-flex">
                        	<!--  <a id="search_1" href=""><i class="ti-search"></i></a>-->
                            <!--   <a href=""><i class="ti-heart"></i></a> --> 
                            <div class="dropdown site-header_cart">
                                <a class="dropdown-toggle " href="#" id="navbarDropdown3" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-cart-plus"></i>
                                </a>
                                
                                 <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="/cart/cartList">Cart List</a>
                                    <a class="dropdown-item" href="/order/orderInfo">Order Info</a>
                                </div> 
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <div class="search_input" id="search_input_box" style="display: none;">
            <div class="container ">
                <form class="d-flex justify-content-between search-inner">
                    <input type="text" class="form-control" id="search_input" placeholder="Search Here">
                    <button type="submit" class="btn"></button>
                    <span class="ti-close" id="close_search" title="Close Search"></span>
                </form>
            </div>
        </div>
        
        
    </header>
    
    <div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
    

 
    
    <!-- jquery plugins here-->
    <script src="/resources/js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="/resources/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="/resources/js/bootstrap.min.js"></script>
    <!-- easing js -->
    <script src="/resources/js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="/resources/js/swiper.min.js"></script>
    <!-- swiper js -->
    <script src="/resources/js/masonry.pkgd.js"></script>
    <!-- particles js -->
    <script src="/resources/js/owl.carousel.min.js"></script>
    <script src="/resources/js/jquery.nice-select.min.js"></script>
    <!-- slick js -->
    <script src="/resources/js/slick.min.js"></script>
    <script src="/resources/js/jquery.counterup.min.js"></script>
    <script src="/resources/js/waypoints.min.js"></script>
    <script src="/resources/js/contact.js"></script>
    <script src="/resources/js/jquery.ajaxchimp.min.js"></script>
    <script src="/resources/js/jquery.form.js"></script>
    <script src="/resources/js/jquery.validate.min.js"></script>
    <script src="/resources/js/mail-script.js"></script>
    <!-- custom js -->
    <script src="/resources/js/custom.js"></script>
    
    
    <script>
      $(function() {
		
    	  //1차카테고리 mouseover
    	  $(".navbar-nav .nav-item a.nav-link").on("mouseover", function() {
			
    		  
    		  let url = "/product/subCategory/" + $(this).attr("href");
    		  let curAnchor = $(this);
    		  
    		    $.getJSON(url, function(data){
    		    	
    		    	$(".navbar-nav .nav-item .dropdown-menu a.dropdown-item").each(function() {
						$(this).empty();
					});

    		      //subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate")); 
				  let subCategoryStr = "";
				  for(let i=0; i<data.length; i++){
					  
					  let selector = "#subCategory_" + data[i].cg_prt_code;
					  
					  //console.log("선택자: " + selector);
					  subCategoryStr = "<a class='sub_cate' href='" + data[i].cg_code + "'>" + data[i].cg_name + "<br><br></a>";
					  
					  $(selector).append(subCategoryStr);
					  $("a.sub_cate").css({color:"white"});
				  }
    		    });
		});
    	  
    	    //2차 카테고리 출력
    	    $("a.dropdown-item").on("click", "a.sub_cate", function(e) {
				e.preventDefault();
				
				//console.log("2차 카테고리 클릭");
				location.href = "//localhost:8888/product/productList?cg_code=" + $(this).attr("href");
				
			});
	});
    
 </script>
   