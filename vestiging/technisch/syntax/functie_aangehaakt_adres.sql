create or replace function vestiging_aangehaakt_adres()
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
	hhtypen bigint,
	uniou1 bigint,
	uniou2 bigint,
	gslou1 character varying,
	gslou2 character varying,
	gblou1 bigint,
	gblou2 bigint,
	gbdou1 bigint,
	gbdou2 bigint,
	huisnn integer,
	huisln character,
	hstoen character varying,
	ptkodn character,
	geldig_op integer,
	tydber integer,
	adrs15n text,
	stkodn  bigint,
	bagidsn bigint,
	numidsn bigint,
	brtk15n text,
	bctk15n text,
	stad15n text,
	i22gebn character varying,
	i27gebn character varying,
	altbrt15n character varying,
	rayon15n character varying,
	brtk10n character varying,
	vorgem bigint,
	lndimm bigint
) as $$

with vestiging_extra as (
	select
		to_char(to_timestamp(geldigh__datum__opmaak_, 'DD-MM-YYYY'), 'YYYYMMDD')::int as geldig_op,
		to_timestamp(datum_opname_mutatie__opm__, 'DD-MM-YYYY') as kennisgegeven_op,
		*
	from
		bron.vestiging_extra
)
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
	a.hhtypen,
	a.uniou1,
	a.uniou2,
	a.gslou1,
	a.gslou2,
	a.gblou1,
	a.gblou2,
	a.gbdou1,
	a.gbdou2,
	a.huisnn,
	a.huisln,
	a.hstoen,
	case when a.ptkodn is null and b.postcode is not null then
		b.postcode
	else
		a.ptkodn
	end as ptkodn,
	a.geldig_op,
	a.tydber,
	case when a.stkodn is null then
		lpad(coalesce(b.straatcode::char(5), '00000'), 5, '0') || lpad(coalesce(a.huisnn::char(5), '00000'), 5, '0') || lpad(coalesce(a.huisln::char(1), ' '), 1, ' ') || rpad(coalesce(a.hstoen::char(4), '    '), 4, ' ')
	else
		lpad(coalesce(a.stkodn::char(5), '00000'), 5, '0') || lpad(coalesce(a.huisnn::char(5), '00000'), 5, '0') || lpad(coalesce(a.huisln::char(1), ' '), 1, ' ') || rpad(coalesce(a.hstoen::char(4), '    '), 4, ' ')
	end as adrs15n,
	case when a.stkodn is null then
		b.straatcode
	else
		a.stkodn
	end as stkodn,
	b.object_id as bagidsn,
	b.nummer_id as numidsn,
	b.buurtcode as brtk15n,
	substring(b.buurtcode, 1, 3) as bctk15n,
	substring(b.buurtcode, 1, 1) as stad15n,
	(select i22geb from bron.kwadrs where brtk15 = b.buurtcode and i22geb is not null order by kwartaal desc limit 1) as i22gebn,
	(select i27geb from bron.kwadrs where brtk15 = b.buurtcode and i27geb is not null order by kwartaal desc limit 1) as i27gebn,
	(select altbrt15 from bron.kwadrs where brtk15 = b.buurtcode and altbrt15 is not null order by kwartaal desc limit 1) as altbrt15n,
	(select rayon15 from bron.kwadrs where brtk15 = b.buurtcode and rayon15 is not null order by kwartaal desc limit 1) as rayon15n,
	(select brtk10 from bron.kwadrs as k where k.pttkod = a.ptkodn and k.huisnr = a.huisnn and coalesce(k.huislt, '-') = coalesce(a.huisln, '-') and k.brtk10 is not null order by k.kwartaal desc limit 1) as brtk10n,
	case when c.code_gemeente != 1999 and c.code_gemeente is not null then
		c.code_gemeente
	else
		null
	end as vorgem,
	case when c.code_gemeente = 1999 then
		c.code_gemeente
	else
		c.land_code_inschrijving::int
	end as lndimm
from
	persoon.vestiging_aangehaakt as a
left join lateral
	geef_bag_informatie_voor_adres(a.ptkodn, a.stkodn, a.huisnn, a.huisln, a.hstoen, a.geldig_op::char(8)::timestamp without time zone) as b
on
	true
left join
	(select
		count(*) over (partition by bsn_persoon) as aantal,
		*
	from
		vestiging_extra as z
	) as c
on
	bsn_persoon = a.bsnumm
and
	(
		(
			(c.kennisgegeven_op - to_timestamp(a.geldig_op::char(8), 'YYYYMMDD')) < '1 month'
		and
			c.geldig_op = a.geldig_op
		)
	or
		aantal = 1
	)
order by
	a.anummr, a.bsnumm, a.geldig_op, c.geldig_op desc, c.kennisgegeven_op desc;

$$ language sql;
