USE Flights

--Part 1
CREATE VIEW flight_info AS
SELECT 
	f.FNUMBER,
	f.AIRLINE_OPERATOR,
	COUNT(b.CUSTOMER_ID) AS ConfirmedPassengers
FROM Flights AS f
LEFT JOIN Bookings AS b
	ON f.FNUMBER = b.FLIGHT_NUMBER
WHERE b.STATUS = 1
GROUP BY f.FNUMBER, f.AIRLINE_OPERATOR

SELECT
	*
FROM flight_info

DROP VIEW flight_info

--Part 2 (not good)
CREATE VIEW TopClientPerAgency AS
SELECT 
	c.FNAME, 
	c.LNAME, 
	id 
FROM Customers AS c
WHERE id IN (
	SELECT customer_id 
	FROM Bookings as b
	GROUP BY agency, customer_id
	HAVING COUNT(customer_id) >= (
		SELECT TOP 1 COUNT(customer_id) 
		FROM Bookings AS b2
		WHERE b.agency=b2.agency
		GROUP BY agency, customer_id
		ORDER BY COUNT(customer_id) DESC
	)
)

SELECT * FROM TopClientPerAgency

DROP VIEW TopClientPerAgency

--Part 3
CREATE VIEW v_SF_Agencies AS 
SELECT 
	*
FROM AGENCIES AS a
WHERE a.CITY = 'Sofia'
WITH CHECK OPTION

SELECT * FROM v_SF_Agencies

DROP VIEW v_SF_Agencies

--Part 4
CREATE VIEW v_SF_PH_Agencies AS 
SELECT 
	*
FROM AGENCIES AS a
WHERE a.PHONE IS NULL
WITH CHECK OPTION

SELECT * FROM v_SF_PH_Agencies

DROP VIEW v_SF_PH_Agencies

--Part 5
INSERT INTO v_SF_Agencies
VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359');
INSERT INTO v_SF_PH_Agencies
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);
INSERT INTO v_SF_Agencies
VALUES('T3 Tour', 'Bulgaria', 'Varna','+359');
INSERT INTO v_SF_PH_Agencies
VALUES('T4 Tour', 'Bulgaria', 'Varna',null);
INSERT INTO v_SF_PH_Agencies
VALUES('T4 Tour', 'Bulgaria', 'Sofia','+359');