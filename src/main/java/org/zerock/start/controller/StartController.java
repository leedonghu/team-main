package org.zerock.start.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.album.domain.AlbumVO;
import org.zerock.album.service.AlbumService;
import org.zerock.board.domain.BoardVO;
import org.zerock.board.service.BoardService;
import org.zerock.shopping.domain.ShoppingVO;
import org.zerock.shopping.service.ShoppingService;
import org.zerock.start.domain.ApproveVO;
import org.zerock.start.domain.AuthVO;
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
	private BoardService boardService;
	
	@Setter(onMethod_ = @Autowired)
	private ShoppingService shoppingService;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	//포인트 코드
	//1-로그인+, 2-글쓰기+, 3-album+, 4-조회수+, 5-댓글+, 6-대댓글+, 7-추천+, 8-비추천-, 9-퀴즈도전-, 10-퀴즈정답+, 10-공찾기 베팅-,11-공찾기 성공+, 12-생일+, 13-스페이스바-, 14-스페이스바 1등
	
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@GetMapping("/acc")
	public void acc() {
		
	}
	
	@PostMapping("/acc")
	public String register(MemberVO vo) {
		
		
		//회원등록과 member권한을 가진 유저 목록 update
		boolean ok = service.registerAcc(vo);
		
		
		if(ok) {
			return "redirect:/start/login";
		}else {
			return "redirect:/start/acc";
		}
	}
	
	@RequestMapping("/main")
	@Transactional
	public void main(String username, Principal principal, MemberVO vo, MultipartFile file, Model model, HttpSession session) {
		

		//login form에서 id값 넘김
		log.info(principal.getName());
		String id = principal.getName();
		
		pointService.checkLogin(id);
		
		if(file != null) {
			//프로필 사진 변경
			log.info("사진변경!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			albumService.registerProfile(vo, file);
			
		}
		
		//저장된 프로필 사진 가져오기
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
		
		//권한정보 보내줌
		MemberVO vo3 = service.getInfo(id);
		List<AuthVO> authVO = vo3.getAuthList();
		List<String> authName = new ArrayList<>();
		for(AuthVO auth : authVO) {
			authName.add(auth.getAuth());
		}
		model.addAttribute("auth", authName);
		model.addAttribute("size", authName.size());
		
		//로그인한 유저의 권한들을 탐색한 후 member가 있으면 승인해줘야하는 목록을 보내주고
		//member가 없다면 승인요청 상태를 보내줌
		
		boolean existMember = false;
		
		for(int i = 0; i<authName.size(); i++) {
			if(authName.get(i).equals("ROLE_MEMBER")) {
				existMember = true;
			}
				
		}
		
		if(existMember) {
			//user가 승인해줘야될 목록
			List<ApproveVO> appVo = service.getApproveList(id);
			int appSize = appVo.size();
			model.addAttribute("appSize", appSize);
		
		}else {
			
			//승인받지 못한 user의 상황
			ApproveVO appVo2 = service.getApproveState(id);
			if(appVo2 != null) {
				
				model.addAttribute("appState", appVo2);
			}
		}
		
		
		
		//생일자에게 100포인트
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//오늘 날짜를 String으로 변환
		Calendar car = Calendar.getInstance();
		String today = sdf.format(car.getTime());
		String birth = sdf.format(vo3.getBirth());
		//날짜만 비교
		String subToday = today.substring(5);
		String subBirth = birth.substring(5);
		
		//날짜만 같을때 service실행
		if(subToday.equals(subBirth)) {
			
			int cnt = service.birthdayPoint(id);
			if(cnt == 1) {
				
				model.addAttribute("birth", "birthday");
			}
		}
		
		//최신 album 보냄

		List<AlbumVO> albumList = albumService.getMainList();
		model.addAttribute("album", albumList);
		
		//최신 board 보냄
		List<BoardVO> boardList = boardService.mainList();
		for(BoardVO bvo : boardList) {
			log.info(bvo.getBno());
		}
		model.addAttribute("board", boardList);
		
		
		
		//선물함
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
		//hot 아이템
		List<ShoppingVO> shoppingList = shoppingService.hotItem();
		model.addAttribute("hotItem", shoppingList);
		
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
	@PreAuthorize("isAuthenticated()")
	public void getInfo(String userId, Model model) {
		MemberVO vo = service.getInfo(userId);
		
		model.addAttribute("member", vo);
	}
	
	@PostMapping("/info")
	@PreAuthorize("isAuthenticated()")
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
	@PreAuthorize("isAuthenticated()")
	public void getPoint(Principal principal, Model model, MultipartFile file, MemberVO vo) {
		
		String id = principal.getName();
		
		List<ApproveVO> appVo = service.getApproveList(id);
		model.addAttribute("appVo", appVo);
		int appSize = appVo.size();
		model.addAttribute("appSize", appSize);
		
		
		if(file != null) {
			//프로필 사진 변경
			albumService.registerProfile(vo, file);
			
		}
		//저장된 프로필 사진 가져오기
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
				
		//point 정보 리스트
		
		PointVO vo3 = pointService.getPointInfo(id);
		List<String> inout = vo3.getPointInOut();
		int size = inout.size();
		
		model.addAttribute("point", vo3);
		model.addAttribute("size", size);
		
		//얻은 point 정보
		PointVO vo4 = pointService.getEarnPoint(id);
		int size2 = vo4.getPointMap().size();
		model.addAttribute("earn", vo4);
		model.addAttribute("size2", size2);
		
		//잃은 point 정보
		PointVO vo5 = pointService.getLosePoint(id);
		if(vo3 != null) {
			
			int size3 = vo5.getPointMap().size();
			model.addAttribute("lose", vo5);
			model.addAttribute("size3", size3);
		}
		
		//선물함
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
	}
	
	@GetMapping("/approve")
	@PreAuthorize("isAuthenticated()")
	public void approveAuth(Principal principal, Model model, MemberVO vo, MultipartFile file) {
		String id = principal.getName();
		List<ApproveVO> appVo = service.getApproveList(id);
		model.addAttribute("appVo", appVo);
		int appSize = appVo.size();
		model.addAttribute("appSize", appSize);
		
		
		if(file != null) {
			//프로필 사진 변경
			albumService.registerProfile(vo, file);
			
		}
		//저장된 프로필 사진 가져오기
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
		//선물함
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
	}
	
	@PostMapping("/updateApp")
	@ResponseBody
	public void updateApp(@RequestBody ApproveVO vo) {
		//reqId 와 appId를 받은 vo를 가지고 승인요청 update
		
		
		service.updateApp(vo);
	}
	
	@GetMapping("/present")
	public void present(Principal principal, Model model, MemberVO vo, MultipartFile file) {
		String id = principal.getName();
		List<ApproveVO> appVo = service.getApproveList(id);
		model.addAttribute("appVo", appVo);
		int appSize = appVo.size();
		model.addAttribute("appSize", appSize);
		
		
		if(file != null) {
			//프로필 사진 변경
			albumService.registerProfile(vo, file);
			
		}
		//저장된 프로필 사진 가져오기
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
		//선물함 갯수
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
		//선물목록
		List<ShoppingVO> presentList = shoppingService.presentList(id);
		model.addAttribute("presentList", presentList);
	}
	
//	@PostMapping("/acc")
//	public String register() {
//		log.info("post acc");
//		return null;
//	}
}
