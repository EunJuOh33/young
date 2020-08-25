package com.shop.dao;
import java.sql.*;
import java.util.ArrayList;

import com.board.bean.BbsBean;
import com.shop.bean.Order;
import com.shop.bean.Prd;

public class PrdDAO {
	
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
	
	
	private void close(){
	    try {
	        if ( pstmt != null )
	        { pstmt.close(); pstmt=null; }
	        if ( conn != null )
	        { conn.close(); conn=null;    }
	        if ( rs != null )
	        { rs.close(); rs=null;    }
	      
	    } catch (Exception e) {
	        throw new RuntimeException(e.getMessage());
	    }

	}
	
	private static PrdDAO instance;
	
	public static PrdDAO getInstance() {
		if(instance == null) {
			instance = new PrdDAO();
		}
		return instance;
	}

	
	
	
	public ArrayList<Prd> selectPrdList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Prd> prdList = null;
		
		try {
			conn=getConnect();
			pstmt = conn.prepareStatement("SELECT * FROM product");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				prdList = new ArrayList<Prd>();
				
				do {
					prdList.add(new Prd(
							rs.getInt("id"),
							rs.getString("name"),
							rs.getInt("price"),
							rs.getString("image"),
							rs.getString("content")));
				} while(rs.next());
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return prdList;
	}

	public Prd selectPrd(int id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Prd prd = null;
		
		try {
			conn=getConnect();
			
			pstmt = conn.prepareStatement("SELECT * FROM embed1_young.product where id=?");
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			prd = new Prd(
					rs.getInt("id"),
					rs.getString("name"),
					rs.getInt("price"),
					rs.getString("image"),
					rs.getString("content"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return prd;
	}
	
	
	
	// 주문내역 넣기 
	public boolean insertOrder(Order order) {
		boolean result = false;
		int insert=0;
		try {
	
			conn = getConnect();
			
			String sql = "insert into embed1_young.order values (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setString(2, order.getOrder_id());
			pstmt.setString(3, order.getOrder_name());
			pstmt.setString(4, order.getOrder_addr());
			
			insert = pstmt.executeUpdate();
			if(insert>0) {
				result=true;
				conn.commit();
			}
		} catch(Exception e) {
			try {
				System.out.println("insertOrder에" + e);
				conn.rollback();
			} catch (SQLException e2) {
				System.out.println("insertOrder sql 에" + e2);
			}
		} 
		close();
		return result;
	}

	
	
	
	//주문내역 목록으로 보기.
	public ArrayList<Order> getOrderList() {
		ArrayList<Order> orderList = new ArrayList<Order>();
		
		 //페이지의 첫번째 게시글 번호. 0, 10, 20..
		
		try {
			conn = getConnect();
			String sql = "select * from embed1_young.order";
	
			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1,0);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Order order = new Order();
				order.setOrder_num(Integer.parseInt(rs.getString("order_num")));
				order.setOrder_id(rs.getString("order_id"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_addr(rs.getString("order_addr"));
				orderList.add(order);
			}
		} catch (Exception e) {
			System.out.println("getArticleList에서 " + e);
		}
        close(); //연결을 꼭 닫아주기.
		return orderList;
		}
	
	//전체 글의 개수를 가져오는 메소드.
			public int getOrderCount() {
				int total=0;
				try {
					conn = getConnect();
					
					//전체글의 개수.
					
					String sql = "select count(*) from order";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					
					int seq=0;
					if(rs.next()) {
						total = rs.getInt(++seq);
					}
				} catch (Exception e) {
					System.out.println("getOrderCount에" + e );
				}
				close();
				return total;
		
			}
			
			
			
			//글 삭제하기.
			public boolean deleteOrder(int num)
			{
				boolean result = false;
				
				try {
					conn = getConnect();
					conn.setAutoCommit(false);
					String sql = "delete from embed1_young.order where num=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					int flag = pstmt.executeUpdate();
					if(flag > 0) {
						result = true;
						conn.commit();
					}
					
				} catch (Exception e) {
					try {
						conn.rollback();
					} catch (SQLException sqle) {
						sqle.printStackTrace();
					}
				}
					close();
					return result;
			}

}
