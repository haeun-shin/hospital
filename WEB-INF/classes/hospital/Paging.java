package hospital;

public class Paging {
	// ���� ������
	private int prePage;
	
	// ���� ���� �Խù�
	private int preCount;
	
	// �� ������ [1][2][3][4][5]... 
	private int totalPage;
	
	// �� �Խù�
	private int totalCount;
	
	// �� �������� ��µ� �Խù� ��
	private int countList = 10;
	
	// �� ȭ�鿡 ��µ� ������ �� [1][2][3][4][5]
	private int countPage = 5;
	
	// ���� ������ [��][2][3][4][5]
	private int startPage;
	
	// ���� ������ [1][2][3][4][��]
	private int endPage;

	// ���� ���� ��ư
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
	
	// totalCount�� ȣ���ؾ� paging�� �����ϱ� ������
	// �̰� ȣ���ϸ� paging() �޼ҵ带 ȣ���ϵ��� ����
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
     * ����¡ ����
     */
    private void makePaging() {
    	// �� �Խù� ���� ���� ���
    	if(this.totalCount == 0) {
    		return;
    	}
    	
    	// �� ������ ��
    	totalPage = this.totalCount / this.countList;
    	if(this.totalCount % this.countList > 0) {
    		totalPage++;
    	}
    	this.setTotalPage(totalPage);
    	
    	// ���� ������
    	startPage = ((this.prePage - 1) / this.countPage) * this.countPage + 1;
    	
    	// ���� ������
    	endPage = this.startPage + this.countPage - 1;
    	if(endPage > this.totalPage) {
    		endPage = this.totalPage;
    	}
    	
    	// ���� ������ ��ȿ�� üũ
    	if(this.prePage < 0 || this.prePage > this.endPage) {
    		this.prePage = 1;
    	}
 
    	this.prev = prePage == 1 ? false : true;
    	this.next = prePage == endPage ? false: true;
    	
    	this.setStartPage(startPage);
    	this.setEndPage(endPage);
    	
    	// ��µ� �Խù� ����
    	if(this.prePage == 1) {
    		preCount = 0;
    	} else {
    		preCount = (this.prePage - 1) * 10;
    	}
    	
    	this.setPreCount(preCount);
 
    }
}
