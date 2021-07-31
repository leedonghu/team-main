package org.zerock.start.mapper;

import org.zerock.start.domain.AuthVO;
import org.zerock.start.domain.MemberVO;

public interface MemberMapper {
	
	public int registerAcc(MemberVO vo);

	public void insertAuth(AuthVO avo);

	public MemberVO read(String userId);

	public int checkId(String userId);

	public int updateInfo(MemberVO vo);

	public MemberVO getDate(String id);

	public void updateLoginPoint(MemberVO vo);

	public void updatePoint(MemberVO vo);

	public MemberVO getProfile(String id);


}
