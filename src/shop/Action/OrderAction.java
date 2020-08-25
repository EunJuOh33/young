package shop.Action;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;

import com.shop.bean.*;
import com.shop.dao.PrdDAO;

import vo.ActionForward;

public class OrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		
		try {
			
		PrdDAO dao = PrdDAO.getInstance();
		Order order = new Order();
		String user_id = (String)session.getAttribute("id");
		
		order.setOrder_num(order.getOrder_num());
		order.setOrder_id(user_id);
		order.setOrder_name(request.getParameter("user_name"));

//		order.setOrder_content(request.getParameter("prd_content"));
//		System.out.println("내용 " +(request.getParameter("prd_content")));

//		/* user_phone 데이터 받기 */
//		String arr2[] = request.getParameterValues("user_phone");
//		String data2 = "";
//		for(String string : arr2) {
//			data2 += string;
//		}
//		int phone_int = Integer.parseInt(data2);
//		order.setOrder_phone(phone_int);
//		order.setOrder_price(Integer.parseInt(request.getParameter("prd_price")));
//		System.out.println("가격 " +(Integer.parseInt(request.getParameter("prd_price"))));
		/* user_addr 데이터 받기 */
		String [] arr4 = request.getParameterValues("user_addr");
		// 아무것도 입력되지 않았다면 {""} 이다. 데이터베이스 테이블에 null이 적히지 않고, 공백("")으로 처리한다.
		String data4 = "";
		for(String string : arr4) {
			data4 += string;
		}
		String imsiAddr = data4.trim().equals("") ? null : data4;
		order.setOrder_addr(imsiAddr);
		
		
		boolean result = dao.insertOrder(order);
		
		if(result) {
			forward.setPath("OrderList2.jsp");
		}
		
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("주문보내기 오류 : " + e.getMessage());
		}
		
		return forward;
	}
}
