package user.Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;
import vo.ActionForward;

public class MyPageRePwAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		
		
		if(id == null) {
			forward.setRedirect(true);
			forward.setPath("loginForm.jsp");
			
		} else if(id.equals("admin")) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자 계정으로 접속하였습니다.')");
			out.println("location.href='loginForm.jsp'");			
			out.println("</scrpt>");
			
		} else {						
			forward.setPath("myPageRePw.jsp");	// 주소 창에는 myPageManage1.bo 라고 나타난다.
		}
		
		return forward;
	}

}
