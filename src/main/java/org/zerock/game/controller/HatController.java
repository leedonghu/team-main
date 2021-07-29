package org.zerock.game.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.service.MemberService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hat")
@Log4j
public class HatController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@GetMapping("/get")
	public void getHat() {
		log.info("hathathat");
	}
	
	@PostMapping("/checkPoint/{betPoint}")
	@ResponseBody
	public boolean checkPoint(@PathVariable("betPoint") double betPoint, Principal principal) {
		log.info("hat checkPoint");
		
		MemberVO mvo = memberService.getInfo(principal.getName());
		
		double mPoint = mvo.getPoint();
		
		//베팅한 point와 실제 유저가 가지고있는 point를 비교함
		//베팅 point가 가지고있는 point보다 크면 false를 return
		//반대는 가지고있는 point에서 베팅 point를 빼줌
		if(betPoint != 0) {
			if(mPoint < betPoint) {
				return false;
			}else {
				mvo.setPoint(betPoint);
				pointService.subPoint(mvo);
				return true;
			
			}
		}else {
			return false;
		}
	}
	
	@PostMapping("/addPoint/{betPoint}")
	@ResponseBody
	public double addPoint(@PathVariable("betPoint") double betPoint, Principal principal) {
		log.info("hat addPoint");
		double resultPoint = 0;
		
		if(betPoint>= 1 && betPoint <=50) {
			resultPoint =  betPoint * (1.5);
		}else if(betPoint > 50 && betPoint <=100) {
			resultPoint = betPoint * 2;
		}else if(betPoint > 100) {
			resultPoint = betPoint * (2.5);
		}
		
		MemberVO mvo = memberService.getInfo(principal.getName());
		mvo.setPoint(resultPoint);
		pointService.addPoint(mvo);
		
		return resultPoint;
	}
}
