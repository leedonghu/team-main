package org.zerock.start.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.start.domain.ApproveVO;
import org.zerock.start.domain.AuthVO;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	@Override
	@Transactional
	public boolean registerAcc(MemberVO vo) {
		
		//비밀번호를 암호화해서 넣어줌
		vo.setUserPw(encoder.encode(vo.getUserPw()));
		
		int cnt = mapper.registerAcc(vo);
		
		//권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserId(vo.getUserId());
		avo.setAuth("ROLE_USER");
		
		mapper.insertAuth(avo);
		
		//회원가입시 권한이 member인 모든 id 검색
		List<MemberVO> allMember = mapper.getAllMember();
		
		
		//받아온 vo의 id를 꺼내서 승인요청 table에 저장
		for(MemberVO mvo : allMember) {
			MemberVO app = new MemberVO();
			app.setAppId(mvo.getUserId());
			
			//회원가입한 id
			app.setReqId(vo.getUserId());
			mapper.insertApprove(app);
		}
		
		
		return cnt == 1;
	}

	@Override
	public boolean checkId(String userId) {
		return mapper.checkId(userId) == 1;
		
	}

	@Override
	public MemberVO getInfo(String userId) {
		
		return mapper.read(userId);
	}

	@Override
	public boolean updateInfo(MemberVO vo) {
		
		return mapper.updateInfo(vo) == 1;
	}

	@Override
	public MemberVO getProfile(String id) {
		
		return mapper.getProfile(id);
	}

	@Override
	public List<ApproveVO> getApproveList(String userId) {
		return mapper.getApproveList(userId);
		
	}



}
