package user.Action;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.dao.UserDAO;

@WebServlet("/idCheckAction.aj")
public class UserIdCheckAction extends HttpServlet {
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
		
		String dupId = request.getParameter("user_id");
//		System.out.println("idCheckAction으로 데이터 넘어오는 것 확인 " + dupId);
		
		UserDAO userDAO = UserDAO.getInstance();
		
		int dupChk = -2;
		
		if(dupId != null) {
			dupChk = userDAO.selectIdDupChk(dupId);
		}
		
			
		// 서블릿에서 값을 write에 넣어주면 ajax에서 결과값으로 사용이 가능.
		// 해당 체크함수는 결과값이 숫자로 나오기 때문에 공백("")을 추가해서 문자열로 바꾼다.
		PrintWriter out = response.getWriter();
		out.write(dupChk + "");	// ajax의 result로 보낸다.
		
	}
}
