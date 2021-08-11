package org.zerock.album.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AlbumVO {
	
	private int ano;
	private String title;
	private String comment;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private List<FileVO> fileName;
	
	private String firstFile;
	private String main;
}
