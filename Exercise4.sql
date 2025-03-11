--Part 1
USE movies

--Problem 1
SELECT
	m.TITLE,
	me.NAME
FROM MOVIEEXEC AS me
JOIN MOVIE AS m
	ON me.CERT# = m.PRODUCERC#
WHERE me.NAME = (
	SELECT
		me.NAME
	FROM MOVIEEXEC AS me
	JOIN MOVIE	AS m
		ON me.CERT# = m.PRODUCERC#
	WHERE m.TITLE = 'Star Wars'
);

--Problem 2
SELECT DISTINCT
	me.NAME
FROM MOVIEEXEC AS me
JOIN MOVIE AS m	
	ON me.CERT# = m.PRODUCERC#
WHERE m.TITLE IN (
	SELECT
		ss.MOVIETITLE
	FROM STARSIN AS ss
	JOIN MOVIESTAR AS ms
		ON ss.STARNAME = ms.NAME
	WHERE ms.NAME = 'Harrison Ford'
);

--Problem 3
SELECT DISTINCT
	s.NAME,
	ss.STARNAME
FROM STARSIN AS ss
JOIN MOVIE AS m
	ON ss.MOVIETITLE = m.TITLE
JOIN (
	SELECT
		s.NAME
	FROM STUDIO AS s
	JOIN MOVIE AS m
		ON s.NAME = m.STUDIONAME
) AS s
ON m.STUDIONAME = s.NAME
ORDER BY s.NAME ASC

--Problem 4
SELECT 
	ss.STARNAME,
	me.NETWORTH,
	m.TITLE
FROM STARSIN AS ss
JOIN MOVIE AS m
	ON ss.MOVIETITLE = m.TITLE
JOIN MOVIEEXEC AS me 
ON m.PRODUCERC# = me.CERT#
WHERE me.NETWORTH = (
	SELECT TOP(1)
		me.NETWORTH
	FROM MOVIEEXEC AS me
	ORDER BY me.NETWORTH DESC 
);

--Problem 5
SELECT
	ms.NAME,
	ss.MOVIETITLE
FROM MOVIESTAR AS ms
LEFT JOIN STARSIN AS ss
	ON ms.NAME = ss.STARNAME
WHERE ss.MOVIETITLE IS NULL

--Part 2
USE pc

--Problem 1
SELECT
	p.maker,
	p.model,
	p.type
FROM [product] AS p
LEFT JOIN laptop AS l
	ON p.model = l.model
LEFT JOIN pc 
	ON p.model = pc.model
LEFT JOIN printer AS pr 
	ON p.model = pr.model
WHERE l.model IS NULL
	AND pc.model IS NULL
	AND pr.model IS NULL

--Problem 2
(
	SELECT
		p.maker
	FROM product AS p
	JOIN laptop AS l
		ON p.model = l.model
)
INTERSECT
(
	SELECT
		p.maker
	FROM product AS p
	JOIN printer AS pr
		ON p.model = pr.model
)

--Problem 3
SELECT
	l1.hd
FROM laptop AS l1
JOIN laptop AS l2
	ON l1.hd = l2.hd
WHERE l1.code != l2.code

--Problem 3 second way
SELECT DISTINCT
	l1.hd
FROM laptop AS l1
WHERE (
	SELECT 
		COUNT(*)
	FROM laptop AS l2
	WHERE l2.hd = l1.hd
) > 1

--Problem 4
SELECT
	*
FROM pc
LEFT JOIN product AS p
	ON pc.model = p.model
WHERE p.maker IS NULL

--Part 3
USE ships