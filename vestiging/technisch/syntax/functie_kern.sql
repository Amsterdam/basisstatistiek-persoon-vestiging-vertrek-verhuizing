create or replace function vestiging_kern (
	kennisgevingsdatum_begin timestamp without time zone,
	kennisgevingsdatum_eind timestamp without time zone,
	geldigheidsdatum_begin timestamp without time zone,
	geldigheidsdatum_eind timestamp without time zone
)
returns table (
	bs_nummer bigint,
	a_nummer bigint,
	persoon_id bigint,
	ingeschreven_op timestamp without time zone,
	kennisgegeven_op timestamp without time zone
) as $$

select
	distinct on(d.bs_nummer, c.a_nummer, a.ingeschreven_op)
	d.bs_nummer,
	c.a_nummer,
	a.persoon_id,
	a.ingeschreven_op,
	a.kennisgegeven_op
from
	(select
		persoon_id,
		gemeente_id,
		ingeschreven_op,
		kennisgegeven_op,
		lag(persoon_id) over (order by persoon_id, ingeschreven_op) as p_persoon_id,
		lag(gemeente_id) over (order by persoon_id, ingeschreven_op) as p_gemeente_id,
		lag(ingeschreven_op) over (order by persoon_id, ingeschreven_op) as p_ingeschreven_op,
		count(persoon_id) over (partition by persoon_id order by persoon_id) as aantal,
		first_value(ingeschreven_op) over (partition by persoon_id order by persoon_id, ingeschreven_op) as f_ingeschreven_op,
		(select
			distinct on(persoon_id)
			land_id
		from
			persoon.vestiging as z
		where
			(case when kennisgevingsdatum_eind is null then
				true
			when kennisgevingsdatum_eind is not null then
				z.kennisgegeven_op < kennisgevingsdatum_eind
			end)
		and
			z.persoon_id = a.persoon_id
		and
			z.gevestigd_op < ingeschreven_op
		order by
			z.persoon_id, z.gevestigd_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
		) as p_land_id,
		(select
			distinct on(persoon_id)
			type_id
		from
			persoon.vestiging as z
		where
			(case when kennisgevingsdatum_eind is null then
				true
			when kennisgevingsdatum_eind is not null then
				z.kennisgegeven_op < kennisgevingsdatum_eind
			end)
		and
			z.persoon_id = a.persoon_id
		and
			z.gevestigd_op < ingeschreven_op
		order by
			z.persoon_id, z.gevestigd_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
		) as p_type_id
	from
		(select
			distinct on(persoon_id, ingeschreven_op)
			*
		from
			(select
				id,
				persoon_id,
				gemeente_id,
				ingeschreven_op,
				geldig_op,
				kennisgegeven_op
			from
				persoon.inschrijving
			where
				(case when kennisgevingsdatum_begin is null and kennisgevingsdatum_eind is null then
				true
				when kennisgevingsdatum_begin is null and kennisgevingsdatum_eind is not null then
					kennisgegeven_op < kennisgevingsdatum_eind
				when kennisgevingsdatum_begin is not null and kennisgevingsdatum_eind is null then
					kennisgegeven_op >= kennisgevingsdatum_begin
				when kennisgevingsdatum_begin is not null and kennisgevingsdatum_eind is not null then
					(kennisgegeven_op >= kennisgevingsdatum_begin and kennisgegeven_op < kennisgevingsdatum_eind)
				end)
			) as a
		order by
			persoon_id, ingeschreven_op desc, geldig_op desc, kennisgegeven_op desc, id desc
		) as a
	) as a
--
-- Voorheen werd er gekeken of deze persoon in de geboortedatum voor kwam,
-- en zo ja, de geboortedatum vergeleken met de vestigingsdatum. Dit blijkt niet
-- voldoende. Gevallen waarbij de geboortedatum wijzigt (naar later) zonder dat
-- de vestigingsdatum wijzigt, komen niet voor in de geboorte dataset.
-- Doordat deze niet voorkomt in die dataset, kan er ook niet vergeleken worden
-- met de datum. Als gevolg kunnen er inschrijvingen naar boven komen die vóór
-- de gecorrigeerde geboortedatum liggen.
--
left join
	--
	-- Selecteer alle geboorterecords
	-- voor het tijdvak en voor de
	-- peildatum
	--
	(select
		distinct on(persoon_id)
		persoon_id,
		datum,
		geldig_op
	from
		persoon.geboorte
	where
		(case when kennisgevingsdatum_eind is null then
			true
		when kennisgevingsdatum_eind is not null then
			kennisgegeven_op < kennisgevingsdatum_eind
		end)
	order by
		persoon_id, geldig_op desc, kennisgegeven_op desc, id desc
	) as b
on
	a.persoon_id = b.persoon_id
left join
	(select
		distinct on(persoon_id)
		persoon_id,
		code as a_nummer
	from
		persoon.persoon_id
	where
		type_id = (select id from persoon.persoon_id_type where afkorting = 'AN')
	and
		(case when kennisgevingsdatum_eind is null then
			true
		when kennisgevingsdatum_eind is not null then
			kennisgegeven_op < kennisgevingsdatum_eind
		end)
	order by
		persoon_id
	) as c
on
	a.persoon_id = c.persoon_id
left join
	(select
		distinct on(persoon_id)
		persoon_id,
		code as bs_nummer
	from
		persoon.persoon_id
	where
		type_id = (select id from persoon.persoon_id_type where afkorting = 'BSN')
	and
		(case when kennisgevingsdatum_eind is null then
			true
		when kennisgevingsdatum_eind is not null then
			kennisgegeven_op < kennisgevingsdatum_eind
		end)
	order by
		persoon_id
	) as d
on
	a.persoon_id = d.persoon_id
where
	(
		(
			(
				p_persoon_id = a.persoon_id
			or
				p_persoon_id is null
			or
				f_ingeschreven_op = a.ingeschreven_op
			)
		and
			(
				(
					p_persoon_id = a.persoon_id
				and
					(
						p_gemeente_id != 363
					or
						(p_land_id != 6030 and p_type_id = 0)
					or
						p_gemeente_id is null
					)
				)
			or
				f_ingeschreven_op = a.ingeschreven_op
			)
		)
	)
and
	gemeente_id = 363
and
	(case when geldigheidsdatum_begin is null and geldigheidsdatum_eind is null then
		true
	when geldigheidsdatum_begin is null and geldigheidsdatum_eind is not null then
		a.ingeschreven_op < geldigheidsdatum_eind
	when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is null then
		a.ingeschreven_op >= geldigheidsdatum_begin
	when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is not null then
		(a.ingeschreven_op >= geldigheidsdatum_begin and a.ingeschreven_op < geldigheidsdatum_eind)
	end)
and
	(
		b.datum is null
	or
		b.datum < a.ingeschreven_op
	)
order by
	d.bs_nummer, c.a_nummer, a.ingeschreven_op;

$$ language sql;
