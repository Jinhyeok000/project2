package dto;

import java.sql.Timestamp;

public class MoviesDTO {
	private int seq;
	private String title;
	private String genre;
	private Timestamp open_date;
	
	MoviesDTO(){
		
	}
	
	MoviesDTO(int seq, String title, String genre, Timestamp open_date){
		this.seq=seq;
		this.title=title;
		this.genre=genre;
		this.open_date=open_date;
		
	}
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public Timestamp getOpen_date() {
		return open_date;
	}
	public void setOpen_date(Timestamp open_date) {
		this.open_date = open_date;
	}
	

}
