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

public class DetailAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String pw = (String)session.getAttribute("pw");
		
		ActionForward forward = new ActionForward();
		
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		BoardDAO dao = BoardDAO.getInstance();
		BbsBean bean = dao.getDetail(seq);
		
		boolean result = dao.updateCount(seq);
		request.setAttribute("bean", bean);
		
		UserDAO dao1 = UserDAO.getInstance();
		ArrayList<UserBean> userList = dao1.selectUserList();
		request.setAttribute("userList", userList);
		
		forward.setPath("eventReviewList.jsp");
		
		return forward;
	}

}
