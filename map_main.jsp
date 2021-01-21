<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,hospital.*" %>
<style>
@font-face {
    font-family: 'GmarketSans';
    src: url('./font/GmarketSansTTFLight.ttf') format('truetype');
    font-weight: normal;
    font-style: normal; 
}
.navbar > a {
		font-family: 'GmarketSans', sans-serif;
		font-weight:bold;
}
</style>
<!-- 컨텐츠 시작 -->
<div align="center">	
	<!-- 지도 -->
	<div id="mapid"></div>
</div>
	
	<!-- 지도 자바스크립트 -->
    <script> 

	 	// 시작 좌표
	    //var lat = 37.309685; 	// 위도
	    //var lng = 126.8514727; 	// 경도
	    var zoom = 17; 			// 줌 레벨
	    //var mymap = L.map('mapid').setView([lat, lng], zoom);
	    var mymap = L.map('mapid').locate({setView:true});
	    // TileLayet : 지도에 타일 레이어를 로드하고 표시하는 데 사용
	    /* L.tileLayer('https://mt0.google.com/vt/lyrs=m&hl=kr&x={x}&y={y}&z={z}', { */
    	L.tileLayer('http://xdworld.vworld.kr:8080/2d/Base/201802/{z}/{x}/{y}.png', {
	        // attributors : 화면 오른쪽 하단 
	        // 구글 로고 누르면 구글지도로 연결해서 볼 수 있음.
	        //attribution: '&copy; <a target="_blank" href="https://maps.google.com/maps?ll=36.1358642,128.0785804&amp;z=13&amp;t=m&amp;hl=ko-KR&amp;gl=US&amp;mapclient=apiv3" title="Google 지도에서 이 지역을 보려면 클릭하세요." ><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/google4.png" draggable="false"></a>',
	        // 최소 확대 크기
	        minZoom:8,
	    }).addTo(mymap);
		
	   /*  var lat_v = document.getElementById("lat");
		var lng_v = document.getElementById("lng");
		lat_v.value = lat;
		lng_v.value = lng; */
		
	function onLocationFound(e) {
		var radius = e.accuracy;
		L.marker(e.latlng).addTo(mymap)
			.bindPopup("현재 내 위치").openPopup();
			//.bindPopup("You are within " + radius + " meters from this point\n" + e.latlng).openPopup();
		
		L.circle(e.latlng, radius).addTo(mymap);
		//document.write("<p>" + e.latlng + "</p>");
		
		// id=text 요소에 값 넣기
		var lat_v = document.getElementById("lat");
		var lng_v = document.getElementById("lng");
		lat_v.value = e.latitude;
		lng_v.value = e.longitude;
		
	};
	mymap.on('locationfound', onLocationFound);
	
	
	// 탭 변경할때 페이징 유지하려고 스토리지 사용하는데,
	// 메인으로 돌아와도 탭이 원상태로 돌아오지 않기에, 메인으로 돌아오면 스토리지 제거해줌
	localStorage.removeItem("activeTab"); 
    </script>