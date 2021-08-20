package org.zerock.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.zerock.shopping.domain.ShoppingVO;
import org.zerock.shopping.mapper.ShoppingMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ShoppingServiceImpl implements ShoppingService {
	
	@Setter(onMethod_ = @Autowired)
	private ShoppingMapper mapper;
	
	@Override
	public List<ShoppingVO> shoppingList(ShoppingVO vo) {
		log.info(vo.getMainCategory());
		
		if(vo.getMainCategory().equals("")) {
			vo.setMainCategory(null);
		}
		
		return mapper.shoppingList(vo);
		
	}

	@Override
	public ShoppingVO shoppingDetail(ShoppingVO vo) {
		
		return mapper.shoppingDetail(vo);
	}

	@Override
	public void purchase(ShoppingVO vo) {
		mapper.pruchase(vo);
		
	}

}
