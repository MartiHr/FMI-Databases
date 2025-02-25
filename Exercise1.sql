--First part
USE movies
 
--Problem 1
SELECT 
	s.ADDRESS
FROM STUDIO AS s
WHERE s.NAME = 'DISNEY'
 
--Problem 2
SELECT 
	ms.BIRTHDATE
FROM MOVIESTAR as ms
WHERE ms.NAME = 'Jack Nicholson'
 
--Problem 3
SELECT
	s.STARNAME
FROM STARSIN as s
WHERE s.MOVIEYEAR = 1980 
OR s.MOVIETITLE = 'Knight' 	
 
--Problem 4
SELECT
	me.NAME
FROM MOVIEEXEC AS me
WHERE me.NETWORTH > 10000000
 
--Problem 5
SELECT
	ms.NAME
FROM MOVIESTAR as ms
WHERE ms.GENDER = 'M'
 
--Second part
USE pc
 
--Problem 1
SELECT 
	pc.model AS MODEL,
	pc.speed AS MHZ,
	pc.hd AS GB	
FROM pc
WHERE pc.price < 1200
 
--Problem 2
SELECT DISTINCT
	p.maker
FROM product as p
WHERE p.type = 'printer'

--Problem 3
SELECT
	l.model AS MODEL,
	l.ram AS RAM,
	l.screen AS SCREEN
FROM laptop AS l
WHERE l.price > 1000

--Problem 4
SELECT
	*
FROM printer as p
WHERE p.color = 'y'

--Problem 5
SELECT
	model,
	price,
	speed
FROM pc
WHERE cd = '12x' OR cd = '16x' AND price < 2000

--Third part
USE ships

--Problem 1
SELECT
	c.CLASS,
	c.COUNTRY
FROM CLASSES as c
WHERE c.NUMGUNS < 10

--Problem 2
SELECT
	s.NAME AS SHIPNAME
FROM SHIPS as s
WHERE s.LAUNCHED < 1918

--Problem 3
SELECT
	o.SHIP,
	o.BATTLE
FROM OUTCOMES as o
WHERE o.RESULT = 'sunk'

--Problem 4
SELECT
	s.NAME
FROM SHIPS as s
WHERE s.CLASS = s.NAME

--Problem 5
SELECT
	s.NAME
FROM SHIPS AS s
WHERE s.NAME LIKE 'R%'

--Problem 6
SELECT
	s.NAME
FROM SHIPS as s
WHERE s.NAME LIKE '[a-zA-Z]% [a-zA-Z]%'