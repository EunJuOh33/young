package user.Action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;

import Action.Action;
import com.user.dao.UserDAO;
import vo.ActionForward;

public class UserDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = new ActionForward();
		UserDAO dao = UserDAO.getInstance();
		
		
		if(id == null) {
			forward.setRedirect(true);
			forward.setPath("userLogin.bo");
		} else if(!id.equals("admin")) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자가 아닙니다.')");
			out.println("location.href='userLogin.bo'");			
			out.println("</scrpt>");
			
		} else {
			String deleteId = request.getParameter("id");
			int deleteResult = dao.deleteUser(deleteId);
			
			if(deleteResult>0) {
				forward.setRedirect(true);
				forward.setPath("userListAction.bo");
			} else {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원정보 삭제 실패.')");
				out.println("location.href='userLogin.bo'");			
				out.println("</scrpt>");
			}
		}
		
		return forward;
	}

}
