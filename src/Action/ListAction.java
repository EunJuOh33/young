package Action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.user.bean.UserBean;
import com.user.dao.UserDAO;

import com.board.bean.BbsBean;
import com.board.dao.BoardDAO;

import vo.ActionForward;


public class ListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String pw = (String)session.getAttribute("pw");
		
		if(id!=null) {
			System.out.println("id값 있음 " + id);
		}else {
			System.out.println("id값 없음 " + id );
		}
		
		String tempPage = request.getParameter("page");
		int cPage;
		
		//현재 페이지 넘버는 url에서 파라미터(쿼리)를 받아서 cPage에 할당함.
		//page 파라미터가 없는 경우나 숫자가 아닌 문자가 들어있는 경우를 대비해 예외처리를 해줌.
		//cPage = 현재 페이지 번호 만들기.
		if(tempPage==null||tempPage.length()==0) {
			cPage = 1; //한 페이지. 1,2,3..
		}try {
			cPage = Integer.parseInt(tempPage);
//			System.out.println(cPage);
		} catch (Exception e) {
			cPage = 1;
//			System.out.println(cPage);
		}

		
		//검색조건과 검색내용을 가져온다.
		//String opt = request.getParameter("opt");
		
		int pageLength = 10; //한 페이지에 보여줄 게시글 수.
		
		BoardDAO dao = BoardDAO.getInstance();
		int listCount = dao.getListCount(); //글의 총 개수.
		
		int len = pageLength;
		int start = (cPage-1)*len; //0,10,20,30,40.. 한 페이지당 시작하는 글 페이지 번호.
		
		try {
			start = (cPage-1)*len;
//			System.out.println("start의 값은?"+start);
			
		} catch (Exception e) {
//			System.out.println(start);
		}
		//ex) 1페이지에선 시작번호 0부터, 2페이지에선 시작번호 10번부터.
		ArrayList<BbsBean> articleList = dao.getArticleList(start,len);
				
		//한 화면에 10개의 게시글을 보여지게 함.
		//페이지 번호는 총 10개, 이후로는 [다음]으로 표시.
		
		int currentBlock; //1~10이 1블럭. 11~20 2블럭.
		
		//현재 페이지가 2p라면, 2를 10으로 나눠서 나머지가 0이 나오지 않음.
		//2를 10으로 나눈 몫은 0이 나올 것이고, +1을 해서 2페이지는 1블럭에 속하게 된다.
		currentBlock = cPage%pageLength==0? cPage/pageLength:(cPage/pageLength)+1;
		
		//전체 페이지 수. 글의 총 개수가 10으로 나눠서 딱 떨어진다면 그대로, 아니라면 페이지+1 해줘서 남는 데이터 값도 처리해준다.
		int totalPage; 
		totalPage=listCount%pageLength==0? listCount/pageLength:(listCount/pageLength)+1;
		
		if(totalPage==0) {
			totalPage=1;
		}
		if(cPage>totalPage) {
			cPage=1;
		}
		
		//각 블럭의 시작 페이지 번호. 1,11,21..
		int startPage = (currentBlock-1)*pageLength+1;
		
		//각 블럭의 끝 페이지 번호. 10,20,30..
		int endPage = (startPage+pageLength)-1;
		if(endPage>totalPage) endPage=totalPage;
		
		
		//4개 페이지 번호 저장.
		request.setAttribute("cPage",cPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		//글의 총 수와 글 목록 저장.
		request.setAttribute("listCount", listCount);
		request.setAttribute("articleList", articleList);
		
		
		forward.setRedirect(false);
		forward.setPath("eventReview.jsp");
		
		return forward;
	}
	
}
