package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.MoviesDAO;
import dto.MoviesDTO;


@WebServlet("*.movies")
public class MoviesController extends HttpServlet {
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		Gson g=new Gson();
		
		String cmd=request.getRequestURI();
		System.out.println(cmd);
		
		MoviesDAO moviedao=MoviesDAO.getInstance();
		
		try {
			if(cmd.equals("/input.movies")) {
				String title=request.getParameter("title");
				String genre=request.getParameter("genre");
				moviedao.insert(new MoviesDTO(0,title,genre,null));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
