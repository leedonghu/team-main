package org.zerock.shopping.service;

import java.util.List;

import org.zerock.shopping.domain.ShoppingVO;

public interface ShoppingService {

	List<ShoppingVO> shoppingList(ShoppingVO vo);

	ShoppingVO shoppingDetail(ShoppingVO vo);

	void purchase(ShoppingVO vo);

	int myPresent(String receiverId);

	List<ShoppingVO> presentList(String receiverId);

	List<ShoppingVO> hotItem();

}
