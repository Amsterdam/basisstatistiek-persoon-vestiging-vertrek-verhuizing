create or replace function vertrek_binnenland_aangehaakt_adres()
returns table (
	jaar integer,
	anummr bigint,
	bsnumm bigint,
	unicod bigint,
	gslcha character varying,
	lndgbb bigint,
	gebpla character varying,
	bevcbs bigint,
	etncbs bigint,
	natiob bigint,
	vstdgr bigint,
	vstdta bigint,
	vstned bigint,
	brgstb bigint,
	codvbt integer,
	dathuw bigint,
	dathon bigint,
	dtbvbt bigint,
	dtevbt bigint,
	gbdtb8 bigint,
	leeftd double precision,
	leeft1 double precision,
	hhtypev bigint,
	uniou1 bigint,
	uniou2 bigint,
	gslou1 character varying,
	gslou2 character varying,
	gblou1 bigint,
	gblou2 bigint,
	gbdou1 bigint,
	gbdou2 bigint,
	huisnv integer,
	huislv character,
	hstoev character varying,
	ptkodv character,
	nwegem bigint,
	geldig_op integer,
	tydber integer,
	adrs15v text,
	stkodv bigint,
	bagidsv bigint,
	numidsv bigint,
	brtk15v text,
	bctk15v text,
	stad15v text,
	i22gebv character varying,
	i27gebv character varying,
	altbrt15v character varying,
	rayon15v character varying,
	brtk10v character varying
) as $$

select
	distinct on(anummr, bsnumm, geldig_op)
	a.jaar,
	a.anummr,
	a.bsnumm,
	a.unicod,
	a.gslcha,
	a.lndgbb,
	a.gebpla,
	a.bevcbs,
	a.etncbs,
	a.natiob,
	a.vstdgr,
	a.vstdta,
	a.vstned,
	a.brgstb,
	a.codvbt,
	a.dathuw,
	a.dathon,
	a.dtbvbt,
	a.dtevbt,
	a.gbdtb8,
	a.leeftd,
	a.leeft1,
	a.hhtypev,
	a.uniou1,
	a.uniou2,
	a.gslou1,
	a.gslou2,
	a.gblou1,
	a.gblou2,
	a.gbdou1,
	a.gbdou2,
	a.huisnv,
	a.huislv,
	a.hstoev,
	case when a.ptkodv is null and b.postcode is not null then
		b.postcode
	else
		a.ptkodv
	end as ptkodv,
	a.nwegem,
	a.geldig_op,
	a.tydber,
	case when a.stkodv is null then
		lpad(coalesce(b.straatcode::char(5), '00000'), 5, '0') || lpad(coalesce(a.huisnv::char(5), '00000'), 5, '0') || lpad(coalesce(a.huislv::char(1), ' '), 1, ' ') || rpad(coalesce(a.hstoev::char(4), '    '), 4, ' ')
	else
		lpad(coalesce(a.stkodv::char(5), '00000'), 5, '0') || lpad(coalesce(a.huisnv::char(5), '00000'), 5, '0') || lpad(coalesce(a.huislv::char(1), ' '), 1, ' ') || rpad(coalesce(a.hstoev::char(4), '    '), 4, ' ')
	end as adrs15v,
	case when a.stkodv is null then
		b.straatcode
	else
		a.stkodv
	end as stkodv,
	b.object_id as bagidsv,
	b.nummer_id as numidsv,
	b.buurtcode as brtk15v,
	substring(b.buurtcode, 1, 3) as bctk15v,
	substring(b.buurtcode, 1, 1) as stad15v,
	(select i22geb from bron.kwadrs where brtk15 = b.buurtcode and i22geb is not null order by kwartaal desc limit 1) as i22gebv,
	(select i27geb from bron.kwadrs where brtk15 = b.buurtcode and i27geb is not null order by kwartaal desc limit 1) as i27gebv,
	(select altbrt15 from bron.kwadrs where brtk15 = b.buurtcode and altbrt15 is not null order by kwartaal desc limit 1) as altbrt15v,
	(select rayon15 from bron.kwadrs where brtk15 = b.buurtcode and rayon15 is not null order by kwartaal desc limit 1) as rayon15v,
	(select brtk10 from bron.kwadrs as k where k.pttkod = a.ptkodv and k.huisnr = a.huisnv and coalesce(k.huislt, '-') = coalesce(a.huislv, '-') and k.brtk10 is not null order by k.kwartaal desc limit 1) as brtk10v
from
	persoon.vertrek_binnenland_aangehaakt as a
left join lateral
	geef_bag_informatie_voor_adres(a.ptkodv, a.stkodv, a.huisnv, a.huislv, a.hstoev, a.geldig_op::char(8)::timestamp without time zone) as b
on true
order by
	a.anummr, a.bsnumm, a.geldig_op;

$$ language sql;