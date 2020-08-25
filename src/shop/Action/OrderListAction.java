package shop.Action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;

import com.shop.bean.Order;
import com.shop.dao.PrdDAO;
import com.user.bean.UserBean;

import vo.ActionForward;

public class OrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		
		UserBean bean1 = new UserBean();
		session.setAttribute("user_id", bean1.getUser_id());
					
		PrdDAO dao = PrdDAO.getInstance();
		ArrayList<Order> orderList = dao.getOrderList();
		
		request.setAttribute("orderList", orderList);
		
		forward.setRedirect(false);
		forward.setPath("myOrder.jsp");
		
		return forward;
	}
}
