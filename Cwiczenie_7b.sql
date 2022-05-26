--ĆWICZENIE A

CREATE TABLE Ksiegowosc.Fibonacci
	(
		n iNT 
	);

INSERT INTO Ksiegowosc.Fibonacci VALUES
(2)
;

CREATE OR REPLACE FUNCTION fibonacci(n INTEGER) 
RETURNS SETOF INTEGER
LANGUAGE SQL
AS $$
WITH RECURSIVE Fib(a,b) AS 
(
        VALUES(0,1)
    UNION ALL
        SELECT greatest(a,b), a + b as a from Fib
        WHERE b < n
   )
SELECT a FROM Fib;
$$;

CREATE OR REPLACE PROCEDURE Procedura_Fibonacci(n INTEGER)
	AS $$
	BEGIN
		INSERT INTO Ksiegowosc.Fibonacci
		VALUES(fibonacci(n));
	END;
	$$
	LANGUAGE 'plpgsql';
	
CALL Procedura_Fibonacci(1000);
SELECT n
FROM Ksiegowosc.Fibonacci
		

--ĆWICZENIE B

--ABY WYKONAĆ TO ĆWICZENIE, UŻYŁAM BAZY DANYCH Z POPRZEDNICH ĆWICZEŃ, ZE WZGLĘDU NA TO, ŻE POSIADAM SYSTEM
--MACOS I BAZA ADVENTUREWORKS NA NIEGO NIESTETY NIE DZIAŁA :(

CREATE SCHEMA Ksiegowosc; 

	CREATE TABLE Ksiegowosc.Pracownicy
	(
		id_pracownika INT PRIMARY KEY,
		imie VARCHAR(80) NOT NULL,
		nazwisko VARCHAR(80) NOT NULL,
		adres VARCHAR(80) NOT NULL,
		telefon VARCHAR(15) NULL
	);
	
	CREATE TABLE Ksiegowosc.Godziny
	(
		id_godziny INT PRIMARY KEY,
		data DATE NOT NULL,
		liczba_godzin INT NOT NULL,
		id_pracownika INT NOT NULL
	);
	
	CREATE TABLE Ksiegowosc.Pensja
	(
		id_pensji INT PRIMARY KEY,
		stanowisko VARCHAR(80) NOT NULL,
		kwota MONEY NOT NULL
	);
	
	CREATE TABLE Ksiegowosc.Premia
	(
		id_premii INT PRIMARY KEY,
		rodzaj VARCHAR(80) NOT NULL,
		kwota MONEY NOT NULL
	);
	
	CREATE TABLE Ksiegowosc.Wynagrodzenie
	(
		id_wynagrodzenia INT PRIMARY KEY,
		data DATE NOT NULL,
		id_pracownika INT NOT NULL,
		id_godziny INT NOT NULL,
		id_pensji INT NOT NULL,
		id_premii INT
	);
	
	ALTER TABLE Ksiegowosc.Godziny
	ADD FOREIGN KEY (id_pracownika) 
	REFERENCES Ksiegowosc.Pracownicy(id_pracownika);
	
	ALTER TABLE Ksiegowosc.Wynagrodzenie
	ADD FOREIGN KEY (id_pracownika) 
	REFERENCES Ksiegowosc.Pracownicy(id_pracownika);
	
	ALTER TABLE Ksiegowosc.Wynagrodzenie
	ADD FOREIGN KEY (id_godziny) 
	REFERENCES Ksiegowosc.Godziny(id_godziny);
	
	ALTER TABLE Ksiegowosc.Wynagrodzenie
	ADD FOREIGN KEY (id_pensji) 
	REFERENCES Ksiegowosc.Pensja(id_pensji);
	
	ALTER TABLE Ksiegowosc.Wynagrodzenie
	ADD FOREIGN KEY (id_premii) 
	REFERENCES Ksiegowosc.Premia(id_premii);
	
	INSERT INTO Ksiegowosc.Pracownicy VALUES
	(1, 'Aleksandra', 'Nowak', 'ul.Kwiatowa 2, 32-043, Krakow', '721 543 621'),
	(2, 'Piotr', 'Kowalski', 'ul.Basztowa 14, 31-026, Krakow', '711 513 611'),
	(3, 'Magdalena', 'Bury', 'ul.Oliwkowa 1, 32-013, Krakow', NULL),
	(4, 'Weronika', 'Kowal', 'ul.Jagodowa 54, 31-021, Krakow', '631 543 644'),
	(5, 'Tomasz', 'Kamiński', 'ul.Włoska 16, 30-043, Krakow', '766 123 111'),
	(6, 'Paweł', 'Wiśniewski', 'ul.Laurowa 16, 30-023, Krakow', NULL),
	(7, 'Anna', 'Lewandowska', 'ul.Akacjowa 5, 35-143, Krakow', '722 113 142'),
	(8, 'Karolina', 'Kowalczyk', 'ul.Warszawska 11, 31-021, Krakow', '546 133 311'),
	(9, 'Michał', 'Brzoza', 'ul.Wierzbowa 23, 33-123, Krakow', '726 323 431'),
	(10, 'Iwona', 'Szymańska', 'ul.Włoska 16, 30-043, Krakow', '656 423 5421')
	;
	
	INSERT INTO Ksiegowosc.Godziny VALUES
	(1, '2022-03-12', '100', 1),
	(2, '2022-03-12', '180', 3),
	(3, '2022-03-13', '140', 10),
	(4, '2022-03-13', '80', 8),
	(5, '2022-03-14', '300', 5),
	(6, '2022-03-14', '220', 6),
	(7, '2022-03-14', '170', 9),
	(8, '2022-03-15', '161', 7),
	(9, '2022-03-15', '160', 4),
	(10, '2022-03-16', '130', 2)
	;
	
	INSERT INTO Ksiegowosc.Premia VALUES
	(1, 'Zadaniowa', '500'),
	(2, 'Motywacyjna', '100'),
	(3, 'Zadaniowa', '500'),
	(4, 'Uznaniowa', '200'),
	(5, 'Motywacyjna', '100'),
	(6, 'Wynikowa', '1000'),
	(7, 'Zadaniowa', '500'),
	(8, 'Wynikowa', '1500'),
	(9, 'Wynikowa', '1000'),
	(10, 'Uznaniowa', '200')
	;
	
	INSERT INTO Ksiegowosc.Pensja VALUES
	(1, 'Project Manager', '14000'),
	(2, 'Software Engineer', '10000'),
	(3, 'UX Designer', '8000'),
	(4, 'Senior DevOps Engineer', '30000'),
	(5, 'Scrum Master', '9500'),
	(6, 'Product Owner', '17000'),
	(7, 'Project Manager', '25000'),
	(8, 'Data Analyst', '17000'),
	(9, 'Data Analyst', '15000'),
	(10, 'UX Designer Intern', '3500')
	;
	 
	 INSERT INTO Ksiegowosc.Wynagrodzenie VALUES
	(1, '2022-04-16', 1, 1, 3, NULL),
	(2, '2022-04-16', 2, 10, 4, 1),
	(3, '2022-04-16', 3, 2, 1, NULL),
	(4, '2022-04-16', 4, 9, 2, NULL),
	(5, '2022-04-16', 5, 5, 5, 2),
	(6, '2022-04-16', 6, 6, 7, NULL),
	(7, '2022-04-16', 7, 8, 9, 10),
	(8, '2022-04-17', 8, 4, 8, NULL),
	(9, '2022-04-17', 9, 7, 10, 7),
	(10, '2022-04-17', 10, 3, 6, NULL)
	;
	


CREATE OR REPLACE FUNCTION zamiana_malych_liter_na_duze()
	RETURNS TRIGGER AS $$
	BEGIN
		new.nazwisko = UPPER(new.nazwisko);
		RETURN new;
	END;
	$$
	LANGUAGE 'plpgsql'
	
CREATE TRIGGER zamiana_malych_liter_na_duze
--tu mozna uzyc after, w zaleznosci co chcemy zmienic, czy dane przed czy po 
	BEFORE INSERT ON Ksiegowosc.Pracownicy
	FOR EACH ROW
		EXECUTE PROCEDURE zamiana_malych_liter_na_duze();
END;
		
INSERT INTO Ksiegowosc.Pracownicy VALUES
	(11, 'Aleksandra', 'Witek', 'ul.Akacjoa 1, 32-043, Krakow', '711 533 621')
	;
	
	
--ĆWICZENIE C 

CREATE TABLE Ksiegowosc.TAXES
	(
		SalesTaxRateID INT PRIMARY KEY,
		StateProvinceID INT NOT NULL,
		TaxType SMALLINT NOT NULL,
		TaxRate INT NOT NULL
	);

INSERT INTO Ksiegowosc.TAXES VALUES
(1,	1,	1,	14),
(2,	57,	1,	14.25),
(3,	63,	1,	14.25),
(4,	1,	2,	7),
(5,	57,	2,	7),
(6,	63,	2,	7),
(7,	7,	3,	7),
(8,	29,	3,	7),
(9,	31,	3,	7),
(10,41,	3,	7),
(11,45,	3,	7),
(12,49,	3,	7),
(13,51,	3,	7),
(16,69,	3,	7),
(17,83,	3,	7),
(18,6,	1,	7.75),
(19,9,	1,	8.75),
(20,15,	1,	8),
(21,30,	1,	7),
(22,35,	1,	7.25),
(23,36,	1,	6.75),
(24,72,	1,	7.25),
(25,73,	1,	7.5),
(26,74,	1,	5),
(27,79,	1,	8.8)
;

CREATE OR REPLACE FUNCTION czytaxrate30()
	RETURNS TRIGGER AS $$
	BEGIN
		IF new.taxrate > 30 THEN
			RAISE WARNING 'BŁĄD!' 
		END IF;
	END;
	$$
	LANGUAGE 'plpgsql'


CREATE TRIGGER taxRateMonitoring
--tu mozna uzyc after, w zaleznosci co chcemy zmienic, czy dane przed czy po 
	BEFORE INSERT ON Ksiegowosc.TAXES
	FOR EACH ROW
		EXECUTE PROCEDURE czytaxrate30();

INSERT INTO Ksiegowosc.TAXES VALUES
(28,77,	3,	10),
(29,20,	3,	16),
(30,84,	3,	19.6),
(31,14,	3,	17.5)
;

INSERT INTO Ksiegowosc.TAXES VALUES
(28,77,	3,	31),
(28,77,	3,	32),
(28,77,	3,	21)
;
	
	
