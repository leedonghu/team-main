package org.zerock.shopping.domain;

import lombok.Data;

@Data
public class ShoppingVO {
	
	private int productId;
	private String productName;
	private String productDetail;
	private int productPoint;
	private String mainCategory;
	private String middleCategory;
	private String subCategory;
	private String productKeyword;
	private String productPicture;
	
	private int index;
	
	private String userId;
	private String receiverId;
}
