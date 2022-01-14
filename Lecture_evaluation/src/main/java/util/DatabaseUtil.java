package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	public static Connection getConnection() { //static을 사용하여 userDAO.java에서 함수 바로사용
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TUTORIAL";// 우리 컴퓨터 안에 깔린 3306 포트를 사용하는 TUTORIAL이라는 mysql DB에
			String dbID = "root"; //이 ID로 접속
			String dbPassword = "login1323!"; //이 PW로 접속
			Class.forName("com.mysql.jdbc.Driver");

			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
