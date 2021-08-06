package org.zerock.start.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
	private PointService pointService;
	
	
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

	@Override
	@Transactional
	public void updateApp(ApproveVO vo) {
		
		//승인해준 id의 승인상태를 0으로 바꿈
		mapper.updateApp(vo);
		
		//상태가 모두 0으로 바뀌었을때 member권한을 줌
		String reqId = vo.getReqId();
		List<ApproveVO> list = mapper.getApproveState(reqId);
		
		int state = 0;
		
		for(ApproveVO vo1 : list) {
			state += vo1.getState();
		}
		
		if(state == 0) {
			MemberVO vo2 = getInfo(reqId);
			List<AuthVO> authVO = vo2.getAuthList();
			List<String> authName = new ArrayList<>();
			for(AuthVO auth : authVO) {
				authName.add(auth.getAuth());
			}
			boolean existMember = false;
			
			for(int i = 0; i<authName.size(); i++) {
				if(authName.get(i).equals("ROLE_MEMBER")) {
					existMember = true;
				}
					
			}
			if(!existMember) {
				
				mapper.updateAuth(reqId);
			}
		}
		
		
	}

	@Override
	public ApproveVO getApproveState(String reqId) {
		List<ApproveVO> list =  mapper.getApproveState(reqId);
		
		
		int state = 0;
		for(ApproveVO vo : list) {
			state += vo.getState();
		}
		

			
		ApproveVO appVo  = new ApproveVO();
		appVo.setSize(list.size());
		appVo.setState(state);
		
		return appVo;

	}

	@Override
	@Transactional
	public void birthdayPoint(String id) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜를 String으로 변환
		Calendar car = Calendar.getInstance();
		String today = sdf.format(car.getTime());
		
		MemberVO vo = mapper.read(id);
		String birthday = vo.getBirthday();
		
		String subYear = today.substring(0, 4);
		String subBirthday = birthday.substring(0, 4);
		
		if(!subYear.equals(subBirthday)) {
			//년도가 다를때
			//년도를 업데이트 해주고
			//100point 줌
			vo.setBirthday(today);
			vo.setPoint(100);
			mapper.updateBirthday(vo);
			
			pointService.addPoint(vo, 12);
		}
		
	}



}
