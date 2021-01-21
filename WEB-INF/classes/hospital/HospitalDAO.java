package hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



// DAO Ŭ����
public class HospitalDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt_result = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1:3306/hospital_project?useUnicode=yes&characterEncoding=UTF-8";

	// DB ���� �޼���
	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "jspbook", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// DB ���� ���� �޼���
	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 

		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
	}
	
	
	// �˻��� ó���� �޼ҵ�
	public ArrayList<Hospital> getSearchList(String search, String lat, String lng) {
		
		connect();
		
		ArrayList<Hospital> datas = new ArrayList<Hospital>();
		
		// result ���̺��� ����ִ� �� Ȯ��
		try {
			pstmt_result = conn.prepareStatement("select * from result where r_id=1;");
			ResultSet rs = pstmt_result.executeQuery();
			
			Hospital hospital = new Hospital();
			rs.next();
			hospital.setHos_name(rs.getString("result.r_name"));
			
			// ���� null�� �ƴ϶��
			if(hospital.getHos_name() != null) {
				pstmt = conn.prepareStatement("TRUNCATE TABLE result;");
				// SQL�� ���� (result ���̺� ����)
				pstmt.executeUpdate();	
			}
			
			if(rs != null) rs.close();		
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		

		
		if(pstmt != null) {
			pstmt = null;
		}
		// 1�� �˻� : virus ���̺� �˻�
		if (virusSearch(search, lat, lng)) {
			try {
				
				// result ���̺� �˻�
				pstmt_result = conn.prepareStatement("select * from result order by r_distance asc ");
				
				ResultSet rs = pstmt_result.executeQuery();

				
				// ����� ����Ʈ�� ����
				while(rs.next()) {
					Hospital hospital = new Hospital();
					
					hospital.setHos_name(rs.getString("result.r_name"));
					hospital.setHos_addr(rs.getString("result.r_addr"));
					hospital.setHos_tel(rs.getString("result.r_tel"));
					hospital.setHos_lat(rs.getDouble("result.r_lat"));
					hospital.setHos_lng(rs.getDouble("result.r_lng"));				
					hospital.setHos_part(rs.getString("result.r_part"));
					hospital.setHos_class(rs.getString("result.r_class"));
					hospital.setHos_distance(rs.getDouble("result.r_distance"));
					hospital.setHos_star(rs.getString("result.r_star"));
					hospital.setBadge_ser(rs.getString("result.badge_ser"));
					hospital.setBadge_abi(rs.getString("result.badge_abi"));
					hospital.setBadge_con(rs.getString("result.badge_con"));
					
					datas.add(hospital);
				}
				
				
				if(rs != null) rs.close();		
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
		} 
		
		
		
		
		// ���� 1�� �˻��� ����� ���� ���
		if(datas == null || datas.size() == 0) {
			// 2�� �˻� : question ���̺� �˻�
			if(questionSearch(search, lat, lng)) {
				try {
					// result ���̺� �˻�
					pstmt_result = conn.prepareStatement("select * from result order by r_distance asc ");
					ResultSet rs = pstmt_result.executeQuery();
					
					// ����� ����Ʈ�� ����
					while(rs.next()) {
						Hospital hospital = new Hospital();
						
						hospital.setHos_name(rs.getString("result.r_name"));
						hospital.setHos_addr(rs.getString("result.r_addr"));
						hospital.setHos_tel(rs.getString("result.r_tel"));
						hospital.setHos_lat(rs.getDouble("result.r_lat"));
						hospital.setHos_lng(rs.getDouble("result.r_lng"));				
						hospital.setHos_part(rs.getString("result.r_part"));
						hospital.setHos_class(rs.getString("result.r_class"));
						hospital.setHos_distance(rs.getDouble("result.r_distance"));
						hospital.setHos_star(rs.getString("result.r_star"));
						hospital.setBadge_ser(rs.getString("result.badge_ser"));
						hospital.setBadge_abi(rs.getString("result.badge_abi"));
						hospital.setBadge_con(rs.getString("result.badge_con"));
						
						datas.add(hospital);
					}
					
					if(rs != null) rs.close();		
					
				} catch(SQLException e) {
					e.printStackTrace();
				}					
			}
		}				
		
		// Connection�� PreparedStatement ���� ����
		disconnect();
		
		return datas;
	}
	
	
	// 2�� �˻� : ����� ������ ��ġ. 1������ �˻��� ���� ������ �����.
	public boolean questionSearch(String search, String lat, String lng){
		PreparedStatement pstmt = null;
		
		// hos_part(�з��� ��)�� �����ϴ� ���	
		// SQL���� ���� ����
		StringBuffer sql_question = new StringBuffer();
		
		// ** 1 : lat, 2 : lng, 3 : lat
		sql_question.append("insert into result( ")
				   .append("select @id, notnull_hos_part.* ")
		           .append("from (select hospital.*, (6371*acos(cos(radians(?))*cos(radians(hos_lat))")
		           .append("*cos(radians(hos_lng)-radians(?))+sin(radians(?))")
		           .append("*sin(radians(hos_lat)))) AS hos_distance ");
		sql_question.append("from hospital, (select q_part, max(counted) ")
		           .append("from ( select q_part, count(q_part) as counted ")
		           .append("from question where ");
		
		if(search.length() > 2) {
			for(int i=0; i<search.length(); i++) {
			    // ù ��° ���ڸ� �����ϰ� �տ� <and>�� �ٿ���
				if(i == 0) {
					sql_question.append("q_question like '%" + search.charAt(i) + "%' ");
				} else {
					sql_question.append("and q_question like '%" + search.charAt(i) + "%' ");
				}
			}			
		} else {
			sql_question.append("q_question like '%" + search + "%' ");
		}
	
		sql_question.append("group by q_part ")
				   .append("order by count(q_part) desc) as counts) as max_counted ")
				   .append("where hos_part in (max_counted.q_part) ")
				   .append("having hos_distance <=10.0 ")
				   .append("order by hos_distance asc) as notnull_hos_part);");
		
		try {
			pstmt = conn.prepareStatement(sql_question.toString());
			
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			pstmt.setString(3, lat);	
			
			// SQL�� ���� (result ���̺� ����)
			pstmt.executeUpdate();			

		} catch(SQLException e) {
			e.printStackTrace();
		} 		
		
		

		// hos_part(�з��� ��)�� �������� �ʴ� ���
		// SQL���� ���� ����
		StringBuffer sql_question_not = new StringBuffer();
		
		// ** 1 : lat, 2 : lng, 3 : lat
		sql_question_not.append("insert into result( ")
					   .append("select @id, null_hos_part.* ")
		               .append("from (select hospital.*, (6371*acos(cos(radians(?))*cos(radians(hos_lat))")
		               .append("*cos(radians(hos_lng)-radians(?))+sin(radians(?))")
		               .append("*sin(radians(hos_lat)))) AS hos_distance ");
		sql_question_not.append("from hospital, (select q_part, max(counted) ")
		               .append("from ( select q_part, count(q_part) as counted ")
		               .append("from question where ");
		
		if(search.length() > 2) {
			for(int i=0; i<search.length(); i++) {
			    // ù ��° ���ڸ� �����ϰ� �տ� <and>�� �ٿ���
				if(i == 0) {
					sql_question_not.append("q_question like '%" + search.charAt(i) + "%' ");
				} else {
					sql_question_not.append("and q_question like '%" + search.charAt(i) + "%' ");
				}
			}				
		} else {
			sql_question_not.append("q_question like '%" + search + "%' ");
		}

		sql_question_not.append("group by q_part ")
				       .append("order by count(q_part) desc) as counts) as max_counted ")
				       .append("where hos_part in (' ') ")
				       .append("and hos_class like concat('%',' ',max_counted.q_part,'%') ")
				       .append("having hos_distance <=10.0 ")
				       .append("order by hos_distance asc) as null_hos_part);");			
		
		try {
			pstmt = null;
			pstmt = conn.prepareStatement(sql_question_not.toString());
			
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			pstmt.setString(3, lat);	
			
			// SQL�� ���� (result ���̺� ����)
			pstmt.executeUpdate();		

		} catch(SQLException e) {
			e.printStackTrace();
		}					

		return true;
	}	
	
	// 1�� �˻� : ��Ȯ�� ���̷�����
	public boolean virusSearch(String search, String lat, String lng) {
		PreparedStatement pstmt = null;

		// hos_part(�з��� ��)�� �����ϴ� ���	
		// SQL���� ���� ����
		StringBuffer sql_virus = new StringBuffer();
		
		// ** 1 : lat, 2 : lng, 3 : lat
		sql_virus.append("insert into result ( ")
				   .append("select @id, notnull_hos_part.* ")
		           .append("from (select hospital.*, (6371*acos(cos(radians(@lat))*cos(radians(hos_lat))")
		           .append("*cos(radians(hos_lng)-radians(@lng))+sin(radians(@lat))")
		           .append("*sin(radians(hos_lat)))) AS hos_distance ");
		sql_virus.append("from hospital,(select v_part ")
		           .append("from virus where ");
		
		if(search.length() > 2) {
			for(int i=0; i<search.length(); i++) {
			    // ù ��° ���ڸ� �����ϰ� �տ� <and>�� �ٿ���
				if(i == 0) {
					sql_virus.append("v_virus like '%" + search.charAt(i) + "%' ");
				} else {
					sql_virus.append("and v_virus like '%" + search.charAt(i) + "%' ");
				}
			}				
		} else {
			sql_virus.append("v_virus like '%" + search + "%' ");
		}

		sql_virus.append("group by v_part) as v_result  ")
				   .append("where hos_part in (v_result.v_part) ")
				   .append("having hos_distance <=10.0 ")
				   .append("order by hos_distance asc) as notnull_hos_part);");
		
		try {
			pstmt = conn.prepareStatement(sql_virus.toString());
			
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			pstmt.setString(3, lat);	
			
			// SQL�� ���� (result ���̺� ����)
			pstmt.executeUpdate();	

		} catch(SQLException e) {
			e.printStackTrace();
		} 		
		
		

		// hos_part(�з��� ��)�� �������� �ʴ� ���
		// SQL���� ���� ����
		StringBuffer sql_virus_not = new StringBuffer();
		
		// ** 1 : lat, 2 : lng, 3 : lat
		sql_virus_not.append("insert into result ( ")
				   .append("select @id, null_hos_part.* ")
		           .append("from (select hospital.*, (6371*acos(cos(radians(@lat))*cos(radians(hos_lat))")
		           .append("*cos(radians(hos_lng)-radians(@lng))+sin(radians(@lat))")
		           .append("*sin(radians(hos_lat)))) AS hos_distance ");
		sql_virus_not.append("from hospital, (select v_part ")
		           .append("from virus where ");
		
		if(search.length() > 2) {
			for(int i=0; i<search.length(); i++) {
			    // ù ��° ���ڸ� �����ϰ� �տ� <and>�� �ٿ���
				if(i == 0) {
					sql_virus_not.append("v_virus like '%" + search.charAt(i) + "%' ");
				} else {
					sql_virus_not.append("and v_virus like '%" + search.charAt(i) + "%' ");
				}
			}				
		} else {
			sql_virus_not.append("v_virus like '%" + search + "%' ");
		}
		sql_virus_not.append("group by v_part) as v_result  ")
				       .append("where hos_part in (' ') ")
				       .append("and  hos_part in (' ') ")
				       .append("and hos_class like concat('%',' ',v_result.v_part,'%') ")
				       .append("having hos_distance <=10.0 ")
				       .append("order by hos_distance asc) as null_hos_part);");
		
		try {
			pstmt = null;
			pstmt = conn.prepareStatement(sql_virus_not.toString());
			
			pstmt.setString(1, lat);
			pstmt.setString(2, lng);
			pstmt.setString(3, lat);	
			
			// SQL�� ���� (result ���̺� ����)
			pstmt.executeUpdate();	

		} catch(SQLException e) {
			e.printStackTrace();
		}					

		return true;
	}
	
	// �˻��� ������ ����
		public int getTotalCount() {
			connect();
			
			int totalCount = 0;
			
			// result ���̺��� ����ִ� �� Ȯ��
			try {
				pstmt_result = conn.prepareStatement("select count(*) as totalCount from result");
				ResultSet rs = pstmt_result.executeQuery();
				
				if(rs.next()) {
					totalCount = rs.getInt("totalCount");
				}
				
				if(rs != null) rs.close();		
				
			} catch(SQLException e) {
				e.printStackTrace();
			}		
			
			return totalCount;
		}
		
		// ����¡ ó��
		public ArrayList<Hospital> getTotalList(int page) {
			
		connect();
		
		ArrayList<Hospital> datas = new ArrayList<Hospital>();
		
		try {
			pstmt_result = conn.prepareStatement("select * from result order by r_distance asc limit ?,10");
			pstmt_result.setInt(1, page);
			ResultSet rs = pstmt_result.executeQuery();
			
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				hospital.setHos_name(rs.getString("result.r_name"));
				hospital.setHos_addr(rs.getString("result.r_addr"));
				hospital.setHos_tel(rs.getString("result.r_tel"));
				hospital.setHos_lat(rs.getDouble("result.r_lat"));
				hospital.setHos_lng(rs.getDouble("result.r_lng"));				
				hospital.setHos_part(rs.getString("result.r_part"));
				hospital.setHos_class(rs.getString("result.r_class"));
				hospital.setHos_distance(rs.getDouble("result.r_distance"));
				hospital.setHos_star(rs.getString("result.r_star"));
				hospital.setBadge_ser(rs.getString("result.badge_ser"));
				hospital.setBadge_abi(rs.getString("result.badge_abi"));
				hospital.setBadge_con(rs.getString("result.badge_con"));
				
				datas.add(hospital);
			}
			
			if(rs != null) rs.close();		
			if(pstmt != null) pstmt.close();
			
		} catch(SQLException e) {
			e.printStackTrace();
		}					

		// Connection�� PreparedStatement ���� ����
		disconnect();
		
		return datas;
	}
}
