package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil { // �����ͺ��̽��� ���� 
   public static Connection getConnection() { //static�� ����Ͽ� userDAO.java���� �Լ� �ٷλ��
      try {
         String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";// �츮 ��ǻ�� �ȿ� �� 3306 ��Ʈ�� ����ϴ� TUTORIAL�̶�� mysql DB��
         String dbID = "root"; // ������ ID
         String dbPassword = "login1323!"; // ������ ��й�ȣ 
         Class.forName("com.mysql.cj.jdbc.Driver"); //DriverManager�� ���

         return DriverManager.getConnection(dbURL, dbID, dbPassword);
      } catch (Exception e) {
    	  System.out.println("����");
         e.printStackTrace();
      }
      return null;
   }
}

