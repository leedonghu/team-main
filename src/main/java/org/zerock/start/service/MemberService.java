package org.zerock.start.service;

import org.zerock.start.domain.MemberVO;

public interface MemberService {
	
	public boolean registerAcc(MemberVO vo);

	

	public boolean checkId(String userId);



	public MemberVO getInfo(String userId);
}
