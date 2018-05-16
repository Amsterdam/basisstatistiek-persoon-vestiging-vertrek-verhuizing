data vestig.stvst2016p;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'G:\OIS\Basisbestanden\bevolking\mutaties\vestig\2016\vestiging_aangehaakt_sas.csv'
delimiter = ';' MISSOVER DSD lrecl=32767 firstobs=2 ;

	informat jaar 4.0 ;
	informat anummr $10. ;
	informat bsnumm $9. ;
	informat unicod $14. ;
	informat gslcha $1. ;
	informat lndgbb $4. ;
	informat gebpla $50. ;
	informat bevcbs $1. ;
	informat etncbs $4. ;
	informat natiob $3. ;
	informat vstdgr $8. ;
	informat vstdta $8. ;
	informat vstned $8. ;
	informat brgstb $1. ;
	informat codvbt $2. ;
	informat dathuw $8. ;
	informat dathon $8. ;
	informat dtbvbt $8. ;
	informat dtevbt $8. ;
	informat gbdtb8 $8. ;
	informat leeftd 3.0 ;
	informat leeft1 3.0 ;
	informat hhtypen $2. ;
	informat uniou1 $14. ;
	informat uniou2 $14. ;
	informat gslou1 $1. ;
	informat gslou2 $1. ;
	informat gblou1 $4. ;
	informat gblou2 $4. ;
	informat gbdou1 $8. ;
	informat gbdou2 $8. ;
	informat huisnn $5. ;
	informat huisln $1. ;
	informat hstoen $4. ;
	informat ptkodn $6. ;
	informat geldig_op $8. ;
	informat tydber $8. ;
	informat adrs15n $15. ;
	informat stkodn $5. ;
	informat bagidsn $16. ;
	informat numidsn $16. ;
	informat brtk15n $4. ;
	informat bctk15n $3. ;
	informat stad15n $1. ;
	informat i22gebn $4. ;
	informat i27gebn $4. ;
	informat altbrt15n $4. ;
	informat rayon15n $4. ;
	informat brtk10n $4. ;
	informat vorgem $4. ;
	informat lndimm $4. ;
	informat migrlv $4. ;

	format jaar 4.0 ;
	format anummr $10. ;
	format bsnumm $9. ;
	format unicod $14. ;
	format gslcha $1. ;
	format lndgbb $4. ;
	format gebpla $50. ;
	format bevcbs $1. ;
	format etncbs $4. ;
	format natiob $3. ;
	format vstdgr $8. ;
	format vstdta $8. ;
	format vstned $8. ;
	format brgstb $1. ;
	format codvbt $2. ;
	format dathuw $8. ;
	format dathon $8. ;
	format dtbvbt $8. ;
	format dtevbt $8. ;
	format gbdtb8 $8. ;
	format leeftd 3.0 ;
	format leeft1 3.0 ;
	format hhtypen $2. ;
	format uniou1 $14. ;
	format uniou2 $14. ;
	format gslou1 $1. ;
	format gslou2 $1. ;
	format gblou1 $4. ;
	format gblou2 $4. ;
	format gbdou1 $8. ;
	format gbdou2 $8. ;
	format huisnn $5. ;
	format huisln $1. ;
	format hstoen $4. ;
	format ptkodn $6. ;
	format geldig_op $8. ;
	format tydber $8. ;
	format adrs15n $15. ;
	format stkodn $5. ;
	format bagidsn $16. ;
	format numidsn $16. ;
	format brtk15n $4. ;
	format bctk15n $3. ;
	format stad15n $1. ;
	format i22gebn $4. ;
	format i27gebn $4. ;
	format altbrt15n $4. ;
	format rayon15n $4. ;
	format brtk10n $4. ;
	format vorgem $4. ;
	format lndimm $4. ;
	format migrlv $4. ;

input
	jaar
	anummr $
	bsnumm $
	unicod $
	gslcha $
	lndgbb $
	gebpla $
	bevcbs $
	etncbs $
	natiob $
	vstdgr $
	vstdta $
	vstned $
	brgstb $
	codvbt $
	dathuw $
	dathon $
	dtbvbt $
	dtevbt $
	gbdtb8 $
	leeftd
	leeft1
	hhtypen $
	uniou1 $
	uniou2 $
	gslou1 $
	gslou2 $
	gblou1 $
	gblou2 $
	gbdou1 $
	gbdou2 $
	huisnn $
	huisln $
	hstoen $
	ptkodn $
	geldig_op $
	tydber $
	adrs15n $
	stkodn $
	bagidsn $
	numidsn $
	brtk15n $
	bctk15n $
	stad15n $
	i22gebn $
	i27gebn $
	altbrt15n $
	rayon15n $
	brtk10n $
	vorgem $
	lndimm $
	migrlv $;

label
	jaar = "jaar van verwerking"
	anummr = "administratienummer"
	bsnumm = "burgerservicenummer"
	unicod = "unieke code persoon"
	gslcha = "geslacht"
	lndgbb = "code geboorteland"
	gebpla = "geboorteplaats"
	bevcbs = "herkomstgroepering CBS"
	etncbs = "modelclassificatie herkomstgroepering CBS"
	natiob = "code van de nationaliteit"
	vstdgr = "vestigingsdatum in de gemeente"
	vstdta = "vestigingsdatum op het adres"
	vstned = "vestigingsdatum in nederland"
	brgstb = "burgerlijke staat"
	codvbt = "code van verblijfstitel"
	dathuw = "datum huwelijkssluiting"
	dathon = "datum huwelijksbeëindiging"
	dtbvbt = "datum begin verblijfstitel"
	dtevbt = "datum einde verblijfstitel"
	gbdtb8 = "geboortedatum"
	leeftd = "leeftijd"
	leeft1 = "leeftijd op 1 januari van het mutatiejaar"
	hhtypen = "huishoudtype van het vestigingsadres op de dag van vestiging"
	uniou1 = "unieke code ouder1"
	uniou2 = "unieke code ouder2"
	gslou1 = "geslacht van ouder1"
	gslou2 = "geslacht van ouder2"
	gblou1 = "geboortelandcode ouder1"
	gblou2 = "geboortelandcode ouder2"
	gbdou1 = "geboortedatum van ouder1"
	gbdou2 = "geboortedatum van ouder2"
	huisnn = "huisnummer na de mutatie"
	huisln = "huisletter na de mutatie"
	hstoen = "huisnummertoevoeging na de mutatie"
	ptkodn = "postcode na de mutatie"
	geldig_op = "mutatiedatum"
	tydber = "tijdstip van verwerking mutatie"
	adrs15n = "15 positie adrescode na de mutatie"
	stkodn = "straatcode na de mutatie"
	bagidsn = "landelijke bagidentificatie van het adresseerbaar object na de mutatie"
	numidsn = "landelijke bagnummeridentificatie na de mutatie"
	brtk15n = "buurtindeling 2015 na de mutatie"
	bctk15n = "buurtcombinatieindeling 2015 na de mutatie"
	stad15n = "stadsdeelindeling 2015 na de mutatie"
	i22gebn = "gebiedsgericht werken indeling in 22 gebieden na de mutatie"
	i27gebn = "gebiedsgericht werken indeling in 27 gebieden na de mutatie"
	altbrt15n = "alternatieve buurtindeling stadsdelen 2015 na de mutatie"
	rayon15n = "rayon indeling stadsdelen 2015 na de mutatie"
	brtk10n = "buurtindeling 2010 na de mutatie"
	vorgem = "code van de vorige gemeente van inschrijving"
	lndimm = "code van het land van immigratie"
	migrlv = "code van vorige gemeente/land van immigratie";
if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;
