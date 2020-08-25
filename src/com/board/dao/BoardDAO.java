package com.board.dao;

import java.sql.*;
import java.util.*;
import com.board.bean.BbsBean;

public class BoardDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;

	
	public Connection getConnect(){
		String dbURL="jdbc:mysql://118.131.179.138:3306/embed1_young?serverTimezone=UTC&useSSL=false";
		String dbID="emb1young";
		String dbPW="emb1young";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL,dbID,dbPW);
			con.setAutoCommit(false);
		} catch (Exception e) {
			e.printStackTrace();
		}
			return con;
	}
	
	private void close(){
    try {
        if ( pstmt != null )
        { pstmt.close(); pstmt=null; }
        if ( con != null )
        { con.close(); con=null;    }
        if ( rs != null )
        { rs.close(); rs=null;    }
      
    } catch (Exception e) {
        throw new RuntimeException(e.getMessage());
    }

}
	
	private static BoardDAO instance;
	
	public static BoardDAO getInstance(){
		if(instance==null)
			instance=new BoardDAO();
		return instance;
	}
	
	//글 목록 가져오기.
	public ArrayList<BbsBean> getArticleList(int start, int len) {
		ArrayList<BbsBean> articleList = new ArrayList<BbsBean>();
		
		int startrow = start; //페이지의 첫번째 게시글 번호. 0, 10, 20..
		
		try {
			con = getConnect();
			String sql = "select * from bbs_review order by seq desc limit ?,10";
	
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BbsBean article = new BbsBean();
				article.setSeq(Integer.parseInt(rs.getString("seq")));
				article.setTitle(rs.getString("title"));
				article.setContent(rs.getString("content"));
				article.setWriter(rs.getString("writer"));
				article.setFdate(rs.getDate("fdate"));
				article.setFile(rs.getString("file"));
				article.setCount(Integer.parseInt(rs.getString("count")));
				articleList.add(article);
			}
		} catch (Exception e) {
			System.out.println("getArticleList에서 " + e);
			System.out.println(start);
		}
        close(); //연결을 꼭 닫아주기.
		return articleList;
		}
	
	
	//메인페이지 글 목록 가져오기.
	public ArrayList<BbsBean> getArticle(int start, int len) {
		ArrayList<BbsBean> articleMain = new ArrayList<BbsBean>();
		
		int startrow = start; //페이지의 첫번째 게시글 번호. 0, 4, 8..
		
		try {
			con = getConnect();
			String sql = "select * from bbs_review order by seq desc limit ?,4";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,startrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BbsBean main = new BbsBean();
				main.setSeq(Integer.parseInt(rs.getString("seq")));
				main.setTitle(rs.getString("title"));
				main.setContent(rs.getString("content"));
				main.setWriter(rs.getString("writer"));
				main.setFdate(rs.getDate("fdate"));
				main.setFile(rs.getString("file"));
				main.setCount(Integer.parseInt(rs.getString("count")));
				articleMain.add(main);
			}
		} catch (Exception e) {
			System.out.println("getArticle에서 " + e);
			System.out.println(start);
		}
		close(); //연결을 꼭 닫아주기.
		return articleMain;
	}
	
		
		//전체 글의 개수를 가져오는 메소드.
		public int getListCount() {
			int total=0;
			try {
				con = getConnect();
				
				//전체글의 개수.
				
				String sql = "select count(*) from bbs_review";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				int seq=0;
				if(rs.next()) {
					total = rs.getInt(++seq);
				}
			} catch (Exception e) {
				System.out.println("getListCount에" + e );
			}
			close();
			return total;
	
		}
	
		//글등록
		public boolean insertContent(BbsBean bbs) {
			boolean result = false;
			int num=0;
			int insert=0;
			try {
			con = getConnect();
			pstmt = con.prepareStatement("select max(seq) from bbs_review");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num= rs.getInt(1)+1;
			}else {
				num=1;
			}

            //시퀀스 값을 글 번호와 그룹번호로 사용
            String sql = "insert into bbs_review values (?,?,?,?,?,?,now())";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.setString(2, bbs.getTitle());
            pstmt.setString(3, bbs.getWriter());
            pstmt.setString(4, bbs.getContent());
            pstmt.setString(5, bbs.getFile());
            pstmt.setInt(6, 0);

            
            insert = pstmt.executeUpdate();
            
            if(insert>0) {
            	result=true;
            	con.commit();
            }
        }catch (Exception e) {
        	try {
        		System.out.println("insertContent에" + e);
				con.rollback();
			} catch (SQLException e2) {
				System.out.println("insertContent에" + e2);
			}
        	throw new RuntimeException(e.getMessage());

		}
			close();
			return result;
		}
		
	//글 내용보기.

		public BbsBean getDetail(int seq) {
			BbsBean bean = null;
			try {
				con = getConnect();
				String sql = "select * from bbs_review where seq=?";
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, seq);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bean = new BbsBean();
					bean.setSeq(seq);
					bean.setWriter(rs.getString("writer"));
					bean.setFdate(rs.getDate("fdate"));
					bean.setCount(rs.getInt("count"));
					bean.setTitle(rs.getString("title"));
					bean.setContent(rs.getString("content"));
					bean.setFile(rs.getString("file"));
//					bean.setRe_ref(rs.getInt("re_ref"));
//		            bean.setRe_lev(rs.getInt("re_lev"));
//		            bean.setRe_seq(rs.getInt("re_seq"));
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			close();
			return bean;
			
		}
		
		
		//조회수 증가.
		public boolean updateCount(int seq) {
			boolean result = false;
			
			try {
				con = getConnect();
				String sql = "update bbs_review set count=count+1 where seq=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, seq);
				
				int flag = pstmt.executeUpdate();
				if(flag>0) {
					result=true;
					con.commit();
				}
			} catch (Exception e) {
				System.out.println("조회수dao에서"+e);
				try {
					con.rollback(); 
				} catch (SQLException sqle) {
					System.out.println("조회수dao sql에서" + sqle);
				}
			}
			close();
			return result;
		}
		
		//삭제할 파일명을 가져온다.
		public String getFileName(int seq) 
		{
			String fileName = null;
			try {
				con = getConnect();
				String sql = "select file from bbs_review where seq=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, seq);
				
				rs = pstmt.executeQuery();
				if(rs.next()) fileName = rs.getString("file");
			} catch (Exception e) {
				e.printStackTrace();
			}
			close();
			return fileName;
		}
		
		
		//글 삭제하기.
			public boolean deleteBoard(int seq)
			{
				boolean result = false;
				
				try {
					con = getConnect();
					con.setAutoCommit(false);
					String sql = "delete from bbs_review where seq=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, seq);
					
					int flag = pstmt.executeUpdate();
					if(flag > 0) {
						result = true;
						con.commit();
					}
					
				} catch (Exception e) {
					try {
						con.rollback();
					} catch (SQLException sqle) {
						sqle.printStackTrace();
					}
				}
					close();
					return result;
			}
		
			//글 수정하기.
			public int updateBoard(BbsBean bean) {
				int update=0;
				
				try {
					con = getConnect();
					
					String sql = "update bbs_review set title=?, content=?, file=? where seq=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bean.getTitle());
					pstmt.setString(2, bean.getContent());
					pstmt.setString(3, bean.getFile());
					pstmt.setInt(4, bean.getSeq());
					update = pstmt.executeUpdate();
					System.out.println("ss " + bean.getSeq());
					System.out.println("dd " + update);
					
					if(update>0) {
						con.commit();
					}
				}catch (Exception e) {
					try {
						con.rollback();
						System.out.println("file " + bean.getFile());
						System.out.println("updateBoard rollback에서 " + e);
					} catch (Exception e2) {
						System.out.println("updateBoard rollback에서2 " + e2);
					}
//					System.out.println("updateBoard에서" + e);
//					System.out.println("title값?" + bean.getTitle());
				}finally {
					close();
				}
				return update;
			}
			

}

	
	

		
		
		
		
	

