package hospital;

// VO 클래스
public class Hospital {
	private String hos_name;  	// 사업장명
	private String hos_tel;  	// 전화번호
	private String hos_addr;  	// 주소
	private double hos_lat;  	// 위도
	private double hos_lng;  	// 경도
	private String hos_part; 	// 대표과
	private String hos_class; 	// 진료과
	private double hos_distance;	// 거리
	private String hos_star;	// 별점
	private String badge_ser;	// 배찌 - 서비스
	private String badge_abi;	// 배찌 - 실력
	private String badge_con;	// 배찌 - 양심
	
	
	
	public String getHos_star() {
		return hos_star;
	}
	public void setHos_star(String hos_star) {
		this.hos_star = hos_star;
	}
	public String getBadge_ser() {
		return badge_ser;
	}
	public void setBadge_ser(String badge_ser) {
		this.badge_ser = badge_ser;
	}
	public String getBadge_abi() {
		return badge_abi;
	}
	public void setBadge_abi(String badge_abi) {
		this.badge_abi = badge_abi;
	}
	public String getBadge_con() {
		return badge_con;
	}
	public void setBadge_con(String badge_con) {
		this.badge_con = badge_con;
	}
	public String getHos_name() {
		return hos_name;
	}
	public void setHos_name(String hos_name) {
		this.hos_name = hos_name;
	}
	public String getHos_tel() {
		return hos_tel;
	}
	public void setHos_tel(String hos_tel) {
		this.hos_tel = hos_tel;
	}
	public String getHos_addr() {
		return hos_addr;
	}
	public void setHos_addr(String hos_addr) {
		this.hos_addr = hos_addr;
	}
	public double getHos_lat() {
		return hos_lat;
	}
	public void setHos_lat(double hos_lat) {
		this.hos_lat = hos_lat;
	}
	public double getHos_lng() {
		return hos_lng;
	}
	public void setHos_lng(double hos_lng) {
		this.hos_lng = hos_lng;
	}
	public String getHos_part() {
		return hos_part;
	}
	public void setHos_part(String hos_part) {
		this.hos_part = hos_part;
	}
	public String getHos_class() {
		return hos_class;
	}
	public void setHos_class(String hos_class) {
		this.hos_class = hos_class;
	}
	public double getHos_distance() {
		return hos_distance;
	}
	public void setHos_distance(double hos_distance) {
		// 500m가 0.5로 표현되기 때문에 500.00으로 표현되게 함.
		this.hos_distance = (Math.round((hos_distance * 1000)*100)/100.0);
	}
	
	
}
