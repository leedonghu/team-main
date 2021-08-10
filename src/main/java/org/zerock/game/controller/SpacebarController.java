package org.zerock.game.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.service.SpacebarService;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.service.MemberService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/spacebar")
@Controller
@Log4j
public class SpacebarController {
	
	@Setter(onMethod_ = @Autowired)
	private SpacebarService service;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	
	@GetMapping("/get")
	public void space(Model model) {
		log.info("space get");
		
		List<QuizVO> list = service.prideList();
		model.addAttribute("list", list);
	}
	
	@PostMapping("/score")
	@ResponseBody
	public int score(@RequestBody QuizVO vo, Principal principal) {
		log.info(vo.getScore());
		String userId = principal.getName();
		vo.setUserId(userId);
		
		//유저 아이디와 점수를 저장
		service.insertScore(vo);
		
		//1등인지 확인
		int pride = service.firstPride(vo);
		
		MemberVO vo2 = memberService.getInfo(userId);
		if(pride == 0) {
			//200point 지급
			vo2.setPoint(150);
			pointService.addPoint(vo2, 14);
			//int값 리턴
			log.info(pride);
			return pride;
		}else if(pride == 1) {
			log.info(pride);
			//2등일때 100point 지급
			vo2.setPoint(100);
			pointService.addPoint(vo2, 14);
			return pride;
		}else if(pride == 2) {
			//3등일때 75point 지급
			vo2.setPoint(75);
			pointService.addPoint(vo2, 14);
			return pride;
		}else if(pride == 3) {
			//4등일때 50point 지급
			vo2.setPoint(50);
			pointService.addPoint(vo2, 14);
			return pride;
		}else if(pride == 4) {
			//5등일때 25point 지급
			vo2.setPoint(25);
			pointService.addPoint(vo2, 14);
			return pride;
		}else {
			return pride;
		}
	}
	
	@GetMapping("/checkPoint")
	@ResponseBody
	public boolean checkPoint(Principal principal) {
		//25point가 있는지 확인
		String userId = principal.getName();
		MemberVO vo = memberService.getInfo(userId);
		Double mPoint = vo.getPoint();
		
		if(mPoint < 25) {
			return false;
		}else {
			vo.setPoint(25);
			pointService.subPoint(vo, 13);
			return true;
		}
		
	}
}
