package org.zerock.game.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.mapper.QuizMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class QuizServiceImpl implements QuizService {
	
	@Setter(onMethod_ = @Autowired)
	private QuizMapper mapper;
	
	@Override
	public QuizVO getQuiz() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜를 String으로 변환
		Calendar car = Calendar.getInstance();
		String today = sdf.format(car.getTime());
		
		return mapper.getQuiz(today);
	}

	@Override
	public void insertAtt(@RequestBody QuizVO vo) {
		
		int cnt = mapper.countQuizAtt(vo);
		
		if(cnt == 0) {
			
			mapper.insertAtt(vo);
		}
		log.info("quiz insertAtt");
		
	}

	@Override
	public QuizVO getQuizAtt(QuizVO vo) {
		
		return mapper.getQuizAtt(vo);
	}

	@Override
	public void updateAtt(QuizVO vo) {
		mapper.updateAtt(vo);
		
	}

	@Override
	@Transactional
	public void updateQuiz(QuizVO vo) {
		//누가 몇번문제를 풀었는지 insert
		mapper.insertQuizCheck(vo);
		
		//문제를 풀었다면 enabled를 0으로
		mapper.updateQuizCheck(vo);
		
	}

}
