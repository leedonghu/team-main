package org.zerock.start.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PointServiceImpl implements PointService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
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
		
		
		
		if(!today.equals(login)) {
			//같지 않을때
			//오늘 날짜와 10포인트를 넣어줌
			vo.setLogin(today);
			double point = vo.getPoint();
			double upPoint = point + 10;
			vo.setPoint(upPoint);
			
			mapper.updateLoginPoint(vo);
			log.info("login point");
		}else {
			
			log.info("more login not point");
		}
		
		
	}

	@Override
	public void addTenPoint(String id) {
		log.info("board add point");
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double upPoint = point + 10;
		vo.setPoint(upPoint);
		
		mapper.updatePoint(vo);
		
	}

	@Override
	public void addOnePoint(String id) {
		log.info("reply add point");
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double upPoint = point + 1;
		vo.setPoint(upPoint);
		
		mapper.updatePoint(vo);
		
	}

	@Override
	public void addPercentPoint(String id) {
		
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double upPoint = point + 0.1;
		vo.setPoint(upPoint);
		
		mapper.updatePoint(vo);
		
	}

	@Override
	public void subPercentPoint(String id) {
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double downPoint = point - 0.1;
		vo.setPoint(downPoint);
		
		mapper.updatePoint(vo);
	}

	@Override
	public void subFivePoint(String id) {
		MemberVO vo = mapper.read(id);
		double point = vo.getPoint();
		double downPoint = point - 5;
		vo.setPoint(downPoint);
		
		mapper.updatePoint(vo);
		
	}

}
