package org.zerock.game.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.mapper.QuizMapper;

import lombok.Setter;

@Service
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

}
