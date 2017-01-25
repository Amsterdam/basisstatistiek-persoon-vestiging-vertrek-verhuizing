--
-- stap 1
--
create materialized view persoon.vertrek_kern as
select * from vertrek_kern('2017-01-01', '2018-02-01', '2017-01-01', '2018-01-01');

--
-- Binnenland
--

--
-- stap 2
--
create materialized view persoon.vertrek_binnenland_aangehaakt as
select * from vertrek_binnenland_aangehaakt();

grant all on persoon.vertrek_binnenland_aangehaakt to maurice;
grant all on persoon.vertrek_binnenland_aangehaakt to hans;
grant all on persoon.vertrek_binnenland_aangehaakt to aafke;

--
-- stap 3
--
create index vertrek_binnenland_aangehaakt_anummr_idx on persoon.vertrek_binnenland_aangehaakt(anummr);
create index vertrek_binnenland_aangehaakt_bsnumm_idx on persoon.vertrek_binnenland_aangehaakt(bsnumm);
create index vertrek_binnenland_aangehaakt_huisnv_idx on persoon.vertrek_binnenland_aangehaakt(huisnv);
create index vertrek_binnenland_aangehaakt_huislv_idx on persoon.vertrek_binnenland_aangehaakt(huislv);
create index vertrek_binnenland_aangehaakt_hstoev_idx on persoon.vertrek_binnenland_aangehaakt(hstoev);
create index vertrek_binnenland_aangehaakt_ptkodv_idx on persoon.vertrek_binnenland_aangehaakt(ptkodv);

create materialized view persoon.vertrek_binnenland_aangehaakt_adres as
select * from vertrek_binnenland_aangehaakt_adres();

grant all on persoon.vertrek_binnenland_aangehaakt_adres to maurice;
grant all on persoon.vertrek_binnenland_aangehaakt_adres to hans;
grant all on persoon.vertrek_binnenland_aangehaakt_adres to aafke;

--
-- Buitenland
--

--
-- stap 4
--
create materialized view persoon.vertrek_buitenland_aangehaakt as
select * from vertrek_buitenland_aangehaakt();

grant all on persoon.vertrek_buitenland_aangehaakt to maurice;
grant all on persoon.vertrek_buitenland_aangehaakt to hans;
grant all on persoon.vertrek_buitenland_aangehaakt to aafke;

--
-- stap 5
--
create index vertrek_buitenland_aangehaakt_anummr_idx on persoon.vertrek_buitenland_aangehaakt(anummr);
create index vertrek_buitenland_aangehaakt_bsnumm_idx on persoon.vertrek_buitenland_aangehaakt(bsnumm);
create index vertrek_buitenland_aangehaakt_huisnv_idx on persoon.vertrek_buitenland_aangehaakt(huisnv);
create index vertrek_buitenland_aangehaakt_huislv_idx on persoon.vertrek_buitenland_aangehaakt(huislv);
create index vertrek_buitenland_aangehaakt_hstoev_idx on persoon.vertrek_buitenland_aangehaakt(hstoev);
create index vertrek_buitenland_aangehaakt_ptkodv_idx on persoon.vertrek_buitenland_aangehaakt(ptkodv);

create materialized view persoon.vertrek_buitenland_aangehaakt_adres as
select * from vertrek_buitenland_aangehaakt_adres();

grant all on persoon.vertrek_buitenland_aangehaakt_adres to maurice;
grant all on persoon.vertrek_buitenland_aangehaakt_adres to hans;
grant all on persoon.vertrek_buitenland_aangehaakt_adres to aafke;