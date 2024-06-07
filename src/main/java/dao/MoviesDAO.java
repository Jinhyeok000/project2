package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

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
	//2. 삭제하기 delete
	public int delete(int seq) throws Exception{
		   String sql = "delete from movies where seq=?";
		   try(Connection con = this.getConnection();
				   PreparedStatement pstat = con.prepareStatement(sql)){
			   pstat.setInt(1, seq);
			   int result = pstat.executeUpdate();
			   
			   return result;
		   }
	}

	//3. 전체 출력 select
	public ArrayList<MoviesDTO> selectAll() throws Exception{
		String sql="select * from movies order by 1";

		try(Connection con=this.getConnection();
				PreparedStatement ps=con.prepareStatement(sql);
				ResultSet rs=ps.executeQuery();){
			ArrayList<MoviesDTO> list=new ArrayList<MoviesDTO>();
			while(rs.next()){
				int seq=rs.getInt(1);
				String title=rs.getString(2);
				String genre=rs.getString(3);
				Timestamp open_date=rs.getTimestamp(4);

				list.add(new MoviesDTO(seq, title, genre, open_date));

			}
			return list;
		}
	}
	
	public static String ts2Str(Timestamp ts) {
		   SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
		   return sdf.format(ts);
	}
	
	public static Timestamp str2Ts(String strTime) throws Exception{
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		   Timestamp ymdTs = new Timestamp(sdf.parse(strTime).getTime());
		   return ymdTs;
	}
	
	//5. update
	public int updateBySeq(int targetseq, String updatetitle, String updategenre, String updateopen_date) throws Exception{
			String sql="update movies set title=?, genre=?, open_date=? where seq=? ";
			Timestamp tsupdateopen_date= str2Ts(updateopen_date);

			try(Connection con=this.getConnection();
					PreparedStatement ps=con.prepareStatement(sql);){
				ps.setString(1, updatetitle);
				ps.setString(2, updategenre);
				ps.setTimestamp(3, tsupdateopen_date);
				ps.setInt(4, targetseq);
				return ps.executeUpdate();
			}
	}

}
