package shop.Action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.svc.PrdCartListService;
import vo.ActionForward;
import com.shop.bean.Cart;

import Action.Action;

public class PrdCartListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrdCartListService prdCartListService = new PrdCartListService();
		ArrayList<Cart> cartList = prdCartListService.getCartList(request);
		int totalMoney = 0;
		int money = 0;
		
		for(int i = 0; i<cartList.size(); i++) {
			money = cartList.get(i).getPrice()*cartList.get(i).getQty();
			totalMoney += money;
		}
		request.setAttribute("totalMoney", totalMoney);
		request.setAttribute("cartList", cartList);
		ActionForward forward = new ActionForward();
		
		forward.setPath("ShoppingCart.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
