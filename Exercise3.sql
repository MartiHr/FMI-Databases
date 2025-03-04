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

	

--Part 3 
USE ships