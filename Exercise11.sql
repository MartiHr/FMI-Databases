USE FLIGHTS

--Part 1
ALTER TABLE Flights
ADD num_pass INT

UPDATE Flights
SET num_pass = 0
WHERE num_pass IS NULL

SELECT * FROM FLIGHTS

--Part 2
ALTER TABLE Agencies
ADD num_book INT 

UPDATE Agencies
SET num_book = 0
WHERE num_book IS NULL;

-- Може и ALTER TABLE Agencies ADD num_book INT DEFAULT 0; на един ред

SELECT * FROM Agencies

--Part 3
CREATE TRIGGER trigger_booking_insert
ON Bookings
AFTER INSERT
AS
BEGIN
	UPDATE Flights
	SET num_pass = num_pass + 1
	FROM Flights AS f
	WHERE f.FNUMBER IN (SELECT fnumber FROM inserted); --Това е първия начин

	UPDATE Agencies
	SET num_book = num_book + 1
	FROM AGENCIES AS a
	JOIN inserted AS i
		ON a.NAME = i.AGENCY --Tова е втория начин
END

--Part 4
CREATE TRIGGER trigger_reservation_del
ON Bookings
AFTER DELETE
AS
BEGIN
	UPDATE Flights
	SET num_pass = num_pass - 1
	FROM FLIGHTS AS f
	JOIN deleted
		ON f.FNUMBER = deleted.FLIGHT_NUMBER

	UPDATE AGENCIES 
	SET num_book = num_book - 1
	WHERE name IN (
		SELECT
			AGENCY
		FROM deleted
	)
END

CREATE TRIGGER trigger_update_passengers
ON Bookings
AFTER UPDATE
AS 
BEGIN
	UPDATE FLIGHTS
	SET num_pass += 1
	WHERE FNUMBER IN (
		SELECT 
			FLIGHT_NUMBER
		FROM inserted
		WHERE STATUS = 1
	) 
	AND FNUMBER IN (
		SELECT
			FLIGHT_NUMBER
		FROM deleted
		WHERE STATUS = 0
	)

	UPDATE FLIGHTS
	SET num_pass -= 1
	WHERE FNUMBER IN (
		SELECT
			FLIGHT_NUMBER		
		FROM inserted
		WHERE status = 0
	)
	AND FNUMBER IN (
		SELECT
			FLIGHT_NUMBER
		FROM deleted
		WHERE status = 1
	)
END