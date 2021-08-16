create TABLE product
(
productId int PRIMARY key AUTO_INCREMENT,
productName VARCHAR(100) not null,
productDetail VARCHAR(1024) not null,
productPoint int not null,
mainCategory VARCHAR(10) not null,
middleCategory VARCHAR(10) not null,
subCategory VARCHAR(10) not null,
productKeyword VARCHAR(100) not null,
productPicture VARCHAR(150) not null
);


SELECT * from member;

	SELECT userId, pointInOut, count(1) point
	FROM point_inout
	WHERE userId = 'www' AND point > 0
	GROUP BY pointInOut;

CREATE TABLE product_purchase
(
purchaseId int PRIMARY key AUTO_INCREMENT,
userId VARCHAR(50) not null,
receiverId VARCHAR(50) not null,
productId int not null,
productAmount int not null,
FOREIGN KEY (productId) REFERENCES product (productId)

);

update product
set productName = '3만원 교환권',
productPicture = '3만원 교환권.png'
WHERE productName = '교환권';


SELECT * from product

ORDER BY productId;
LIMIT 24, 12
-- insert
-- https://linuxism.ustd.ip.or.kr/806
-- 여러 로우를 하나의 칼럼에
INSERT INTO product
(productName, productDetail, productPoint, mainCategory, middleCategory, subCategory, productKeyword, productPicture)
VALUES
('사파리 이용권', '사파리', 230, 'D', 'j', '3', '사파리,동물원,이용권', '사파리 이용권.png');


SELECT productId,
			   productName,
			   productDetail,
			   productPoint,
			   mainCategory,
			   middleCategory,
			   subCategory,
			   productKeyword,
			   productPicture
		FROM product
		 
				
			 
		ORDER BY productId;





