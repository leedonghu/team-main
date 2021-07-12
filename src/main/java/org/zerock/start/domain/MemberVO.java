package org.zerock.start.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;


@Data
public class MemberVO {
	
	private String userId;
	private String userPw;
	private String userName;
	private String userNickName;
	private String mobileNum;
	private String email;
	private Date birth;
	private Date regdate;
	private Date updateDate;
	private boolean enabled;
	
	private List<AuthVO> authList;
}
