package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

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
		
		MoviesDAO moviesdao=MoviesDAO.getInstance();
		
		try {
			if(cmd.equals("/input.movies")) {
				String title=request.getParameter("title");
				String genre=request.getParameter("genre");
				moviesdao.insert(new MoviesDTO(0,title,genre,null));
			}else if(cmd.equals("/output.movies")) {
				ArrayList<MoviesDTO> movieslist=moviesdao.selectAll();
				PrintWriter pw=response.getWriter();
				pw.append(g.toJson(movieslist));
				
			} else if(cmd.equals("/delete.movies")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				moviesdao.delete(seq);
				
			}else if(cmd.equals("/update.movies")) {
				int seq=Integer.parseInt(request.getParameter("seq")) ;
				String title=request.getParameter("title");
				String genre=request.getParameter("genre");
				String open_date=request.getParameter("date");
				moviesdao.updateBySeq(seq, title, genre, open_date);	
				
			}
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
