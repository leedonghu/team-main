package org.zerock.start.mapper;

import org.zerock.start.domain.AuthVO;
import org.zerock.start.domain.MemberVO;

public interface MemberMapper {
	
	public int registerAcc(MemberVO vo);

	public void insertAuth(AuthVO avo);

	public MemberVO read(String userId);
}
