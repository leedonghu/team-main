package org.zerock.start.service;

import java.util.List;

import org.zerock.start.domain.ApproveVO;
import org.zerock.start.domain.MemberVO;

public interface MemberService {
	
	public boolean registerAcc(MemberVO vo);

	

	public boolean checkId(String userId);



	public MemberVO getInfo(String userId);



	public boolean updateInfo(MemberVO vo);



	public MemberVO getProfile(String id);



	public List<ApproveVO> getApproveList(String id);



	public void updateApp(ApproveVO vo);



	public ApproveVO getApproveState(String reqId);
}
