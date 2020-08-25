package shop.Action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.dao.PrdDAO;

import Action.Action;
import vo.ActionForward;

public class orderRemoveAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		
		//글 번호를 가져온다.
		String seq = request.getParameter("wish_id");
		int num = Integer.parseInt(seq);
		
		PrdDAO dao = PrdDAO.getInstance();
		
		//글 삭제 - 답글이 있을 경우 답글도 모두 삭제한다.
		boolean result = dao.deleteOrder(num);
		
		
		if(result) {
			forward.setPath("wishList.jsp");
		}else {
			return null;
		}
		return forward;
	}


}
