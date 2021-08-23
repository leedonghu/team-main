package org.zerock.shopping.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.shopping.domain.ShoppingVO;
import org.zerock.shopping.service.ShoppingService;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/shopping")
@PreAuthorize("isAuthenticated()")
@Log4j
public class ShoppingController {
	
	
	@Setter(onMethod_ = @Autowired)
	private ShoppingService service;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	
	@GetMapping("/list")
	public void shoppingList(Model model, ShoppingVO vo) {
		log.info("shopping get list");
		log.info(vo.getMainCategory());
		
//		List<ShoppingVO> list = service.shoppingList(vo);
//		log.info(list.size());
//		model.addAttribute("list", list);
	}
	
	@GetMapping("/detail")
	public void shoppingDetail(ShoppingVO vo, Model model) {
		log.info("shopping detail");
		ShoppingVO detail = service.shoppingDetail(vo);
		
		model.addAttribute("detail", detail);
		
		List<MemberVO> mvo = memberService.memberList();
		log.info(mvo);
		model.addAttribute("memberList", mvo);
	}
	
	@PostMapping("/moreView")
	@ResponseBody
	public List<ShoppingVO> moreView(@RequestBody ShoppingVO vo) {
		log.info(vo.getIndex());
		log.info(vo.getMainCategory());
		List<ShoppingVO> list = service.shoppingList(vo);
		
		return list;
	}
	
	@PostMapping("/firstProduct")
	@ResponseBody
	public List<ShoppingVO> firstProduct(@RequestBody ShoppingVO vo) {
		log.info(vo.getMainCategory());
		List<ShoppingVO> list = service.shoppingList(vo);
		
		return list;
	}
	
	@GetMapping("/checkPoint/{productPoint}")
	@ResponseBody
	public boolean checkPoint(@PathVariable("productPoint") int productPoint, Principal principal) {
		MemberVO vo = memberService.getInfo(principal.getName());
		double userPoint = vo.getPoint();
		
		if(userPoint < productPoint) {
			return false;
		}else {
			return true;
		}
	}
	
	@PostMapping("/purchase")
	public String purchase(ShoppingVO vo, Principal principal) {
		log.info(vo);
		String userId = principal.getName();
		vo.setUserId(userId);
		
		service.purchase(vo);
		
		return "redirect:/shopping/list";
	}
	

}
