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
	(1, '2022-04-16', 1, 1, 3, 1),
	(2, '2022-04-16', 2, 10, 4, 1),
	(3, '2022-04-16', 3, 2, 1, 2),
	(4, '2022-04-16', 4, 9, 2, 1),
	(5, '2022-04-16', 5, 5, 5, 2),
	(6, '2022-04-16', 6, 6, 7, 2),
	(7, '2022-04-16', 7, 8, 9, 10),
	(8, '2022-04-17', 8, 4, 8, 1),
	(9, '2022-04-17', 9, 7, 10, 7),
	(10, '2022-04-17', 10, 3, 6, 2)
	;
	
--> a)
ALTER TABLE  Ksiegowosc.Pracownicy
ADD numer_telefonu_kierunkowy VARCHAR(20);
    
UPDATE
    Ksiegowosc.Pracownicy
SET
    numer_telefonu_kierunkowy = (
        SELECT
            CONCAT(
                '+48 ',
                SUBSTR(telefon, 1, 3),
				'',
                SUBSTR(telefon, 4, 3),
				'',
                SUBSTR(telefon, 7)
            ) 
		AS  numer_telefonu_kierunkowy
    )
	WHERE ksiegowosc.pracownicy.telefon IS NOT NULL;
	
--> b)

--substring function -> (stringname, start location, length)
ALTER TABLE  Ksiegowosc.Pracownicy
ADD numer_telefonu_myslniki VARCHAR(20);
    
UPDATE
    Ksiegowosc.Pracownicy
SET
    numer_telefonu_myslniki = (
        SELECT
            CONCAT(
                SUBSTR(telefon, 1, 3),
				' - ',
                SUBSTR(telefon, 4, 4),
				' - ',
                SUBSTR(telefon, 9)
            ) 
		AS  numer_telefonu_myslniki
    )
	WHERE ksiegowosc.pracownicy.telefon IS NOT NULL;
	
-->c)

SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon
FROM Ksiegowosc.Pracownicy
WHERE LENGTH(nazwisko) = (SELECT max(LENGTH(nazwisko)) FROM Ksiegowosc.Pracownicy)

-->d)

SELECT 
	MD5(Pracownicy.id_pracownika::char) as id_pracownika,
	MD5(Pracownicy.imie) as imie,
	MD5(Pracownicy.nazwisko) as nazwisko,
	MD5(Pracownicy.adres) as adres,
	MD5(Pracownicy.telefon) as telefon,
	MD5(Pensja.kwota::char) as pensja
FROM ksiegowosc.Pracownicy
INNER JOIN ksiegowosc.Wynagrodzenie ON Pracownicy.id_pracownika = Wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.Pensja ON Pensja.id_pensji = Pensja.id_pensji

-->e)

SELECT 
	Pracownicy.id_pracownika,
	Pracownicy.imie,
	Pracownicy.nazwisko,
	Pensja.kwota as Pensja,
	Premia.kwota as Premia
FROM ksiegowosc.Pracownicy
LEFT OUTER JOIN ksiegowosc.Wynagrodzenie ON Pracownicy.id_pracownika = Wynagrodzenie.id_pracownika
LEFT OUTER JOIN ksiegowosc.Pensja ON Wynagrodzenie.id_pensji = Pensja.id_pensji
LEFT OUTER JOIN ksiegowosc.Premia ON Wynagrodzenie.id_premii = Premia.id_premii

-->f)

ALTER TABLE ksiegowosc.godziny ADD liczba_nadgodzin INT;
UPDATE ksiegowosc.godziny SET liczba_nadgodzin = liczba_godzin-160
WHERE ksiegowosc.godziny.liczba_godzin > 160;

UPDATE ksiegowosc.godziny SET liczba_nadgodzin = 0
WHERE ksiegowosc.godziny.liczba_godzin < 160;

SELECT 'Pracownik ' || Pracownicy.imie || ' ' || Pracownicy.nazwisko || ', w dniu ' || Godziny.data || ' otrzymał pensję całkowitą na kwotę ' || (Pensja.kwota+Premia.kwota) || ' , gdzie wynagrodzenie zasadnicze wynosiło: ' || Pensja.kwota  || ', premia: ' || Premia.kwota || ', nadgodziny: ' ||   (Godziny.liczba_nadgodzin * 12)  ||'zł.'  AS RAPORT 
FROM ksiegowosc.Pracownicy 
INNER JOIN ksiegowosc.Wynagrodzenie ON Pracownicy.id_pracownika = Wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.Pensja ON Wynagrodzenie.id_pensji = Pensja.id_pensji
INNER JOIN ksiegowosc.Premia ON Wynagrodzenie.id_premii = Premia.id_premii
INNER JOIN ksiegowosc.Godziny ON Wynagrodzenie.id_godziny = Godziny.id_godziny

