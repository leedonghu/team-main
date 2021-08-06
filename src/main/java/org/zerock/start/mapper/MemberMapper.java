package org.zerock.start.mapper;

import java.util.List;

import org.zerock.start.domain.ApproveVO;
import org.zerock.start.domain.AuthVO;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.domain.PointVO;

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

	public void registerPoint(MemberVO vo2);

	public PointVO getPointInfo(String userId);

	public PointVO getEarnPoint(String id);

	public PointVO getLosePoint(String id);

	public List<MemberVO> getAllMember();

	public void insertApprove(MemberVO vo);

	public List<ApproveVO> getApproveList(String appId);

	public void updateApp(ApproveVO vo);

	public List<ApproveVO> getApproveState(String userId);

	public void updateAuth(String userId);

	public void updateBirthday(MemberVO vo);


}
