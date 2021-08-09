package org.zerock.shopping.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public void shoppingList(Model model) {
		log.info("shopping get list");
		
		List<ShoppingVO> list = service.shoppingList();
		log.info(list.size());
		model.addAttribute("list", list);
	}
}
