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
--a)
CREATE TABLE Users (
	ID INT PRIMARY KEY,
	Email VARCHAR(50),
	[Password] VARCHAR(50),
	RegisterDate DATETIME2
)

CREATE TABLE Friends (
	UID INT,
	FriendUID INT,
	PRIMARY KEY(UID, FriendUID),
	FOREIGN KEY(UID) REFERENCES Users(ID),
	FOREIGN KEY(FriendUID) REFERENCES Users(ID)
)

CREATE TABLE Walls(
	UID INT,
	MessengerUID INT,
	Text NVARCHAR(255),
	Date DATETIME2,
	FOREIGN KEY(UID) REFERENCES Users(ID),
	FOREIGN KEY(MessengerUID) REFERENCES Users(ID),
)

CREATE TABLE Groups(
	GroupUID INT PRIMARY KEY,
	Name VARCHAR(50),
	Description VARCHAR(255) DEFAULT ''
)

CREATE TABLE GroupMembers (
    GroupUID INT,
    UID INT,
    PRIMARY KEY(GroupUID, UID),
    FOREIGN KEY(GroupUID) REFERENCES Groups(GroupUID),
    FOREIGN KEY(uid) REFERENCES Users(id)
);