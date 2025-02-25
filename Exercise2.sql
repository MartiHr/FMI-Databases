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