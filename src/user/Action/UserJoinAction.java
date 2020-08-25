package user.Action;

import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.bean.UserBean;
import com.user.dao.UserDAO;

import Action.Action;
import vo.ActionForward;

public class UserJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserBean bean = new UserBean();
		UserDAO dao = UserDAO.getInstance();
		boolean joinResult = false;
		
		bean.setUser_id(request.getParameter("user_id"));
		
		bean.setUser_pw(request.getParameter("user_pw"));
		
		bean.setUser_name(request.getParameter("user_name"));
		
		/* birth 데이터 받기 */
		String arr1[] = request.getParameterValues("user_birth");
		String data1 = "";
		for(String string : arr1) {
			data1 += string;	// data = "19950319" 이런식으로 저장
		}
		int birth_int = Integer.parseInt(data1, 10);
		bean.setUser_birth(birth_int);
		
		/* user_phone 데이터 받기 */
		String arr2[] = request.getParameterValues("user_phone");
		String data2 = "";
		for(String string : arr2) {
			data2 += string;
		}
		bean.setUser_phone(data2);

		/* user_email 값 받기 */
		String email_1 = request.getParameter("user_email1");
		String email_2 = request.getParameter("user_email2");
		String data3 = email_1 + "@" + email_2;
		bean.setUser_email(data3);
		
		/* user_zip 데이터 받기 */
//		int  imsiZip = (request.getParameter("user_zip") == null) ? 0 : Integer.parseInt(request.getParameter("user_zip"));
// 		trim()은 공백 제거, String은 equals로 비교해야 한다, 아무것도 안 적으면 메모리에 올라가 있지만 값이 없는 것이기 때문에 null이 아니라 ""이다.
		int  imsiZip = (request.getParameter("user_zip").trim().equals("")) ? 0 : Integer.parseInt(request.getParameter("user_zip"));
		bean.setUser_zip(imsiZip);
		
		
		/* user_addr 데이터 받기 */
		String [] arr4 = request.getParameterValues("user_addr");
		// 아무것도 입력되지 않았다면 {""} 이다. 데이터베이스 테이블에 null이 적히지 않고, 공백("")으로 처리한다.
		String data4 = "";
		for(String string : arr4) {
			data4 += string;
		}
		String imsiAddr = data4.trim().equals("") ? null : data4;
		bean.setUser_addr(imsiAddr);
		
		/* user_gender데이터 받기 */
		// 아무것도 선택되어 있지 않다면 form에서 아예 데이터를 넘기지 않는다.
		// 하지만 value=""에 checked되어있기 때문에 데이터베이스에서 공백처리 된다. 그래서 ""은 억지로 NULL로 바꾸는 방법을 사용했다.
		// System.out.println("user_gender 넘어온 값 : " + request.getParameter("user_gender"));	// '선택안함'선택시 공백이 넘어온다.
		String imsiGender = (request.getParameter("user_gender").equals("")) ? null : request.getParameter("user_gender");
		bean.setUser_gender(imsiGender);
		
		
		/* select_P 데이터 받기 */
		String imsiP = (request.getParameter("select_p").equals("")) ? null : request.getParameter("select_p");
		bean.setSelect_p(imsiP);
		
		
		/* 수신동의 체크박스 데이터 받기 */
		String [] arr5 = request.getParameterValues("rcv_agree");
		// System.out.println("arr5 배열 출력 : " + Arrays.toString(arr5));
		// 선택하지 않으면 null, "" 등 아무것도 넘어오지 않는다. 예 : [우편물수신동의, sms수신동의]
		// 아무것도 선택하지 않으면 arr5 = null 이 된다.
		try {
			String data5 = "";
			for(String string : arr5) {
				data5 += string + "/";
			}
			bean.setRcv_agree(data5);
			// System.out.println("data5 확인 : " + data5);
       } catch(Exception e) {
          System.out.println(e);
       }
		
		
		
//		UserJoinService userJoinService = new UserJoinService();
//		joinResult = userJoinService.joinUser(bean);	// 성공했다면 ture가 반환될 것.
		
		int insertCount = dao.insertUser(bean);
		
		ActionForward forward = new ActionForward();
		
		if(insertCount > 0) {
			joinResult = true;
			
			HttpSession session = request.getSession();
			session.setAttribute("join_id", bean.getUser_id());	// joinDone.jsp로 넘겨주기 위한 데이터
			session.setAttribute("join_name", bean.getUser_name());	
			// request.setAttribute("user_id", user_id);
			
			// setRedirect(true)라면 setAttribute를 해도 request가 넘어가지 않는다.
			// 그래서 위에서 request 대신 session에 붙여서 넘겨준 것이다.
			// 하지만 setRedirect(false)로 한다면 userJoinDone.jsp 페이지 주소창이 UserJoinAction.bo 로 뜨기 때문에.. true로 놔둔다.
			forward.setRedirect(true);	
			forward.setPath("userJoin3.bo");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원등록 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return forward;
	}
}
