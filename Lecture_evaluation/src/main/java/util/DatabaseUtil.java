package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	public static Connection getConnection() { //static�� ����Ͽ� userDAO.java���� �Լ� �ٷλ��
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL";// �츮 ��ǻ�� �ȿ� �� 3306 ��Ʈ�� ����ϴ� TUTORIAL�̶�� mysql DB��
			String dbID = "root"; //�� ID�� ����
			String dbPassword = "login1323!"; //�� PW�� ����
			Class.forName("com.mysql.jdbc.Driver");

			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
