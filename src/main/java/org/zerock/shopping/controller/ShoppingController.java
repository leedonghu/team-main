package org.zerock.shopping.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.shopping.domain.ShoppingVO;
import org.zerock.shopping.service.ShoppingService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/shopping")
@Log4j
public class ShoppingController {
	
	
	@Setter(onMethod_ = @Autowired)
	private ShoppingService service;
	
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
	

}
