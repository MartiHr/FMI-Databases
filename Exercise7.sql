--Part 1
USE movies

--Problem 1
INSERT INTO MOVIESTAR(NAME, BIRTHDATE) VALUES
('Nicole Kidman', '1967-06-20')

--Problem 2
DELETE FROM MOVIEEXEC
WHERE NETWORTH < 30000000

--Problem 3
DELETE FROM MOVIESTAR
WHERE ADDRESS IS NULL

--Part 2
USE pc

--Problem 4
INSERT INTO [product](maker, model, [type]) VALUES
('C', '1100','PC')

INSERT INTO pc(code, model, speed, ram, hd, cd, price) VALUES
(12, '1100', 2400, 2048, 500, '52x', 299)

--Problem 5
DELETE FROM pc
WHERE pc.model = '1100'

--Problem 6
DELETE FROM laptop 
WHERE laptop.model NOT IN (
	SELECT DISTINCT
		p.maker
	FROM product AS p
	WHERE p.type = 'Printer'
)

--Problem 7
UPDATE product 
	SET maker = 'A'
WHERE maker = 'B'

--Problem 8
UPDATE pc
	SET price /= 2,
		hd += 20
	
--Problem 9
UPDATE laptop
	SET screen += 1
WHERE model IN (
	SELECT
		p.model
	FROM product AS p
	WHERE p.type = 'laptop'
	AND	p.maker = 'B'
)

--Part 3
USE ships

--Problem 10
INSERT INTO SHIPS(NAME, CLASS, LAUNCHED) VALUES
('Nelson', 'Nelson', 1927),
('Rodney', 'Nelson', 1927)

INSERT INTO CLASSES (NUMGUNS, BORE, DISPLACEMENT, CLASS, TYPE, COUNTRY)
VALUES (9, 16, 34000, 'Nelson', 'bb', 'Gt.Britain')

--Problem 11
DELETE FROM SHIPS
WHERE NAME IN (
	SELECT
		o.SHIP
	FROM OUTCOMES AS o
	WHERE o.RESULT = 'sunk'
)

--Problem 12
UPDATE CLASSES
	SET BORE *= 2.5,
	DISPLACEMENT -= DISPLACEMENT / 11