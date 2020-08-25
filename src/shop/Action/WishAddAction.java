package shop.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Action.Action;

import com.shop.bean.Prd;
import com.shop.dao.PrdDAO;
import com.user.bean.UserBean;
import com.user.svc.AddWishService;

import vo.ActionForward;

public class WishAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		AddWishService addWishService = new AddWishService();
		
		HttpSession session = request.getSession();
		
		UserBean bean1 = new UserBean();
		session.setAttribute("user_id", bean1.getUser_id());
		
		int wish_id = Integer.parseInt(request.getParameter("id"));
		PrdDAO dao = PrdDAO.getInstance();
		Prd bean = dao.selectPrd(wish_id);
		addWishService.addCart(request, bean);
		
		forward.setPath("myPageAction.bo");
		forward.setRedirect(true);
		
		return forward;

	}
}
