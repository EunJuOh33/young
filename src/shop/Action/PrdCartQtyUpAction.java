package shop.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import com.shop.svc.PrdCartQtyUpService;
import vo.ActionForward;

public class PrdCartQtyUpAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		PrdCartQtyUpService prdCartQtyUpService = new PrdCartQtyUpService();
		prdCartQtyUpService.upCartQty(name, request);
		ActionForward forward = new ActionForward();
		
		forward.setPath("prdCartList.vo"); 
		forward.setRedirect(true);
		return forward;
	}

}
