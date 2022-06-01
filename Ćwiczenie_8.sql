--ĆWICZENIE A
CREATE SCHEMA Baza; 

	CREATE TABLE Baza.EmployeePayHistory
	(
		BusinessEntityID INT PRIMARY KEY,
		Rate MONEY NOT NULL
	);
	
	CREATE TABLE Baza.Employee
	(
		BusinessEntityID INT PRIMARY KEY,
		JobTitle VARCHAR(50) NOT NULL,
		BirthDate DATE NOT NULL,
		MaritalStatus CHAR(1) NOT NULL,
		Gender CHAR(1) NOT NULL
	);
	
	CREATE TABLE Baza.Person
	(
		BusinessEntityID INT PRIMARY KEY,
		FirstName VARCHAR(50) NOT NULL,
		MiddleName VARCHAR(50),
		LastName VARCHAR(50) NOT NULL
	);
	
	ALTER TABLE Baza.EmployeePayHistory
	ADD FOREIGN KEY (BusinessEntityID) 
	REFERENCES Baza.Employee(BusinessEntityID);
	
	ALTER TABLE Baza.Employee
	ADD FOREIGN KEY (BusinessEntityID) 
	REFERENCES Baza.Person(BusinessEntityID);
	
	ALTER TABLE Baza.EmployeePayHistory
	ADD FOREIGN KEY (BusinessEntityID) 
	REFERENCES Baza.Person(BusinessEntityID);
	
	INSERT INTO Baza.EmployeePayHistory VALUES
	(1,	125.5),
	(2,	63.4615),
	(3,	43.2692),
	(4,	48.62),
	(5,	32.6923),
	(6,	32.6923),
	(7,	50.4808),
	(8,	40.8654),
	(9,	40.8654),
	(10,42.4808)
	;
	
	INSERT INTO Baza.Employee VALUES
	(1,		'Chief Executive Officer',				'1969-01-29',	'S',	'M'),
	(2,		'Vice President of Engineering',		'1971-08-01',	'S',	'F'),
	(3,		'Engineering Manager',					'1974-11-12',	'M',	'M'),
	(4,		'Senior Tool Designer',					'1974-12-23',	'S',	'M'),
	(5,		'Design Engineer',						'1952-09-27',	'M',	'F'),
	(6,		'Design Engineer',						'1959-03-11',	'M',	'M'),
	(7,		'Research and Development Manager',		'1987-02-24',	'M',	'M'),
	(8,		'Research and Development Engineer',	'1986-06-05',	'S',	'F'),
	(9,		'Research and Development Engineer',	'1979-01-21',	'M',	'F'),
	(10,	'Research and Development Manager',		'1984-11-30',	'M',	'M')
	;
	
	INSERT INTO Baza.Person VALUES
	(1, 'Aleksandra', 	'Maria', 	'Nowak'),
	(2, 'Piotr', 		'Paweł', 	'Kowalski'),
	(3, 'Magdalena', 	'Natalia', 	'Bury'),
	(4, 'Weronika', 	NULL, 		'Kowal'),
	(5, 'Tomasz',		NULL, 		'Kamiński'),
	(6, 'Paweł', 		'Maciej', 	'Wiśniewski'),
	(7, 'Anna', 		NULL, 		'Lewandowska'),
	(8, 'Karolina', 	'Iwona', 	'Kowalczyk'),
	(9, 'Michał', 		NULL, 		'Brzoza'),
	(10, 'Iwona', 		'Weronika', 'Szymańska')
	;
	
	--tutaj tylko sprawdzam czy moje tabele dzialaja :)
	SELECT EmployeePayHistory.Rate, EmployeePayHistory.BusinessEntityID, JobTitle, BirthDate, MaritalStatus, Gender, FirstName, MiddleName, LastName 
	FROM Baza.EmployeePayHistory
	INNER JOIN Baza.Employee on EmployeePayHistory.BusinessEntityID = Employee.BusinessEntityID  
	INNER JOIN Baza.Person on Employee.BusinessEntityID = Person.BusinessEntityID
	--POMINĄĆ!
	--
	
	--Stworzenie tabeli 
	CREATE TABLE Baza.TabelaTymaczasowa
(
	Rate MONEY,
	BusinessEntityID INT,
	JobTitle varchar(50),
	BirthDate DATE,
	MaritalStatus  char(1),
	Gender char(1),
	FirstName VARCHAR(50),
	MiddleName VARCHAR(50),
	LastName VARCHAR(50)
	
);
	
	WITH cte_dane_o_osobie(BusinessEntityID, FirstName, MiddleName, Lastname)
AS
(
	SELECT
		Person.BusinessEntityID,
		Person.FirstName,
		Person.MiddleName,
		Person.LastName
	FROM Baza.Person 
),
cte_dane_dodatkowe(BusinessEntityID, JobTitle, BirthDate, MaritalStatus, Gender)
AS
(
	SELECT
		Employee.BusinessEntityID,
		Employee.JobTitle,
		Employee.BirthDate,
		Employee.MaritalStatus,
		Employee.Gender
	FROM Baza.Employee 
),
cte_zarobki(BusinessEntityID, Rate)
AS
(
	SELECT 
		EmployeePayHistory.BusinessEntityID ,
		EmployeePayHistory.Rate
	FROM Baza.EmployeePayHistory 
		
)
	INSERT INTO Baza.TabelaTymaczasowa(Rate, BusinessEntityID, JobTitle, BirthDate, MaritalStatus, Gender, FirstName, MiddleName, LastName )
	SELECT EmployeePayHistory.Rate, EmployeePayHistory.BusinessEntityID, JobTitle, BirthDate, MaritalStatus, Gender, FirstName, MiddleName, LastName 
	FROM Baza.EmployeePayHistory
	INNER JOIN Baza.Employee on EmployeePayHistory.BusinessEntityID = Employee.BusinessEntityID  
	INNER JOIN Baza.Person on Employee.BusinessEntityID = Person.BusinessEntityID 
	

	

	
--ĆWICZENIE B 
	
	CREATE TABLE Baza.Customer
	(
		CustomerID INT PRIMARY KEY,
		CompanyID INT NOT NULL,
		CompanyName VARCHAR(50)
	
	);
	
	CREATE TABLE Baza.SalesOrderHeader
	(
		CustomerID INT PRIMARY KEY,
		TotalDue MONEY
	);
	
	
	ALTER TABLE Baza.Customer
	ADD FOREIGN KEY (CustomerID) 
	REFERENCES Baza.SalesOrderHeader(CustomerID);
	
	
	INSERT INTO Baza.Customer VALUES
	(1, 11, 'AFirma1'),
	(2, 12,	'DFirma2'),
	(3, 13,	'FFirma3'),
	(4, 14,	'BFirma4'),
	(5, 15,	'EFirma5'),
	(6, 16,	'KFirma6'),
	(7, 17,	'JFirma7'),
	(8, 18,	'CFirma8'),
	(9, 19, 'HFirma9'),
	(10, 20,'IFirma10')
	;
	INSERT INTO Baza.SalesOrderHeader VALUES
	(1, 23153.2339),
	(2, 1457.3288),
	(3, 36865.8012),
	(4, 32474.9324),
	(5, 472.3108),
	(6, 27510.4109),
	(7, 16158.6961),
	(8, 5694.8564),
	(9, 6876.3649),
	(10,40487.7233)
	;
	
	
	
	
	WITH cte_firma(CompanyName, CustomerID)  
AS  
(  
    SELECT 
		Customer.CompanyName,
		Customer.CustomerID
    FROM Baza.Customer
),
cte_total(Revenue, CustomerID)
AS
(
	SELECT
		SalesOrderHeader.TotalDue,
		SalesOrderHeader.CustomerID
	FROM Baza.SalesOrderHeader 
)
SELECT Customer.CompanyName, SalesOrderHeader.TotalDue
FROM Baza.Customer
JOIN Baza.SalesOrderHeader ON Customer.CustomerID = SalesOrderHeader.CustomerID
ORDER BY Customer.CompanyName



--ĆWICZENIE C


CREATE TABLE Baza.Product
	(
		ProductID INT PRIMARY KEY,
		ProductCategoryID INT NOT NULL
	
	);
	
	CREATE TABLE Baza.ProductSales
	(
		ProductID INT PRIMARY KEY,
		Category_Name VARCHAR(50) NOT NULL,
		ProductCategoryID INT,
		LineTotal MONEY NOT NULL
	);
	

	
	ALTER TABLE Baza.Product
	ADD FOREIGN KEY (ProductID) 
	REFERENCES Baza.ProductSales(ProductID);
	

	
	INSERT INTO Baza.Product VALUES
	(1, 10),
	(2, 10),
	(3, 10),
	(4, 11),
	(5, 12),
	(6, 12),
	(7, 14),
	(8, 14),
	(9, 14),
	(10,17)
	;
	INSERT INTO Baza.ProductSales VALUES
	(1, 'Road Bikes', 10, 2024.994000),
	(2, 'Touring Bikes', 11, 6074.982000),
	(3,  'Chains', 12, 4079.988000),
	(4, 'Wheels', 13, 34.200000),
	(5, 'Saddles', 14, 80.746000),
	(6, 'Bib-Shorts', 15, 714.704300),
	(7, 'Caps', 16, 1429.408600),
	(8, 'Bottom Brackets', 17, 4049.988000),
	(9, 'Forks', 18, 57.680800),
	(10, 'Cranksets', 19, 100.932500)
	;
	
WITH product_cte(ProductCategoryID, ProductID)
AS
(
	SELECT
		Product.ProductCategoryID,
		Product.ProductID
	FROM Baza.Product 
),
product_sales(ProductID, Category_Name, ProductCategoryID, LineTotal)
AS 
(
	SELECT
		ProductSales.ProductID,
		ProductSales.Category_Name,
		ProductSales.ProductCategoryID,
		ProductSales.LineTotal 
	FROM Baza.ProductSales  
)


SELECT Category_Name, SUM(LineTotal) AS Sales
FROM Baza.Product
JOIN Baza.ProductSales ON Product.ProductCategoryID = ProductSales.ProductCategoryID
GROUP BY Category_Name