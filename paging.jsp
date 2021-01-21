

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="hospital.HospitalDAO" /> 
<%@ page import="java.util.*,hospital.*" %>
<jsp:useBean id="datas" scope="session" class="java.util.ArrayList" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	.row {
		margin:0 10px;
		margin-bottom: 50px;
		margin-top:2rem;
	}
	#card_wrap {
		margin : 15px 0;
		color:#353535;
		font-family: 'NotoSansCJKkr-Regular', sans-serif;
	}
	ul {
		font-family: 'NotoSansCJKkr-Regular', sans-serif;
	}
	.card {
		/* box-shadow: 0px 0px 11.31px 1.69px rgba(68, 68, 78, 0.2); */
		box-shadow: 0px 0px 5px 0px rgba(68, 68, 78, 0.2);
	}
	
	.card-header {
		padding: 1.25rem 1.25rem;
	}
	/* 대표과 */
	.card-header .hos-part {
		padding-top:1px;
		font-size:.8em;
	}
	/* 배찌 */
	.good-badeg {
		margin-bottom:5px;
	}
	/* 별점 */
	.card-header .star {
		margin:0;
		color: #ffca12;
		margin-top:5px;
	}
	.card-header > span, .card-header > h5 {
		
	}
	.card-header > .card-title {
		font-size: 1.26em;
		margin:0;
		font-weight:bold;
	}
	/* 내용 박스 */
	.card-body {
	    padding: .8rem 1.25rem;
	}
	/* 내용 박스 > 전체 텍스트 */
	.card-body > .card-text {
		padding:13px 0;
		margin:0;
	}
	.card-text > * {
		margin:0;
	}
	.card-text > i {
		padding:2px 0 0 5px;
	}
	
	/* 주소 */
	h6.card-text {
		font-size: 1em;
	}
	
	/* 진료과 */
	h6.hos-part > p {
		/* font-family: 'NotoSansCJKkr-Light', sans-serif; */
		font-size: 0.9em;
	}
	
	.pagination {
		margin-bottom:100px;
		font-family: 'NotoSansCJKkr-Regular', sans-serif;
	}
	/* font-awesome */
	/* .card-text > i {
		padding: 0 10px;
		height:100%;
	} */
	/* 별점 start */
	.star-container {
		position:relative;
        width: 170px;
        left:50%;
        transform:translate(-50%, -50%);        
        margin-top:.2rem;
	}
	.star-wrap {
/*         position:relative;
        width: 112px;
        left:50%;
        transform:translate(-50%, -50%);
        margin-top:1rem; */
        float: left;
    	margin-top: 7px;
    	margin-right: 0.4rem;
        
    }
	.star-text {
   	    float: left;
    	font-size: 1.2em;
    	color:#cacaca;
    }
    .star-text > strong {
    	color:#ed3514;
    }
    .star-gray {
        float:left;
        text-align: left;
        height: 16px;
        width: 112px;
        background-image: url('./image/star-gray.png');
    }

    .star-color {
        height:16px;
        /* width:100%; */
        position: relative;
        background-image: url('./image/star-color.png');
    }

    .star-color > img {
        position: absolute;
        top:0;
        left:0;
    }
    
    
	/* 별점 end */
	 Small devices (landscape phones, 576px and up)
	@media (min-width: 576px) and (max-width: 767.98px) {
		
	}
</style>
<script>
/* 	$(document).ready(function() {
		$("#card_wrap").addClass('col-sm-6');
		$("#card_wrap").addClass('col-md-6');
	}); */
	
	/* var mql = window.matchMedia("screen and (max-width:768px)");
	mql.addListener(function(e) {
		if(e.matches) {
			alert('768 보다 작다');
			$("#card_wrap").removeClass('col-sm-6');
			$("#card_wrap").removeClass('col-md-6');
		} else {
			alert('768보다 크다');
		}
	}); */
</script>


</head>
<body>

<%-- <button type="button" class="btn btn-primary">
  검색 결과 <span class="badge badge-light">${paging.totalCount }</span>
  <span class="sr-only">unread messages</span>
</button> --%>


<!-- row-eq-height -->
<div class="row" style="max-width:1200px;margin:0 auto;">
<%
	ArrayList<Hospital> hos = (ArrayList<Hospital>)request.getAttribute("pagingList");
	for(int i=0; i<hos.size(); i++) {
		
		/* 거리 단위 */
		double distance = hos.get(i).getHos_distance();
		String dis_text;
		if(distance < 1000) {
			dis_text = distance + "m";
		}
		else {
			dis_text = Integer.toString(((int)(distance/1000))) + "."  
			+ Integer.toString((int) ((distance % 1000))) + "km";
		} /* end 거리 단위 */
%>

<div id="card_wrap" class="col-md-6 col-sm-6">
	<div class="card h-100">
		<div class="card-header text-center">
			<%-- <h5 class="card-title float-left font-weight-bold"><%=hos.get(i).getHos_name().toString()%></h5>
			<span class="badge badge-primary float-right"><%=hos.get(i).getHos_part().toString()%></span> --%>
			<%--배찌--%>
			<c:set var="service" value="<%=hos.get(i).getBadge_ser().toString().trim()%>" />
			<c:set var="ability" value="<%=hos.get(i).getBadge_abi().toString().trim()%>" />
			<c:set var="conscience" value="<%=hos.get(i).getBadge_con().toString().trim()%>" />
			
			<c:if test="${service != '' ||  service != null }">
				<span class="badge badge-pill badge-primary">${service}</span>
			</c:if>
			<c:if test="${ability != '' || ability != null }">
				<span class="badge badge-pill badge-info">${ability }</span>
			</c:if>
			<c:if test="${conscience != '' || conscience != null }">
				<span class="badge badge-pill badge-secondary">${conscience }</span>
			</c:if>
			
			<h5 class="card-title">
				<%=hos.get(i).getHos_name().toString()%>
				<span class="hos-part"><%=hos.get(i).getHos_part().toString()%></span>
			</h5>
			
			<!-- 별점 -->
			<div class="star-container">
				<div class="star-wrap">
				    <div class="star-gray"></div>
				    
				    <c:set var="star_score" value="<%=hos.get(i).getHos_star().trim() %>" />
				    
				    <!-- 별점이 null이 아닐 경우에만 double로 변환 -->
<%-- 				    <c:if test="${star_score != \"\" }">
				    	<c:set var="star_score" value="${Double.parseDouble(star_score) }" />
			    		<div class="star-color" style=" width:${star_score}%;"></div>
				    </c:if> --%>
				    <c:choose>
				    	<c:when test="${star_score == '' || star_score == null}">
				    		<div class="star-color" style="width:0;"></div>
				    	</c:when>
				    	<c:otherwise>
				    		<div class="star-color" style="width:${star_score * 20}%;"></div>
				    	</c:otherwise>
				    </c:choose>
				</div>
				<div class="star-text"><strong>${star_score }</strong>/5</div>
			</div>
			
			
		</div>
		<div class="card-body">
			
			<h6 class="card-text border-bottom row">
				<i class="fas fa-map-marker-alt" style="color: #999;"></i> 
				<p class="col" ><%=hos.get(i).getHos_addr().toString()%></p>
			</h6>
			<h6 class="card-text border-bottom row">
				<i class="fas fa-phone-alt" style="color: #999;"></i> 
				<p class="col" ><%=hos.get(i).getHos_tel().toString()%></p>
			</h6>
			<h6 class="card-text border-bottom hos-part row">
				<i class="fas fa-stethoscope" style="color: #999;" ></i>
				<p class="col" ><%=hos.get(i).getHos_class().toString()%></p>
			</h6>
			
			<h6 class="card-text row" >
				<i class="fas fa-directions" style="color: #999;"></i>
				<p class="col"><%=dis_text%></p>
			</h6>
		</div>
	</div>
</div>
<%
	} 
%>
</div>
<c:url var="action" value="controller.jsp?action=page&result=true"/>


<% request.setAttribute("page", page); %>

<%-- <c:if test="${paging.prePage > 1 }">
	<a href="${action }&page=${paging.prePage - 1}" class="page_button">
		<c:out value="이전" />
	</a>
</c:if>

<c:forEach var="page" begin="${paging.startPage }" end="${paging.endPage }">
	<c:choose>
		<c:when test="${paging.prePage == page }">
			<a href="${action }&page=${page}" class="page_button">
				<strong><c:out value="${page}" /></strong>
			</a>
		</c:when>
		<c:otherwise>
			<a href="${action }&page=${page}" class="page_button">
				<c:out value="${page}" />
			</a>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:if test="${paging.prePage < paging.totalPage}">
	<a href="${action }&page=${paging.prePage + 1}" class="page_button">
		<c:out value="다음" />
	</a>
</c:if> --%>

<nav aria-label="Page navigation">
  <ul class="pagination justify-content-center">
  
    <li class="page-item">
       <c:if test="${paging.prePage > 1 }">
       		<a class="page-link" href="${action }&page=${paging.prePage - 1}" tabindex="-1">Previous</a>
			</a>
		</c:if>
    </li>
    
   	<c:forEach var="page" begin="${paging.startPage }" end="${paging.endPage }">
			<c:choose>
			<c:when test="${paging.prePage == page }">
			<li class="page-item active">	
				<a href="${action }&page=${page}" class="page-link" >
					<strong><c:out value="${page}" /></strong>
				</a>
			</li>
			</c:when>
			<c:otherwise>
			<li class="page-item">
				<a href="${action }&page=${page}" class="page-link">
					<c:out value="${page}" />
				</a>
			</li>
			</c:otherwise>
			</c:choose>
	</c:forEach>
	
    <c:if test="${paging.prePage < paging.totalPage}">
		<li class="page-item">
			<a class="page-link" href="${action }&page=${paging.prePage + 1}">Next</a>
			</a> 
    	</li>
	</c:if>
	
  </ul>
</nav>

</body>
</html>

