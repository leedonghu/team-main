package org.zerock.start.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.album.service.AlbumService;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.domain.PointVO;
import org.zerock.start.service.MemberService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/start/*")
@Log4j
public class StartController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@Setter(onMethod_ = @Autowired)
	private AlbumService albumService;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	//포인트 코드
	//1-로그인+, 2-글쓰기+, 3-album+, 4-조회수+, 5-댓글+, 6-대댓글+, 7-추천+, 8-비추천-, 9-퀴즈도전-, 10-퀴즈정답+, 10-공찾기 베팅-,11-공찾기 성공+
	
	
	@GetMapping("/login")
	public void login() {
		log.info("loginpage");
	}
	
	@GetMapping("/acc")
	public void acc() {
		log.info("accpage");
	}
	
	@PostMapping("/acc")
	public String register(MemberVO vo) {
		log.info("post acc");
		
		boolean ok = service.registerAcc(vo);
		
		if(ok) {
			return "redirect:/start/login";
		}else {
			return "redirect:/start/acc";
		}
	}
	
	@RequestMapping("/main")
	public void main(String username, Principal principal, MemberVO vo, MultipartFile file, Model model) {
		//login form에서 id값 넘김
		log.info(principal.getName());
		String id = principal.getName();
		
		pointService.checkLogin(id);
		
		if(file != null) {
			//프로필 사진 변경
			albumService.registerProfile(vo, file);
			
		}
		
		//저장된 프로필 사진 가져오기
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
	}
	
	
	
	@RequestMapping("/fail")
	public void fail(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
        String errorMessage = null;
        if (session != null) {
            AuthenticationException ex = (AuthenticationException) session
                    .getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
            if (ex != null) {
                errorMessage = ex.getMessage();
                ex.printStackTrace();
                log.info(ex.getCause());
            }
        }
        model.addAttribute("errorMessage", errorMessage);
        log.info(errorMessage);
        
		
	}
	
	@ResponseBody
	@PostMapping("/checkId")
	public String checkId(String userId) {
		//
		boolean ok = service.checkId(userId);
		String idForm = "^[a-zA-Z0-9]{5,10}$";
		if(ok) {
			return "not ok";
		}else {
			if(userId.matches(idForm)) {
				return "ok";
			}else {
				return "not good";
			}
		}
	}
	
	@ResponseBody
	@PostMapping("/checkPassword")
	public String checkPassword(String userPw) {
		String passwordForm = "^[a-zA-Z0-9]{8,14}$";
		if(userPw.matches(passwordForm)) {
			return "good";
		}else {
			return "";
		}
	}
	
	@GetMapping("/info")
	public void getInfo(String userId, Model model) {
		MemberVO vo = service.getInfo(userId);
		
		model.addAttribute("member", vo);
	}
	
	@PostMapping("/info")
	public String modifyInfo(MemberVO vo, RedirectAttributes rttr) {
		
		vo.setUserPw(encoder.encode(vo.getUserPw()));
		
		boolean ok = service.updateInfo(vo);
		
		if(ok) {
			rttr.addAttribute("result", vo.getUserId());
			rttr.addAttribute("messageTitle", "수정성공");
			rttr.addAttribute("messageBody", "개인정보를 수정하였습니다.");
			
			return "redirect:/start/info?userId=" + vo.getUserId();
		}else {
			rttr.addAttribute("result", vo.getUserId());
			rttr.addAttribute("messageTitle", "수정실패");
			rttr.addAttribute("messageBody", "개인정보를 수정하지 못했습니다.");
			
			return "redirect:/start/info?userId=" + vo.getUserId();
		}
	}
	
	@GetMapping("/point")
	public void getPoint(Principal principal, Model model) {
		log.info("start get point");
				
		//point 정보 리스트
		String id = principal.getName();
		PointVO vo = pointService.getPointInfo(id);
		List<String> inout = vo.getPointInOut();
		int size = inout.size();
		log.info(inout);
		model.addAttribute("point", vo);
		model.addAttribute("size", size);
		
		//얻은 point 정보
		PointVO vo2 = pointService.getEarnPoint(id);
		int size2 = vo2.getPointMap().size();
		model.addAttribute("earn", vo2);
		model.addAttribute("size2", size2);
		
		//잃은 point 정보
		PointVO vo3 = pointService.getLosePoint(id);
		int size3 = vo3.getPointMap().size();
		model.addAttribute("lose", vo3);
		model.addAttribute("size3", size3);
		
	}
	
//	@PostMapping("/acc")
//	public String register() {
//		log.info("post acc");
//		return null;
//	}
}
