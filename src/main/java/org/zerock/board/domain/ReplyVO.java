package org.zerock.board.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int rno;
	private int bno;
	private String content;
	private String replyer;
	
	private Date replyDate;
	
	private Date updateDate;
	
	private int good;
	private int bad;
	
	private String replyerName;
	
	
}
