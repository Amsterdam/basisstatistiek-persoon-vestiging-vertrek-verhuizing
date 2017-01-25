--
-- Test 1: Persoon verhuist (A-B) in 2015 binnen Amsterdam. REVIEWED
--
insert into persoon.persoon ( id ) values ( 1 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 1, 1, 474223401, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 1, 363, NULL, '2014-08-23', NULL, '2014-08-25' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 1, 5523, 6030, 20, 'C', NULL, '2014-08-23', '2014-08-25' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 1, 630, 6030, 168, NULL, 3, '2015-03-02', '2015-03-10' );

--
-- Test 2: Inschrijving in Amsterdam in 2015 (B), voorafgaande adres is niet in Amsterdam (A) REVIEWED
--
insert into persoon.persoon ( id ) values ( 2 );
insert into persoon.persoon_id ( persoon_id, type_id, code,  kennisgegeven_op ) values ( 2, 1, 534733852, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 2, 471, NULL, '2012-06-14', NULL, '2012-06-20' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 2, 234, 6030, 12, NULL, NULL, '2012-06-14', '2012-06-20' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, ingeschreven_op, kennisgegeven_op ) values ( 2, 363, '2015-02-02', '2015-02-26' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 2, 15, 6030, 3, 'A', NULL, '2015-02-02', '2015-02-26' );

--
-- Test 3: Inschrijving buiten Amsterdam in 2015 (B), voorafgaand adres is in Amsterdam (A) REVIEWED
--
insert into persoon.persoon ( id ) values ( 3 );
insert into persoon.persoon_id ( persoon_id, type_id, code,  kennisgegeven_op ) values ( 3, 1, 651097794, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 3, 363, NULL, '2013-10-31', NULL, '2013-11-05' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 3, 512, 6030, 300, NULL, 'AF13', '2013-10-31', '2013-11-05' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, ingeschreven_op, kennisgegeven_op ) values ( 3, 471, '2015-03-25', '2015-04-02' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 3, 6004, 6030, 13, NULL, 3 , '2015-03-25', '2015-04-02' );

--
-- Test 4: Persoon verhuist begin 2016 binnen Amsterdam (A-B), voor 1e peildatum REVIEWED
--
insert into persoon.persoon ( id ) values ( 4 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 4, 1, 609717078, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 4, 363, NULL, '2010-01-23', NULL, '2010-07-01' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 4, 101, 6030, 5, 'D', NULL, '2010-01-23', '2010-07-01'  );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 4, 4291, 6030, 113, NULL, NULL, '2016-01-05', '2016-01-10' );

--
-- Test 5: Persoon verhuist in 2015 binnen Amsterdam (A-B), na 1e peildatum maar voor 2e peildatum gemeld
--
insert into persoon.persoon ( id ) values ( 5 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 5, 1, 38525252, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 5, 363, NULL, '2009-12-31', NULL, '2009-12-31' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 5, 1234, 6030, 751, NULL, 6, '2009-12-31', '2009-12-31' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 5, 2497, 6030, 13, 'BC', NULL, '2015-10-16', '2016-05-01' );

--
-- Test 6: Persoon verhuist in 2015 binnen Amsterdam (A-B), na 2e peildatum gemeld REVIEWED
--
insert into persoon.persoon ( id ) values ( 6 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 6, 1, 458698957, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 6, 363, NULL, '2014-11-23', NULL, '2015-01-02' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 6, 3245, 6030, 1005, 'F', NULL, '2014-11-23', '2015-01-02' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 6, 166, 6030, 12, NULL , '3A', '2015-05-29', '2017-03-18' );

--
-- Test 7: Persoon verhuist eind 2014 binnen Amsterdam (A-B), voor 1e peildatum gemeld REVIEWED
--
insert into persoon.persoon ( id ) values ( 7 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 7, 1, 181982948, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 7, 363, NULL, '2014-01-31', NULL, '2014-02-10' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 7, 590, 6030, 7, NULL, NULL, '2014-01-31', '2014-02-10'  );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 7, 1087, 6030, 17, 'Q', NULL, '2014-12-29', '2015-03-07' );

--
-- Test 9: Persoon verhuist in 2015 van (A) naar een puntadres (B)
--
-- REVIEW: Zoals je hem nu hebt gemaakt is dit zowel een vestiging als een verhuizing. In de testcase staat adres A vóór het tijdvak ligt.
-- Aangepast
--
insert into persoon.persoon ( id ) values ( 9 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 9, 1, 692053062, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 9, 363, NULL, '2010-07-12', NULL, '2010-07-27' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 9, 1009, 6030, 124, NULL, 2, '2014-12-16', '2014-12-20'  );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 9, 9999, NULL, 0, NULL, NULL, '2015-09-03', '2015-09-20' );

--
-- Test 11: Persoon verhuist in 2015 binnen Amsterdam (A-B), geldigheidsdatum is later dan kennisgevingsdatum REVIEWED
--
insert into persoon.persoon ( id ) values ( 11 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 11, 1, 271495649, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 11, 363, NULL, '2007-06-12', NULL, '2008-01-28' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 11, 654, 6030, 605, 'D', NULL, '2007-06-12', '2008-01-28'  );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 11, 6742, 6030, 23, NULL, NULL, '2015-02-23', '2015-01-20'  );

--
-- Test 12: Persoon vertrekt in 2015 uit Amsterdam (A), gemeentecode opvolgende inschrijving is geen Amsterdam, landcode inschrijving is geen Nederland (B)
--
-- REVIEW: Het komt in 2016 nooit voor dat we geen gemeentecode weten, maar wel een inschrijvingsdatum.
-- Aangepast (gemeentecode aangepast, de code is verzonnen omdat ik geen gemeentecodes van het buitenland weet)
--
insert into persoon.persoon ( id ) values ( 12 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 12, 1, 78219462, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 12, 363, 6030, '2001-04-12', '2001-04-12', '2004-05-06' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 12, 307, 6030, 2, 'B', NULL, '2001-04-12', '2004-05-06' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 12, 207, 7050, '2015-08-17', '2015-08-17', '2015-08-22' );

-- 
-- Test 13: Inschrijving van persoon in 2015 in Amsterdam (B), geen voorafgaand adres (A), inschrijvingsdatum is gelijk aan geboortedatum	REVIEWED
--
insert into persoon.persoon ( id ) values ( 13 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 13, 1, 402494362, '1900-01-01' );
insert into persoon.geboorte ( persoon_id, datum, kennisgegeven_op ) values ( 13, '2015-05-01', '2015-06-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 13, 363, NULL, '2015-05-01', NULL, '2015-06-01' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 13, 1044, 6030, 144, 'F', NULL, '2015-05-01', '2015-06-01' );

--
-- Test 14: Persoon verhuist in 2015 binnen Amsterdam van (A) naar (B), later in 2015 wordt het opvolgend adres teruggezet naar het adres vóór mutatie (C) REVIEWED
--
insert into persoon.persoon ( id ) values ( 14 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 14, 1, 528247761, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 14, 363, NULL, '2012-11-01', NULL, '2012-12-10' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 14, 124, 6030, 144, NULL, NULL, '2012-11-01', '2012-12-10' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 14, 4055, 6030, 18, NULL, '7B', '2015-05-05', '2015-05-05' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 14, 124, 6030, 144, NULL, NULL, '2015-05-05', '2015-10-17' );

--
-- Test 15: Persoon verhuist in 2015 binnen Amsterdam van (A) naar (B), na 1e peildatum wordt het opvolgend adres teruggezet naar het adres vóór mutatie (C)
--
-- REVIEW: Deze persoon heeft een adres geldigheid voordat hij een geldige inschrijving heeft in Amsterdam.
-- Aangepast
--
insert into persoon.persoon ( id ) values ( 15 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 15, 1, 644660624, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 15, 363, NULL, '2013-11-06', NULL, '2013-11-06' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 15, 998, 6030, 13, 'A', NULL, '2014-10-03', '2014-10-23' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 15, 7533, 6030, 163, NULL, 3, '2015-01-20', '2015-01-21' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 15, 998, 6030, 13, 'A', NULL, '2014-10-03', '2016-09-10' );

--
-- Test 16: Persoon verhuist in 2015 binnen Amsterdam (A-B), voor 1e peildatum wordt het opvolgend adres teruggezet naar het adres vóór mutatie (C), na 1e peildatum wordt die correctie weer ongedaan gemaakt (D)
--
-- REVIEW: Deze persoon heeft een adres geldigheid voordat hij een geldige inschrijving heeft in Amsterdam.
-- Verder interpreteer ik deze case anders dan jij. Volgens mij wordt adres B teruggezet naar adres A voor 1e peildatum. Daarna wordt na de 1e peildatum adres A toch weer op adres B gezet.
-- Ook kloppen je opmerkingen niet. D geldig_op is niet gelijk aan B geldig_op
-- En dan is door je inschrijving in 2015 deze case niet alleen een verhuizing, maar ook een vestiging.
--
-- Aangepast
--
insert into persoon.persoon ( id ) values ( 16 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 16, 1, 398478429, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 16, 363, NULL, '2011-01-01', NULL, '2011-01-05' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 16, 1012, 6030, 134, NULL, 1, '2011-09-23', '2011-09-28' );--A
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 16, 308, 6030, 81, NULL, NULL, '2015-12-16', '2015-12-23' );--B
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 16, 1012, 6030, 134, NULL, 1, '2015-12-16', '2016-01-10' );--C geldig_op is gelijk aan situatie A
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 16, 308, 6030, 81, NULL, NULL, '2015-12-16', '2016-03-01' );--D geldig_op is gelijk aan situatie A

--
-- Test 17: Persoon verhuist in 2015 binnen Amsterdam van (A) naar (B), op dezelfde dag nogmaals verhuisd naar ander adres (C)
--
-- REVIEW: Typefout in inschrijvingsjaar. Daarnaast zou ik hier wel de kennisgevingsdatum na de inschrijvingsdatum laten vallen.
-- Ook zou ik van adres C de kennisgevingsdatum later zetten dan van B. Deze case overigens maar één verhuizing op, omdat in de huidige structuur adres C als correctie van adres B wordt gezien.
--
insert into persoon.persoon ( id ) values ( 17 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 17, 1, 602641627, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 17, 363, NULL, '2012-12-30', NULL, '2013-01-05' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 17, 127, 6030, 601, NULL, '1A', '2014-07-27', '2014-07-28' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 17, 4321, 6030, 97, NULL, NULL, '2015-04-12', '2015-04-18' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 17, 703, 6030, 75, 'C', NULL, '2015-04-12', '2015-05-28' );

--
-- Test 18: Persoon verhuist in 2015 binnen Amsterdam van (A) naar (B), maar overlijdensdatum ligt voor de inschrijvingsdatum
--
insert into persoon.persoon ( id ) values ( 18 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 18, 1, 471002471, '1900-01-01' );
insert into persoon.sterfte ( persoon_id, overleden_op, kennisgegeven_op ) values ( 18, '2015-08-17', '2015-08-18' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 18, 363, NULL, '2010-06-16', NULL, '2010-06-24' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 18, 4321, 6030, 97, NULL, NULL, '2015-01-12', '2015-01-13' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 18, 703, 6030, 75, 'C', NULL, '2015-08-21', '2015-08-22' );

--
-- Test 19: Persoon vertrekt in 2015 uit Nederland (A) naar buitenland (B), komt weer terug in Amsterdam (C), vertrekt weer uit Nederland (D). In alle gevallen komt de persoon terug op hetzelfde adres. REVIEWED
--
insert into persoon.persoon ( id ) values ( 19 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 19, 1, 013495264, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 19, 363, NULL, '2015-01-01', NULL, '2015-01-06' );--A
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 19, 103, 6030, 17, NULL, '3F', '2015-01-01', '2015-01-06' );--A
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 19, NULL, 6022, NULL, '2015-01-20', '2015-01-21' );--B
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 19, 363, 6030, '2015-03-02', '2015-03-02', '2015-03-05' );--C
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 19, 103, 6030, 17, NULL, '3F', '2015-03-02', '2015-03-05' );--C
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 19, NULL, 6035, '2015-10-06', NULL, '2015-10-12' );--D

--
-- Test 20: Persoon verhuist in 2015 in Amsterdam (A-B), vertrekt later in 2015 uit Nederland (C), komt weer terug in Amsterdam (D), verhuist weer een keer (E)
-- en vertrekt weer uit Nederland (F). REVIEWED
--
insert into persoon.persoon ( id ) values ( 20 );
insert into persoon.persoon_id ( persoon_id, type_id, code,  kennisgegeven_op ) values ( 20, 1, 484489768, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 20, 363, NULL, '2003-10-02', NULL, '2003-10-12' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 20, 1287, 6030, 12, 'B', NULL, '2011-03-17', '2011-03-27' );--A
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 20, 708, 6030, 78, NULL, NULL, '2015-01-20', '2015-01-25' );--B
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 20, NULL, 6061, NULL, '2015-03-01', '2015-03-19' );--C
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 20, 363, 6030, '2015-06-23', '2015-06-23', '2015-06-26' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 20, 1278, 6030, 806, NULL, '1A', '2015-06-23', '2015-06-26' );--D
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 20, 908, 6030, 17, NULL, NULL, '2015-09-18', '2015-10-01' );--E
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 20, NULL, 5013, NULL, '2015-11-08', '2015-11-16' );--F

--
-- Test 21: Persoon duikt in 2015 op in Amsterdam. REVIEWED
--
insert into persoon.persoon ( id ) values ( 21 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 21, 1, 592408048, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 21, 363, NULL, '2015-05-05', NULL, '2015-05-29' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 21, 197, 6030, 12, 'B', NULL, '2015-05-05', '2015-05-29' );

--
-- Test 22: Geboortedatum correctie (naar later in tijdvak), maar geen inschrijvingsdatum correctie. REVIEWED
--
insert into persoon.persoon ( id ) values ( 22 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 22, 1, 201256381, '1900-01-01' );
insert into persoon.geboorte ( persoon_id, datum, kennisgegeven_op ) values ( 22, '2015-10-12', '2015-11-01' );
insert into persoon.geboorte ( persoon_id, datum, kennisgegeven_op ) values ( 22, '2015-10-31', '2015-11-18' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 22, 363, NULL, '2015-10-12', NULL, '2015-11-01' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 22, 604, 6030, 73, NULL, 5, '2015-10-31', '2015-11-08' );

--
-- Test 23: Verhuizing naar hetzelfde adres (postcode en straatcode zijn leeg) (A) maar aan de gemeente van inschrijving is te zien dat het adres in een andere gemeente moet liggen (B). REVIEWED
--
insert into persoon.persoon ( id ) values ( 23 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 23, 1, 276853477, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 23, 363, 6030, '2015-02-23', NULL, '2015-02-23' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 23, NULL, 6030, 112, NULL, NULL, '2015-02-23', '2015-02-24' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 23, 471, 6030, '2015-11-03', NULL, '2015-11-05' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 23, NULL, 6030, 112, NULL, NULL, '2015-11-03', '2015-11-06' );

--
-- Test 24: Persoon woont in Amsterdam en staat op dezelfde datum ingeschreven in Amsterdam (A). Persoon verhuist een paar keer (binnen Amsterdam) (B, D),
-- maar de gemeente van inschrijving na de tweede verhuizing is op dezelfde datum buiten Amsterdam (C).
--
insert into persoon.persoon ( id ) values ( 24 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 24, 1, 067164687, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 24, 363, NULL, '2014-04-18', NULL, '2014-04-19' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 24, 18756, 6030, 63, 'E', NULL, '2014-04-18', '2014-04-19' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 24, 7068, 6030, 633, NULL, '2F', '2015-03-23', '2015-03-29' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op ) values ( 24, 471, NULL, '2015-06-03', NULL, '2015-06-10' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 24, 1205, 6030, 12, 'A', NULL, '2015-06-03', '2015-06-10' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 24, 668, 6030, 257, NULL, 2, '2015-10-31', '2015-11-12' );

--
-- Test 25: Persoon verhuist naar nagenoeg hetzelfde adres (zonder straatcode en postcode) (A), maar de huisnummertoevoeging wordt huisletter (B).
--
insert into persoon.persoon ( id ) values ( 25 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 25, 1, 289704650, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, ingeschreven_op, kennisgegeven_op ) values ( 25, 363, '2015-02-04', '2015-02-05' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 25, NULL, 6030, 306, NULL, 'C', '2015-10-31', '2015-11-12' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 25, NULL, 6030, 306, 'C', NULL, '2015-11-20', '2015-11-25' );

--
-- Test 26: Persoon verhuist in 2015 in Amsterdam (A-B), vertrekt later in 2015 uit Amsterdam (C), komt weer terug in Amsterdam (D),
-- verhuist weer een keer (E) en vertrekt weer uit Amsterdam (F).
--
insert into persoon.persoon ( id ) values ( 26 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 26, 1, 289704650, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 26, 363, NULL, '2008-12-30', NULL, '2009-01-10' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 26, 160, 6030, 12, 'A', NULL, '2012-04-09', '2012-04-17' );--A
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 26, 8516, 6030, 1, 'A', NULL, '2015-02-20', '2015-02-21' );--B
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 26, 471, NULL, '2015-04-12', NULL, '2014-04-17' );--C
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 26, 363, NULL, '2015-05-18', NULL, '2015-06-01' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 26, 3339, 6030, 700, NULL, 2, '2015-05-18', '2015-06-01' );--D
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 26, 70456, 6030, 73, 'C', NULL, '2015-10-03', '2015-10-31' );--E
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 26, 471, NULL, '2015-12-01', NULL, '2015-12-18' );--F

--
-- Test 27: Persoon verhuisd 2015 binnen Amsterdam, in de ochtend kennisgegeven op 31 januari 2016
--
insert into persoon.persoon ( id ) values ( 27 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 27, 1, 468161466, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 27, 363, NULL, '2014-03-28', NULL, '2014-03-29' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 27, 1476, 6030, 4512, NULL, '3C', '2012-04-09', '2012-04-17 08:03:00' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 27, 67561, 6030, 541, NULL, NULL, '2015-12-07', '2016-01-31 09:15:12' );

--
-- Test 28: Persoon verhuisd 2015 binnen Amsterdam, in de middag kennisgegeven op 31 januari 2016
--
insert into persoon.persoon ( id ) values ( 28 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 28, 1, 115199585, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 28, 363, NULL, '2011-08-12', NULL, '2011-08-17' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 28, 42567, 6030, 834, 'D', NULL, '2013-04-16', '2013-04-17 23:03:12' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 28, 1055, 6030, 672, NULL, NULL, '2015-12-29', '2016-01-31 15:04:30' );

--
-- Test 29: Persoon verhuisd 2015 binnen Amsterdam, om 1 minuut voor 12 's avonds kennisgegeven op 31 januari 2016
--
insert into persoon.persoon ( id ) values ( 29 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 29, 1, 320265456, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 29, 363, NULL, '2014-12-13', NULL, '2014-12-17' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 29, 6745, 6030, 106, NULL, NULL, '2014-12-13', '2014-12-17 23:03:12' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 29, 108, 6030, 756, NULL, NULL, '2015-12-31', '2016-01-31 23:59:59' );

--
-- Test 30: Persoon verhuisd 2015 binnen Amsterdam, om 1 minuut over 12 's avonds kennisgegeven op 1 feburari 2016
--
insert into persoon.persoon ( id ) values ( 30 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 30, 1, 037694868, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 30, 363, NULL, '2013-06-28', NULL, '2013-07-29' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 30, 42567, 6030, 834, 'D', NULL, '2014-03-01', '2014-03-02 23:03:12' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 30, 1055, 6030, 672, NULL, NULL, '2015-12-08', '2016-02-01 00:00:01' );

--
-- Test 31: Persoon vertrekt naar het buitenland, maar heeft geen voorgaande Amsterdamse inschrijving
--
insert into persoon.persoon ( id ) values ( 31 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 31, 1, 083598315, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 31, NULL, 5054, NULL, '2015-09-09', '2015-09-22' );

--
-- Test 32: Persoon vertrekt naar een andere gemeente, maar heeft geen voorgaande Amsterdamse inschrijving
--
insert into persoon.persoon ( id ) values ( 32 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 32, 1, 674800497, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 32, 471, NULL, '2015-03-17', NULL, '2015-03-25' );

--
-- Test 33: Persoon vertrekt naar het buitenland (A-B) , maar van de voorgaande inschrijving is alleen de vestigingsdatum bekend
--
insert into persoon.persoon ( id ) values ( 33 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 33, 1, 674800497, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 33, NULL, NULL, NULL, '2014-06-28', '2014-06-29' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 33, 8944, 6030, 136, NULL, 'A', '2014-09-16', '2014-09-20' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 33, NULL, 7008, '2015-05-01', NULL, '2015-05-12' );

--
-- Test 34: Persoon vertrekt uit Amsterdam (A) (land code = 0) en vestigt daarna weer (B), maar heeft voor het eerste vertrek geen inschrijving in Amsterdam
--
insert into persoon.persoon ( id ) values ( 34 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values ( 34, 1, 083598315, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 34, NULL, 0, NULL, '2015-07-19', '2015-07-21' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 34, 363, 6030, '2015-11-23', NULL, '2015-11-25' );
insert into persoon.adres ( persoon_id, straat_id, land_id, huisnummer, huisletter, huisnummertoevoeging, geldig_op, kennisgegeven_op ) values ( 34, 5663, 6030, 6521, NULL, 2, '2015-11-23', '2015-11-25' );

--
-- Test 35: Persoon vertrekt in 2015 uit Amsterdam (A-B), maar vertrekt in 2015 nog een keer uit Amsterdam (C), zonder dat er een Amsterdamse inschrijving tussen zit.
--
insert into persoon.persoon ( id ) values ( 35 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values (35, 1, 345311735, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 35, 363, NULL, '2015-02-11', NULL, '2015-03-02' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 35, 471, NULL, '2015-05-19', NULL, '2015-05-27' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 35, 471, NULL, '2015-12-03', NULL, '2015-12-09' );

--
-- Test 36: Persoon staat in 2015 ingeschreven in Amsterdam, maar met een latere vestigingsdatum uit het buitenland. Later in 2015 vertrekt deze persoon naar het buitenland.
--
insert into persoon.persoon ( id ) values ( 36 );
insert into persoon.persoon_id ( persoon_id, type_id, code, kennisgegeven_op ) values (36, 1, 023950833, '1900-01-01' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 36, 363, 6030, '2015-07-17', '2015-10-08', '2015-07-17' );
insert into persoon.inschrijving ( persoon_id, gemeente_id, land_id, ingeschreven_op, gevestigd_op, kennisgegeven_op  ) values ( 36, NULL, 6013, NULL, '2015-12-08', '2015-12-10' );
