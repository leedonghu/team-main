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

mainCategory VARCHAR(10) not null,
middleCategory VARCHAR(10) not null,
subCategory VARCHAR(10) not null,
FOREIGN KEY (productId) REFERENCES product (productId)

);

SELECT * from product_purchase;
DELETE from product_purchase 
where purchaseId = 2;

update product
set productName = '3만원 교환권',
productPicture = '3만원 교환권.png'
WHERE productName = '교환권';




SELECT * from product

ORDER BY productId
LIMIT 24, 12;
-- insert
-- https://linuxism.ustd.ip.or.kr/806
-- 여러 로우를 하나의 칼럼에
INSERT INTO product
(productName, productDetail, productPoint, mainCategory, middleCategory, subCategory, productKeyword, productPicture)
VALUES
('커피 교환권', '커피 3만원 교환권', 230, 'B', 'k', '1', '커피,교환권', '커피 교환권.png');


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
		where mainCategory = 'B' 
				
			 
		ORDER BY productId;
UPDATE member
set point = 1000
where userId = 'ccc';
-- 만들것
SELECT
p.productId,
p.productName,
p.productPoint,
p.mainCategory
FROM product p
ORDER BY p.mainCategory 
;
ORDER BY (SELECT 
 count('to')
 from product_purchase
  where userId = 'ccc'
  GROUP BY mainCategory
  )
;
-- ORDER BY (SELECT COUNT(mainCategory) from product_purchase);
 
 SELECT * from product;
 SELECT
 count(1)
 from product_purchase
  where userId = 'ccc'
  GROUP BY mainCategory DESC
  ;

 SELECT * FROM product_purchase
 where userId = 'ccc';



;

SELECT b.productId,
	   b.productName,
       b.productDetail,
	   b.productPoint,
	   b.mainCategory,
	   b.middleCategory,
	   b.subCategory,
	   b.productKeyword,
	   b.productPicture 
FROM
product b
LEFT JOIN
(SELECT  mainCategory mc, count(*) cnt 
 FROM product_purchase 
 WHERE userId = 'CCC'
 GROUP BY mainCategory
 ORDER BY cnt DESC) a
ON a.mc = b.mainCategory
LEFT JOIN 
(SELECT productId id, count(1) pcnt
 FROM product_purchase WHERE userId = 'CCC'
 GROUP BY productId 
 ORDER BY pcnt DESC) c
ON b.productId =  c.id
-- WHERE b.mainCategory = 'A'
ORDER BY a.cnt DESC, b.mainCategory ASC, c.pcnt DESC
;

SELECT mainCategory mc, count(2) mcnt
FROM product_purchase 
GROUP BY mainCategory
ORDER BY mcnt DESC;

SELECT productId id, count(1) pcnt 
FROM product_purchase 
GROUP BY productId
ORDER BY pcnt DESC;

SELECT *
FROM product_purchase;






