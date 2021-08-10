package org.zerock.start.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.game.domain.QuizVO;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.domain.PointVO;
import org.zerock.start.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PointServiceImpl implements PointService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	@Transactional
	public void checkLogin(String id) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜를 String으로 변환
		Calendar car = Calendar.getInstance();
		String today = sdf.format(car.getTime());
		
		//db에 저장된 날짜
		MemberVO vo = mapper.read(id);
		String login = vo.getLogin();
		
		log.info(vo.getLogin());
		log.info(today);
		
		MemberVO vo2 = mapper.read(id);
		
		if(!today.equals(login)) {
			//같지 않을때
			//오늘 날짜와 10포인트를 넣어줌
			vo.setLogin(today);
			double point = vo.getPoint();
			double upPoint = point + 10;
			vo.setPoint(upPoint);
			
			mapper.updateLoginPoint(vo);
			
			//획득한 포인트를 point_inout db에 저장
			double inoutPoint = vo2.getPoint();
			inoutPoint = 10;
			vo2.setPoint(inoutPoint);
			vo2.setPointInOut("로그인");
			mapper.registerPoint(vo2);
			log.info("login point");
		}else {
			
			log.info("more login not point");
		}
		
		
	}

	@Override
	@Transactional
	public void addTenPoint(String id, int pointCode) {
		log.info("board add point");
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double upPoint = point + 10;
		vo.setPoint(upPoint);
		
		mapper.updatePoint(vo);
		
		//획득한 포인트를 point_inout db에 저장
		MemberVO vo2 = mapper.read(id);
		double inoutPoint = vo2.getPoint();
		inoutPoint = 10;
		vo2.setPoint(inoutPoint);
		
		if(pointCode == 2) {
			vo2.setPointInOut("글쓰기 등록");
		}else if(pointCode == 3) {
			vo2.setPointInOut("엘범 등록");
		}
		
		mapper.registerPoint(vo2);
	}

	@Override
	@Transactional
	public void addOnePoint(String id, int pointCode) {
		log.info("reply add point");
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double upPoint = point + 1;
		vo.setPoint(upPoint);
		
		mapper.updatePoint(vo);
		
		//획득한 포인트를 point_inout db에 저장
		MemberVO vo2 = mapper.read(id);
		double inoutPoint = vo2.getPoint();
		inoutPoint = 1;
		vo2.setPoint(inoutPoint);
		
		if(pointCode == 4) {
			vo2.setPointInOut("조회수");
		}else if(pointCode == 5) {
			vo2.setPointInOut("댓글 등록");
		}else if(pointCode == 6) {
			vo2.setPointInOut("대댓글 등록");
		}
		
		mapper.registerPoint(vo2);
		
	}

	@Override
	@Transactional
	public void addPercentPoint(String id) {
		
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double upPoint = point + 0.1;
		vo.setPoint(upPoint);
		
		mapper.updatePoint(vo);
		
		//획득한 포인트를 point_inout db에 저장
		MemberVO vo2 = mapper.read(id);
		double inoutPoint = vo2.getPoint();
		inoutPoint = 0.1;
		vo2.setPoint(inoutPoint);
		vo2.setPointInOut("추천");
		mapper.registerPoint(vo2);
		
	}

	@Override
	@Transactional
	public void subPercentPoint(String id) {
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double downPoint = point - 0.1;
		vo.setPoint(downPoint);
		
		mapper.updatePoint(vo);
		
		//획득한 포인트를 point_inout db에 저장
		MemberVO vo2 = mapper.read(id);
		double inoutPoint = vo2.getPoint();
		inoutPoint = -0.1;
		vo2.setPoint(inoutPoint);
		vo2.setPointInOut("비추천");
		mapper.registerPoint(vo2);
	}

	@Override
	@Transactional
	public void subFivePoint(String id) {
		log.info("퀴즈풀려고 포인트 씀-------------");
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double downPoint = point - 5;
		vo.setPoint(downPoint);
		
		mapper.updatePoint(vo);
		
		//획득한 포인트를 point_inout db에 저장
		MemberVO vo2 = mapper.read(id);
		double inoutPoint = vo2.getPoint();
		inoutPoint = -5;
		vo2.setPointInOut("퀴즈도전");
		vo2.setPoint(inoutPoint);
		mapper.registerPoint(vo2);
		
	}

	@Override
	@Transactional
	public void addQuizPoint(QuizVO vo) {
		log.info("퀴즈풀어 포인트 얻음-------------------");
		MemberVO mvo = mapper.read(vo.getUserId());
		double point = mvo.getPoint();
		double upPoint = point + vo.getPoint();
		
		mvo.setPoint(upPoint);
		
		mapper.updatePoint(mvo);
		
		//획득한 포인트를 point_inout db에 저장
		MemberVO vo2 = mapper.read(vo.getUserId());
		double inoutPoint = vo2.getPoint();
		inoutPoint = vo.getPoint();
		vo2.setPointInOut("퀴즈정답");
		vo2.setPoint(inoutPoint);
		mapper.registerPoint(vo2);
		
	}

	@Override
	@Transactional
	public void subPoint(MemberVO vo, int pointCode) {
		MemberVO mvo = mapper.read(vo.getUserId());
		double mPoint = mvo.getPoint();
		double betPoint = vo.getPoint();
		
		double resultPoint = mPoint - betPoint;
		
		mvo.setPoint(resultPoint);
		
		mapper.updatePoint(mvo);
		
		MemberVO mvo2 = mapper.read(vo.getUserId());
		mvo2.setPoint(-betPoint);
		if(pointCode == 10) {
			mvo2.setPointInOut("공찾기 베팅");
		}else if(pointCode == 13) {
			mvo2.setPointInOut("스페이스바");
		}
		
		mapper.registerPoint(mvo2);
		
	}

	@Override
	@Transactional
	public void addPoint(MemberVO vo, int pointCode) {
		MemberVO mvo = mapper.read(vo.getUserId());
		double mPoint = mvo.getPoint();
		double addPoint = vo.getPoint();
		
		double resultPoint = mPoint + addPoint;
		
		mvo.setPoint(resultPoint);
		
		mapper.updatePoint(mvo);
		
		
		MemberVO mvo2 = mapper.read(vo.getUserId());
		mvo2.setPoint(addPoint);
		if(pointCode == 11) {
			mvo2.setPointInOut("공찾기 성공");
		}else if(pointCode == 12) {
			mvo2.setPointInOut("생일 보너스");
		}else if(pointCode == 14) {
			mvo2.setPointInOut("스페이스바 1등");
		}
		
		mapper.registerPoint(mvo2);
	}

	@Override
	public PointVO getPointInfo(String id) {
		return mapper.getPointInfo(id);
	}

	@Override
	public PointVO getEarnPoint(String id) {
		
		return mapper.getEarnPoint(id);
	}
	
	@Override
	public PointVO getLosePoint(String id) {
		
		return mapper.getLosePoint(id);
	}

}
