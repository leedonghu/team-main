package org.zerock.start.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
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

}
