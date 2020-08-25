package shop.Action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Action.Action;
import vo.ActionForward;
import com.shop.bean.Prd;
import com.shop.dao.PrdDAO;

public class PrdListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrdDAO dao = PrdDAO.getInstance();
		ArrayList<Prd> prdList = dao.selectPrdList();
		request.setAttribute("prdList", prdList);
		ActionForward forward = new ActionForward();
		
		forward.setPath("prdmain2.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
