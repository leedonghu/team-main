package org.zerock.game.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.mapper.SpacebarMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SpacebarServiceImpl implements SpacebarService {
	
	@Setter(onMethod_ = @Autowired)
	private SpacebarMapper mapper;
	
	public void insertScore(QuizVO vo) {
		mapper.insertScore(vo);
		
	}

	@Override
	public int firstPride(QuizVO vo) {
		//본인의 점수보다 높은 점수가 없다면 0을 return
		return mapper.firstPride(vo);
	}

	@Override
	public List<QuizVO> prideList() {
		//5등까지의 등수 가져옴
		return mapper.prideList();
	}

}
