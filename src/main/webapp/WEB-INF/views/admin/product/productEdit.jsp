<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- css, js 파일포함 -->
<!-- 절대경로  /WEB-INF/views/include/header_info.jsp -->
<%@include file="/WEB-INF/views/admin/include/header_info.jsp" %>


<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  <script src="/bower_components/ckeditor/ckeditor.js"></script>
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/left_menu.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
  
<h3>상품수정</h3>
  <form action="productEdit" method="post" id="productEditForm" enctype="multipart/form-data">
	<div class="form-row">
   	  <div class="col-md-6">
	    <label for="pro_num">상품코드</label>
	    <input type="hidden" name="pageNum" value="${ cri.pageNum}" >
	    <input type="hidden" name="amount" value="${ cri.amount}" >
	    <input type="hidden" name="type" value="${ cri.type}" >
	    <input type="hidden" name="keyword" value="${ cri.keyword}" >
	    <input type="text" class="form-control" id="pro_num" name="pro_num" value='<c:out value="${productVO.pro_num }" />'>
	  </div>
	  <div class="col-md-6">
	    <label for="pro_name">상품명</label>
	    <input type="text" class="form-control" id="pro_name" name="pro_name" value='<c:out value="${productVO.pro_name}" />' >
	  </div>
    </div>
    <div class="form-row">
      <div class="col-md-6">
	   <label for="cg_prt_code">1차카테고리</label>
	    <select class="form-control" id="mainCategory"  name="cg_prt_code">
	      <option value="">1차 카테고리 선택</option> 
	      
	      <c:forEach items="${mainCategory}" var="categoryVO">
	      	<option value="${categoryVO.cg_code }" ${categoryVO.cg_code == productVO.cg_prt_code ? 'selected' : ''} >
	      	${categoryVO.cg_name }
	      	</option>
	      </c:forEach>
	      
	    </select>
	  </div>
	  <div class="col-md-6">
		<label for="cg_code">2차카테고리</label>
	    <select class="form-control" id="subCategory" name="cg_code">
	    <c:forEach items="${ subCategory }" var="categoryVO">
	      	<option value="${categoryVO.cg_code }" ${categoryVO.cg_code == productVO.cg_code ? 'selected' : ''} >
	      	${categoryVO.cg_name }
	      	</option>
	    </c:forEach>
	    </select>    
      </div>
    </div>
    <div class="form-row">
      <div class="col-md-4">
		<label for="pro_price">상품가격</label>
	    <input type="text" class="form-control" id="pro_price" name="pro_price" value='<c:out value="${productVO.pro_price}" />'>
      </div>
      <div class="col-md-4">
	    <label for="pro_discount">할인율</label>
	    <input type="text" class="form-control" id="pro_discount" name="pro_discount" value='<c:out value="${productVO.pro_discount}" />'>
      </div>
	  <div class="col-md-4">
		<label id="pro_company">제조사</label>
	    <input type="text" class="form-control" id="pro_company" name="pro_company" value='<c:out value="${productVO.pro_company}" />'>
      </div>
    </div>
   <!-- 상품설명 : CKeditor -->
   <div class="form-row">
     <div class="col-md-12">
        <label for="pro_content">상품설명</label>
        <textarea id="pro_content" name="pro_content" rows="10" cols="80"><c:out value="${productVO.pro_content}" /></textarea>
     </div>
   </div>
  <div class="form-row">
    <div class="col-md-4">
        <label for="upload">상품이미지</label>
        <input type="file" id="upload" name="upload">
        
        <!-- 1) 이미지 변경시 기존이미지 정보를 이용하여 기존이미지 삭제, 2) 변경 안하면, 기존이미지 정보를 수정데이타로 사용 -->
        <input type="hidden" name="pro_uploadpath" value="<c:out value="${productVO.pro_uploadpath}" />">
        <input type="hidden" name="pro_img" value="<c:out value="${productVO.pro_img}" />">
    </div>
    <div class="col-md-4">
        <label for="upload">미리보기</label>   
        <img name="productImage" id="previewImage" src="/admin/product/displayFile?fileName=<c:out value="${productVO.pro_img }"></c:out>&uploadPath=<c:out value="${productVO.pro_uploadpath }"></c:out>">
        <!-- <div id="preview_img"></div>-->
    </div>
     <div class="col-md-4">
        <label for="upload"></label>
    </div>
  </div>
  
   <div class="form-row">
      <div class="col-md-4">
        <label for="pro_stock">재고수량</label>
        <input type="text" class="form-control" id="pro_stock" name="pro_stock" value='<c:out value="${productVO.pro_stock}" />'>
      </div>
    <div class="col-md-4">
      <label for="pro_ok_buy">판매여부</label>
      <select class="form-control" id="pro_ok_buy" name="pro_ok_buy">
	      <option>판매여부를 선택하세요</option>
	      <option value="Y" <c:out value="${productVO.pro_ok_buy == 'Y' ? 'selected' : ''}" />>판매함</option>
	      <option value="N" <c:out value="${productVO.pro_ok_buy == 'N' ? 'selected' : ''}" />>판매 안함</option>
	    </select>
	    
       </div>   
	   <div class="col-md-4">
        <label for=""></label>
        <input type="hidden" class="form-control" id="" name="">
       </div>  
    </div>
   <div class="form-row">
     <div class="col-md-5">
      <label for="mbsp_deaddr"></label>
      <input type="hidden" class="form-control" id="" name="">
    </div>
  
    <div class="col-md-2">
      <button type="submit" id="btnProductEdit" class="form-control">상품수정</button>
    </div>
    <div class="col-md-5">
      <label for="mbsp_deaddr"></label>
      <input type="hidden" class="form-control" id="" name="">
	 </div>
   </div>
  
  </form>
	</section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer (기타 footer태그밑에 소스포함)-->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin_js.jsp" %>

<!--  상품 이미지 미리보기 id=preview_img-->
<script>
  
  function readImage(input){
    if(input.files && input.files[0]){

      let imgPath = $("#upload").val();
      alert(imgPath);

      let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();
      alert(ext);
      if(typeof(FileReader ) == "undefined"){
        alert("브라우적 작업을 지원안합니다.");
        return;
      }

      if(ext == "png" || ext == "gif" || ext == "jpg" || ext == "jpeg" ){

        const reader = new FileReader();

        // 이벤트 설정. reader객체가 이미지 파일을 성공적으로 읽어들였을 때 발생하는 이벤트
        reader.onload = (e) => {
            //alert("onload");
            const previewImage = document.getElementById('previewImage');
            previewImage.src = e.target.result;
        }
        // reader객체가 파일을 읽어들이는 작업. (읽어들이면 위의 작업 시작) 
        reader.readAsDataURL(input.files[0]);
      }else{
        $("#upload").val("");
        alert("이미지 파일을 선택하세요.");
      } 
    } 
  }
  // 이벤트 리스너. 
  document.getElementById('upload').addEventListener('change', (e) => {
      readImage(e.target);
  });

</script>
<script>
	$(document).ready(function(){
		
		let ckeditor_config = {
			resize_enabled : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			toolbarCanCollapse : true,
			removePlugins : "elementspath",
			
			filebrowserUploadUrl : "editor/imageUpload" // /editor/imageUpload 이미지 업로드시 업로드탭 보기
				
		};
		
		CKEDITOR.replace('pro_content', ckeditor_config);
		
		//alert(CKEDITOR.version);
		
	});
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="subCategoryTemplate" type="text/x-handlebars-template">
  
	<option>2차 카테고리 선택</option>
	{{#each .}}
  
		<option value="{{cg_code}}">{{cg_name}}</option>
  
    {{/each}}
</script>
	

  <script>

$(document).ready(function(){
  
  
  
  $("#mainCategory").on("change", function(){

    if($(this).val() == ""){alert("카테고리를 선택하세요."); return;}		//선택하세요 선택시 동작되는 것을 방지

    let url = "/admin/product/subCategory/" + $(this).val();
    
    $.getJSON(url, function(data){

      subCategoryBindingView(data, $("#subCategory"), $("#subCategoryTemplate")); 

    });
  }); 
});   
  </script>
  
  <script>
    // subCategory: 2차 카테고리 데이타
    // target : 2차 카테고리 바인딩 결과가 출력될 위치
    // template : 2차 카테고리 핸들바 템플릿
    let subCategoryBindingView = function(subCategory, target, template){

      let templateObj = Handlebars.compile(template.html());  // 문법 이상여부 검사
      let subCgOptionsResult = templateObj(subCategory);


      //누적되는 증상발생. 처리
      $("#subCategory option").remove();
      target.append(subCgOptionsResult);
    }

  </script>
 

</body>
</html>
