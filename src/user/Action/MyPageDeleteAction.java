package user.Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;
import com.user.dao.UserDAO;
import vo.ActionForward;

public class MyPageDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = new ActionForward();
		UserDAO dao = UserDAO.getInstance();
		
		
		if(id == null) {
			forward.setRedirect(true);
			forward.setPath("userLogin.bo");
			
		} else if(id.equals("admin")) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자 계정으로 접속하였습니다.')");
			out.println("location.href='userLogin.bo'");			
			out.println("</scrpt>");
			
		} else {
			String deleteId = request.getParameter("id");
			int deleteResult = dao.deleteUser(deleteId);
			
			if(deleteResult > 0) {
				session.invalidate();	// 사용자의 세션 영역을 제거한다.
				forward.setRedirect(true);
				forward.setPath("home.jsp");
				
			} else {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원탈퇴 실패.')");
				out.println("location.href='userLogin.bo'");			
				out.println("</scrpt>");
			}
		}
		
		return forward;
	}

}
