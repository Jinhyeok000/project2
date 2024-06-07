package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MoviesDTO;


public class MoviesDAO {
	//singletone
	private MoviesDAO() {}
	public static MoviesDAO instance;

	public synchronized static MoviesDAO getInstance() {
		if(instance==null) {
			instance=new MoviesDAO();
		}
		return instance;
	}

	//JNDI
	private Connection getConnection() throws Exception{
		Context ctx=new InitialContext();
		DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}


	// 1. 글 추가하기 insert
	public int insert(MoviesDTO dto) throws Exception {
		String sql = "insert into movies values(movies_seq.nextval,?,?,sysdate)";
		try (Connection con = this.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getGenre());
			return ps.executeUpdate();
		}
	}
	// 삭제하기 delete
	public int delete(int seq) throws Exception{
		   String sql = "delete from movies where seq=?";
		   try(Connection con = this.getConnection();
				   PreparedStatement pstat = con.prepareStatement(sql)){
			   pstat.setInt(1, seq);
			   int result = pstat.executeUpdate();
			   
			   return result;
		   }
	}

}
