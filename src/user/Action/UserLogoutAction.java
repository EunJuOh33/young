package user.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;
import vo.ActionForward;

public class UserLogoutAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();	// 사용자의 세션 영역을 제거한다.
		response.sendRedirect("home.jsp");
		
		ActionForward forward = null;
		
		return forward;
	}
}
