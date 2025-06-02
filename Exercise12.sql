--Problem 1

CREATE DATABASE FurnitureCompany

USE FurnitureCompany

--Part 1
CREATE TABLE Customer (
	CustomerId INT PRIMARY KEY IDENTITY,
	CustomerName NVARCHAR(30) NOT NULL,
	CustomerAddress NVARCHAR(50) NOT NULL,
	CustomerCity NVARCHAR(50) NOT NULL,
	CityCode INT NOT NULL
);

CREATE TABLE [Order] (
	OrderId INT PRIMARY KEY,
	OrderDate DATETIME2 NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customer(CustomerId) NOT NULL,
)	

CREATE TABLE [Product] (
	ProductId INT PRIMARY KEY,
	ProductDescription NVARCHAR(200),
	ProductFinish NVARCHAR(50) CHECK(ProductFinish IN (N'череша', N'естествен ясен', N'бял ясен',
		N'червен дъб', N'естествен дъб', N'орех')) NOT NULL,
	StandardPrice DECIMAL(9, 2) NOT NULL,
	ProductLineId INT NOT NULL
)

CREATE TABLE OrderLine (
	OrderId INT FOREIGN KEY REFERENCES [Order](OrderId) NOT NULL,
	ProductId INT FOREIGN KEY REFERENCES [Product](ProductId) NOT NULL,
	OrderedQuantity INT CHECK(OrderedQuantity > 0),
	PRIMARY KEY(OrderId, ProductId)
)

INSERT INTO Customer VALUES
(N'Иван Петров', N'ул. Лавеле 8', N'София', N'1000'),
(N'Камелия Янева', N'ул. Иван Шишман 3', N'Бургас', N'8000'),
(N'Васил Димитров', N'ул. Абаджийска 87', 'Пловдив', '4000'),
(N'Ани Милева', N'бул. Владислав Варненчик 56', N'Варна',N'9000');

INSERT INTO Product VALUES
(1000, N'офис бюро', N'череша', 195, 10),
(1001, N'директорско бюро', N'червен дъб', 250, 10),
(2000, N'офис стол', N'череша', 75, 20),
(2001, N'директорски стол', N'естествен дъб', 129, 20),
(3000, N'етажерка за книги', N'естествен ясен', 85, 30),
(4000, N'настолна лампа', N'естествен ясен', 35, 40);

INSERT INTO [Order] VALUES
(100, '2013-01-05', 1),
(101, '2013-12-07', 2),
(102, '2014-10-03', 3),
(103, '2014-10-08', 2),
(104, '2015-10-05', 1),
(105, '2015-10-05', 4),
(106, '2015-10-06', 2),
(107, '2016-01-06', 1);

INSERT INTO OrderLine VALUES
(100, 4000, 1),
(101, 1000, 2),
(101, 2000, 2),
(102, 3000, 1),
(102, 2000, 1),
(106, 4000, 1),
(103, 4000, 1),
(104, 4000, 1),
(105, 4000, 1),
(107, 4000, 1);

--Problem 2
SELECT
	p.ProductId,
	p.ProductDescription,
	COUNT(p.ProductId) AS productCount
FROM Product AS p
JOIN OrderLine AS ol
		ON p.ProductId = ol.ProductId
GROUP BY p.ProductId, p.ProductDescription

--Problem 3
SELECT
	p.ProductId,
	p.ProductDescription,
	SUM(ol.OrderedQuantity) AS orderedCount
FROM Product AS p
LEFT JOIN OrderLine AS ol
		ON p.ProductId = ol.ProductId
GROUP BY p.ProductId, p.ProductDescription

--Problem 4
SELECT
	c.CustomerName,
	SUM(ol.OrderedQuantity * p.StandardPrice) AS TotalMoneySpent
FROM Customer AS c
JOIN [Order] AS o
	ON c.CustomerId = o.CustomerId
JOIN OrderLine AS ol
	ON o.OrderId = ol.OrderId
JOIN Product AS p
	ON ol.ProductId = p.ProductId
GROUP BY c.CustomerName

--Part 2
USE pc

--Problem 5
SELECT DISTINCT
	p.maker
FROM product AS p
JOIN laptop AS l
	ON p.model = l.model
WHERE p.maker IN (
	SELECT DISTINCT
		p.maker
	FROM product AS p
	JOIN printer AS pr
		ON p.model = pr.model
)

SELECT DISTINCT
	p.maker
FROM product AS p
JOIN laptop AS l
	ON p.model = l.model
INTERSECT
SELECT DISTINCT
	p.maker
FROM product AS p
JOIN printer AS pr
	ON p.model = pr.model

--Problem 6
UPDATE pc
SET price = price * 0.95
WHERE pc.model IN (
    SELECT 
		p.model
    FROM product AS p
    JOIN (
        SELECT 
			maker
        FROM product AS p2
        JOIN printer AS pr 
			ON p2.model = pr.model
        GROUP BY p2.maker
        HAVING AVG(pr.price) > 200 --Should be 800 but then no results
    ) AS rich_makers 
		ON p.maker = rich_makers.maker
);

--Problem 7
SELECT
	pc.hd,
	MIN(pc.price) AS leastExpensive
FROM pc
WHERE pc.hd >= 10 
	AND pc.hd <= 30
GROUP BY pc.hd

--Part 3
USE ships

--Problem 8
-- b)
CREATE VIEW guadalcanal_countries AS
SELECT 
	COUNT(COUNTRY) as Countries_Count
FROM CLASSES
JOIN SHIPS
	ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES
	ON SHIPS.NAME = OUTCOMES.SHIP
JOIN BATTLES
	ON BATTLES.NAME = OUTCOMES.BATTLE
WHERE BATTLES.NAME = 'Guadalcanal'
GROUP BY BATTLES.NAME

CREATE VIEW more_countries_info AS
SELECT BATTLES.NAME
FROM CLASSES
JOIN SHIPS
    ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES
    ON SHIPS.NAME = OUTCOMES.SHIP
JOIN BATTLES
    ON BATTLES.NAME = OUTCOMES.BATTLE
GROUP BY BATTLES.NAME
HAVING COUNT(COUNTRY) > (SELECT * FROM guadalcanal_countries)

-- a)
CREATE VIEW guadalcanal_ships AS
SELECT COUNT(SHIPS.NAME) as Countries_Count
FROM CLASSES
JOIN SHIPS
    ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES
    ON SHIPS.NAME = OUTCOMES.SHIP
JOIN BATTLES
    ON BATTLES.NAME = OUTCOMES.BATTLE
WHERE BATTLES.NAME = 'Guadalcanal'
GROUP BY BATTLES.NAME

CREATE VIEW more_ships_info AS
SELECT  
	BATTLES.NAME, 
	COUNT(SHIPS.NAME) AS shipsCount
FROM CLASSES
JOIN SHIPS
    ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES
    ON SHIPS.NAME = OUTCOMES.SHIP
JOIN BATTLES
    ON BATTLES.NAME = OUTCOMES.BATTLE
GROUP BY BATTLES.NAME
HAVING COUNT(SHIPS.NAME) > (SELECT * FROM guadalcanal_ships)

--Problem 9
DELETE FROM OUTCOMES
WHERE OUTCOMES.BATTLE IN (
	SELECT 
		BATTLES.NAME
    FROM BATTLES 
	JOIN OUTCOMES
		ON BATTLES.NAME = OUTCOMES.BATTLE
    GROUP BY BATTLES.NAME
    HAVING COUNT(SHIP) = 1
)




