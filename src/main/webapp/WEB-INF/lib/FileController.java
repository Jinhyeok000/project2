package controllers;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.FilesDAO;
import dto.FilesDTO;

/**
 * Servlet implementation class FileController
 */
@WebServlet("*.file")
public class FileController extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		FilesDAO dao = FilesDAO.getInstance();
		Gson g = new Gson();
		
		try {
		
		if(cmd.equals("/upload.file")) {
			int maxSize = 1024*1024*10; // 10 메가 사이즈 제한
			String realPath = request.getServletContext().getRealPath("files"); // 파일이 저장될 위치, 파일 이름 files로 만들기
			
			File uploadPath = new File(realPath); // 저장 위치 폴더를 파일 인스턴스로 생성해준다.
			
			//uploadPath.exists(); // 이 파일이 존재하는 검사
			// mkdir() - 폴더 생성
			if(!uploadPath.exists()) {
				uploadPath.mkdir();
			} // 파일 업로드 폴더가 존재하지 않을 경우 직접 생성
			
			MultipartRequest multi = new MultipartRequest(request,realPath, maxSize,"UTF-8", new DefaultFileRenamePolicy());
			//String message = multi.getParameter("message");
			//System.out.println("클라이언트 메시지 : "  + message );
			
			// 1번 인자 : multipart/form-data로 인코딩 된 request
			// 2번 인자 : 파일이 첨부되어 있다면 파일이 업로드 될 경로
			// 3번 인자 : 업로드 파일 사이즈 제한
			// 4번 인자 : 한글 데이터나 한문 데이터 등에 대한 깨짐을 방지하기 위한 인코딩 처리
			// 5번 인자 : 파일 이름이 겹치는 경우 이름을 자동으로 변경해주는 정책
			// > 파일 업로드 기능 까지 
			
			Enumeration<String> names = multi.getFileNames();
			while(names.hasMoreElements()) {
				String name = names.nextElement();
				String oriName = multi.getOriginalFileName("file"); // 원본 이름
				String sysName = multi.getFilesystemName("file"); // 서버에 저장되었을 때 이름
				
				if(oriName!=null) {dao.insert(new FilesDTO(0,oriName,sysName,0));}
			}
			response.sendRedirect("/index.jsp");
			System.out.println(realPath);	
		
		} else if(cmd.equals("/list.file")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter pw = response.getWriter();
			List<FilesDTO> list = dao.selectAll();
			//request.setAttribute("lists", list);
			//request.getRequestDispatcher("/index.jsp").forward(request, response);
			String result = g.toJson(list); 
			pw.append(result);
		} else if(cmd.equals("/download.file")) {
			
			
			String filepath = request.getServletContext().getRealPath("files");// 다운 받을 파일의 위치 확보
			String sysname = request.getParameter("sysname");//다운 받을 파일 이름 확보
			String oriname = request.getParameter("oriname");
			
			oriname = new String(oriname.getBytes("UTF8"),"ISO-8859-1");
			response.reset();
			response.setHeader("Content-Disposition", "attachment;filename=\""+oriname+"\"");
			
			File target = new File(filepath + "/" + sysname);// 위치와 이름을 결합하여 타겟 파일 인스턴스 생성
			
			byte[] fileContents = new byte[(int)target.length()];// 하드디스크에서 뽑아낸 타겟 파일 내용을 저장할 배열을 준비
			
			try(FileInputStream fis = new FileInputStream(target);
					DataInputStream dis = new DataInputStream(fis);
					ServletOutputStream sos = response.getOutputStream();){
				dis.readFully(fileContents);
				sos.write(fileContents);
				sos.flush();
			}
			
			// 타겟 파일에 스트림을 연결(데이터 통신 준비)
			// 하드디스크에서 타겟 파일 내용을 ram으로 복사
			
			 // 클라이언트에게 데이터를 보낼 수 있는 스트림 개방
			// 파일의 내용을 전송
			
			// 스트림 정리
		}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
