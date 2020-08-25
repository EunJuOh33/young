package shop.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import com.shop.svc.PrdCartAddService;
import vo.ActionForward;
import com.shop.bean.Prd;
import com.shop.dao.PrdDAO;

public class PrdCartAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrdCartAddService prdCartAddService = new PrdCartAddService();
		int id = Integer.parseInt(request.getParameter("id"));
		PrdDAO dao = PrdDAO.getInstance();
		Prd cartPrd = dao.selectPrd(id);
		prdCartAddService.addCart(request, cartPrd);
		ActionForward forward = new ActionForward();
		
		forward.setPath("prdCartList.vo");
		forward.setRedirect(true);
		
		return forward;
	}

}
