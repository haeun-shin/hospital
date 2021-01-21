package hospital;

public class Paging {
	// 현재 페이지
	private int prePage;
	
	// 현재 시작 게시물
	private int preCount;
	
	// 총 페이지 [1][2][3][4][5]... 
	private int totalPage;
	
	// 총 게시물
	private int totalCount;
	
	// 한 페이지에 출력될 게시물 수
	private int countList = 10;
	
	// 한 화면에 출력될 페이지 수 [1][2][3][4][5]
	private int countPage = 5;
	
	// 시작 페이지 [■][2][3][4][5]
	private int startPage;
	
	// 종료 페이지 [1][2][3][4][■]
	private int endPage;

	// 이전 다음 버튼
	boolean prev;
	boolean next;
 
	
    public int getPrePage() {
		return prePage;
	}

	public void setPrePage(int prePage) {
		this.prePage = prePage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalCount() {
		return totalCount;
	}
	
	// totalCount를 호출해야 paging이 가능하기 때문에
	// 이걸 호출하면 paging() 메소드를 호출하도록 설정
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePaging();
	}

	public int getCountList() {
		return countList;
	}

	public void setCountList(int countList) {
		this.countList = countList;
	}

	public int getCountPage() {
		return countPage;
	}

	public void setCountPage(int countPage) {
		this.countPage = countPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getPreCount() {
		return preCount;
	}

	public void setPreCount(int preCount) {
		this.preCount = preCount;
	}

	/**
     * 페이징 생성
     */
    private void makePaging() {
    	// 총 게시물 수가 없는 경우
    	if(this.totalCount == 0) {
    		return;
    	}
    	
    	// 총 페이지 수
    	totalPage = this.totalCount / this.countList;
    	if(this.totalCount % this.countList > 0) {
    		totalPage++;
    	}
    	this.setTotalPage(totalPage);
    	
    	// 시작 페이지
    	startPage = ((this.prePage - 1) / this.countPage) * this.countPage + 1;
    	
    	// 종료 페이지
    	endPage = this.startPage + this.countPage - 1;
    	if(endPage > this.totalPage) {
    		endPage = this.totalPage;
    	}
    	
    	// 현재 페이지 유효성 체크
    	if(this.prePage < 0 || this.prePage > this.endPage) {
    		this.prePage = 1;
    	}
 
    	this.prev = prePage == 1 ? false : true;
    	this.next = prePage == endPage ? false: true;
    	
    	this.setStartPage(startPage);
    	this.setEndPage(endPage);
    	
    	// 출력될 게시물 기준
    	if(this.prePage == 1) {
    		preCount = 0;
    	} else {
    		preCount = (this.prePage - 1) * 10;
    	}
    	
    	this.setPreCount(preCount);
 
    }
}
