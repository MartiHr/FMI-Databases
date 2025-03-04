--Part 1
USE movies

--Problem 1
SELECT
	m.NAME
FROM MOVIESTAR AS m
WHERE m.GENDER = 'F'
AND m.NAME IN
		(
			SELECT
				me.NAME
			FROM MOVIEEXEC as me
			WHERE me.NETWORTH > 1000000
		);

--Problem 2
SELECT
	m.NAME
FROM MOVIESTAR AS m
WHERE m.NAME NOT IN
		(
			SELECT
				me.NAME
			FROM MOVIEEXEC as me
			WHERE me.NETWORTH > 1000000
		)

--Problem 3
SELECT 
	m.TITLE
FROM MOVIE as m
WHERE m.LENGTH > (
					SELECT 
						m2.LENGTH
					FROM MOVIE as m2
					WHERE m2.TITLE = 'Star Wars'
				 );

--Problem 4
SELECT 
	m.TITLE,
	me.NAME
FROM MOVIEEXEC as me
JOIN MOVIE AS m
	ON me.CERT# = m.PRODUCERC# 
WHERE me.NETWORTH > 
		(
			SELECT
				me2.NETWORTH
			FROM MOVIEEXEC as me2
			WHERE me2.NAME = 'Merv Griffin'
		);

--Part 2
USE pc

--Problem 1
SELECT DISTINCT
	p.maker
FROM product AS p
WHERE p.model IN 
		(
			SELECT
				pc.model
			FROM pc
			WHERE pc.speed > 500
		)
ORDER BY p.maker DESC;

--Problem 2
SELECT 
	p1.code,
	p1.model,
	p1.price
FROM printer AS p1 
WHERE p1.price >= ALL 
				(
					SELECT
						p2.price
					FROM printer AS p2
				);

--Problem 3
SELECT
	*
FROM laptop AS l1
WHERE l1.speed < ALL
				(
					SELECT
						pc.speed
					FROM pc
				);

--Problem 4
SELECT
	model,
	price
FROM (
	SELECT
		model,
		price
	FROM laptop
	UNION
	SELECT 
		model,
		price
	FROM pc
	UNION
	SELECT 
		model,
		price
	FROM printer
) AS products
WHERE price >= ALL (
	SELECT price FROM laptop
    UNION 
    SELECT price FROM pc
    UNION
    SELECT price FROM printer
);

--Problem 5
SELECT
	p.maker
FROM printer AS pr1
JOIN product AS p
	ON pr1.model = p.model
WHERE pr1.color = 'y'
AND pr1.price <= ALL (
	SELECT	
		pr2.price
	FROM printer AS pr2
	WHERE pr2.color = 'y'
)

--Problem 6
SELECT DISTINCT
    p.maker
FROM pc
JOIN [product] AS p
    ON pc.model = p.model
WHERE pc.ram <= ALL (
    SELECT	
        pc.ram
    FROM pc
)
AND pc.speed >= ALL (
    SELECT 
        pc.speed
    FROM pc
    WHERE pc.ram <= ALL (
        SELECT pc.ram
        FROM pc
    )
);

--Part 3 
USE ships