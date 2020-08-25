
package Action;


import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.user.bean.UserBean;
import com.user.dao.UserDAO;

import com.board.bean.BbsBean;
import com.board.dao.BoardDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import vo.ActionForward;
import vo.ImageUtil;

public class WriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		
		String uploadPath = request.getServletContext().getRealPath("/UploadFolder");
		System.out.println("uploadPath : " + uploadPath);
		int fileSize= 10*1024*1024; //10메가임.
		
		
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
//			String fileName = "";
//			
//			Enumeration<String> names = multi.getFileNames();
//
//			if(names.hasMoreElements()) 
//			{
//				String name = names.nextElement();
//				fileName = multi.getFilesystemName(name);
//				System.out.println("fileName : " + fileName);
//			}
//			
			
			BoardDAO dao = BoardDAO.getInstance();
			BbsBean bean = new BbsBean();
			
			String id = (String)session.getAttribute("id");
			
//			UserDAO dao1 = UserDAO.getInstance();
//			UserBean bean1 = new UserBean();
			
			bean.setSeq(bean.getSeq());
			bean.setTitle(multi.getParameter("title"));
			bean.setWriter(id);
			bean.setContent(multi.getParameter("content"));
//			bean.setFile(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
			

			if(multi.getFilesystemName("file")!=null) {
				String file = multi.getFilesystemName("file");
				System.out.println("file이름 " + file);
				bean.setFile(file);
				
			//썸네일 이미지	
				String pattern = file.substring(file.indexOf(".")+1); //jpg,gif..
				System.out.println("패턴 " + pattern);
				String headName = file.substring(0, file.indexOf(".")); //이미지 이름 ex)cat, dog..
				System.out.println("헤드네임 " + headName);
				
			//원본파일
			//imagePath 대로 jsp에 작성해주면 원본 이미지가 등록됨.
				String imagePath = uploadPath + "/" + file;
				File src = new File(imagePath);
				
			//썸네일 이미지 file 객체
			//thumbImagePath 대로 jsp에 작성해주면 resize 메소드가 적용되면서 썸네일 이미지가 등록됨.
				String thumbImagePath = uploadPath + "/" + headName + "_small." + pattern;
				File dest = new File(thumbImagePath);
				if(pattern.equals("jpg")||pattern.equals("gif")) {
					ImageUtil.resize(src, dest, 100, ImageUtil.RATIO);
				}
				
			}
			
			
			boolean result = dao.insertContent(bean);
//			String loginId = dao1.selectLoginId(bean1);
			
			if(result) {
				forward.setPath("list.do");
			}else {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('등록실패.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("글쓰기 오류 : " + e.getMessage());
		}
//		finally {
//			MultipartRequest mReq = null;
//			System.out.println("request getContentType : " + request.getContentType());
//			try {
//			    if (-1 < request.getContentType().indexOf("multipart/form-data")) {
//			     
//			     mReq = new MultipartRequest(request, uploadPath, fileSize,"UTF-8", new DefaultFileRenamePolicy());
//			    }
//			    
//			   }catch (IOException ie) {
//			    System.out.println("ie에서 문제가 생김 : " + ie);
//			   }catch (Exception e) {
//			    System.out.println("finally e에서 문제가 생김 : " + e);;
//			   }
//		}
		
		return forward;
		
	}
	    
}
