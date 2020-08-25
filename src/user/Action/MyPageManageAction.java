package user.Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.bean.UserBean;
import com.user.dao.UserDAO;

import Action.Action;
import vo.ActionForward;

public class MyPageManageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		UserDAO dao = UserDAO.getInstance();
		
		
		if(id == null) {
			forward.setRedirect(true);
			forward.setPath("home.jsp");
			
		} else if(id.equals("admin")) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자 계정으로 접속하였습니다.')");
			out.println("location.href='home.jsp'");			
			out.println("</scrpt>");
			
		} else {
			String viewId = id;	// 현재 로그인 되어있는 아이디의 값을 viewId에 넣어준다.
			UserBean bean = dao.selectUser(viewId);
			request.setAttribute("bean", bean);
			
			forward.setPath("myPageManage.jsp");	// 주소 창에는 myPageManage2.bo 라고 나타난다.
		}
		
		return forward;
	}

}
