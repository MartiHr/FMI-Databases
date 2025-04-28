CREATE DATABASE DEMO
USE DEMO

--Problem 1
--a)
CREATE TABLE Product (
	Model CHAR(4),
	Manufacturer CHAR(1),
	Type VARCHAR(7)
)

CREATE TABLE Printer (
	Code INT,
	Model CHAR(4),
	Price DECIMAL(9, 2)
)

--b)
INSERT INTO Product(Model, Manufacturer, Type) VALUES
('Mode', 'A', 'printer')

--c)
ALTER TABLE Printer
ADD Type VARCHAR(6),
ADD Color CHAR(1) DEFAULT 'n'

--d)
ALTER TABLE Printer
DROP COLUMN price

--e)
DROP TABLE Product

DROP TABLE Printer

--Problem 2
