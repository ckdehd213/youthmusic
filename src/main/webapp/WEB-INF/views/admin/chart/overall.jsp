<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@include file="/WEB-INF/views/admin/include/header_info.jsp" %>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});

  
  // 1차카테고리 주문통계차트
  google.charts.setOnLoadCallback(primeChart);

  function primeChart() {

    var data = google.visualization.arrayToDataTable(${prime_chart});

    var options = {
      title: '1차 카테고리 주문통계'
    };

    var chart = new google.visualization.PieChart(document.getElementById('primePiechart'));

    chart.draw(data, options);
  }
  
  //2차카테고리 주문통계차트
  google.charts.setOnLoadCallback(secondChart);

  function secondChart() {

    var data = google.visualization.arrayToDataTable(${second_chart});

    var options = {
      title: '2차 카테고리 주문통계'
    };

    var chart = new google.visualization.PieChart(document.getElementById('secondPiechart'));

    chart.draw(data, options);
  }
  
//년도별 총매출 통계차트
  google.charts.setOnLoadCallback(salesYearChart);

  function salesYearChart() {

    var data = google.visualization.arrayToDataTable(${salesYear_chart});

    var options = {
      title: '년도별 총매출 통계'
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('salesYearPiechart'));

    chart.draw(data, options);
  }
</script>
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
<body>

<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
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
    <div class="row">
    
    	<div class="col-md-4">
    		<div id="primePiechart" style="width: 300px; height: 300px;"></div>
    	</div>
    	<div class="col-md-4">
    		<div id="secondPiechart" style="width: 300px; height: 300px;"></div>
    	</div>
    	<div class="col-md-4">
    		<div id="salesYearPiechart" style="width: 300px; height: 300px;"></div>
    	</div>
    	
    </div>
	
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

</body>
</html>