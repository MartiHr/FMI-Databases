--Part 1
USE movies

--Problem 1
SELECT
	s.STARNAME
FROM MOVIESTAR AS ms
LEFT JOIN STARSIN AS s
	ON ms.NAME = s.STARNAME
WHERE ms.GENDER = 'M'
AND s.MOVIETITLE = 'The Usual Suspects'

--Problem 2
SELECT
	s.STARNAME
FROM STARSIN as s
JOIN MOVIE as m
	ON s.MOVIETITLE = m.TITLE
WHERE m.YEAR = 1995
AND m.STUDIONAME = 'MGM'

--Problem 3
SELECT DISTINCT
	me.NAME
FROM MOVIEEXEC as me
JOIN MOVIE as m
	ON me.CERT# = m.PRODUCERC#
WHERE m.STUDIONAME = 'MGM'

--Problem 4
SELECT 
	m.TITLE
FROM MOVIE as m
WHERE m.LENGTH > (
		SELECT
			LENGTH
		FROM MOVIE AS m2
		WHERE m2.TITLE = 'Star Wars'
	)

--Problem 5
SELECT
	me.NAME
FROM MOVIEEXEC as me
WHERE me.NETWORTH > (
	SELECT
		me.NETWORTH
	FROM MOVIEEXEC as me
	WHERE me.NAME = 'Stephen Spielberg'
)

--Part 2
USE pc

--Problem 1
SELECT
	p.maker,
	l.speed
FROM laptop as l
JOIN product as p
	ON l.model = p.model
WHERE l.hd > 9

--Problem 2
SELECT cm.model, cm.price
FROM (
		(
			SELECT
				model,
				price
			FROM laptop as l
		)
		UNION
		(
			SELECT
				model,
				price
			FROM pc
		)
		UNION
		(
			SELECT
				model,
				price
			FROM printer
		)
) AS cm
LEFT JOIN product as p
	ON p.model = cm.model
WHERE p.MAKER = 'B'

--Problem 3
SELECT DISTINCT
	p.maker
FROM product as p
JOIN laptop as l
	ON p.model = l.model
WHERE p.maker NOT IN (
	SELECT DISTINCT
		p.maker
	FROM product p
	JOIN pc 
		ON p.model = pc.model
)

--Problem 4
SELECT 
	hd
FROM pc
GROUP BY hd
HAVING COUNT(DISTINCT code) >= 2;

--Problem 5
SELECT 
	hd
FROM pc
GROUP BY hd
HAVING COUNT(DISTINCT code) >= 2;

--Problem 6
SELECT DISTINCT
    pc1.model,
    pc2.model 
FROM 
    pc AS pc1
JOIN 
    pc AS pc2
ON 
    pc1.speed = pc2.speed
    AND pc1.ram = pc2.ram
    AND pc1.model < pc2.model

--Part 3
USE ships

--Problem 1
SELECT 
	s.NAME
FROM SHIPS AS s
JOIN CLASSES AS c
	ON s.CLASS = c.CLASS
WHERE c.DISPLACEMENT > 50000

--Problem 2
SELECT 
	s.NAME,
	c.DISPLACEMENT,
	c.NUMGUNS
FROM SHIPS AS s
JOIN CLASSES AS c	
	ON s.CLASS = c.CLASS
JOIN OUTCOMES as o
	ON s.NAME = o.SHIP
WHERE o.BATTLE = 'Guadalcanal'

--Problem 3
SELECT DISTINCT
	c1.COUNTRY AS country
FROM CLASSES as c1
JOIN CLASSES as c2
	ON c1.COUNTRY = c2.COUNTRY
WHERE c1.TYPE = 'bb' 
AND c2.TYPE = 'bc'

--Problem 4
SELECT
	o1.SHIP
FROM OUTCOMES as o1
JOIN OUTCOMES as o2
	on o1.SHIP = o2.SHIP
WHERE o1.RESULT = 'damaged'
AND o2.RESULT IN ('sunk', 'ok')
AND o1.BATTLE != o2.BATTLE