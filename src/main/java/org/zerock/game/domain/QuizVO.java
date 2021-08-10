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
	private String userName;
	private int contact;
	private int click;
	private int solve;
	
	private int score;
	
	public int getState() {
		return this.contact + this.click + this.solve;
	}
}
