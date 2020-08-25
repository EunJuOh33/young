package com.user.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.user.bean.UserBean;


/* 데이터베이스에 접근해서 작업하는 부분만 정의한 클래스 */
public class UserDAO {
	/* 필드 */
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public Connection getConnect(){
		String dbURL="jdbc:mysql://118.131.179.138:3306/embed1_young?serverTimezone=UTC&useSSL=false";
		String dbID="emb1young";
		String dbPW="emb1young";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPW);
			conn.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
			return conn;
	}
	
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	
	private void close() {
	    try {
	        if ( pstmt != null ) { 
	        	pstmt.close(); 
	        	pstmt=null; 
	        }
	        if ( conn != null ) { 
	        	conn.close(); 
	        	conn=null;    
	        }
	        if ( rs != null ) { 
	        	rs.close(); 
	        	rs=null;    
	        } 
	    } catch (Exception e) {
	        throw new RuntimeException(e.getMessage());
	    }
	}
	
	
	/* 생성자 */
	// private으로 외부에서 사용 못하게 막았다.
	private static UserDAO instance;
	
	public static UserDAO getInstance(){
		if(instance==null)
			instance=new UserDAO();
		return instance;
	}
	

	
	/* 회원가입 - sql 테이블에 정보를 입력한다. */
	public int insertUser(UserBean bean) {
		int insertCount = 0;
		
		try {
			conn=getConnect();
			String sql = "INSERT INTO login VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";	// 11개
			pstmt = conn.prepareStatement(sql);	// sql문을 전송할 수 있는 PreparedStatement객체를 생성한다.
			
			pstmt.setString(1, bean.getUser_id());	// setString메소드: (물음표 순서대로 첫 번째, User_id의 값을 넣는다.)
			pstmt.setString(2, bean.getUser_pw());	// get메소드는 private 변수를 외부로 리턴
			pstmt.setString(3, bean.getUser_name());	
			pstmt.setInt(4, bean.getUser_birth());
			pstmt.setString(5, bean.getUser_phone());
			pstmt.setString(6, bean.getUser_email());
			pstmt.setInt(7, bean.getUser_zip());
			pstmt.setString(8, bean.getUser_addr());
			pstmt.setString(9, bean.getUser_gender());
			pstmt.setString(10, bean.getSelect_p());
			pstmt.setString(11, bean.getRcv_agree());
			
			insertCount = pstmt.executeUpdate();
			// executeUpdate()의 반환 값은 해당 SQL 문 실행에 영향을 받는 행 수를 반환. 아마 여기서는 1이 반환될 것
			// creat, drop, alert인 경우 0을 반환.
			
			try {
				if(insertCount > 0) {
					conn.commit();
				
			}
				} catch (Exception e) {
					conn.rollback();
			} 
		} catch (SQLException e) {
			e.printStackTrace();
			// 여기서 예외가 생기는 경우는 여러가지가 있다.
			// 데이터베이스에 설정한 데이터 형과 전송하는 데이터 형이 다르거나, 데이터베이스에 설정한 데이터의 글자 수와 전송하는 글자 수가 다르거나..
		} finally {
			close();
		}
		
		return insertCount;
	}
	
	
	
	/* 아이디 중복 체크 */
	public int selectIdDupChk(String dupId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnect();
			
			String sql = "SELECT * FROM login WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dupId);	// 물음표 안에 괄호 안으로 들어온 매개변수를 넣는다.
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 있다면
				return 0; // 이미 존재하는 아이디
			} else {
				return 1; // 가입 가능한 아이디
			}
			
		} catch(Exception e) {
			System.out.println("중복체크 dao에서 " + e);
		} finally {
			close();

		}
		
		return -1;	// 데이터베이스 오류
	}
	

	/* 로그인 아이디 */
	public String selectLoginId(UserBean bean) {
		String loginId = null;
		
		try {
			conn=getConnect();
			
			String sql = "SELECT user_id FROM login WHERE user_id=? AND user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getUser_pw());
			
			rs = pstmt.executeQuery();
			// ResultSet인터페이스 : select문을 executeQuery() 메소드로 실행한 후, 반환되는 레코드 셋을 저장한다.
			// 레코드 셋은 가상의 데이터베이스 테이블 형태이다.
			// select구문을 수행할 때 사용한다.
			
			if(rs.next()) {
				loginId = rs.getString("user_id");	// db의 컬럼 명
			}
			/*
			 * 모든 데이터를 한번에 가져올 수 없기 때문에 cursor의 개념을 가지고 있다.
			 * 커서(cursor)란 ResultSet 객체가 가져올 수 있는 행의 위치를 지정해 준다.
			 * 처음 커서의 위치는 결과물(필드)에 위치하지 않기 때문에 cursor를 이동해야 한다.
			 * 커서를 이동하는 역할을 ResultSet의 next()메서드가 수행한다.
			 * next()메서드 : 리턴 타입은 boolean, 다음 행의 결과물이 있으면 true, 없으면 false리턴 
			 * if(true)는 구문 실행, if(false)는 실행하지 않는다.
			 */
			
			try {
				if(loginId!=null) {
					conn.commit();
				}
			} catch (Exception e) {
				conn.rollback();
			}			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();

		}
		
		return loginId;
	}

	
	/* 회원 목록 */
	public ArrayList<UserBean> selectUserList() {
		String sql = "SELECT * FROM login";
		ArrayList<UserBean> userList = new ArrayList<UserBean>();
		UserBean bean = null;
		
		try {
			conn=getConnect();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					bean = new UserBean();
					
					bean.setUser_id(rs.getString("user_id"));	// sql은 대소문자 가리지 않는다.
					bean.setUser_pw(rs.getString("user_pw"));
					bean.setUser_name(rs.getString("user_name"));
					bean.setUser_birth(rs.getInt("user_birth"));
					bean.setUser_phone(rs.getString("user_phone"));
					bean.setUser_email(rs.getString("user_email"));
					bean.setUser_zip(rs.getInt("user_zip"));
					bean.setUser_addr(rs.getString("user_addr"));
					bean.setUser_gender(rs.getString("user_gender"));
					bean.setSelect_p(rs.getString("select_p"));
					bean.setRcv_agree(rs.getString("rcv_agree"));
					
					userList.add(bean);
				} while(rs.next());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();

		}
		
		return userList;
	}


	/* 회원정보 뷰 페이지에 회원 정보를 보여준다. */
	public UserBean selectUser(String viewId) {
		String sql = "SELECT * FROM login WHERE user_id=?";
		UserBean bean = null;
		
		try {
			
			conn=getConnect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, viewId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new UserBean();
				
				bean.setUser_id(rs.getString("user_id"));
				bean.setUser_pw(rs.getString("user_pw"));
				bean.setUser_name(rs.getString("user_name"));
				bean.setUser_birth(rs.getInt("user_birth"));
				bean.setUser_phone(rs.getString("user_phone"));
				bean.setUser_email(rs.getString("user_email"));
				bean.setUser_zip(rs.getInt("user_zip"));
				bean.setUser_addr(rs.getString("user_addr"));
				bean.setUser_gender(rs.getString("user_gender"));
				bean.setSelect_p(rs.getString("select_p"));
				bean.setRcv_agree(rs.getString("rcv_agree"));
				
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return bean;
	}
	
	
	/* 회원 삭제*/
	public int deleteUser(String deleteId) {
		int deleteCount = 0;
		
		try {
			conn=getConnect();
			
			String sql = "DELETE FROM login WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, deleteId);
			deleteCount = pstmt.executeUpdate();
		
			try {
				if(deleteCount>0) {
					conn.commit();
				}
			} catch (Exception e) {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return deleteCount;
	}

	
	/* 패스워드 체크 */
	public String selectLoginPw(String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String checkPw = null;
		
		try {
			conn = getConnect();
			
			String sql = "SELECT user_pw FROM login WHERE user_id=?";	// 아이디가 물음표('?')일 때, 해당 패스워드를 select한다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);	// sql구문의 물음표 부분에 해당 변수를 대입한다.
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				checkPw = rs.getString("user_pw");	// checkPw에 loginId의 패스워드가 저장된다.
				// System.out.println("checkPw 확인 : " + checkPw);
			}
			/*
			 * next()메서드 : 리턴 타입은 boolean, 다음 행의 결과물이 있으면 true, 없으면 false리턴 
			 * if(true)는 구문 실행, if(false)는 실행하지 않는다.
			 */
			
			try {
				if(checkPw != null) {
					return checkPw;
				}
			} catch (Exception e) {
				System.out.println("아마 checkPw가 null에러 : " + e);
			}			
			
		} catch(Exception e) {
			System.out.println("패스워드 체크 dao에서 에러 : " + e);
		} finally {
			close();

		}
		
		return checkPw;
	}
	
	
	/* 회원정보 수정 */
	public int modifUser(UserBean bean) {
		int modifCount = 0;
		
		try {
			conn = getConnect();
			String sql = "UPDATE login SET user_name=?, user_phone=?, user_email=?, user_zip=?, user_addr=?, user_gender=?, select_p=?, rcv_agree=? WHERE user_id=?;";	// 8개
			pstmt = conn.prepareStatement(sql);	// sql문을 전송할 수 있는 PreparedStatement객체를 생성한다.
				
			pstmt.setString(1, bean.getUser_name());	// setString메소드: (물음표 순서대로 첫 번째, 넣으려는 값)			
			pstmt.setString(2, bean.getUser_phone());	// get메소드는 private 변수를 외부로 리턴
			pstmt.setString(3, bean.getUser_email());
			pstmt.setInt(4, bean.getUser_zip());
			pstmt.setString(5, bean.getUser_addr());
			pstmt.setString(6, bean.getUser_gender());
			pstmt.setString(7, bean.getSelect_p());
			pstmt.setString(8, bean.getRcv_agree());
			pstmt.setString(9, bean.getUser_id());
			
			modifCount = pstmt.executeUpdate();
			// executeUpdate()의 반환 값은 해당 SQL 문 실행에 영향을 받는 행 수를 반환. 아마 여기서는 1이 반환될 것
			// creat, drop, alert인 경우 0을 반환.
			
			try {
				if(modifCount > 0) {
					conn.commit();				
				}
			} catch (Exception e) {
					conn.rollback();
			} 
		
		} catch (SQLException e) {
			e.printStackTrace();
			// 여기서 예외가 생기는 경우는 여러가지가 있다.
			// 데이터베이스에 설정한 데이터 형과 전송하는 데이터 형이 다르거나, 데이터베이스에 설정한 데이터의 글자 수와 전송하는 글자 수가 다르거나..
		} finally {
			close();
		}
		
		return modifCount;
	}
}
