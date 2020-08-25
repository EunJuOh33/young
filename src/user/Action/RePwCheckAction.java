package user.Action;



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.bean.UserBean;
import com.user.dao.UserDAO;

import vo.ActionForward;

@WebServlet("/rePwCheckAction.aj")
public class RePwCheckAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}
	
	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 언어 설정
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String rePw = request.getParameter("rePw");	// '비밀번호 확인' 창에 입력한 비밀번호
		// System.out.println("비밀번호 확인창에 입력한 것 : " + rePw);
		
		HttpSession session = request.getSession();	// 로그인한 아이디와 비밀번호를 가져온다. -> UserLoginAction에서 setAttribute했다.
		String loginId = (String)session.getAttribute("id");
		String loginPw = (String)session.getAttribute("pw");
		// System.out.println("로그인한 아이디와 패스워드 :  " + loginId + ", " + loginPw);
		
		UserDAO userDAO = UserDAO.getInstance();
		
		String checkPw = null;
		int result = -1;
		if(rePw != null) {	// '비밀번호 확인' 창에 입력한 비밀번호가 있다면
			checkPw = userDAO.selectLoginPw(loginId);	// loginId에 해당하는 패스워드를 sql문으로 찾아서 가져왔다.
			
			if(loginPw.equals(rePw)) {
				result = 1;	// 같으면 1
			} else {
				result = 0;	// 다르면 0
				System.out.println("패스워드가 일치하지 않음.");
			}
		}
		
			
		// 서블릿에서 값을 write에 넣어주면 ajax에서 결과값으로 사용이 가능.
		// 해당 체크함수는 결과값이 숫자로 나오기 때문에 공백("")을 추가해서 문자열로 바꾼다.
		PrintWriter out = response.getWriter();
		out.write(result + "");	// ajax의 result로 보낸다.
		
	}
}
