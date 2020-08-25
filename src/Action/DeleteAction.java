package Action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.dao.BoardDAO;

import vo.ActionForward;

public class DeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		
		//글 번호를 가져온다.
		String seq = request.getParameter("seq");
		int num = Integer.parseInt(seq);
		
		BoardDAO dao = BoardDAO.getInstance();
		//삭제할 글에 있는 파일 정보를 가져온다.
		String fileName = dao.getFileName(num);
		
		//글 삭제 - 답글이 있을 경우 답글도 모두 삭제한다.
		boolean result = dao.deleteBoard(num);
		
		//파일 삭제
		if(fileName != null) {
			//파일이 있는 폴더의 절대경로를 가져온다.
			String folder = request.getServletContext().getRealPath("/UploadFolder");
			//파일의 절대경로를 만든다.
			String filePath = folder + "/" + fileName;
			
			File file = new File(filePath);
			if(file.exists()) file.delete(); //파일은 1개만 업로드 되므로 한번만 삭제하면 된다.
		}
		
		if(result) {
			forward.setPath("list.do");
		}else {
			return null;
		}
		return forward;
	}


}
