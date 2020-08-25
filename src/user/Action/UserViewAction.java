package user.Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;
import vo.ActionForward;
import com.user.bean.UserBean;
import com.user.dao.UserDAO;

public class UserViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");	// id는 admin으로 로그인했다면 admin이 나온다.
		
		ActionForward forward = new ActionForward();
		UserDAO dao = UserDAO.getInstance();
		
		if(id == null) {
			forward.setRedirect(true);
			forward.setPath("home.jsp");
			
		} else if(!id.equals("admin")) {
			response.setContentType("text/html;charset=UTF-8");	// 한글처리
			
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자가 아닙니다.');");
			out.println("location.href='/userLogin.bo';");			
			out.println("</scrpt>");
		} else {
			String viewId = request.getParameter("id");
			UserBean bean = dao.selectUser(viewId);
			request.setAttribute("bean", bean);
			
			forward.setPath("userInfo.jsp");
		}
		
		return forward;
	}

}
