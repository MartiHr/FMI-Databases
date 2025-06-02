--Problem 1

CREATE DATABASE FurnitureCompany

USE FurnitureCompany

CREATE TABLE Customer (
	CustomerId INT PRIMARY KEY IDENTITY,
	CustomerName VARCHAR(30) NOT NULL,
	CustomerAddress VARCHAR(50) NOT NULL,
	CustomerCity VARCHAR(50) NOT NULL,
	CityCode INT NOT NULL
);

CREATE TABLE [Order] (
	OrderId INT PRIMARY KEY,
	OrderDate DATETIME2 NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customer(CustomerId) NOT NULL,
)	

CREATE TABLE [Product] (
	ProductId INT PRIMARY KEY,
	ProductDescription VARCHAR(200),
	ProductFinish VARCHAR(50) CHECK(ProductFinish IN ('череша', 'естествен ясен', 'бял ясен',
		'червен дъб', 'естествен дъб', 'орех')) NOT NULL,
	StandardPrice DECIMAL(9, 2) NOT NULL,
	ProductLineId INT NOT NULL
)

CREATE TABLE OrderLine (
	OrderId INT FOREIGN KEY REFERENCES [Order](OrderId) NOT NULL,
	ProductId INT FOREIGN KEY REFERENCES [Product](ProductId) NOT NULL,
	OrderedQuantity INT CHECK(OrderedQuantity > 0),
	PRIMARY KEY(OrderId, ProductId)
)

INSERT INTO Customer VALUES
('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

INSERT INTO Product VALUES
(1000, 'офис бюро', 'череша', 195, 10),
(1001, 'директорско бюро', 'червен дъб', 250, 10),
(2000, 'офис стол', 'череша', 75, 20),
(2001, 'директорски стол', 'естествен дъб', 129, 20),
(3000, 'етажерка за книги', 'естествен ясен', 85, 30),
(4000, 'настолна лампа', 'естествен ясен', 35, 40);

INSERT INTO [Order] VALUES
(100, '2013-01-05', 1),
(101, '2013-12-07', 2),
(102, '2014-10-03', 3),
(103, '2014-10-08', 2),
(104, '2015-10-05', 1),
(105, '2015-10-05', 4),
(106, '2015-10-06', 2),
(107, '2016-01-06', 1);

INSERT INTO OrderLine VALUES
(100, 4000, 1),
(101, 1000, 2),
(101, 2000, 2),
(102, 3000, 1),
(102, 2000, 1),
(106, 4000, 1),
(103, 4000, 1),
(104, 4000, 1),
(105, 4000, 1),
(107, 4000, 1);


--Problem 2