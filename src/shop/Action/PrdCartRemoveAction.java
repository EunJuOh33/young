package shop.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import com.shop.svc.PrdCartRemoveService;
import vo.ActionForward;
	
public class PrdCartRemoveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String[] nameArray = request.getParameterValues("remove");
			PrdCartRemoveService prdCartRemoveService = new PrdCartRemoveService();
			prdCartRemoveService.cartRemove(request, nameArray);
			ActionForward forward = new ActionForward();
			
			forward.setPath("prdCartList.do");
			forward.setRedirect(true);
			return forward;
	}

}
