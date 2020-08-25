package Action;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.bean.BbsBean;
import com.board.dao.BoardDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import vo.ActionForward;

public class ModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		ActionForward forward = new ActionForward();
		
		int pageNum = Integer.parseInt(request.getParameter("seq"));
		int sPage = 0;
	
//		if(pageNum==null||pageNum.length()==0) {
//			try {
//				sPage = Integer.parseInt(pageNum);
//				System.out.println("sPage값은?" + sPage);
//			} catch (Exception e) {
//				System.out.println("pageNum오류" + e);
//				System.out.println("sPage값은?" + sPage);
//			}
//		}
		
		int fileSize = 10*1024*1024;
		String uploadPath = request.getServletContext().getRealPath("/UploadFolder");
		
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			pageNum = Integer.parseInt(multi.getParameter("seq")); //글 번호.
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			String existFile = multi.getParameter("existFile");
			System.out.println("existFile : " + existFile);
			
			
			//파라미터 값을 자바빈에 세팅한다.
			BbsBean bean = new BbsBean();
			bean.setSeq(pageNum);
//			System.out.println("글번호 값은? : " + pageNum);
			bean.setTitle(title);
//			System.out.println("타이틀 값은? : " + title);
			bean.setContent(content);
//			System.out.println("content 값은? : " + content);
			
			
			//글 수정시 업로드 된 파일 가져오기
			Enumeration<String> fileNames = multi.getFileNames();
			if(fileNames.hasMoreElements()) {
				String fileName = fileNames.nextElement();
				String updateFile = multi.getFilesystemName(fileName);
				System.out.println("fileName : " + fileName);
				System.out.println("updateFile : " + updateFile);
				
				//수정시 새로운 파일을 첨부안했다면 기존의 파일명을 세팅.
				if(updateFile==null) bean.setFile(existFile);
				else //새로운 파일을 첨부했을 경우. 
					bean.setFile(updateFile);
			}
			
			try {
				
				BoardDAO dao = BoardDAO.getInstance();
				int update = dao.updateBoard(bean);
				if(update>0) {
					forward.setRedirect(true);
					forward.setPath("detail.do?seq=" + bean.getSeq());
				}
			}catch (Exception e) {
				System.out.println("action dao에서 : " + e);
			}
		} catch (Exception e) {
			System.out.println("ModifyAction에서 글 수정 오류" + e );

		}
		
		return forward;
	}
	
}
