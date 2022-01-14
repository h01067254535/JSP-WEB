package user;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DatabaseUtil;

//DAO �� JSP���� �ϳ��� ������ ������ ��� ���� ��ü
public class UserDAO {
	public int join(String userID, String userPassword) {
		String SQL = "INSERT INTO USER VALUES (?, ?)";
		try {
			Connection conn = DatabaseUtil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL); // format ���� ���� 
			pstmt.setString(1,  userID); // ? ���� ä��� �׸� 1
			pstmt.setString(2, userPassword); // 2
			return pstmt.executeUpdate(); // ���� �������� ���� ��ȯ 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
