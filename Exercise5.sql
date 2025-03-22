--Part 1
USE pc

--Problem 1
SELECT
	CONVERT(decimal(9,2), AVG(pc.speed)) AS AvgSpeed
FROM pc

--Problem 2
SELECT
	p.maker,
	AVG(l.screen) AS AvgScreen
FROM laptop AS l
JOIN product AS p
	ON l.model = p.model
GROUP BY p.maker

--Problem 3
SELECT
	CONVERT(decimal(9, 2), AVG(l.speed)) AS AvgSpeed
FROM laptop AS l
WHERE l.price > 1000

--Problem 4
SELECT
	p.maker,
	CONVERT(decimal(9,2), AVG(price)) AS AvgPrice
FROM pc
JOIN product AS p
	ON pc.model = p.model
WHERE p.maker = 'A'
GROUP BY p.maker

--Problem 5
SELECT 
	u.maker,
	CONVERT(decimal(9,2), AVG(u.price)) AS AvgPrice
FROM
(
	(
		SELECT
			p.maker,
			l.price
		FROM product AS p
		LEFT JOIN laptop AS l
			ON p.model = l.model
	)
	UNION 
	(
		SELECT
			p.maker,
			pc.price
		FROM product AS p
		LEFT JOIN pc
			ON p.model = pc.model
	)
) AS u
WHERE u.maker = 'B'
GROUP BY u.maker

--Problem 6
SELECT
	pc.speed,
	AVG(pc.price) AS AvgPrice
FROM pc
GROUP BY pc.speed

--Problem 7
SELECT
	p.maker,
	COUNT(pc.code) AS number_of_pc
FROM product AS p
JOIN pc
	ON p.model = pc.model
GROUP BY p.maker
HAVING COUNT(DISTINCT pc.code) >= 3

--Problem 8
SELECT DISTINCT
	p.maker,
	pc.price
FROM product AS p
JOIN pc 
	ON p.model = pc.model
WHERE pc.price = (
	SELECT TOP(1)
		pc.price
	FROM pc
	ORDER BY pc.price DESC
)

--OR
--SELECT DISTINCT
--	p.maker,
--	pc.price
--FROM product AS p
--JOIN pc 
--	ON p.model = pc.model
--WHERE pc.price = (
--	SELECT
--		MAX(pc.price)
--	FROM pc
--)

--Problem 9
SELECT
	pc.speed,
	AVG(price) AS AvgPrice
FROM pc
WHERE pc.speed > 800
GROUP BY pc.speed

--Problem 10
SELECT
	p.maker,
	CONVERT(decimal(9, 2), AVG(pc.hd)) AS AvgHDD
FROM product AS p
JOIN pc 
	ON p.model = pc.model
WHERE p.maker IN (
	SELECT DISTINCT
		p.maker
	FROM product AS p
	JOIN printer AS pr
		ON p.model = pr.model
)
GROUP BY p.maker

--Part 2
USE ships

--Problem 1
