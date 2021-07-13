package org.zerock.mapper;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTest {
	
	@Autowired
	MemberMapper mapper;
	
	@Autowired
	PasswordEncoder encoder;

	@Test
	public void test() {
		MemberVO vo = new MemberVO();
		vo.setUserId("bbb");
		vo.setUserPw(encoder.encode("222"));
		vo.setUserName("bbb");
		vo.setMobileNum("01099999999");
		vo.setAddress("seoul");
		vo.setUserNickName("bbb");
		vo.setBirth(Date.valueOf("2020-02-02"));
		vo.setEmail("aa@aa.com");
		
		mapper.registerAcc(vo);
	}

}
