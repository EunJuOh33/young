package com.board.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*; 
import javax.servlet.http.*;

import Action.Action;
import Action.BoardFormChangeAction;
import vo.ActionForward;


public class ControllerAction extends HttpServlet {
	 
	private static final long serialVersionUID = 1L;
	private HashMap<String,Action> commandMap;
	 
		
	     //최초 실행 init
	     
	    public void init(ServletConfig config) throws ServletException {
	 
	        // Common properties 
	        loadProperties("com/board/properties/Command");
	 
	    }
	 
	    /**
	     * 프로퍼티 파일에서 키값과 클래스 정보를 추출하여 그것을 Map에 저장한다.
	     * @param filePath 프로퍼티 파일의 경로
	     */

	    private void loadProperties(String path) {
	 
	    	commandMap = new HashMap<String, Action>();
	    	ResourceBundle rbHome = ResourceBundle.getBundle(path);// 누구를 실행할지를 rb에
	                                                                // 저장.
	        Enumeration<String> actionEnumHome = rbHome.getKeys();
	 
	        while (actionEnumHome.hasMoreElements())
	 
	        {
	        	// 명령어를 가져온다.
	            String command = actionEnumHome.nextElement();
	            System.out.println(command);
	            
	            // 명령어에 해당하는 Action 클래스 이름을 가져온다.
	            String className = rbHome.getString(command);
	 
	            try {
	 
	                Class actionClass = Class.forName(className); // 해당 문자열을 클래스로 만든다
	                Action actionInstance = (Action)actionClass.newInstance(); // 해당 클래스의 객체를 생성
	                                     
	                // 화면전환 Action 인지 확인한다. 화면전환 Action이면 명령어를 전달한다.
	                if(className.equals("Action.BoardFormChangeAction")) {
	                	BoardFormChangeAction bf = (BoardFormChangeAction)actionInstance;
	                	bf.setCommand(command);
	                }
	                	// 맵에 명령어와 Action을 담는다.
	                	commandMap.put(command, actionInstance);
	                	
	            	} catch (Exception e) {
	            	e.printStackTrace();

	            	
	            	} 
	 
	            }
	 
	        }

	    public void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	 
	        doProc(request, response); // get방식과 post방식을 모두 doProc 으로 처리
	 
	    }
	 
	    protected void doPost(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	 
	        doProc(request, response);
	 
	    }
	 
	    // 사용자의 요청을 분석해서 해당 작업을 처리
	    /**
	     * 명령어에 따른 해당 Action을 지정해 준다.
	     * @param request
	     * @param response
	     * @throws ServletException
	     * @throws IOException
	     */


	    private void doProc(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	 
	    	// 넘어온 커맨드를 추출하는 과정
	    	String requestURI = request.getRequestURI();
			int cmdIdx = requestURI.lastIndexOf("/") + 1;
			String command = requestURI.substring(cmdIdx);
	 
			// URI, command 확인
	        // System.out.println("requestURI : "+requestURI);
			System.out.println("Board cmd:" + command);
			
			ActionForward forward = null;
			Action action = null;
			
			try {
	 
				// 맵에서 명령어에 해당하는 Action을 가져온다.
	        	action = (Action)commandMap.get(command);
	 
	            if (action==null) {
	            	System.out.println("명령어 : "+command+"는 잘못된 명령입니다.");
	            	return;
	            	}
	            
	            forward = action.execute(request, response);
	            
	            /*
	             * 화면이동 - isRedirect() 값에 따라 sendRedirect 또는 forward를 사용
	             * sendRedirect : 새로운 페이지에서는 request와 response객체가 새롭게 생성된다.
	             * forward : 현재 실행중인 페이지와 forwad에 의해 호출될 페이지는 request와 response 객체를 공유
	             */


	 
	            if (forward!=null) {
	             if(forward.isRedirect()) {
	            	 response.sendRedirect(forward.getPath());
	             }else {
	            	 RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
	            	 dispatcher.forward(request, response);
	             }
	            }
			}catch (Exception e){
	            	 e.printStackTrace();
	             }
	       }
	    }
