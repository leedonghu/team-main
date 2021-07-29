package org.zerock.game.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.mapper.QuizMapper;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QuizServiceImpl implements QuizService {
	
	@Setter(onMethod_ = @Autowired)
	private QuizMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	

	@Override
	public QuizVO getQuiz() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜를 String으로 변환
		Calendar car = Calendar.getInstance();
		String today = sdf.format(car.getTime());
		
		return mapper.getQuiz(today);
	}


	@Override
	@Transactional
	public void insertState(QuizVO vo) {
		int cnt = mapper.countQuizState(vo);
		
		if(cnt == 0) {
			vo.setContact(1);
			mapper.insertState(vo);
			mapper.updateContact(vo);
		}
		log.info("quiz insertAtt");
		
	}

	@Override
	@Transactional
	public void updateClick(QuizVO vo) {
		log.info("service attQuiz----------------");
		mapper.updateClick(vo);
		pointService.subFivePoint(vo.getUserId());
		
	}

	@Override
	public QuizVO getQuizState(QuizVO vo) {
		
		return mapper.getQuizState(vo);
	}


	@Override
	@Transactional
	public void updateSolve(QuizVO vo) {
		mapper.updateSolve(vo);
		pointService.addQuizPoint(vo);
		
	}




}
