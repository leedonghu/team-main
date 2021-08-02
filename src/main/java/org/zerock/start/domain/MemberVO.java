package org.zerock.start.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


@Data
public class MemberVO {
	
	private String userId;
	private String userPw;
	private String userName;
	private String userNickName;
	private String mobileNum;
	private String email;
	private String address;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	private Date regdate;
	private Date updateDate;
	private boolean enabled;
	private double point;
	
	//포인트 사용처
	private String pointInOut;
	int pointCode;
	
	private String login;
	
	private String fileName;
	
	private List<AuthVO> authList;
}
