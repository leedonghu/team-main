package org.zerock.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.zerock.shopping.domain.ShoppingVO;
import org.zerock.shopping.mapper.ShoppingMapper;

import lombok.Setter;

@Controller
public class ShoppingServiceImpl implements ShoppingService {
	
	@Setter(onMethod_ = @Autowired)
	private ShoppingMapper mapper;
	
	@Override
	public List<ShoppingVO> shoppingList(ShoppingVO vo) {
		return mapper.shoppingList(vo);
		
	}

}
