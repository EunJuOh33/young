package user.Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import Action.Action;
import vo.ActionForward;
import com.user.bean.UserBean;
import com.user.dao.UserDAO;

public class UserLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		
		// UserBean클래스 변수 값 설정
		UserBean bean = new UserBean();
		bean.setUser_id(request.getParameter("user_id"));
		bean.setUser_pw(request.getParameter("user_pw"));
		
		UserDAO dao = UserDAO.getInstance();
		String loginId = dao.selectLoginId(bean);
		
		if(loginId!=null) {
			session.setAttribute("id", bean.getUser_id());
			session.setAttribute("pw", bean.getUser_pw());
			forward.setRedirect(true);
			forward.setPath("home.jsp");
		} else {
			response.setContentType("text/html;charset=UTF-8");	// 한글처리
			
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 실패')");	// ";"이거 안붙혀도 된다.
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}

}
