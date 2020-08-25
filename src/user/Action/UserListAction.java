package user.Action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import Action.Action;
import vo.ActionForward;
import com.user.bean.UserBean;
import com.user.dao.UserDAO;

public class UserListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		
		
		if(id == null) {
			forward.setRedirect(true);
			forward.setPath("home.jsp");
		} else if(!id.equals("admin")) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자가 아닙니다.')");
			out.println("location.href='home.jsp'");			
			out.println("</scrpt>");
		} else {
			UserDAO dao = UserDAO.getInstance();
			ArrayList<UserBean> userList = dao.selectUserList();
			request.setAttribute("userList", userList);
			forward.setPath("userList.jsp");
		}
		
		return forward;
	}

}
