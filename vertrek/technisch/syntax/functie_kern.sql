create or replace function vertrek_kern (
	kennisgevingsdatum_begin timestamp without time zone,
	kennisgevingsdatum_eind timestamp without time zone,
	geldigheidsdatum_begin timestamp without time zone,
	geldigheidsdatum_eind timestamp without time zone
)
returns table (
	a_nummer bigint,
	bs_nummer bigint,
	persoon_id bigint,
	naar_gemeentecode bigint,
	naar_ingeschreven_op timestamp without time zone,
	naar_kennisgegeven_op timestamp without time zone,
	naar_landcode bigint,
	naar_gevestigd_op timestamp without time zone
) as $$

select
	a_nummer,
	bs_nummer,
	persoon_id,
	(case when bs_nummer in (select bsnumm from bron.vertrek_rni) and n_gemeente_id = 1999 then
		null
	else
		n_gemeente_id
	end) as naar_gemeentecode,
	(case when bs_nummer in (select bsnumm from bron.vertrek_rni) and n_gemeente_id = 1999 then
		null
	else
		n_ingeschreven_op
	end) as naar_ingeschreven_op,
	n_kennisgegeven_op as naar_kennisgegeven_op,
	(case when bs_nummer in (select bsnumm from bron.vertrek_rni) and n_gemeente_id = 1999 then
		land_code_vertrek
	else
		n_land_id
	end) as naar_landcode,
	(case when bs_nummer in (select bsnumm from bron.vertrek_rni) and n_gemeente_id = 1999 then
		n_ingeschreven_op
	else
		n_gevestigd_op
	end) as naar_gevestigd_op
from
	(
	/*
	 * Selecteer eerst alle binnenlandse vertrek bewegingen.
	 */
	select
		a.persoon_id,
		(select code from persoon.persoon_id as z where a.persoon_id = z.persoon_id and type_id = (select id from persoon.persoon_id_type where afkorting = 'BSN') limit 1) as bs_nummer,
		(select code from persoon.persoon_id as z where a.persoon_id = z.persoon_id and type_id = (select id from persoon.persoon_id_type where afkorting = 'AN') limit 1) as a_nummer,
		gemeente_id as n_gemeente_id,
		ingeschreven_op as n_ingeschreven_op,
		kennisgegeven_op as n_kennisgegeven_op,
		NULL as n_land_id,
		NULL as n_gevestigd_op
	from
		(
		select
			*,
			/*
			 * Als blijkt dat het vorige vestigingsland niet Nederland is,
			 * maar een ander land dan negeren we het huidige vertrek. Als
			 * we dit niet doen, dan hebben we twee vertrekbewegingen achter
			 * elkaar.
			 */
			(select
				distinct on(persoon_id)
					gemeente_id
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
				and
					z.gevestigd_op > p_ingeschreven_op
				order by
					z.persoon_id, z.gevestigd_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
			) as p_land_id
		from
			(
			select
				persoon_id,
				gemeente_id,
				ingeschreven_op,
				kennisgegeven_op,
				lag(persoon_id) over (order by persoon_id, ingeschreven_op) as p_persoon_id,
				lag(gemeente_id) over (order by persoon_id, ingeschreven_op) as p_gemeente_id,
				lag(ingeschreven_op) over (order by persoon_id, ingeschreven_op) as p_ingeschreven_op,
				count(persoon_id) over (partition by persoon_id order by persoon_id) as aantal,
				first_value(ingeschreven_op) over (partition by persoon_id order by persoon_id, ingeschreven_op) as f_ingeschreven_op
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
		) as a
	where
		/*
		 * Kijk of de vorige Gemeente van inschrijving Amsterdam is
		 * of leeg wanneer er geen vorige inschrijving is.
		 */
		(p_gemeente_id is null or p_gemeente_id = 363)
	and
		(
			p_persoon_id = a.persoon_id
		or
			p_persoon_id is null
		or
			f_ingeschreven_op = ingeschreven_op
		)
	and
		(
			/*
			 * De nieuwe gemeente van inschrijving moet
			 * een niet Amsterdamse gemeente betreffen
			 * of de nieuwe gemeente moet onbekend zijn.
			 */
			gemeente_id != 363
		or
			gemeente_id is null
		)
	and
		(
			/*
			 * Het vorige land van vestiging moet ofwel
			 * Nederland zijn ofwel onbekend.
			 */
			p_land_id is null
		or
			p_land_id = 6030
		)
	and
		/*
		 * De inschrijvingsdatum in de nieuwe gemeente
		 * moet in ons tijdvak liggen.
		 */
		(ingeschreven_op is not null and 
			(case when geldigheidsdatum_begin is null and geldigheidsdatum_eind is null then
				true
			when geldigheidsdatum_begin is null and geldigheidsdatum_eind is not null then
				ingeschreven_op < geldigheidsdatum_eind
			when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is null then
				ingeschreven_op >= geldigheidsdatum_begin
			when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is not null then
				(ingeschreven_op >= geldigheidsdatum_begin and ingeschreven_op < geldigheidsdatum_eind)
			end)
		)
	union all
	select
		a.persoon_id,
		(select code from persoon.persoon_id as z where a.persoon_id = z.persoon_id and type_id = (select id from persoon.persoon_id_type where afkorting = 'BSN') limit 1) as bs_nummer,
		(select code from persoon.persoon_id as z where a.persoon_id = z.persoon_id and type_id = (select id from persoon.persoon_id_type where afkorting = 'AN') limit 1) as a_nummer,
		NULL as n_gemeente_id,
		NULL as n_ingeschreven_op,
		kennisgegeven_op as n_kennisgegeven_op,
		land_id as n_land_id,
		gevestigd_op as n_gevestigd_op
	from
		(
		select
			*,
			/*
			 * Kijk wat de laatste gemeente van inschrijving
			 * was voor de vestigingsdatum.
			 */
			(select
				distinct on(persoon_id)
				gemeente_id
			from
				persoon.inschrijving as z
			where
				(case when kennisgevingsdatum_eind is null then
					true
				when kennisgevingsdatum_eind is not null then
					z.kennisgegeven_op < kennisgevingsdatum_eind
				end)
			and
				z.persoon_id = a.persoon_id
			and
				z.ingeschreven_op < gevestigd_op
			order by
				z.persoon_id, z.ingeschreven_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
			) as p_gemeente_id,
			/*
			 * Kijk wat de huidige gemeente van inschrijving
			 * is op de vestigingsdatum.
			 */
			(select
				distinct on(persoon_id)
				gemeente_id
			from
				persoon.inschrijving as z
			where
				(case when kennisgevingsdatum_eind is null then
					true
				when kennisgevingsdatum_eind is not null then
					z.kennisgegeven_op < kennisgevingsdatum_eind
				end)
			and
				z.persoon_id = a.persoon_id
			and
				z.ingeschreven_op = gevestigd_op
			order by
				z.persoon_id, z.ingeschreven_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
			) as gemeente_id,
			/*
			 * Kijk wat de laatste inschrijvingsdatum in
			 * de gemeente was voor de vestigingsdatum.
			 */
			(select
				distinct on(persoon_id)
				ingeschreven_op
			from
				persoon.inschrijving as z
			where
				(case when kennisgevingsdatum_eind is null then
					true
				when kennisgevingsdatum_eind is not null then
					z.kennisgegeven_op < kennisgevingsdatum_eind
				end)
			and
				z.persoon_id = a.persoon_id
			and
				z.ingeschreven_op <= gevestigd_op
			order by
				z.persoon_id, z.ingeschreven_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
			) as p_ingeschreven_op
		from
			(
			select
				persoon_id,
				land_id,
				gevestigd_op,
				type_id,
				kennisgegeven_op,
				lag(persoon_id) over (order by persoon_id, gevestigd_op) as p_persoon_id,
				lag(land_id) over (order by persoon_id, gevestigd_op) as p_land_id,
				lag(gevestigd_op) over (order by persoon_id, gevestigd_op) as p_gevestigd_op,
				lead(gevestigd_op) over (order by persoon_id, gevestigd_op) as n_gevestigd_op,
				count(persoon_id) over (partition by persoon_id order by persoon_id) as aantal,
				first_value(gevestigd_op) over (partition by persoon_id order by persoon_id, gevestigd_op) as f_gevestigd_op
			from
				(select
					distinct on(persoon_id, gevestigd_op)
					*
				from
					(select
						id,
						persoon_id,
						land_id,
						type_id,
						gevestigd_op,
						geldig_op,
						kennisgegeven_op
					from
						persoon.vestiging
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
					persoon_id, gevestigd_op desc, geldig_op desc, kennisgegeven_op desc, id desc
				) as a
			) as a
		) as a
	where
		/*
		 * Kijk of de vorige Gemeente van inschrijving Amsterdam is
		 * of leeg wanneer er geen vorige inschrijving is.
		 */
		(p_gemeente_id is null or p_gemeente_id = 363)
	and
		(
			p_persoon_id = a.persoon_id
		or
			p_persoon_id is null
		or
			f_gevestigd_op = gevestigd_op
		)
	and
		(
			/*
			 * Het nieuwe vestigingsland mag niet Nederland zijn
			 */
			land_id != 6030
		and
			/*
			 * Mits het een vestiging in Nederland betreft vanuit
			 * het buitenland.
			 */
			(
				gemeente_id != 363
			or
				gemeente_id is null
			)
		)
	and
		/*
		 * Selecteer alleen landen die over immigratiestromen gaan.
		 */
		type_id = 0
	and
		/*
		 * De vestigingsdatum in het nieuwe land
		 * moet in ons tijdvak liggen.
		 */
		(gevestigd_op is not null and
			(case when geldigheidsdatum_begin is null and geldigheidsdatum_eind is null then
				true
			when geldigheidsdatum_begin is null and geldigheidsdatum_eind is not null then
				gevestigd_op < geldigheidsdatum_eind
			when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is null then
				gevestigd_op >= geldigheidsdatum_begin
			when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is not null then
				(gevestigd_op >= geldigheidsdatum_begin and gevestigd_op < geldigheidsdatum_eind)
			end)
		)
) as a
--
-- Voor de RNI gevallen de juiste landcode selecteren ipv RNI
--
left join
	(select
		*
	from
		bron.vertrek_rni) as b
on
	a.bs_nummer = b.bsnumm
and
	a.n_ingeschreven_op = to_timestamp(b.geldig_op::char(16), 'YYYYMMDDHH24MISSMS')::timestamp without time zone
where
	(case when geldigheidsdatum_begin < kennisgevingsdatum_begin then
		bs_nummer in (select bsnumm from bron.kw20171)
	else
		true
	end);

$$ language sql;