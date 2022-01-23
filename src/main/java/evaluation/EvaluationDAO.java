package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.UserDTO;
import util.DatabaseUtil;

public class EvaluationDAO {
	public void disconnect(Connection conn, ResultSet rs, PreparedStatement pstmt) { // db 연결 해제
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int write(EvaluationDTO evaluationDTO) { // 강의정보 1개 기록
		String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			//크로스사이트 공격 방지 
			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(2, evaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(3, evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(6, evaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(10, evaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(11, evaluationDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(12, evaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect(conn, rs, pstmt);
			// 데이터 베이스에 접근한 후 자원 해제
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber) {
	if(lectureDivide.equals("전체")) {
		lectureDivide = "";	
	}
	ArrayList<EvaluationDTO> evaluationList =null; //강의평가글을 담는 리스트
	String SQL = "";
    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement pstmt =null;
    try {
    	if(searchType.equals("최신순")) {
    		SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
    	}
    	else if (searchType.equals("추천순")) {
    		SQL = "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT(lectureName, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;

    	}
       conn = DatabaseUtil.getConnection();
       pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
       pstmt.setString(1, "%" + lectureDivide + "%"); // ? 내용 채우는 항목 1
       pstmt.setString(2, "%" + search + "%");
       rs = pstmt.executeQuery();  // executeQuery : 데이터베이스 검색 결과 확인 
       evaluationList = new ArrayList<EvaluationDTO>();
       while(rs.next()) {
    	   EvaluationDTO evaluation = new EvaluationDTO (
    			   rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getInt(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11),
					rs.getString(12),
					rs.getString(13),
					rs.getInt(14)
    			);
    	   evaluationList.add(evaluation);
       }
    } catch (Exception e) {
       e.printStackTrace();
    } finally {
       disconnect(conn,rs,pstmt);
       //데이터 베이스에 접근한 후 자원 해제 
    }
    return evaluationList; 
 }
	public int like(String evaluationID) {
	      String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID=? ";
	      ResultSet rs = null;
	      Connection conn = null;
	      PreparedStatement pstmt =null;
	      try {
	         conn = DatabaseUtil.getConnection();
	         pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
	         pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? 내용 채우는 항목 1
	         return pstmt.executeUpdate();

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         disconnect(conn,rs,pstmt);
	      }
	      return -1; // 데이터베이스 오류 
	}
	
	public int delete(String evaluationID) {
	      String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
	      ResultSet rs = null;
	      Connection conn = null;
	      PreparedStatement pstmt =null;
	      try {
	         conn = DatabaseUtil.getConnection();
	         pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
	         pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? 내용 채우는 항목 1
	         return pstmt.executeUpdate();

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         disconnect(conn,rs,pstmt);
	      }
	      return -1; // 데이터베이스 오류 
	}
	
	public String getUserID(String evaluationID) {
	      String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?;";
	      ResultSet rs = null;
	      Connection conn = null;
	      PreparedStatement pstmt =null;
	      try {
	         conn = DatabaseUtil.getConnection();
	         pstmt = conn.prepareStatement(SQL);// sql에서 중복코드 문제 방지
	         pstmt.setInt(1, Integer.parseInt(evaluationID)); // ? 내용 채우는 항목 1
	         rs = pstmt.executeQuery();
	         if(rs.next()) { //결과 존재 
	            return rs.getString(1); // userEmailChecked 의 값 반환 
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         disconnect(conn,rs,pstmt);
	      }
	      return null; // 데이터베이스 오류 
	}
	
}