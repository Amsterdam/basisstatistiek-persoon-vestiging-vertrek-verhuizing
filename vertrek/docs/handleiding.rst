Inleiding
-----------

De mutatiestatistiek gaat uit van een tweetal database schema's: bron en persoon.

*Alle syntax is gemaakt voor gebruik met PostgreSQL.*

Opzetten database structuur
---------------------------

Maak de tabellen zoals beschreven in:

#. `structuur.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/2f9d8efdc5644d5da828da0eab85ee47e942e21e/persoon/structuur/structuur.sql>`_
#. `brp_stuf_csv.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/cb40cfebf78c7db728cbafb511195e282dbaeeb8/stufcsv.sql>`_

Maak de stored procedure zoals beschreven in:

#. `verwerk_nieuw_persoon.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/2f9d8efdc5644d5da828da0eab85ee47e942e21e/persoon/transformaties/sql/functies/verwerk_nieuw_persoon.sql>`_

Met stand ervoor (optioneel)
----------------------------

#. Maak voor het 1ste kwartaalbestand van de periode een tabel aan in de database in het ``bron`` schema met behulp van de volgende syntax `kwartaalstand.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/3bc1ec7bfe487d0ef0b7c84b10346fbdd9c48bc3/BRP/import/kwartaalstand.sql>`_. Pas de naam van de tabel aan naar de juiste en dump het 1ste kwartaalbestand van de periode in deze tabel. De vertrekstatistiek is afhankelijk van een uniforme opslag van de ``anummr``, ``bsnumm``, ``gbdtb8``, ``strkod``, ``huisnr``, ``huislt``, ``hstoev``, ``pttkod``, ``vstdta``, ``vstdgr``, ``vstned``, ``lndimm`` en ``jaar`` velden. Zorg dus dat die velden gevuld zijn. De namen van de geïmporteerde kwartaalbestanden zijn kwYYYYK, waarbij YYYY voor het jaar inclusief eeuw staat en KK voor het kwartaal. Het eerste kwartaal bestand komt daarmee in de database te staan als ``bron.kw20161``.
#. Voeg alle nog onbekende personen uit het kwartaalbestand in de database. Het kan zijn dat de stap op regel 1 opgeslagen kan worden als de betreffende materialized view nog niet bestaat. Pas wanneer nodig het jaartal van het betreffende jaar in de SQL aan. `verwerk_nieuw_persoon_uit_stand.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_nieuw_persoon_uit_stand.sql>`_
#. Verwerk alle geboortegegevens uit het kwartaalbestand. Pas wanneer nodig het jaartal van het betreffende jaar in de SQL aan. `verwerk_geboorte_stand.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_geboorte_stand.sql>`_
#. Verwerk alle inschrijvingsgegevens uit het kwartaalbestand. Pas wanneer nodig het jaartal van het betreffende jaar in de SQL aan. `verwerk_inschrijving_stand.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_inschrijving_stand.sql>`_
#. Verwerk alle vestigingsgegevens uit het kwartaalbestand. Pas wanneer nodig het jaartal van het betreffende jaar in de SQL aan. `verwerk_vestiging_stand.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_vestiging_stand.sql>`_

Mutatieberichten
----------------

#. Dump alle mutatieberichten in de ``bron.brp_stuf_csv`` tabel.
#. Voeg alle nog onbekende personen uit de mutatieberichten in de database. Het kan zijn dat de stap op regel 1 opgeslagen kan worden als de betreffende materialized view nog niet bestaat. `verwerk_nieuw_persoon.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_nieuw_persoon.sql>`_
#. Verwerk alle geboortegegevens uit de mutatieberichten. `verwerk_geboorte.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_geboorte.sql>`_
#. Verwerk alle inschrijvingsgegevens uit de mutatieberichten. `verwerk_inschrijving.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_inschrijving.sql>`_
#. Verwerk alle vestigingsgegevens uit de mutatieberichten. `verwerk_vestiging.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/8bc15cb1a0f74e3da207781d107069c7e957d0f0/persoon/transformaties/sql/verwerk_vestiging.sql>`_

Uitdraaien van vertrek
----------------------

#. Maak de volgende procedure zoals beschreven in `functie_kern.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/functie_kern.sql>`_. Draai het deel wat onder *stap 1* staat beschreven in `query.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/query.sql>`_ om de kern tabel te maken. Zorg dat de parameters passen bij het tijdvak waarover de statistiek uitgedraaid dient te worden.
#. Voor de nagekomen berichten, moeten dezelfde stappen worden gevolgd zoals hierboven staan beschreven. Pas echter het tijdvak waarover de statistiek moet worden gemaakt aan naar de juiste. Daarnaast moeten de aan te maken tabellen en functies andere namen krijgen. Voeg hiervoor achter elke tabelnaam en functie een 1 toe.

Aangehaakte gegevens
--------------------

Aanvullende persoonsgegevens
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Maak voor de overige 4 kwartaalbestanden van de periode waarover we nu vestigingstatistiek maken een tabel aan in de database in het ``bron`` schema met behulp van de volgende syntax `kwartaalstand.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/3bc1ec7bfe487d0ef0b7c84b10346fbdd9c48bc3/BRP/import/kwartaalstand.sql>`_. Pas de naam van de tabel aan naar de juiste en dump de 4 kwartaalbestanden van de periode in deze tabel. Dit betreft de overige 3 kwartalen uit het jaar waarover statistiek wordt gemaakt en het eerste kwartaal van het jaar erop. De namen van de geïmporteerde kwartaalbestanden zijn kwYYYYK, waarbij YYYY voor het jaar inclusief eeuw staat en KK voor het kwartaal. Het eerste kwartaal bestand komt daarmee in de database te staan als ``bron.kw20161``. De aanhaakte gegevens gaan uit van een uniforme opslag van de ``peildt``, ``unicod``, ``anummr``, ``bsnumm``, ``gslcha``, ``gbdtb8``, ``lndgbb``, ``gebpla``, ``bevcbs``, ``etncbs``, ``natiob``, ``uniou1``, ``uniou2``, ``vstdgr``, ``vstdta``, ``vstned``, ``brgstb``, ``codvbt``, ``dathon``, ``dtbvbt``, ``dtevbt`` en ``hhtype`` velden. Of de vervolg stappen efficient verlopen is deels afhankelijk van de kwaliteit van deze dump. D.w.z. als kolommen met een numerieke waarde niet als integer in de database komen te staan en kolommen met een character waarde niet als character type, dan zal dat impact hebben op de snelheid en werking van de verschillende queries in deze handleiding.

Aanvullende BAG gegevens
^^^^^^^^^^^^^^^^^^^^^^^^

#. Maak de BAG tabellen structuur zoals hier beschreven:

   - `nummeraanduiding <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_num.sql>`_

     - Hernoem ``landelijke_bag_num_id`` naar ``lv_bag_nag_id``
     - Hernoem ``num_id`` naar ``nag_id``

   - `openbare ruimte <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/3bc1ec7bfe487d0ef0b7c84b10346fbdd9c48bc3/BAG/import/bag_ore.sql>`_
   - `nummeraanduiding - verblijfsobject <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_vot_num.sql>`_

     - Hernoem de tabel naar ``bron.bag_aos``
     - Vervang in de kolomnamen ``landelijk`` door ``lv``
     - Vervang vervolgens in de kolomnaam ``lv_bag_num_id`` het stukje ``num`` naar ``nag``.

   - `nummeraanduiding - ligplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_lps_num.sql>`_

     - Vervang in de kolomnamen ``landelijk`` door ``lv``

   - `nummeraanduiding - standplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_sps_num.sql>`_

     - Hernoem de tabel naar ``bron.bag_ass``
     - Vervang in de kolomnamen ``landelijk`` door ``lv``
     - Vervang vervolgens in de nieuwe kolomnaam ``lv_bag_num_id`` het stukje ``num`` naar ``nag``.

   - `verblijfsobject <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_vot.sql>`_

     - Vervang in de kolomnamen ``landelijk`` door ``lv``

   - `ligplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_lps.sql>`_

     - Vervang in de kolomnamen ``landelijk`` door ``lv``


   - `standplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/import/bag_sps.sql>`_

     - Vervang in de kolomnamen ``landelijk`` door ``lv``

   - buurt

     .. code-block:: sql

        create table bron.bag_brt (
          sleutelverzendend bigint,
          buurtcode character varying,
          buurtnaam character varying,
          brondocumentverwijzing character varying,
          brondocumentdatum bigint,
          geometrie character varying,
          mutatie_gebruiker character varying,
          indicatie_vervallen character varying,
          tijdvakgeldigheid_begindatumtijdvakgeldigheid bigint,
          tijdvakgeldigheid_einddatumtijdvakgeldigheid bigint,
          brtsdl_sdl_sleutelverzendend bigint,
          brtsdl_sdl_stadsdeelcode character varying,
          brtsdl_tijdvakrelatie_begindatumrelatie bigint,
          brtsdl_tijdvakrelatie_einddatumrelatie bigint
       );

#. Maak de volgende index aan:

   .. code-block:: sql

      create index bag_als_lv_bag_lps_id_idx on bron.bag_als(lv_bag_lps_id);
      create index bag_als_lv_bag_nag_id_idx on bron.bag_als(lv_bag_nag_id);
      create index bag_aos_lv_bag_nag_id_idx on bron.bag_aos(lv_bag_nag_id);
      create index bag_aos_lv_bag_vot_id_idx on bron.bag_aos(lv_bag_vot_id);
      create index bag_aos_lv_bag_sps_id_idx on bron.bag_ass(lv_bag_sps_id);
      create index bag_ass_lv_bag_nag_id_idx on bron.bag_ass(lv_bag_nag_id);
      create index bag_ore_ore_id_idx on bron.bag_ore(ore_id);
      create index bag_vot_lv_bag_vot_id_idx on bron.bag_vot(lv_bag_vot_id);
      create index bag_vot_lv_bag_lps_id_idx on bron.bag_lps(lv_bag_lps_id);
      create index bag_sps_lv_bag_sps_id_idx on bron.bag_sps(lv_bag_sps_id);


#. Verzamel alle data uit de volgende bronnen in puntkomma gescheiden csv formaat zonder header

   - Doe een dump uit DIVA

     - `nummeraanduiding <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/export/nummeraanduiding.sql>`_
     - `openbare ruimte <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/export/openbareruimte.sql>`_
     - `verblijfsobject <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/export/verblijfsobject.sql>`_
     - `standplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/export/standplaats.sql>`_
     - `ligplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/61bde63b9defaa725853197c882bfb1d2372da5e/BAG/export/ligplaats.sql>`_
     - `nummeraanduiding - verblijfsobject <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/fa3c31ec1cf748f298be4f405d06618255f3f5b5/BAG/export/verblijfsobject_koppel_nummeraanduiding.sql>`_
     - `nummeraanduiding - standplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/fa3c31ec1cf748f298be4f405d06618255f3f5b5/BAG/export/standplaats_koppel_nummeraanduiding.sql>`_
     - `nummeraanduiding - ligplaats <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/fa3c31ec1cf748f298be4f405d06618255f3f5b5/BAG/export/ligplaats_koppel_nummeraanduiding.sql>`_

   - Uit de basisinformatie gebieden UVA bestanden

     - buurt ``BRT_YYYYMMDD_J_ALLES_YYYYMMDD.UVA2``
	    Vervang hierbij de ``YYYYMMMDD`` voor de daadwerkelijke datum van het laatste bestand

#. Dump alle data in de respectievelijke tabellen in de OIS database

#. Ontdubbel alle nummeraanduidingen zodat alle correcties zijn doorgevoerd

   .. code-block:: sql

      create table bron.bag_num_ontdubbelt as
      select
	    distinct on (lv_bag_nag_id, geldig_op)
	    *
      from
	    bron.bag_num
      order by
	    lv_bag_nag_id, geldig_op, adrescyclusnr desc

#. Maak de volgende indexes aan voor een snellere selectie

   .. code-block:: sql

      create index bag_num_ontdubbelt_postcode4_idx ON bron.bag_num_ontdubbelt((COALESCE(substr(postcode::text, 1, 4)::integer, 0)));
      create index bag_num_ontdubbelt_postcode2_idx ON bron.bag_num_ontdubbelt((COALESCE(substr(postcode::text, 5, 2), '-'::text)));
      create index bag_num_ontdubbelt_ore_id_idx ON bron.bag_num_ontdubbelt(ore_id);
      create index bag_num_ontdubbelt_nag_id_idx ON bron.bag_num_ontdubbelt(nag_id);
      create index bag_num_ontdubbelt_lv_bag_nag_id_idx ON bron.bag_num_ontdubbelt(lv_bag_nag_id);
      create index bag_num_ontdubbelt_huisnummertoevoeging_idx ON bron.bag_num_ontdubbelt((COALESCE(huisnummertoevoeging, '-'::character varying)));
      create index bag_num_ontdubbelt_huisletter_idx ON bron.bag_num_ontdubbelt((COALESCE(huisletter, '-'::character varying)));
      create index bag_num_ontdubbelt_huisnummer_idx ON bron.bag_num_ontdubbelt((COALESCE(huisnummer, '-999'::integer)));

#. Maak de volgende functie aan voor het bijzoeken van gebiedsinformatie bij het adres `functie_geef_bag_informatie_voor_adres <https://git.datapunt.amsterdam.nl/Basisstatistiek/database/raw/2f9d8efdc5644d5da828da0eab85ee47e942e21e/functies/geef_bag_informatie_voor_adres.sql>`_

Gebundelde gebiedsinformatie
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Voor het aanhaken van gebiedsinformatie worden alle adressen met hun gebieden uit de kwartaalbestanden samengevoegd: `kwadrs <https://git.datapunt.amsterdam.nl/Basisstatistiek/bronnen/raw/fa3c31ec1cf748f298be4f405d06618255f3f5b5/staging/BRP/kwadrs.sql>`_
Verander wanneer nodig de jaartallen van de kwartaalbestanden en zorg wanneer nodig dat de veldtypes logisch onderling aansluiten (bijv. bigint met bigint in geval van huisnummers en varchar met varchar in geval van huisletters, mocht je daar foutmeldingen over krijgen).

Aanhaken van gegevens
^^^^^^^^^^^^^^^^^^^^^

#. Maak de volgende procedure zoals beschreven in `functie_binnenland_aangehaakt.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/d1f66b02f68a1680c5b8024f2e4d757866899193/vertrek/technisch/syntax/functie_binnenland_aangehaakt.sql>`_. Draai vervolgens de syntax wat onder *stap 2* staat beschreven in `query.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/query.sql>`_ om gegevens aan de kern van binnenlandse vertrekken aan te haken vertrekken.
#. Maak de volgende procedure zoals beschreven in `functie_binnenland_aangehaakt_adres.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/functie_binnenland_aangehaakt_adres.sql>`_. Draai vervolgens de syntax wat onder *stap 3* staat beschreven in `query.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/query.sql>`_ om adresgegevens van binnenlandse vertrekken aan te haken.
#. Maak de volgende procedure zoals beschreven in `functie_buitenland_aangehaakt.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/d1f66b02f68a1680c5b8024f2e4d757866899193/vertrek/technisch/syntax/functie_buitenland_aangehaakt.sql>`_. Draai vervolgens de syntax wat onder *stap 4* staat beschreven in `query.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/query.sql>`_ om gegevens aan de kern van buitenlandse vertrekken aan te haken.
#. Maak de volgende procedure zoals beschreven in `functie_buitenland_aangehaakt_adres.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/functie_buitenland_aangehaakt_adres.sql>`_. Draai vervolgens de syntax wat onder *stap 5* staat beschreven in `query.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/a7b724867c9f4869e9e3d76f12611a594d875c35/vertrek/technisch/syntax/query.sql>`_ om adresgegevens van buitenlandse vertrekken aan te haken.
#. Voor de nagekomen berichten, moeten dezelfde stappen worden gevolgd als hierboven staan vermeld. De tabellen en functies die worden aangemaakt in de database, andere tabelnamen krijgen. Voeg hiervoor achter elke tabelnaam en functie een 1 toe.

SAS bestanden aanmaken
^^^^^^^^^^^^^^^^^^^^^^

#. Draai de volgende syntax op de database. `sas.sql <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/d1f66b02f68a1680c5b8024f2e4d757866899193/vertrek/technisch/syntax/sas.sql>`_
#. Exporteer het resultaat van de aangemaakte SAS view (vertrek_aangehaakt_sas) naar een CSV bestand (dit doe je door alles te selecteren uit de view en vervolgens naar file-export te gaan en het bestand op te slaan als CSV).
#. Draai de volgende syntax in SAS en verander waar nodig de bestandsnaam van het CSV bestand en de naam en locatie van het SAS bestand. `aanmaken_sas_bestand.sas <https://git.datapunt.amsterdam.nl/Basisstatistiek/persoon-vestiging-vertrek-verhuizing/raw/6e651235e6a2347f162833fa3535a66280532fac/vertrek/technisch/syntax/aanmaken_sas_bestand.sas>`_
