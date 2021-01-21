<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,hospital.*" %>
<jsp:useBean id="datas" scope="session" class="java.util.ArrayList" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
@font-face {
    font-family: 'NotoSansCJKkr-Regular';
    src: url('./font/NotoSansCJKkr-Regular.otf') format('truetype');
    font-weight: normal;
    font-style: normal; 
}
@font-face {
    font-family: 'NotoSansCJKkr-Light';
    src: url('./font/NotoSansCJKkr-Light.otf') format('truetype');
    font-weight: normal;
    font-style: normal; 
}

@font-face {
    font-family: 'GmarketSans';
    src: url('./font/GmarketSansTTFLight.ttf') format('truetype');
    font-weight: normal;
    font-style: normal; 
}

/*  @font-face {
    font-family: 'GmarketSansBold';
    src: url('./font/GmarketSansTTFBold.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}  */

 

	#mapid { 
    	display:block;
        /* height: 100vh; */
        /* 네비게이션바+리스트 높이 뺌 */
        height:calc(100vh - 56px);
        width:100vw;
        font-family: 'NotoSansCJKkr-Regular', sans-serif;
    }
    .leaflet-popup * {
    	font-size:1.04em;
    }
    .leaflet-popup .pop_wrap .badge-pill {
    	font-size:0.9em;
    	margin-right: 0.2rem;
    }
    /* 팝업 */
    .leaflet-popup-content p {
    	margin:0;
    }
    .pop_wrap > .title > strong {
    	font-size: 1.3em;
    	/* margin-bottom: .5rem; */
    }
    
    .pop_wrap i {
    	line-height: inherit;
    }
    
    .pop_wrap > .addr {
    	margin-top: .8rem;
    	clear: both;
    }
    
    .pop_wrap  > .tel {
    	margin: .6rem 0;
    }
    /* 별점 */
	.pop_wrap > .star-container {
        left:0;
        transform:translate(-0, -50%);
    }
    .pop_wrap  .star-wrap {
    	margin-top:.2rem;
    	margin-bottom: 1.3rem;
   	    padding-top: .3rem;
    }
    .pop_wrap  .star-text {
   	    font-size: 1.5em;
    }

</style>
<div align="center">	
	<!-- 지도 -->
	<div id="mapid"></div>
</div>
	<!-- 지도 자바스크립트 -->
    <script> 
        // 시작 좌표
        // 시작 좌표
	    //var lat = 37.309685; 	// 위도
	    //var lng = 126.8514727; 	// 경도
	    var zoom = 15; 			// 줌 레벨
	    //var mymap = L.map('mapid').setView([lat, lng], zoom);
	    var mymap = L.map('mapid').locate({setView:false});
	    
	    
	    // TileLayet : 지도에 타일 레이어를 로드하고 표시하는 데 사용
	    /* L.tileLayer('https://mt0.google.com/vt/lyrs=m&hl=kr&x={x}&y={y}&z={z}', { */
    	L.tileLayer('http://xdworld.vworld.kr:8080/2d/Base/201802/{z}/{x}/{y}.png', {
	        // attributors : 화면 오른쪽 하단 
	        // 구글 로고 누르면 구글지도로 연결해서 볼 수 있음.
	        //attribution: '&copy; <a target="_blank" href="https://maps.google.com/maps?ll=36.1358642,128.0785804&amp;z=13&amp;t=m&amp;hl=ko-KR&amp;gl=US&amp;mapclient=apiv3" title="Google 지도에서 이 지역을 보려면 클릭하세요." ><img alt="" src="https://maps.gstatic.com/mapfiles/api-3/images/google4.png" draggable="false"></a>',
	        // 최소 확대 크기
	        minZoom:8,
	    }).addTo(mymap);
		
    	function onLocationFound(e) {
    		var radius = e.accuracy;
    		L.marker(e.latlng).addTo(mymap)
    						  .bindPopup("현재 내 위치")
    						  .openPopup();
    						  
    						  //.bindPopup("You are within " + radius + " meters from this point\n" + e.latlng)
    		
    		L.circle(e.latlng, radius).addTo(mymap);
    		//document.write("<p>" + e.latlng + "</p>");
    		
    		// id=text 요소에 값 넣기
    		var lat_v = document.getElementById("lat");
    		var lng_v = document.getElementById("lng");
    		lat_v.value = e.latitude;
    		lng_v.value = e.longitude;
    		
    	};
    	
    	mymap.on('locationfound', onLocationFound);
		
		// 마커가 다 지도에 표시되게 -1
		var markerArray = [];
     </script>	     

        
	<%
		
		
		ArrayList<Hospital> hos = (ArrayList<Hospital>)session.getAttribute("datas");
		// 만약 병원이 1개도 검색되지 않는다면, 알림창을 나타내라.
		if(hos.size() == 0) {
	%>
		<script>
			alert('검색 결과가 없습니다.');	
		</script>
	<%
		// 1개 이상이라면 마커를 표시해라.
		} else {
			for(int i=0; i<hos.size(); i++) {	
	%>
	<c:set var="star_score" value="<%=hos.get(i).getHos_star().trim() %>" />
	<c:choose>
    	<c:when test="${star_score == '' || star_score == null}">
    		<c:set var="star_score_wd" value="0px" />
    	</c:when>
    	<c:otherwise>
    		<c:set var="star_score_wd" value="${star_score * 20}%" />
    		<c:set var="star_score" value="${star_score }" />
    	</c:otherwise>
    </c:choose>
    <c:set var="service" value="<%=hos.get(i).getBadge_ser().toString().trim()%>" />
	<c:set var="ability" value="<%=hos.get(i).getBadge_abi().toString().trim()%>" />
	<c:set var="conscience" value="<%=hos.get(i).getBadge_con().toString().trim()%>" />
	<!-- 마커 표시 스크립트 -->
	<script> 
			var iconUrl;
			var hos_part = '<%=hos.get(i).getHos_part().toString()%>';
			if(hos_part == '산부인과') {
				iconUrl = './image/산부인과.png';
			} else if (hos_part == '비뇨의학과'){
				iconUrl = './image/비뇨의학과.png';
			} else if (hos_part == '내과') {
				iconUrl = './image/내과.png';
			} else if (hos_part == '대장항문외과') {
				iconUrl = './image/대장항문외과.png';
			} else if (hos_part == '비뇨의학과') {
				iconUrl = './image/비뇨의학과.png';
			} else if (hos_part == '소아과') {
				iconUrl = './image/소아과.png';
			} else if (hos_part == '소아청소년과') {
				iconUrl = './image/소아청소년과.png';
			} else if (hos_part == '신경과') {
				iconUrl = './image/신경과.png';
			} else if (hos_part == '신경외과') {
				iconUrl = './image/신경외과.png';
			} else if (hos_part == '안과') {
				iconUrl = './image/안과.png';
			} else if (hos_part == '이비인후과') {
				iconUrl = './image/이비인후과.png';
			} else if (hos_part == '정신과' || hos_part == '정신건강의학과') {
				iconUrl = './image/정신과.png';
			} else if (hos_part == '정형외과') {
				iconUrl = './image/정형외과.png';
			} else if (hos_part == '치과') {
				iconUrl = './image/치과.png';
			} else if (hos_part == '') {
				iconUrl = './image/병원의원.png';
			}
			else {
				iconUrl = './image/그외.png';
			}
			options = {
					iconUrl: iconUrl,
					iconAnchor: [22, 43],
					popupAnchor: [0, -43]
			};
			
			<%
				double distance = hos.get(i).getHos_distance();
				String dis_text;
				if(distance < 1000) {
					dis_text = distance + "m";
				}
				else {
					dis_text = Integer.toString(((int)(distance/1000))) + "."  
					+ Integer.toString((int) ((distance % 1000))) + "km";
				}
			%>
			
			var marker = L.marker([<%=hos.get(i).getHos_lat() %>, <%=hos.get(i).getHos_lng() %>], {
				icon: L.icon(options)
			}).addTo(mymap);
			
			// 별점 퍼센트로 추가하기 + 텍스트도
			var popup = L.popup().setContent('<div class="pop_wrap">' + 
					'<c:if test="${service != '' ||  service != null }">'+
					'<span class="badge badge-pill badge-primary">${service}</span>'+
					'</c:if>'+
					'<c:if test="${ability != '' || ability != null }">'+
						'<span class="badge badge-pill badge-info">${ability }</span>'+
					'</c:if>'+
					'<c:if test="${conscience != '' || conscience != null }">'+
						'<span class="badge badge-pill badge-secondary">${conscience }</span>'+
					'</c:if>'+
					'<p class="title"><strong><%=hos.get(i).getHos_name().toString()%></strong>  <%=hos.get(i).getHos_part().toString()%><br></p>' +
					'<div class="star-container"><div class="star-wrap"><div class="star-gray"></div><div class="star-color" style="width:${star_score_wd};"></div></div><div class="star-text"><strong>${star_score}</strong>/5</div></div>' +
					'<p class="addr row"><i class="fas fa-map-marker-alt" style="color: #999; margin: 0 0.1rem;"></i><span class="col"><%=hos.get(i).getHos_addr().toString()%></span></p>' + 
					'<p class="tel row"><i class="fas fa-phone-alt" style="color: #999;"></i> <span class="col"><%=hos.get(i).getHos_tel().toString()%></span></p>' + 
					'<p class="dis row"><i class="fas fa-directions" style="color: #999;"></i> <span class="col"><%= dis_text %></span></p></div>');
			marker.bindPopup(popup);
			
			// 마커가 다 지도에 표시되게 -2
			// distance 순으로 해야지만 제대로 보일듯..흠...
			if(<%=i%> < 7) {
				markerArray.push(L.marker([<%=hos.get(i).getHos_lat() %>, <%=hos.get(i).getHos_lng() %>]));
			}	
				
	</script>		
	<%
		}
			}
	%>	

	<script>
		// 마커가 다 지도에 표시되게 -3
		var group = L.featureGroup(markerArray);
		mymap.fitBounds(group.getBounds());
		
		
		// 내 위치 기준으로 하려면 아래 써보기.... -> 오류남 ㅎ;;;
		//mymap.setView(group.getBounds().getCenter());
		
	</script>