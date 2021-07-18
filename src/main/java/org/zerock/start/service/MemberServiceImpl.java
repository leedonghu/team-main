package org.zerock.start.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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



}
