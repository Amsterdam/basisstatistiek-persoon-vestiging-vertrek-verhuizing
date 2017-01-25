--
-- stap 1
--
create materialized view persoon.vestiging_kern as
select * from vestiging_kern('2017-01-01', '2018-02-01', '2017-01-01', '2018-01-01');

grant all on persoon.vestiging_kern to maurice;
grant all on persoon.vestiging_kern to hans;
grant all on persoon.vestiging_kern to aafke;

--
-- stap 2
--
create materialized view persoon.vestiging_aangehaakt as
select * from vestiging_aangehaakt();

grant all on persoon.vestiging_aangehaakt to maurice;
grant all on persoon.vestiging_aangehaakt to hans;
grant all on persoon.vestiging_aangehaakt to aafke;

--
-- stap 3
--
create index vestiging_aangehaakt_anummr_idx on persoon.vestiging_aangehaakt(anummr);
create index vestiging_aangehaakt_bsnumm_idx on persoon.vestiging_aangehaakt(bsnumm);
create index vestiging_aangehaakt_huisnn_idx on persoon.vestiging_aangehaakt(huisnn);
create index vestiging_aangehaakt_huisln_idx on persoon.vestiging_aangehaakt(huisln);
create index vestiging_aangehaakt_hstoen_idx on persoon.vestiging_aangehaakt(hstoen);
create index vestiging_aangehaakt_ptkodv_idx on persoon.vestiging_aangehaakt(ptkodn);

create materialized view persoon.vestiging_aangehaakt_adres as
select * from vestiging_aangehaakt_adres();

grant all on persoon.vestiging_aangehaakt_adres to maurice;
grant all on persoon.vestiging_aangehaakt_adres to hans;
grant all on persoon.vestiging_aangehaakt_adres to aafke;