package com.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import user.Action.MyPageDeleteAction;
import user.Action.MyPageMainAction;
import user.Action.MyPageManageAction;
import user.Action.MyPageRePwAction;
import user.Action.UserDeleteAction;
import user.Action.UserJoinAction;
import user.Action.UserListAction;
import user.Action.UserLoginAction;
import user.Action.UserLogoutAction;
import user.Action.UserModifAction;
import user.Action.UserViewAction;
import vo.ActionForward;

@WebServlet("*.bo")
// href="~.bo" 는 모두 이 페이지로 넘어온다.
public class UserFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProc(request, response);
	}
	
	/* post방식으로 넘어오든 get방식으로 넘어오든 boProc메소드가 받는다. */
	protected void doProc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* 한글 */
		request.setCharacterEncoding("UTF-8");
		
		String requestURI = request.getRequestURI();					// 프로젝트와 파일경로를 얻어온다. /olive/*.bo 이렇게 리턴된다.
		String contextPath = request.getContextPath();					// 프로젝트 path만 얻어온다. http://localhost:8081/olive/test.jsp 라면 -> /olive
		String command = requestURI.substring(contextPath.length());	// 찾을 문자열.substring(괄호 안의 인덱스 번호만큼 빠진다.) -> /olive가 빠지게 된다.
		
		ActionForward forward = null;
		Action action = null;	
		
		if (command.equals("/userLogin.bo")) {
			forward = new ActionForward();		// 객체 생성
			forward.setPath("/loginForm.jsp");	// 매개변수가 ActionForward의 변수 path 값이 된다.
		} else if (command.equals("/userJoin1.bo")) {
			forward = new ActionForward();
			forward.setPath("/joinAgreeForm.jsp");
		} else if (command.equals("/userJoin2.bo")) {	
			forward = new ActionForward();
			forward.setPath("/joinForm.jsp");
		} else if (command.equals("/userJoin3.bo")) {	
			forward = new ActionForward();
			forward.setPath("/joinDone.jsp");
		
		// 여기서부터 action페이지	
		} else if (command.equals("/userLoginAction.bo")) {
			action = new UserLoginAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/userLogoutAction.bo")) {
			action = new UserLogoutAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/userJoinAction.bo")) {
			action = new UserJoinAction();	// 객체 생성
			try {
				forward = action.execute(request, response);	// forward은 UserJoinAction의 execute메소드의 리턴값(forward)
				// 성공했을 때, redirect=true, path=userLogin.bo
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/userListAction.bo")) {
			action = new UserListAction();	
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/userViewAction.bo")) {
			action = new UserViewAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/userDeleteAction.bo")) {
			action = new UserDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/myPage.bo")) {
			action = new MyPageMainAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/myPageManage1.bo")) {
			action = new MyPageRePwAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/myPageManage2.bo")) {
			action = new MyPageManageAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/userModifAction.bo")) {
			action = new UserModifAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/myPageDeleteAction.bo")) {
			action = new MyPageDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {	// 나머지 잘못되어 들어온 경우 메인 페이지로 돌아간다.
			response.setContentType("text/html;charset=UTF-8");
			
			PrintWriter out = response.getWriter();	// 간단한거라서 action으로 넘기지 않고 바로 적어줬다.
			out.println("<script>");
			out.println("alert('잘못된 경로입니다.')");
			out.println("</script>");
			forward = new ActionForward();
			forward.setPath("/main.jsp");
		}
		
		
		if(forward != null) {
			// (return redirect) -> true or false
			// true라면 if문이 항상 실행된다. false라면 실행되지 않는다.
			if(forward.isRedirect()) {	
				response.sendRedirect(forward.getPath());	// (path);
				// sendRedirect() : JSP 페이지에서 특정한 작업을 수행한 후 지정한 페이지로 이동하고 싶은 경우 사용하는 메서드
			} else {
				RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
				rd.forward(request, response);
			}
		}
	}
}
