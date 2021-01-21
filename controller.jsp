<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hospital.*,java.util.*,java.sql.*" %>    
    
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bean" class="hospital.HospitalDAO" /> 
<jsp:useBean id="data" class="hospital.Hospital" >
	<jsp:setProperty name="data" property="*" /> 
</jsp:useBean>



<% 
	// 컨트롤러 요청 파라미터
	String action = request.getParameter("action");
	
	// -- 검색이 전달됐을 때
	if(action.equals("search")) {
		
		// search_bar의 값을 search에 저장
		String search = request.getParameter("search_bar");	
		// 검색어를 그대로 저장해서 보여주기 위한 용도
		session.setAttribute("search", search);
		
		
		if(search == null || search.equals(" ")) {
			pageContext.forward("main.jsp");
		} else {
			// 글자 사이사이 띄어쓰기 제거
			search = search.replaceAll("\\p{Z}", "");
		}
		
		// 위도 경도 값을 변수에 저장
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		
		
		if(search != null) {
			// -- DB에 있는 정보를 가져오는 부분	
			ArrayList<Hospital> datas = bean.getSearchList(search, lat, lng);
			session.setAttribute("datas", datas);
			
		} else {
			throw new Exception("왜안돼에에에에ㅔ에에ㅔㅠㅠ?");
		}
		
		
		Paging paging = new Paging();
		
		// 현재 페이지
		String getPage = request.getParameter("page");
		int prePage;
		
		if(getPage == null || getPage.equals("")) {
			prePage = 1;
		} else {
			prePage = Integer.parseInt(getPage);
		}
		paging.setPrePage(prePage);
		
		// 총 페이지
		paging.setTotalCount(bean.getTotalCount());
		
		int preCount = paging.getPreCount();
		
		ArrayList<Hospital> pagingList = bean.getTotalList(preCount);
		
		request.setAttribute("pagingList", pagingList);
		request.setAttribute("paging", paging);

		
		// -- action이 list라면 list.jsp 로 가라.
		pageContext.forward("main.jsp?result=true");
		

		
	}
	
	
	if(action.equals("page")) {
		Paging paging = new Paging();
		
		// 현재 페이지
		String getPage = request.getParameter("page");
		int prePage;
		
		if(getPage == null || getPage.equals("")) {
			prePage = 1;
		} else {
			prePage = Integer.parseInt(getPage);
		}
		paging.setPrePage(prePage);
		
		// 총 페이지
		paging.setTotalCount(bean.getTotalCount());

		
		int preCount = paging.getPreCount();
		
		ArrayList<Hospital> pagingList = bean.getTotalList(preCount);
		
		request.setAttribute("pagingList", pagingList);
		request.setAttribute("paging", paging);
		
		pageContext.forward("main.jsp?page=" + prePage);
	}
	
	else {
	}
%>

