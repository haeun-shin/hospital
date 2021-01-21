<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Map</title>
	
	<!-- Mobile 화면 : Viewport 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Leaflet Map CSS + script -->
    <link rel="stylesheet" href="./css/leaflet.css"/>
    <script src="./js/leaflet.js" ></script>
    
    <!-- vworld 배경지도 사용 -->
    <script src="./js/OpenLayers-2.13.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://map.vworld.kr/js/apis.do?type=Base&apiKey=1748EE1E-87D2-3E31-BAC2-BDCFFD720E4C"></script>
    
    <!-- 제이쿼리 -->
    <script src="./js/jquery-3.5.1.min.js"></script>
    
    <!-- 부트스트랩 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<script src="./js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
	

 	<script>
		$(document).ready(function(){
 			/* var locations = $(location).attr('search'); */
			/* 
			if(locations.indexOf("page") > -1) {
				$('#myTab #map').tab('show')
			} else {
				$('#myTab #map').tab('show')
			} 
			 */
			
			$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
				localStorage.setItem('activeTab', $(e.target).attr('href'));
			});
			 
			var activeTab = localStorage.getItem('activeTab');
			if(activeTab){
				$('#myTab a[href="' + activeTab + '"]').tab('show');
			} 
			
			
			 
		});
	</script> 
</head>

<style>
	.navbar > a {
		font-family: 'GmarketSans', sans-serif;
		font-weight:bold;
	}
    #mapid { 
    	display:block;
        /* height: 100vh; */
        /* 네비게이션바 높이 뺌 */
        height:calc(100vh - 56px); 
        width:100vw;
        font-family: 'NotoSansCJKkr-Regular', sans-serif;
    }
    
     /* html, body {
		margin: 0;
		padding: 0;
		height: 100%;
	}  */
	.form-control, .btn-outline-light{
		font-size:0.9em;
	}
	
	.navbar-brand {
		font-size:1.2em;
		font-weight:bold;
		
	}
	.navbar-brand > img {
		width:30px;
	}
	
</style>

<% String result = request.getParameter("result"); %>
<c:set var="result" value="<%=result %>" />

<c:if test="${result == null }">
		<% session.removeAttribute("search"); %>
		<% request.removeAttribute("pagingList"); %>
		<% request.removeAttribute("paging"); %>
</c:if>

<body>

<div class="content-wrap" style="background-color:#2759d1;">
<nav class="navbar navbar-dark bg-primary " style="background-color:#2759d1!important;max-width:1200px; margin:0 auto;">
  <a href="main.jsp" class="navbar-brand" width="30" height="30" class="d-inline-block align-top">
	  <img src="./image/logo.png"/>
	  병원 어디가지
  </a>
  
  	<!-- 검색창 form 영역 -->
	<form name=form1 method=post action="controller.jsp"  class="form-inline ">
		<input type=hidden name="action" value="search" />  
		
		<!-- 검색창 -->		
<%--  		<div class="form-inline">
			<input type="text" name="search_bar" value='${search }'  class="form-control mr-sm-2" >
			<input type="submit" value="검색" class="btn btn-outline-success my-2 my-sm-0" /> 
			<input type="hidden" id="lat" name="lat">
			<input type="hidden" id="lng" name="lng">
		</div> --%>
		<div class="d-flex">
	        <input type="text" name="search_bar" value='${search }'  class="form-control mr-2" >
			<input type="submit" value="검색" class="btn btn-outline-light mr-2 my-sm-0" /> 
			<input type="hidden" id="lat" name="lat">
			<input type="hidden" id="lng" name="lng">
	    </div>
	</form>
</nav>
</div>



<c:choose>
	<c:when test="${search == null }">
			<c:import url="./map_main.jsp" />
	</c:when>
	
	<c:otherwise>
	
	
	<!-- 리스트 방식 -->
 	<%-- <ul class="nav nav-tabs row" id="myTab" role="tablist" style="margin:0;">
		<li class="nav-item col" role="presentation" style="padding:0;">
			<a class="nav-link active" id="tab-tab" data-toggle="tab" href="#map" role="tab" aria-controls="map">지도</a>
		</li>
		<li class="nav-item col" role="presentation" style="padding:0;">
			<a class="nav-link" id="list-tab" data-toggle="tab" href="#list" role="tab" aria-controls="list">
			리스트
			 <span class="badge badge-primary">${paging.totalCount }</span>
			</a>
		</li>
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane show active" id="map" role="tabpanel" aria-labelledby="map-tab">
			<c:import url="./map_result.jsp" />
		</div>
		<div class="tab-pane" id="list" role="tabpanel" aria-labelledby="list-tab">
			<jsp:include page="./paging.jsp"/>
		</div>
	</div> --%>
	
	
	<!-- 버튼 방식 도전! -->
	<style>
		#myTab {
			width:250px;
		    margin: 0;
		    position: fixed;
		    z-index: 99999999999;
		    /* left:50%;
		    transform:translate(-50%, 0);   */
		    bottom:1rem;
		    right:1rem;
		    background-color: #fff;
		    border: 5px solid rgba(0,0,0,0);
		    border-radius:2rem;
		    box-shadow: 0px 0px 5px 0px rgba(68, 68, 78, 0.2);
		    
		}

		#list-tab , #map-tab  {
		    height: 45px;
		    text-align: center;
		    line-height: 28px;
		    border-radius:2rem;
		    
		}
		
		#list-tab > i, #map-tab > i {
		    font-size: 0.8em;
		}
		.nav-pills .nav-link.active {
		    /* background-color: #007bff; */
		    background-color: #2759d1;
		}
		
		.page-item.active .page-link {
		    background-color: #2759d1;
    		border-color: #2759d1;
		}
		.page-link {
			color:#2759d1;
		}
		a {
			color:#2759d1;
		}
	</style>
	
	<ul class="nav nav-pills row" id="myTab" role="tablist"  style="margin:0;">
		<li class="nav-item col" role="presentation" style="padding:0;">
			<a class="nav-link active" id="map-tab" data-toggle="tab" href="#map" role="tab" aria-controls="map">
			<i class="far fa-map"></i>			
			지도
			</a>
		
		</li>
		<li class="nav-item col" role="presentation"  style="padding:0;">
			<a class="nav-link" id="list-tab" data-toggle="tab" href="#list" role="tab" aria-controls="list">
			<i class="fas fa-list"></i>
			목록
			 <%-- <span class="badge badge-primary">${paging.totalCount }</span> --%>
			</a>
		</li>
	</ul>
	
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane show active" id="map" role="tabpanel" aria-labelledby="map-tab">
			<c:import url="./map_result.jsp" />
		</div>
		<div class="tab-pane" id="list" role="tabpanel" aria-labelledby="list-tab">
			<jsp:include page="./paging.jsp"/>
		</div>
	</div>

	 
	 
	 
	 
<!-- 	 <div class="btn_wrap"  id="myTab">
	  <button type="button" class="btn" id="button1">리스트로 보기</button>
	  <button type="button" class="btn" id="button2">지도로 보기</button>
    </div>
	<script>
 
 		$("#button2").addClass('d-none');
		$("#list").addClass('d-none'); 
		
		$('#button1').on('click', function (e) {
			$("#button2").removeClass('d-none');
			$("#list").removeClass('d-none');
			
			$("#button1").addClass('d-none');
			$("#map").addClass('d-none');
		})
		
		$('#button2').on('click', function (e) {
			$("#button1").removeClass('d-none');
			$("#map").removeClass('d-none');
			
			$("#button2").addClass('d-none');
			$("#list").addClass('d-none');
		}) 

	</script> -->
	 
	<script>
/* 		$(document).ready(function() {
			$('#myTab a').on('click', function (e) {
				  e.preventDefault()
				  $(this).tab('show')
			})
		});  */
		
 		/* $(document).ready(function() {
			$('#myTab a').on('click', function (e) {
				  e.preventDefault()
				  $(this).tab('show')
			})
		});  */
		
		
		
	</script>

<%--
	버튼방식
	<div class="btn_wrap">
	  <button type="button" class="btn" id="button1">리스트로 보기</button>
	  <button type="button" class="btn" id="button2">지도로 보기</button>
    </div>
	
	<div id="map">
		<c:import url="./map_result.jsp" />
	</div>
	<div id="list">
		<jsp:include page="./paging.jsp"/>
	</div>
	
	<script>
 
 		$("#button2").addClass('d-none');
		$("#list").addClass('d-none'); 
		
		$('#button1').on('click', function (e) {
			$("#button2").removeClass('d-none');
			$("#list").removeClass('d-none');
			$("#button1").addClass('d-none');
			$("#map").addClass('d-none');
		})
		
		$('#button2').on('click', function (e) {
			$("#button1").removeClass('d-none');
			$("#map").removeClass('d-none');
			$("#button2").addClass('d-none');
			$("#list").addClass('d-none');
		}) 

	</script>
--%>
	</c:otherwise>
</c:choose>

</body>
</html>
