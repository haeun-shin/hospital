package hospital;

// VO Ŭ����
public class Hospital {
	private String hos_name;  	// ������
	private String hos_tel;  	// ��ȭ��ȣ
	private String hos_addr;  	// �ּ�
	private double hos_lat;  	// ����
	private double hos_lng;  	// �浵
	private String hos_part; 	// ��ǥ��
	private String hos_class; 	// �����
	private double hos_distance;	// �Ÿ�
	private String hos_star;	// ����
	private String badge_ser;	// ���� - ����
	private String badge_abi;	// ���� - �Ƿ�
	private String badge_con;	// ���� - ���
	
	
	
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
		// 500m�� 0.5�� ǥ���Ǳ� ������ 500.00���� ǥ���ǰ� ��.
		this.hos_distance = (Math.round((hos_distance * 1000)*100)/100.0);
	}
	
	
}
