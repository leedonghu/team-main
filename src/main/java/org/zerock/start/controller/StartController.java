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
	
	//????????? ??????
	//1-?????????+, 2-?????????+, 3-album+, 4-?????????+, 5-??????+, 6-?????????+, 7-??????+, 8-?????????-, 9-????????????-, 10-????????????+, 10-????????? ??????-,11-????????? ??????+, 12-??????+, 13-???????????????-, 14-??????????????? 1???
	
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@GetMapping("/acc")
	public void acc() {
		
	}
	
	@PostMapping("/acc")
	public String register(MemberVO vo) {
		
		
		//??????????????? member????????? ?????? ?????? ?????? update
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
		

		//login form?????? id??? ??????
		log.info(principal.getName());
		String id = principal.getName();
		
		pointService.checkLogin(id);
		
		if(file != null) {
			//????????? ?????? ??????
			log.info("????????????!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			albumService.registerProfile(vo, file);
			
		}
		
		//????????? ????????? ?????? ????????????
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
		
		//???????????? ?????????
		MemberVO vo3 = service.getInfo(id);
		List<AuthVO> authVO = vo3.getAuthList();
		List<String> authName = new ArrayList<>();
		for(AuthVO auth : authVO) {
			authName.add(auth.getAuth());
		}
		model.addAttribute("auth", authName);
		model.addAttribute("size", authName.size());
		
		//???????????? ????????? ???????????? ????????? ??? member??? ????????? ????????????????????? ????????? ????????????
		//member??? ????????? ???????????? ????????? ?????????
		
		boolean existMember = false;
		
		for(int i = 0; i<authName.size(); i++) {
			if(authName.get(i).equals("ROLE_MEMBER")) {
				existMember = true;
			}
				
		}
		
		if(existMember) {
			//user??? ?????????????????? ??????
			List<ApproveVO> appVo = service.getApproveList(id);
			int appSize = appVo.size();
			model.addAttribute("appSize", appSize);
		
		}else {
			
			//???????????? ?????? user??? ??????
			ApproveVO appVo2 = service.getApproveState(id);
			if(appVo2 != null) {
				
				model.addAttribute("appState", appVo2);
			}
		}
		
		
		
		//??????????????? 100?????????
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		//?????? ????????? String?????? ??????
		Calendar car = Calendar.getInstance();
		String today = sdf.format(car.getTime());
		String birth = sdf.format(vo3.getBirth());
		//????????? ??????
		String subToday = today.substring(5);
		String subBirth = birth.substring(5);
		
		//????????? ????????? service??????
		if(subToday.equals(subBirth)) {
			
			int cnt = service.birthdayPoint(id);
			if(cnt == 1) {
				
				model.addAttribute("birth", "birthday");
			}
		}
		
		//?????? album ??????

		List<AlbumVO> albumList = albumService.getMainList();
		model.addAttribute("album", albumList);
		
		//?????? board ??????
		List<BoardVO> boardList = boardService.mainList();
		for(BoardVO bvo : boardList) {
			log.info(bvo.getBno());
		}
		model.addAttribute("board", boardList);
		
		
		
		//?????????
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
		//hot ?????????
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
			rttr.addAttribute("messageTitle", "????????????");
			rttr.addAttribute("messageBody", "??????????????? ?????????????????????.");
			
			return "redirect:/start/info?userId=" + vo.getUserId();
		}else {
			rttr.addAttribute("result", vo.getUserId());
			rttr.addAttribute("messageTitle", "????????????");
			rttr.addAttribute("messageBody", "??????????????? ???????????? ???????????????.");
			
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
			//????????? ?????? ??????
			albumService.registerProfile(vo, file);
			
		}
		//????????? ????????? ?????? ????????????
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
				
		//point ?????? ?????????
		
		PointVO vo3 = pointService.getPointInfo(id);
		List<String> inout = vo3.getPointInOut();
		int size = inout.size();
		
		model.addAttribute("point", vo3);
		model.addAttribute("size", size);
		
		//?????? point ??????
		PointVO vo4 = pointService.getEarnPoint(id);
		int size2 = vo4.getPointMap().size();
		model.addAttribute("earn", vo4);
		model.addAttribute("size2", size2);
		
		//?????? point ??????
		PointVO vo5 = pointService.getLosePoint(id);
		if(vo3 != null) {
			
			int size3 = vo5.getPointMap().size();
			model.addAttribute("lose", vo5);
			model.addAttribute("size3", size3);
		}
		
		//?????????
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
			//????????? ?????? ??????
			albumService.registerProfile(vo, file);
			
		}
		//????????? ????????? ?????? ????????????
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
		//?????????
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
	}
	
	@PostMapping("/updateApp")
	@ResponseBody
	public void updateApp(@RequestBody ApproveVO vo) {
		//reqId ??? appId??? ?????? vo??? ????????? ???????????? update
		
		
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
			//????????? ?????? ??????
			albumService.registerProfile(vo, file);
			
		}
		//????????? ????????? ?????? ????????????
		MemberVO vo2 = service.getProfile(id);
		model.addAttribute("profile", vo2);
		
		//????????? ??????
		int myPresent = shoppingService.myPresent(id);
		model.addAttribute("myPresent", myPresent);
		
		//????????????
		List<ShoppingVO> presentList = shoppingService.presentList(id);
		model.addAttribute("presentList", presentList);
	}
	
//	@PostMapping("/acc")
//	public String register() {
//		log.info("post acc");
//		return null;
//	}
}
