package Action;

import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class FileDownloadAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//다운로드할 파일명을 가져온다.
		String fileName = request.getParameter("file_name");
		
		//파일이 있는 절대경로를 가져온다.
		//현재 업로드된 파일은 UploadFolder 파일에 있다.
		String folder = request.getServletContext().getRealPath("UploadFolder");
		
		//파일의 절대경로를 만든다.
		String filePath = folder + "/" + fileName;
		
		try {
			File file = new File(filePath);
			byte b[] = new byte[(int) file.length()];
			
			//page의 ContentType 등을 동적으로 바꾸기 위해 초기화 시킴.
			response.reset();
			response.setContentType("application/octet-stream");
			
			//한글 인코딩.
			String encoding = new String(fileName.getBytes("UTF-8"),"8859_1");
			
			//파일 링크를 클릭했을 때 다운로드 저장 화면이 출력되게 처리하는 부분.
			response.setHeader("Content-Disposition",  "attachment;filename="+ encoding);
			response.setHeader("Content-Length", String.valueOf(file.length()));
			
			if(file.isFile()) //파일이 있을 경우.
			{
				FileInputStream fileInputStream = new FileInputStream(file);
				ServletOutputStream servletOutputStream = response.getOutputStream();
				
				//파일을 읽어서 클라이언트 쪽으로 저장한다.
				int readNum = 0;
				while((readNum = fileInputStream.read(b)) != -1) {
					servletOutputStream.write(b,0,readNum);
				}
				
				servletOutputStream.close();
				fileInputStream.close();
			}
			
			
		} catch (Exception e) {
			System.out.println("Download Exception : " + e.getMessage());
		}
		
		return null;
	}
	
}
