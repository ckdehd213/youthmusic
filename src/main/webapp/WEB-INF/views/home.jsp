<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>YouthMusic</title>
    
    <!-- Bootstrap CSS -->
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
</head>

<script >

	let msg = '${msg}';   
	if(msg == 'editOk'){
		alert("회원정보가 수정됨");
	} 

	<%--
	let msg = '${msg}';   
	if(msg == 'logoutOk'){
		alert("로그아웃 되었습니다.");
	}
	--%>
</script>


<body>
    <!--::header part start::-->
 <%@include file="/WEB-INF/views/include/header.jsp" %>
    <!-- Header part end-->

 <!--
     banner part start
    <section class="banner_part">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <div class="banner_slider owl-carousel">
                        <div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>Wood & Cloth
                                                Sofa</h1>
                                            <p>Incididunt ut labore et dolore magna aliqua quis ipsum
                                                suspendisse ultrices gravida. Risus commodo viverra</p>
                                            <a href="#" class="btn_2">buy now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="img/banner_img.png" alt="">
                                </div>
                            </div>
                        </div><div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>Cloth & Wood
                                                Sofa</h1>
                                            <p>Incididunt ut labore et dolore magna aliqua quis ipsum
                                                suspendisse ultrices gravida. Risus commodo viverra</p>
                                            <a href="#" class="btn_2">buy now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="img/banner_img.png" alt="">
                                </div>
                            </div>
                        </div><div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>Wood & Cloth
                                                Sofa</h1>
                                            <p>Incididunt ut labore et dolore magna aliqua quis ipsum
                                                suspendisse ultrices gravida. Risus commodo viverra</p>
                                            <a href="#" class="btn_2">buy now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="img/banner_img.png" alt="">
                                </div>
                            </div>
                        </div>
                        <!-- <div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>Cloth $ Wood Sofa</h1>
                                            <p>Incididunt ut labore et dolore magna aliqua quis ipsum
                                                suspendisse ultrices gravida. Risus commodo viverra</p>
                                            <a href="#" class="btn_2">buy now</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="img/banner_img.png" alt="">
                                </div>
                            </div>
                        </div> -->
     <!--                </div>
                    <div class="slider-counter"></div>
                </div>
            </div>
        </div>
    </section>  
    
    		--> 
    
    <!-- banner part start-->

    <!-- feature_part start-->
    <section class="feature_part padding_top">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="section_tittle text-center">
                        <h4>Popular Category</h4>
                    </div>
                </div>
            </div>
            <div class="row align-items-center justify-content-between">
                <div class="col-lg-6 col-sm-6" >
                    <div class="single_feature_post_text" >
                        <div>
                        <h3 style="z-index: 2; position: absolute;">Guitar</h3>
                        <img name="guitarImage" src="/resources/img/acoustic_guitar.png" style="z-index: 1; position: absolute;">
                        <a href="/product/productList?cg_code=5" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i>
                        </a> 
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="single_feature_post_text" >
                    <div>
                        <div>
                       <h3 style="z-index: 2; position: absolute;">Bass</h3><div>&nbsp;</div>
                        </div>
                        <img name="guitarImage" src="/resources/img/bass_guitar.jpg" style="z-index: 1; position: absolute;">
                        <a href="/product/productList?cg_code=6" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i>
                        </a> 
                        </div>
                        
                    </div>
                </div>
                <div class="col-lg-7 col-sm-6">
                    <div class="single_feature_post_text" >
                        <div>
                        <h3 style="z-index: 2; position: absolute;">Drum Set</h3>
                        <img name="guitarImage" src="/resources/img/pearl Pearl Decade Maple.png" style="z-index: 1; position: absolute;">
                        <a href="/product/productList?cg_code=9" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i>
                        </a> 
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 col-sm-6">
                    <div class="single_feature_post_text" >
                        <div>
                        <h3 style="z-index: 2; position: absolute;">Recording</h3>
                        <img name="guitarImage" src="/resources/img/Scarlett studio pack bg.png" style="z-index: 1; position: absolute;">
                        <a href="/product/productList?cg_code=13" class="feature_btn">EXPLORE NOW <i class="fas fa-play"></i>
                        </a> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

 
    <!-- product_list part start
    <section class="product_list best_seller section_padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>Best Sellers <span>shop</span></h2>
                    </div>
                </div>
            </div>
            <div class="row align-items-center justify-content-between">
                <div class="col-lg-12">
                    <div class="best_product_slider owl-carousel">
                        <div class="single_product_item">
                            <img src="/resources/img/product_1.png" alt="">
                            <div class="single_product_text">
                                <h4>Quartz Belt Watch</h4>
                                <h3>$150.00</h3>
                            </div>
                        </div>
                        <div class="single_product_item">
                            <img src="img/product/product_2.png" alt="">
                            <div class="single_product_text">
                                <h4>Quartz Belt Watch</h4>
                                <h3>$150.00</h3>
                            </div>
                        </div>
                        <div class="single_product_item">
                            <img src="img/product/product_3.png" alt="">
                            <div class="single_product_text">
                                <h4>Quartz Belt Watch</h4>
                                <h3>$150.00</h3>
                            </div>
                        </div>
                        <div class="single_product_item">
                            <img src="img/product/product_4.png" alt="">
                            <div class="single_product_text">
                                <h4>Quartz Belt Watch</h4>
                                <h3>$150.00</h3>
                            </div>
                        </div>
                        <div class="single_product_item">
                            <img src="img/product/product_5.png" alt="">
                            <div class="single_product_text">
                                <h4>Quartz Belt Watch</h4>
                                <h3>$150.00</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
     product_list part end-->
 

    <!--::footer_part start::-->
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
    <!--::footer_part end::-->
    
   
    

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
   
</body>

</html>