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


public class MainAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		ActionForward forward = new ActionForward();
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

		BoardDAO dao = BoardDAO.getInstance();
		
		BbsBean bean = new BbsBean();
		
		int len = 4;
		int start = (cPage-1)*len; //0,3,6,9..
		ArrayList<BbsBean> articleMain = dao.getArticle(start,len);
		
		request.setAttribute("bean", bean);
		request.setAttribute("cPage",cPage);
		//글 목록 저장.
		request.setAttribute("articleMain", articleMain);
		
		UserDAO dao1 = UserDAO.getInstance();
		ArrayList<UserBean> userList = dao1.selectUserList();
		request.setAttribute("userList", userList);
		
		forward.setRedirect(false);
		forward.setPath("eventMain.jsp");
		
		return forward;
	}
	
}
