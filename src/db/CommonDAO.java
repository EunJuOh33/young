package db;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommonDAO {
	public static Connection getConnection() {
		Connection con = null;

		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/emb1young");
			con = ds.getConnection();
			con.setAutoCommit(false);
			System.out.println("success");
		} catch (Exception e) {
			System.out.println("sql연결에서 " + e );
		}

		return con;
	}
		 
	
	
		//접속을 종료하기위한 closeConnection 메소드를 구현합니다.
		public static void close(Connection con) {
			try {
				if(con != null) {
					con.close();		
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		public static void close(Statement stmt) {
			try {
				if(stmt != null) {
				stmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		public static void close(PreparedStatement pstmt) {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		public static void close(ResultSet rs) {
			try {
				if(rs != null) {
					rs.close();
				}	
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		public static void commit(Connection con) {
			try {
				con.commit();
				System.out.println("commit success");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		public static void rollback(Connection con) {
			try {
				con.rollback();
				System.out.println("rollback success");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		}
