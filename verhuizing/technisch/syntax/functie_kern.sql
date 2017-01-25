create or replace function verhuizing_kern (
	kennisgevingsdatum_begin timestamp without time zone,
	kennisgevingsdatum_eind timestamp without time zone,
	geldigheidsdatum_begin timestamp without time zone,
	geldigheidsdatum_eind timestamp without time zone
)
returns table (
	bs_nummer bigint,
	a_nummer bigint,
	straatcode bigint,
	huisnummer integer,
	huisletter character,
	huisnummertoevoeging character varying,
	postcode character,
	geldig_op timestamp without time zone,
	naar_straatcode bigint,
	naar_huisnummer integer,
	naar_huisletter bpchar,
	naar_huisnummertoevoeging character varying,
	naar_geldig_op timestamp without time zone,
	naar_kennisgegeven_op timestamp without time zone,
	naar_postcode character
) as $$

select
	d.bs_nummer,
	c.a_nummer,
	straat_id as straatcode,
	huisnummer,
	huisletter,
	huisnummertoevoeging,
	(postcode4 || postcode2::char(2))::char(6) as postcode,
	geldig_op,
	n_straat_id as naar_straatcode,
	n_huisnummer as naar_huisnummer,
	n_huisletter as naar_huisletter,
	n_huisnummertoevoeging as naar_huisnummertoevoeging,
	n_geldig_op as naar_geldig_op,
	n_kennisgegeven_op as naar_kennisgegeven_op,
	(n_postcode4 || n_postcode2::char(2))::char(6) as naar_postcode
from (
	select
		persoon_id,
		straat_id,
		huisnummer,
		huisletter,
		huisnummertoevoeging,
		postcode4,
		postcode2,
		--
		-- Kijk naar de laatste gemeente van
		-- inschrijving voor of op de vestigingdatum
		-- op het adres.
		--
		-- Het is mogelijk dat we geen gegevens
		-- hebben over de inschrijving van deze
		-- persoon. In dat geval gaan we er vanuit
		-- dat deze persoon in Amsterdam staat
		-- ingeschreven.
		--
		coalesce((select
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
			z.ingeschreven_op <= a.geldig_op
		order by
			z.persoon_id, z.ingeschreven_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
		), 363) as gemeente_id,
		geldig_op,
		(a.persoon_id::varchar || coalesce(a.postcode4, -1)::varchar || coalesce(a.postcode2, '-')::varchar || coalesce(a.huisletter, '-')::varchar || coalesce(a.huisnummer, -1)::varchar || coalesce(a.huisnummertoevoeging, '-')::varchar) as adres,
		lead(a.persoon_id) over (order by persoon_id, geldig_op) as n_persoon_id,
		lead(a.straat_id) over (order by persoon_id, geldig_op) as n_straat_id,
		lead(a.huisnummer) over (order by persoon_id, geldig_op) as n_huisnummer,
		lead(a.huisletter) over (order by persoon_id, geldig_op) as n_huisletter,
		lead(a.postcode4) over (order by persoon_id, geldig_op) as n_postcode4,
		lead(a.postcode2) over (order by persoon_id, geldig_op) as n_postcode2,
		lead(a.huisnummertoevoeging) over (order by persoon_id, geldig_op) as n_huisnummertoevoeging,
		lead(a.persoon_id::varchar || coalesce(a.postcode4, -1)::varchar || coalesce(a.postcode2, '-')::varchar || coalesce(a.huisletter, '-')::varchar || coalesce(a.huisnummer, -1)::varchar || coalesce(a.huisnummertoevoeging, '-')::varchar) over (order by persoon_id, geldig_op) as n_adres,
		lead(a.geldig_op) over (order by persoon_id, geldig_op) as n_geldig_op,
		lead(a.kennisgegeven_op) over (order by persoon_id, geldig_op) as n_kennisgegeven_op
	from (
		select
			distinct on(persoon_id, geldig_op)
			*
		from
			persoon.adres as a
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
		order by
			persoon_id, geldig_op desc, id desc, kennisgegeven_op desc
		) as a
	) as a
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
where	--
	-- Vergelijk het oude adres
	-- met het nieuwe adres.
	--
	--a.adres != a.n_adres
--and
	--
	-- Vergelijk het oude adres met een
	-- mogelijk leeg nieuw adres.
	--
	adres != (a.persoon_id::varchar || '-1' || '-' || '-' || '-1' || '-')
and
	--
	-- Vergelijk het nieuwe adres met een
	-- mogelijk leeg oude adres.
	--
	n_adres != (a.persoon_id::varchar || '-1' || '-' || '-' || '-1' || '-')
and
	--
	-- De vestigingdatum op het nieuwe adres moet
	-- in het tijdvak liggen.
	--
	(case when geldigheidsdatum_begin is null and geldigheidsdatum_eind is null then
		true
	when geldigheidsdatum_begin is null and geldigheidsdatum_eind is not null then
		n_geldig_op < geldigheidsdatum_eind
	when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is null then
		n_geldig_op >= geldigheidsdatum_begin
	when geldigheidsdatum_begin is not null and geldigheidsdatum_eind is not null then
		(n_geldig_op >= geldigheidsdatum_begin and n_geldig_op < geldigheidsdatum_eind)
	end)
and
	n_persoon_id = a.persoon_id
and
	(
		coalesce(huisnummer, -1) != coalesce(n_huisnummer, -1)
	or
		coalesce(huisletter, '-') != coalesce(n_huisletter, '-')
	or
		coalesce(huisnummertoevoeging, '-') != coalesce(n_huisnummertoevoeging, '-')
	or
		(
			straat_id is not null
		and
			n_straat_id is not null
		and
			straat_id != n_straat_id
		)
	or

		(
			postcode4 is not null
		and
			n_postcode4 is not null
		and
			straat_id is null
		and
			n_straat_id is null
		and
			postcode4 != n_postcode4
		)
	)
and
	--
	-- Kijk naar de laatste gemeente van
	-- inschrijving voor of op de vestigingdatum
	-- op het nieuwe adres. Deze moet ook
	-- Amsterdam zijn.
	--
	-- Het is mogelijk dat we geen gegevens
	-- hebben over de inschrijving van deze
	-- persoon. In dat geval gaan we er vanuit
	-- dat deze persoon in Amsterdam staat
	-- ingeschreven.
	--
	coalesce((select
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
		z.ingeschreven_op <= n_geldig_op
	order by
		z.persoon_id, z.ingeschreven_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
	), 363) = 363
	--
	-- TEST ME
	--
	-- Als de gemeente voor de inschrijvingsdatum
	-- niet Amsterdam is, dan betreft het een vestiging.
	--
and
	coalesce((select
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
		z.ingeschreven_op < n_geldig_op
	order by
		z.persoon_id, z.ingeschreven_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
	), 363) = 363
/*and
	coalesce((select
		distinct on(persoon_id)
		land_id
	from
		persoon.vestiging as z
	where
		z.kennisgegeven_op < '2016-02-01'
	and
		z.persoon_id = a.persoon_id
	and
		z.gevestigd_op < n_geldig_op
	order by
		z.persoon_id, z.gevestigd_op desc, z.geldig_op desc, z.kennisgegeven_op desc, id desc
	), 6030) = 6030*/
and
	gemeente_id = 363
/*
 * Validatiecriteria
 * - In het geval van een puntadresser is de postcode onbekend.
 *   Postcodes met een NULL waarden moeten dus niet uitgesloten worden.
 */
and
	(coalesce(postcode4, 1000) >= 1000 and coalesce(postcode4, 1000) <= 1109)
and
	(coalesce(n_postcode4, 1000) >= 1000 and coalesce(n_postcode4, 1000) <= 1109)
-- and
-- 	((n_straat_id is not null and n_straat_id != 99999) or n_straat_id is null)
-- and
-- 	((straat_id is not null and straat_id != 99999) or straat_id is null)
;

$$ language sql;