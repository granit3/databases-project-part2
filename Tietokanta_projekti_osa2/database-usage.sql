/* Käyttötapaus 1 */

INSERT INTO Opiskelija
VALUES('Pasi', '1', '2002-04-21', 'tuotantotalous', '2015-02-04', '2021-06-01');

INSERT INTO Opiskelija(nimi, opiskelijanumero, syntymaAika, tutkinto, alkamispaivamaara)
VALUES('Tero', '2', '2000-03-21', 'tietotekniikka', '2020-02-04');

SELECT nimi, tutkinto
FROM Opiskelija
WHERE alkamispaivamaara >= '2020';
/*Query finished in 0.013 second(s). Rows affected: 2 */


/* Käyttötapaus 2 */

UPDATE Opiskelija
SET tutkinto='teknillinen fysiikka'
WHERE opiskelijanumero='2';
/*Query finished in 0.014 second(s). Rows affected: 1 */


/* Käyttötapaus 3 */

INSERT INTO Kurssi
VALUES('CS-123', 'C# alkeet', 15);

INSERT INTO Kurssi
VALUES('PHYS-123', 'laaja suhteellisuusteoria', 3);

SELECT kurssinNimi
FROM Kurssi
WHERE opintopisteet >= 5;
/*Query finished in 0.019 second(s). Rows affected: 2*/


/* Käyttötapaus 4 */

INSERT INTO Rakennus
VALUES('talo', 'Tekniikantie');

INSERT INTO Sali
VALUES(200, 100, 'T1');

INSERT INTO Sali
VALUES(50, 50, 'T2');

INSERT INTO Sali
VALUES(100, 15, 'T3');

INSERT INTO SaliSijaitsee
VALUES('T1', 'talo');

INSERT INTO SaliSijaitsee
VALUES('T2', 'talo');

INSERT INTO SaliSijaitsee
VALUES('T3', 'talo');

SELECT *
FROM Sali
WHERE Tenttikapasiteetti >= 30;
/*Query finished in 0.042 second(s). Rows affected: 7 */


/* Käyttötapaus 5 */
INSERT INTO Opiskelija(nimi, opiskelijanumero, syntymaAika, tutkinto, alkamispaivamaara)
VALUES('Sirpa', '3', '2001-02-21', 'tietotekniikka', '2020-02-04');

SELECT *
FROM TIKopiskelijat
WHERE loppumispaivamaara IS NULL OR loppumispaivamaara > '2023-05-06';
/*Query finished in 0.012 second(s). Rows affected: 1 /*


/* Käyttötapaus 6 */
INSERT INTO Kurssikerta
VALUES('PHYS-123', '2023-03-03', 0, 5);

INSERT INTO Kurssikerta
VALUES('PHYS-123', '2023-09-01', 0, 3);

INSERT INTO Kurssikerta
VALUES('CS-123', '2023-03-03', 50, 1);

SELECT *
FROM Kurssikerta, Kurssi
WHERE kurssikoodi=koodi AND kurssinNimi='Laaja suhteellisuusteoria';
/*Kysely suoritettiin osissa, mutta kaikki viestit olivat Query finished */


/* Käyttötapaus 7 */
INSERT INTO Tentti
VALUES('2023-05-05', 'PHYS-123', '2023-03-03', 'T1');

INSERT INTO Tentti
VALUES('2023-11-01', 'PHYS-123', '2023-09-01', 'T3');

INSERT INTO Harjoitusryhma
VALUES('PHYS-123', '2023-03-03', 'H01', 30, 0);

INSERT INTO Harjoitusryhma
VALUES('PHYS-123', '2023-03-03', 'H02', 30, 14);

INSERT INTO Harjoitusryhma
VALUES('PHYS-123', '2023-03-03', 'H03', 30, 5);

INSERT INTO Harjoitusryhma
VALUES('PHYS-123', '2023-09-01', 'H01', 50, 3);

INSERT INTO HarjoitusryhmanKokoontuminen
VALUES('PHYS-123', 'H01', '2023-03-04-16:00', 'T2');

INSERT INTO HarjoitusryhmanKokoontuminen
VALUES('PHYS-123', 'H01', '2023-03-08-14:00', 'T2');

INSERT INTO HarjoitusryhmanKokoontuminen
VALUES('PHYS-123', 'H02', '2023-03-05-10:00', 'ilmoitetaan myöhemmin');

INSERT INTO HarjoitusryhmanKokoontuminen
VALUES('PHYS-123', 'H02', '2023-03-10-12:00', 'T3');
/* Käskyt lisättiin osissa, mutta kaikki kommentit ovat Query finished -alkuisia*/


/*Käyttötapaus 8*/
INSERT INTO Kurssisuorittaja
VALUES('PHYS-123', '2', '2023-03-03', 0, 0);

INSERT INTO TenttiIlmottautuminen
VALUES('2', 'PHYS-123', '2023-03-03', 'suomi', '2023-02-05');

INSERT INTO HarjoitusryhmanJasen
VALUES('PHYS-123', 'H01', '2023-03-03', '2');

UPDATE Harjoitusryhma
SET nykyinenOsallistujamaara = nykyinenOsallistujamaara + 1
WHERE kurssikoodi='PHYS-123' AND kurssinAlkamispaivamaara='2023-03-03' AND ryhmanKoodi='H01';
/*Query finished in 0.035 second(s). Rows affected: 4*/


/*Käyttötapaus 9*/
SELECT ryhmanKoodi, nykyinenOsallistujamaara
FROM Harjoitusryhma
WHERE kurssikoodi='PHYS-123' AND kurssinAlkamispaivamaara='2023-03-03'
ORDER BY nykyinenOsallistujamaara DESC;
/*Query finished in 0.001 second(s)*/


/*Käyttötapaus 10*/
SELECT nimi, opiskelijanumero
FROM Opiskelija AS O, HarjoitusryhmanJasen AS HJ
WHERE kurssikoodi='PHYS-123' AND ryhmanKoodi='H01' AND kurssinAlkamispaivamaara='2023-03-03' AND HJ.opiskelijanumero = O.opiskelijanumero;
/*Query finished in 0.001 second(s)*/


/*Käyttötapaus 11*/
SELECT salinTunnus, paikkamaara
FROM Sali AS S, Rakennus AS R, SaliSijaitsee AS SIJ
WHERE SIJ.salinTunnus=S.salinTunnus AND R.nimi=SIJ.rakennuksenNimi AND R.nimi='talo';
/*Query finished in 0.007 second(s)*/


/*Käyttötapaus 12*/
INSERT INTO SalinValine
VALUES('tulostin', 'T1');

INSERT INTO SalinValine
VALUES('tulostin', 'T3');

SELECT salinTunnus
FROM SalinValine
WHERE nimi='tulostin';
/*Query finished in 0.019 second(s). Rows affected: 2*/


/*Käyttötapaus 13*/
INSERT INTO Tyontekija
VALUES('B123', 'professori', 'Matti', 'jokukatu 1', '+358123', '2010-03-01', '2025-03-01');

INSERT INTO Tyontekija(tunnus, tehtävänimike, nimi, osoite, puhelinnumero, tyosuhteenAlkupaivamaara)
VALUES('G123', 'professori', 'Salla', 'toinenkatu 2', '+358321', '2005-03-01');

INSERT INTO Salivaraus
VALUES('XDLOL', 'T1', '2023-09-01-10:00', '2023-09-01-12:00', '2023-01-01', 'luento');

INSERT INTO Salivaraus
VALUES('XDLOL2', 'T1', '2023-06-01-17:00', '2023-06-01-18:00', '2023-01-02', 'jotain');

INSERT INTO Salivaraus
VALUES('HEHE', 'T2', '2023-04-01-17:00', '2023-04-01-18:00', '2023-01-03', 'salainen');

INSERT INTO TekiVarauksen
VALUES('G123', 'XDLOL');

INSERT INTO TekiVarauksen
VALUES('G123', 'XDLOL2');

INSERT INTO TekiVarauksen
VALUES('B123', 'HEHE');

SELECT salinTunnus, alkamispaivamaara, loppumispaivamaara
FROM Salivaraus AS S, Tyontekija AS T, TekiVarauksen AS TV
WHERE S.varaustunnus=TV.varaustunnus AND T.tunnus=TV.varaajanTunnus AND T.nimi='Matti';
/*Käyttötapaus suoritettiin osissa, mutta kaikki olivat Query finished -alkuisia*/


/*Käyttötapaus 14*/
SELECT kieli, COUNT(opiskelijanumero)
FROM TenttiIlmottautuminen
GROUP BY kieli;
/*Query finished in 0.002 second(s)*/


/*Käyttötapaus 15*/
SELECT opiskelijanumero, nimi
FROM Opiskelija AS O, Tenttisuoritus AS T
WHERE O.opiskelijanumero=T.opiskelijanumero AND T.kurssikoodi='PHYS-123' AND arvosana >= 4
/*Query finished in 0.002 second(s)*/


/*Käyttötapaus 16*/

INSERT INTO Tenttisuoritus
VALUES('1', 'PHYS-123', '2023-05-01', 3);

INSERT INTO Tenttisuoritus
VALUES('2', 'PHYS-123', '2023-04-01', 5);

INSERT INTO Tenttisuoritus
VALUES('2', 'PHYS-123', '2023-05-01', 4);

INSERT INTO Tenttisuoritus
VALUES('3', 'PHYS-123', '2023-04-01', 3);

INSERT INTO Tenttisuoritus
VALUES('2', 'CS-123', '2023-06-01', 5);

INSERT INTO Tenttisuoritus
VALUES('4', 'CS-123', '2023-06-01', 5);

SELECT suorituspaivamaara, AVG(arvosana)
FROM Tenttisuoritus
GROUP BY suorituspaivamaara;


/*Käyttötapaus 17*/
INSERT INTO SalinValine
VALUES('älytaulu', 'T1');

SELECT DISTINCT salinTunnus
FROM SalinValine AS S1, Salivaraus AS S2, Rakennus AS R, SaliSijaitsee AS SIJ
WHERE S1.salinTunnus=S2.salinTunnus AND SIJ.salinTunnus=S2.salinTunnus AND SIJ.rakennuksenNimi=R.nimi AND R.nimi='talo' AND S1.nimi='älytaulu';
/*Query finished in 0.015 second(s). Rows affected: 1*/


/*Käyttötapaus 18*/
INSERT INTO Luentokerta
VALUES('2023-04-03', '14:00', '16:00', 'PHYS-123');

SELECT DISTINCT kurssikoodi, kurssinAlkupaivamaara
FROM HarjoitusryhmanKokoontuminen AS HK, Kurssikerta AS K
WHERE HK.kurssikoodi=K.kurssikoodi AND K.kurssinAlkupaivamaara > '2023-01-01' AND (kurssinAlkupaivamaara || '-00:00' < HK.kokoontumisaika) AND HK.kokoontumisaika >= '2023-01-01-14:00' AND (HK.kokoontumisaika LIKE '%14:00%' OR HK.kokoontumisaika LIKE '%16:00%');
/*Query finished in 0.002 second(s).*/


/*Käyttötapaus 19*/
INSERT INTO Kurssisuorittaja
VALUES('PHYS-123', '1', '2023-09-01', 1, 13);

UPDATE Kurssisuorittaja
SET kokonaispisteet=22
WHERE opiskelijanumero='2' AND kurssikoodi='PHYS-123' AND kurssinAlkupaivamaara='2023-03-03';

SELECT tutkinto, AVG(kokonaispisteet)
FROM Kurssisuorittaja AS K, Opiskelija AS O
WHERE K.opiskelijanumero=O.opiskelijanumero AND kurssikoodi='PHYS-123'
GROUP BY tutkinto;
/*Käyttötapaus suoritettiin osissa, mutta kaikki olivat Query finished -alkuisia*/


/*Käyttötapaus 20*/
INSERT INTO Opiskelija
VALUES('Salla', '4', '2000-04-21', 'tuotantotalous', '2015-02-04', '2021-06-01');

SELECT nimi, opiskelijanumero, AVG(arvosana) as keskiarvo
FROM Opiskelija AS O NATURAL JOIN Tenttisuoritus AS TS
WHERE O.opiskelijanumero IN 
(
SELECT DISTINCT(opiskelijanumero)
FROM Opiskelija NATURAL JOIN Tenttisuoritus
WHERE kurssikoodi='PHYS-123'
)
AND
NOT EXISTS
(
SELECT Opiskelijanumero
FROM Opiskelija AS O2 NATURAL JOIN Tenttisuoritus AS TS2
WHERE TS2.kurssikoodi='PHYS-123' AND TS.kurssikoodi='PHYS-123' AND O2.tutkinto=O.tutkinto AND O2.opiskelijanumero<>O.opiskelijanumero AND TS2.arvosana > TS.arvosana
)
GROUP BY opiskelijanumero;
/*Käyttötapaus suoritettiin osissa, mutta kaikki olivat Query finished -alkuisia*/