package org.zerock.shopping.mapper;

import java.util.List;

import org.zerock.shopping.domain.ShoppingVO;

public interface ShoppingMapper {

	List<ShoppingVO> shoppingList(ShoppingVO vo);

}
