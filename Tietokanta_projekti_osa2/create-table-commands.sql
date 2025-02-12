CREATE TABLE Opiskelija (
nimi TEXT,
opiskelijanumero TEXT NOT NULL,
syntymaAika TEXT,
tutkinto TEXT,
alkamispaivamaara TEXT,
loppumispaivamaara TEXT,
PRIMARY KEY(opiskelijanumero)
);

CREATE TABLE Kurssi (
koodi TEXT NOT NULL,
kurssinNimi TEXT,
opintopisteet INTEGER CHECK (opintopisteet > 0),
PRIMARY KEY(koodi)
);

CREATE TABLE Rakennus (
nimi TEXT NOT NULL,
katuosoite TEXT,
PRIMARY KEY(nimi)
);

CREATE TABLE Sali (
paikkamaara INTEGER,
tenttikapasiteetti INTEGER CHECK(paikkamaara >= tenttikapasiteetti),
salinTunnus TEXT NOT NULL,
PRIMARY KEY(salinTunnus)
);

CREATE TABLE Tentti (
paivamaara TEXT NOT NULL,
kurssikoodi TEXT NOT NULL,
kurssinAlkamispaivamaara TEXT,
salinTunnus TEXT,
PRIMARY KEY(paivamaara, kurssikoodi),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi),
FOREIGN KEY(salinTunnus) REFERENCES Sali(salinTunnus)
);

CREATE TABLE TenttiIlmottautuminen (
opiskelijanumero TEXT NOT NULL,
kurssikoodi TEXT NOT NULL,
kurssinAlkamispaivamaara TEXT NOT NULL,
kieli TEXT,
ilmottautumisenPaivamaara TEXT,
PRIMARY KEY(opiskelijanumero, kurssikoodi, kurssinAlkamispaivamaara),
FOREIGN KEY(opiskelijanumero) REFERENCES Opiskelija(opiskelijanumero),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi)
);

CREATE TABLE Tenttisuoritus (
opiskelijanumero TEXT NOT NULL,
kurssikoodi TEXT NOT NULL,
suorituspaivamaara TEXT NOT NULL,
arvosana INTEGER CHECK (arvosana >= 0 AND arvosana <= 5),
PRIMARY KEY(opiskelijanumero, kurssikoodi, suorituspaivamaara),
FOREIGN KEY(opiskelijanumero) REFERENCES Opiskelija(opiskelijanumero),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi)
);

CREATE TABLE Kurssikerta (
kurssikoodi TEXT NOT NULL,
kurssinAlkupaivamaara TEXT NOT NULL,
osallistujamaara INTEGER,
harjoitusryhmienMaara INTEGER,
PRIMARY KEY(kurssikoodi, kurssinAlkupaivamaara),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi)
);

CREATE TABLE Kurssisuorittaja (
kurssikoodi TEXT NOT NULL,
opiskelijanumero TEXT NOT NULL,
kurssinAlkupaivamaara TEXT NOT NULL,
hyvaksytytTentit INTEGER CHECK (hyvaksytytTentit >= 0),
kokonaispisteet INTEGER CHECK (kokonaispisteet >= 0),
PRIMARY KEY(kurssikoodi, opiskelijanumero, kurssinAlkupaivamaara),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi),
FOREIGN KEY(opiskelijanumero) REFERENCES Opiskelija(opiskelijanumero)
);

CREATE TABLE Luentokerta (
paivamaara TEXT NOT NULL,
alkukellonaika TEXT,
loppukellonaika TEXT,
kurssikoodi TEXT NOT NULL,
PRIMARY KEY(paivamaara, kurssikoodi),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi)
);

CREATE TABLE HarjoitusryhmanKokoontuminen (
kurssikoodi TEXT NOT NULL,
ryhmanKoodi TEXT NOT NULL,
kokoontumisaika TEXT NOT NULL,
paikka TEXT,
PRIMARY KEY(kurssikoodi, ryhmanKoodi, kokoontumisaika),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi)
);

CREATE TABLE HarjoitusryhmanJasen (
kurssikoodi TEXT NOT NULL,
ryhmanKoodi TEXT NOT NULL,
kurssinAlkamispaivamaara TEXT NOT NULL,
opiskelijanumero TEXT NOT NULL,
PRIMARY KEY(kurssikoodi, ryhmanKoodi, kurssinAlkamispaivamaara, opiskelijanumero),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi),
FOREIGN KEY(opiskelijanumero) REFERENCES Opiskelija(opiskelijanumero)
);

CREATE TABLE Harjoitusryhma (
kurssikoodi TEXT NOT NULL,
kurssinAlkamispaivamaara TEXT NOT NULL,
ryhmanKoodi TEXT NOT NULL,
osallistujaraja INTEGER,
nykyinenOsallistujamaara INTEGER CHECK (nykyinenOsallistujamaara <= osallistujaraja),
PRIMARY KEY(kurssikoodi, kurssinAlkamispaivamaara, ryhmanKoodi),
FOREIGN KEY(kurssikoodi) REFERENCES Kurssi(koodi)
);

CREATE TABLE Tyontekija (
tunnus TEXT NOT NULL,
tehtävänimike TEXT,
nimi TEXT,
osoite TEXT,
puhelinnumero TEXT,
tyosuhteenAlkupaivamaara TEXT,
tyosuhteenLoppupaivamaara TEXT,
PRIMARY KEY(tunnus)
);

CREATE TABLE Salivaraus (
varaustunnus TEXT NOT NULL,
salinTunnus TEXT,
alkamispaivamaara TEXT,
loppumispaivamaara TEXT,
varausaika TEXT,
tilaisuus TEXT,
PRIMARY KEY(varaustunnus),
FOREIGN KEY(salinTunnus) REFERENCES Sali(salinTunnus)
);

CREATE TABLE SalinValine (
nimi TEXT NOT NULL,
salinTunnus TEXT NOT NULL,
PRIMARY KEY(nimi, salinTunnus),
FOREIGN KEY(salinTunnus) REFERENCES Sali(salinTunnus)
);

CREATE TABLE TekiVarauksen (
varaajanTunnus TEXT NOT NULL,
varaustunnus TEXT NOT NULL,
PRIMARY KEY(varaajanTunnus, varausTunnus),
FOREIGN KEY(varaajanTunnus) REFERENCES Tyontekija(tunnus),
FOREIGN KEY(varaustunnus) REFERENCES Salivaraus(varaustunnus)
);

CREATE TABLE SaliSijaitsee (
salinTunnus TEXT NOT NULL,
rakennuksenNimi TEXT NOT NULL,
PRIMARY KEY(salinTunnus),
FOREIGN KEY(salinTunnus) REFERENCES Sali(salinTunnus),
FOREIGN KEY(rakennuksenNimi) REFERENCES Rakennus(nimi)
);

CREATE INDEX OpiskelijaNumeroIndex ON Opiskelija(Opiskelijanumero);
CREATE INDEX OpiskelijaNimiIndex ON Opiskelija(nimi);

CREATE INDEX KurssiKoodiIndex ON Kurssi(koodi);
CREATE INDEX KurssiNimiIndex ON Kurssi(kurssinNimi);

CREATE INDEX RakennusIndex ON Rakennus(nimi);

CREATE INDEX SalinTunnusIndex ON Sali(salinTunnus);
CREATE INDEX SalinPaikkalkmIndex ON Sali(paikkamaara);

CREATE INDEX TenttiPvmIndex ON Tentti(paivamaara);
CREATE INDEX TenttiKurssiIndex ON Tentti(kurssikoodi);

CREATE INDEX TenttiIlmonKurssikoodiIndex ON TenttiIlmottautuminen(kurssikoodi, kurssinAlkamispaivamaara);
CREATE INDEX TenttiIlmonnOpiskelijaNroIndex ON TenttiIlmottautuminen(opiskelijanumero);

CREATE INDEX TenttisuoritusKurssikoodiIndex ON Tenttisuoritus(kurssikoodi);
CREATE INDEX TenttisuoritusOpiskelijanumeroIndex ON Tenttisuoritus(opiskelijanumero);

CREATE INDEX KurssikerranKoodiIndex ON Kurssikerta(kurssikoodi, kurssinAlkupaivamaara);

CREATE INDEX KurssisuorittajaOpiskelijaNroIndex ON Kurssisuorittaja(opiskelijanumero);
CREATE INDEX KurssisuorittajaKurssikoodiIndex ON Kurssisuorittaja(kurssikoodi);
CREATE INDEX KurssisuorittajaKurssialkuIndex ON Kurssisuorittaja(kurssinAlkupaivamaara);

CREATE INDEX LuentokertaPaivamaaraIndex ON Luentokerta(paivamaara);
CREATE INDEX LuentokertaKurssikoodiIndex ON Luentokerta(kurssikoodi);

CREATE INDEX HarjoitusryhmanKokoontuminenKKIndex On HarjoitusryhmanKokoontuminen(kurssikoodi);
CREATE INDEX HarjoitusryhmanKokoontuminenRKIndex On HarjoitusryhmanKokoontuminen(ryhmanKoodi);
CREATE INDEX HarjoitusryhmanKokoontuminenKAIndex ON HarjoitusryhmanKokoontuminen(kokoontumisaika);

CREATE INDEX HarjoitusryhmanJasenOpiskelijanumeroIndex ON HarjoitusryhmanJasen(opiskelijanumero);
CREATE INDEX HarjoitusryhmanJasenKurssiIndex ON HarjoituryhmanJasen(kurssikoodi, kurssinAlkamispaivamaara, ryhmanKoodi);

CREATE INDEX HarjoitusryhmaIndex ON Harjoitusryhma(kurssikoodi, kurssinAlkamispaivamaara);

CREATE INDEX TyontekijaTunnusIndex ON Tyontekija(tunnus);
CREATE INDEX TyontekijaNimiIndex ON Tyontekija(nimi);

CREATE INDEX SalivarausTunnusIndex ON Salivaraus(varaustunnus);
CREATE INDEX SalivarausSalintunnusIndex ON Salivaraus(salinTunnus);
CREATE INDEX SalivarausAikavaliIndex ON Salivaraus(alkamispaivamaara, loppumispaivamaara);

CREATE INDEX SalinvalineNimiIndex ON Salinvaline(nimi);
CREATE INDEX SalinvalineSalinTunnusIndex ON Salinvaline(salinTunnus);

CREATE INDEX TekivarauksenVaraajaIndex ON Tekivarauksen(varaajanTunnus);
CREATE INDEX TekivarauksenSaliIndex ON Tekivarauksen(varaustunnus);

CREATE INDEX SaliSijaitseeTunnusIndex On SaliSijaitsee(salinTunnus);
CREATE INDEX SaliSijaitseeRakennusIndex On SaliSijaitsee(rakennuksenNimi);

CREATE VIEW TIKopiskelijat AS
	SELECT *
	FROM Opiskelija
	WHERE tutkinto = 'tietotekniikka';

CREATE VIEW tyontekijoidenVaraukset AS
	SELECT nimi, tunnus, salinTunnus, alkamispaivamaara, loppumispaivamaara
	FROM Tyontekija, Salivaraus, Tekivarauksen
	WHERE tunnus = varaajanTunnus AND Salivaraus.varaustunnus = Tekivarauksen.varaustunnus;