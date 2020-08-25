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


public class UserModifAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserBean bean = new UserBean();
		UserDAO dao = UserDAO.getInstance();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		
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
		
			bean.setUser_id(id);	// 로그인한 아이디를 넣는다.
			
			bean.setUser_name(request.getParameter("modif_name"));
			// System.out.println(request.getParameter("modif_name"));
			
			/* modif_phone 데이터 받기 */
			String arr2[] = request.getParameterValues("modif_phone");
			String data2 = "";
			for(String string : arr2) {
				data2 += string;
			}
			bean.setUser_phone(data2);
			// System.out.println(data2);
	
			/* user_email 값 받기 */
			String email_1 = request.getParameter("modif_email1");
			String email_2 = request.getParameter("modif_email2");
			String data3 = email_1 + "@" + email_2;
			bean.setUser_email(data3);
			// System.out.println(data3);
			
			/* user_zip 데이터 받기 */
	//		int  imsiZip = (request.getParameter("user_zip") == null) ? 0 : Integer.parseInt(request.getParameter("user_zip"));
	// 		trim()은 공백 제거, String은 equals로 비교해야 한다, 아무것도 안 적으면 메모리에 올라가 있지만 값이 없는 것이기 때문에 null이 아니라 ""이다.
			int  imsiZip = (request.getParameter("modif_zip").trim().equals("")) ? 0 : Integer.parseInt(request.getParameter("modif_zip"));
			bean.setUser_zip(imsiZip);
			// System.out.println(imsiZip);
			
			
			/* user_addr 데이터 받기 */
			String [] arr4 = request.getParameterValues("modif_addr");
			// 아무것도 입력되지 않았다면 {""} 이다. 데이터베이스 테이블에 null이 적히지 않고, 공백("")으로 처리한다.
			String data4 = "";
			for(String string : arr4) {
				data4 += string;
			}
			String imsiAddr = data4.trim().equals("") ? null : data4;
			bean.setUser_addr(imsiAddr);
			// System.out.println(imsiAddr);
			
			/* user_gender데이터 받기 */
			// 아무것도 선택되어 있지 않다면 form에서 아예 데이터를 넘기지 않는다.
			// value=""에 checked되어있기 때문에 데이터베이스에서 공백처리 된다. 그래서 ""은 억지로 NULL로 바꾸는 방법을 사용했다.
			// System.out.println("modif_gender 넘어온 값 : " + request.getParameter("modif_gender"));	// 공백이 넘어온다.
			String imsiGender = (request.getParameter("modif_gender").equals("")) ? null : request.getParameter("modif_gender");
			bean.setUser_gender(imsiGender);
			// System.out.println("imsiGender 출력 : " + imsiGender);
			
			
			/* modif_p 데이터 받기 */
			String imsiP = (request.getParameter("modif_p").equals("")) ? null : request.getParameter("modif_p");
			bean.setSelect_p(imsiP);
			// System.out.println("imsiP 출력 : " + imsiP);
			
			
			/* 수신동의 체크박스 데이터 받기 */
			String email_rcv = request.getParameter("modif_email_rcv");	// "" or "이메일수신동의"
			String sms_rcv = request.getParameter("modif_sms_rcv");
			String post_rcv = request.getParameter("modif_post_rcv");
			// '미수신'을 체크하면 공백("")이 넘어온다.
			String [] arr5 = {email_rcv, sms_rcv, post_rcv};	
			if(email_rcv.equals("") && sms_rcv.equals("") && sms_rcv.equals("")) {
				arr5 = null;
				// 모두 '미수신'을 선택했을 때, 배열을 null로 만든다. 이렇게 하면 밑의 for문에서 에러가 난다.
				// 그래서 bean.setRcv_agree가 실행되지 않기 때문에 테이블이 null로 비어있게 된다. 
			}	
			// System.out.println("arr5 배열 출력 : " + Arrays.toString(arr5));	// [, 우편물수신동의, sms수신동의]
			try {
				String data5 = "";
				for(String string : arr5) {
					data5 += string + "/";
				}
				bean.setRcv_agree(data5);
				// System.out.println("data5 출력 : " + data5);
	       } catch(Exception e) {
	          System.out.println(e);
	       }
			
			
			int modifCount = dao.modifUser(bean);	// 성공했다면 insertCount는 1이다.
			
			if(modifCount > 0) {
				// setRedirect(true)라면 setAttribute를 해도 request가 넘어가지 않는다.
				// 하지만 setRedirect(false)로 한다면 다음 페이지 주소창이 UserModifAction.bo 로 뜨기 때문에.. true로 놔둔다.
				forward.setRedirect(true);	
				forward.setPath("myPageManage1.bo");
				
			} else {
				response.setContentType("text/html;charset=UTF-8");
				
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('회원정보 수정 실패')");
				out.println("history.back()");
				out.println("</script>");
			}
		}	// 맨 위 else구문 끝
		
		return forward;
	}
}
