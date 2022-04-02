CREATE SCHEMA Rozliczenia; 

	CREATE TABLE Rozliczenia.Pracownicy
	(
		id_pracownika CHAR(6) PRIMARY KEY,
		imie VARCHAR(80) NOT NULL,
		nazwisko VARCHAR(80) NOT NULL,
		adres VARCHAR(80) NOT NULL,
		telefon VARCHAR(15) NULL
	);
	
	CREATE TABLE Rozliczenia.Godziny
	(
		id_godziny CHAR(6) PRIMARY KEY,
		data DATE NOT NULL,
		liczba_godzin INT NOT NULL,
		id_pracownika CHAR(6) NOT NULL
	);
	
	CREATE TABLE Rozliczenia.Pensje
	(
		id_pensji CHAR(6) PRIMARY KEY,
		stanowisko VARCHAR(80) NOT NULL,
		kwota MONEY NOT NULL,
		id_premii CHAR(6) NULL
	);
	
	CREATE TABLE Rozliczenia.Premie
	(
		id_premii CHAR(6) PRIMARY KEY,
		rodzaj VARCHAR(80) NOT NULL,
		kwota MONEY NOT NULL
	);
	
	ALTER TABLE rozliczenia.Godziny
	ADD FOREIGN KEY (id_pracownika) 
	REFERENCES rozliczenia.Pracownicy(id_pracownika);
	
	ALTER TABLE Rozliczenia.Pensje
	ADD FOREIGN KEY (id_premii) 
	REFERENCES Rozliczenia.Premie(id_premii);
	
	INSERT INTO Rozliczenia.Pracownicy VALUES
	('ANO001', 'Aleksandra', 'Nowak', 'ul.Kwiatowa 2, 32-043, Krakow', '721 543 621'),
	('PKO001', 'Piotr', 'Kowalski', 'ul.Basztowa 14, 31-026, Krakow', '711 513 611'),
	('MBU001', 'Magdalena', 'Bury', 'ul.Oliwkowa 1, 32-013, Krakow', NULL),
	('WKO001', 'Weronika', 'Kowal', 'ul.Jagodowa 54, 31-021, Krakow', '631 543 644'),
	('TKA001', 'Tomasz', 'Kamiński', 'ul.Włoska 16, 30-043, Krakow', '766 123 111'),
	('PWI001', 'Paweł', 'Wiśniewski', 'ul.Laurowa 16, 30-023, Krakow', NULL),
	('ALE001', 'Anna', 'Lewandowska', 'ul.Akacjowa 5, 35-143, Krakow', '722 113 142'),
	('KKO001', 'Karolina', 'Kowalczyk', 'ul.Warszawska 11, 31-021, Krakow', '546 133 311'),
	('MBR001', 'Michał', 'Brzoza', 'ul.Wierzbowa 23, 33-123, Krakow', '726 323 431'),
	('ISZ001', 'Iwona', 'Szymańska', 'ul.Włoska 16, 30-043, Krakow', '656 423 5421')
	;
	
	INSERT INTO Rozliczenia.Godziny VALUES
	('GO0001', '2022-03-12', '5', 'ANO001'),
	('GO0002', '2022-03-12', '10', 'MBU001'),
	('GO0003', '2022-03-13', '3', 'ISZ001'),
	('GO0004', '2022-03-13', '8', 'KKO001'),
	('GO0005', '2022-03-14', '8', 'TKA001'),
	('GO0006', '2022-03-14', '8', 'PWI001'),
	('GO0007', '2022-03-14', '10', 'MBR001'),
	('GO0008', '2022-03-15', '4', 'ALE001'),
	('GO0009', '2022-03-15', '6', 'WKO001'),
	('GO0010', '2022-03-16', '3', 'MBU001')
	;
	
	INSERT INTO Rozliczenia.Premie VALUES
	('PR0001', 'Zadaniowa', '500'),
	('PR0002', 'Motywacyjna', '100'),
	('PR0003', 'Zadaniowa', '500'),
	('PR0004', 'Uznaniowa', '200'),
	('PR0005', 'Motywacyjna', '100'),
	('PR0006', 'Wynikowa', '1000'),
	('PR0007', 'Zadaniowa', '500'),
	('PR0008', 'Wynikowa', '1500'),
	('PR0009', 'Wynikowa', '1000'),
	('PR0010', 'Uznaniowa', '200')
	;
	
	INSERT INTO Rozliczenia.Pensje VALUES
	('PE0001', 'Project Manager', '14000', NULL),
	('PE0002', 'Software Engineer', '10000', NULL),
	('PE0003', 'UX Designer', '8000', 'PR0003'),
	('PE0004', 'Senior DevOps Engineer', '30000', NULL),
	('PE0005', 'Scrum Master', '9500', NULL),
	('PE0006', 'Product Owner', '17000', 'PR0006'),
	('PE0007', 'Senior Project Manager', '25000', 'PR0007'),
	('PE0008', 'Data Analyst', '17000', NULL),
	('PE0009', 'Python Developer', '15000', 'PR0009'),
	('PE0010', 'UX Designer Intern', '3500', NULL)
	;
	
SELECT date_part('week', godziny.data)
FROM rozliczenia.godziny,
SELECT date_part('month', godziny.data)
FROM rozliczenia.godziny

SELECT 
	godziny.data,
	date_part('week', godziny.data) AS week,
	date_part('month', godziny.data) AS month
FROM rozliczenia.godziny


ALTER TABLE Rozliczenia.pensje RENAME COLUMN "kwota" TO "kwota_brutto"
ALTER TABLE Rozliczenia.pensje ADD "kwota_netto" MONEY
UPDATE Rozliczenia.pensje SET kwota_netto = kwota_brutto*1.2


