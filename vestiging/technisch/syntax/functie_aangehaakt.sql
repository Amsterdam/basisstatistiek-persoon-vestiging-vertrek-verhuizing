create or replace function vestiging_aangehaakt()
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
	stkodn bigint,
	huisnn integer,
	huisln character,
	hstoen character varying,
	ptkodn character,
	geldig_op integer,
	tydber integer
) as $$

select
	distinct on(a.a_nummer, a.bs_nummer, a.ingeschreven_op)
	2017 as jaar,
	a.a_nummer as anummr,
	a.bs_nummer bsnumm,
	c.unicod,
	coalesce(c.gslcha, (select coalesce("O_geslachtsaanduiding", "N_geslachtsaanduiding") from bron.brp_stuf_csv where "O_a_nummer" = a.a_nummer or "N_a_nummer" = a.a_nummer order by "Tijdstip bericht" desc limit 1)) as gslcha,
	c.lndgbb,
	c.gebpla,
	c.bevcbs,
	c.etncbs,
	c.natiob,
	c.vstdgr,
	c.vstdta,
	c.vstned,
	c.brgstb,
	c.codvbt::int,
	c.dathuw::bigint,
	c.dathon::bigint,
	c.dtbvbt::bigint,
	c.dtevbt::bigint,
	coalesce(c.gbdtb8, (select coalesce("O_geboortedatum", "N_geboortedatum") from bron.brp_stuf_csv where "O_a_nummer" = a.a_nummer or "N_a_nummer" = a.a_nummer order by "Tijdstip bericht" desc limit 1)) as gbdtb8,
	extract('years' from age(a.ingeschreven_op, to_timestamp(coalesce(c.gbdtb8, (select coalesce("O_geboortedatum", "N_geboortedatum") from bron.brp_stuf_csv where "O_a_nummer" = a.a_nummer or "N_a_nummer" = a.a_nummer order by "Tijdstip bericht" desc limit 1))::char(8), 'YYYYMMDD')::timestamp without time zone)) as leeftd,
	extract('years' from age('2017-01-01', to_timestamp(coalesce(c.gbdtb8, (select coalesce("O_geboortedatum", "N_geboortedatum") from bron.brp_stuf_csv where "O_a_nummer" = a.a_nummer or "N_a_nummer" = a.a_nummer order by "Tijdstip bericht" desc limit 1))::char(8), 'YYYYMMDD')::timestamp without time zone)) as leeft1,
	case when (g.pttkod::char(6) = (f.postcode4::char(4) || f.postcode2)::char(6)) and (coalesce(g.huisnr, 0) = coalesce(f.huisnummer, 0)) and (coalesce(g.hstoev, '-') = coalesce(f.huisnummertoevoeging, '-')) and (coalesce(g.huislt, '-') = coalesce(f.huisletter, '-')) then
		g.hhtype
	else
		NULL
	end as hhtypen,
	c.uniou1,
	c.uniou2,
	d.gslcha as gslou1,
	e.gslcha as gslou2,
	d.lndgbb as gblou1,
	e.lndgbb as gblou2,
	d.gbdtb8 as gbdou1,
	e.gbdtb8 as gbdou2,
	f.straat_id as stkodn,
	f.huisnummer as huisnn,
	f.huisletter as huisln,
	f.huisnummertoevoeging as hstoen,
	(f.postcode4::char(4) || f.postcode2)::char(6) as ptkodn,
	to_char(a.ingeschreven_op, 'YYYYMMDD')::int as geldig_op,
	to_char(a.kennisgegeven_op, 'YYYYMMDD')::int as tydber
	/* Nu onhaalbaar */
	-- ptkodv,
	-- stkodv,
	-- huisnv,
	-- huislv,
	-- hstoev,
	-- bagidsv,
	-- numidsv
from
	persoon.vestiging_kern as a
left join lateral
	(
	select
		distinct on(anummr, bsnumm)
		*
	from
		(
			select '201701' as kwartaal, peildt, unicod, anummr, bsnumm, gslcha, gbdtb8, lndgbb, gebpla, bevcbs, etncbs, natiob, uniou1, uniou2, vstdgr, vstdta, vstned, brgstb, codvbt, dathuw::varchar, dathon, dtbvbt, dtevbt from bron.kw20171 as z where (a.a_nummer = z.anummr or a.bs_nummer = z.bsnumm)
		union all
			select '201704' as kwartaal, peildt, unicod, anummr, bsnumm, gslcha, gbdtb8, lndgbb, gebpla, bevcbs, etncbs, natiob, uniou1, uniou2, vstdgr, vstdta, vstned, brgstb, codvbt, dathuw::varchar, dathon, dtbvbt, dtevbt from bron.kw20172 as y where (a.a_nummer = y.anummr or a.bs_nummer = y.bsnumm)
		union all
			select '201707' as kwartaal, peildt, unicod, anummr, bsnumm, gslcha, gbdtb8, lndgbb, gebpla, bevcbs, etncbs, natiob, uniou1, uniou2, vstdgr, vstdta, vstned, brgstb, codvbt, dathuw::varchar, dathon, dtbvbt, dtevbt from bron.kw20173 as x where (a.a_nummer = x.anummr or a.bs_nummer = x.bsnumm)
		union all
			select '201710' as kwartaal, peildt, unicod, anummr, bsnumm, gslcha, gbdtb8, lndgbb, gebpla, bevcbs, etncbs, natiob, uniou1, uniou2, vstdgr, vstdta, vstned, brgstb, codvbt, dathuw::varchar, dathon, dtbvbt, dtevbt from bron.kw20174 as w where (a.a_nummer = w.anummr or a.bs_nummer = w.bsnumm)
		union all
			select '201801' as kwartaal, peildt, unicod, anummr, bsnumm, gslcha, gbdtb8, lndgbb, gebpla, bevcbs, etncbs, natiob, uniou1, uniou2, vstdgr, vstdta, vstned, brgstb, codvbt, dathuw::varchar, dathon, dtbvbt, dtevbt from bron.kw20181 as v where (a.a_nummer = v.anummr or a.bs_nummer = v.bsnumm)
		) as b
	order by
		--
		-- Voor de persoongegevens pakken we het kwartaalbestand dat het dichts bij ligt.
		--
		anummr, bsnumm, abs(extract(day from a.ingeschreven_op - to_timestamp(kwartaal::char(6), 'YYYYMM')::timestamp without time zone))
	) as c
on
	(
		a.a_nummer = c.anummr
or
		a.bs_nummer = c.bsnumm
	)
left join lateral
	(
	select
		distinct on(anummr, bsnumm)
		*
	from
		(
			select '201701' as kwartaal, peildt, unicod, anummr, bsnumm, hhtype, pttkod, huisnr, hstoev, huislt from bron.kw20171 as z where (a.a_nummer = z.anummr or a.bs_nummer = z.bsnumm)
		union all
			select '201704' as kwartaal, peildt, unicod, anummr, bsnumm, hhtype, pttkod, huisnr, hstoev, huislt from bron.kw20172 as y where (a.a_nummer = y.anummr or a.bs_nummer = y.bsnumm)
		union all
			select '201707' as kwartaal, peildt, unicod, anummr, bsnumm, hhtype, pttkod, huisnr, hstoev, huislt from bron.kw20173 as x where (a.a_nummer = x.anummr or a.bs_nummer = x.bsnumm)
		union all
			select '201710' as kwartaal, peildt, unicod, anummr, bsnumm, hhtype, pttkod, huisnr, hstoev, huislt from bron.kw20174 as w where (a.a_nummer = w.anummr or a.bs_nummer = w.bsnumm)
		union all
			select '201801' as kwartaal, peildt, unicod, anummr, bsnumm, hhtype, pttkod, huisnr, hstoev, huislt from bron.kw20181 as v where (a.a_nummer = v.anummr or a.bs_nummer = v.bsnumm)
		) as b
	where
		--
		-- Voor de huishoudtype pakken we het dichtbij zijnde kwartaal bestand na de vestigingsdatum
		--
		extract(day from a.ingeschreven_op - to_timestamp(kwartaal::char(6), 'YYYYMM')::timestamp without time zone) < 0
	order by
		anummr, bsnumm, extract(day from a.ingeschreven_op - to_timestamp(kwartaal::char(6), 'YYYYMM')::timestamp without time zone) desc
	) as g
on
	(
		a.a_nummer = c.anummr
or
		a.bs_nummer = c.bsnumm
	)
left join lateral
	(select
		distinct on(unicod)
		*
	from
		(
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20181 as z where (z.unicod = c.uniou1)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20174 as y where (y.unicod = c.uniou1)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20173 as x where (x.unicod = c.uniou1)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20172 as w where (w.unicod = c.uniou1)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20171 as v where (v.unicod = c.uniou1)
		) as b
	order by
		unicod, peildt desc
	) as d
on
	d.unicod = c.uniou1
left join lateral
	(select
		distinct on(unicod)
		*
	from
		(
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20181 as z where (z.unicod = c.uniou2)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20174 as y where (y.unicod = c.uniou2)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20173 as x where (x.unicod = c.uniou2)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20172 as w where (w.unicod = c.uniou2)
		union all
			select peildt, unicod, gslcha, gbdtb8, lndgbb from bron.kw20171 as v where (v.unicod = c.uniou2)
		) as b
	order by
		unicod, peildt desc
	) as e
on
	e.unicod = c.uniou2
left join
	persoon.adres as f
on
	f.persoon_id = a.persoon_id
and
	f.geldig_op = a.ingeschreven_op
/*
 * Validatiecriteria
 * - In het geval van een puntadresser is de postcode onbekend.
 *   Postcodes met een NULL waarden moeten dus niet uitgesloten worden.
 */
where
	(coalesce(f.postcode4, 1000) >= 1000 and coalesce(f.postcode4, 1000) <= 1109)
order by
	a.a_nummer, a.bs_nummer, a.ingeschreven_op, f.geldig_op desc, f.kennisgegeven_op desc, f.id desc;

$$ language sql;