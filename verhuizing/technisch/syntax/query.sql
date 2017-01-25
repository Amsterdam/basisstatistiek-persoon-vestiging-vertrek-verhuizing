--
-- stap 1
--
create materialized view persoon.verhuizing_kern as
select * from verhuizing_kern('2017-01-01', '2018-02-01', '2017-01-01', '2018-01-01');

--
-- stap 2
--
create materialized view persoon.verhuizing_aangehaakt as
select * from verhuizing_aangehaakt();

--
-- stap 3
--
create index verhuizing_aangehaakt_ptkodn_idx on persoon.verhuizing_aangehaakt(ptkodn);
create index verhuizing_aangehaakt_huisnn_idx on persoon.verhuizing_aangehaakt(huisnn);
create index verhuizing_aangehaakt_huisln_idx on persoon.verhuizing_aangehaakt(huisln);
create index verhuizing_aangehaakt_hstoen_idx on persoon.verhuizing_aangehaakt(hstoen);
create index verhuizing_aangehaakt_sort_idx on persoon.verhuizing_aangehaakt(anummr, bsnumm, geldig_op);

create materialized view persoon.verhuizing_aangehaakt_adres as
select * from verhuizing_aangehaakt_adres();

--
-- stap 4
--
create index verhuizing_aangehaakt_adres_hstoev_idx on persoon.verhuizing_aangehaakt_adres(hstoev);
create index verhuizing_aangehaakt_adres_huislv_idx on persoon.verhuizing_aangehaakt_adres(huislv);
create index verhuizing_aangehaakt_adres_huisnv_idx on persoon.verhuizing_aangehaakt_adres(huisnv);
create index verhuizing_aangehaakt_adres_ptkodv_idx on persoon.verhuizing_aangehaakt_adres(ptkodv);
create index verhuizing_aangehaakt_adres_sort_idx on persoon.verhuizing_aangehaakt_adres(anummr, bsnumm, geldig_op);

create materialized view persoon.verhuizing_aangehaakt_adres1 as
select * from verhuizing_aangehaakt_adres1();