package org.zerock.shopping.mapper;

import java.util.List;

import org.zerock.shopping.domain.ShoppingVO;

public interface ShoppingMapper {

	List<ShoppingVO> shoppingList(ShoppingVO vo);

	ShoppingVO shoppingDetail(ShoppingVO vo);

	void pruchase(ShoppingVO vo);

	int myPresent(String receiverId);

	List<ShoppingVO> presentList(String receiverId);

	List<ShoppingVO> hotItem();

}
