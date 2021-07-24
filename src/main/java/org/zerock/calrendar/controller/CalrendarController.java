package org.zerock.calrendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@RequestMapping("/calrendar")
@Controller
@Log4j
public class CalrendarController {
	
	@RequestMapping("/calrendar")
	public void calrendar() {
		log.info("get");
	}
}
