package shop.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import com.shop.svc.PrdCartQtyDownService;
import vo.ActionForward;

public class PrdCartQtyDownAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		PrdCartQtyDownService prdCartQtyDownService = new PrdCartQtyDownService();
		prdCartQtyDownService.downCartQty(name, request);
		ActionForward forward = new ActionForward();
		
		forward.setPath("prdCartList.do");
		forward.setRedirect(true);
		
		return forward;
	}

}
