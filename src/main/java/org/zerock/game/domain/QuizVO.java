package org.zerock.game.domain;

import lombok.Data;

@Data
public class QuizVO {
	
	private int qid;
	private String que;
	private String ans;
	private String date;
	
	private int point;
	private String userId;
	private int enabled;
}
