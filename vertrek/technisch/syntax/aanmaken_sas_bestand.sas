data vertrek.stvrt2016p ;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'G:\OIS\Basisbestanden\bevolking\mutaties\vertrek\2016\vertrek_aangehaakt_sas.csv'
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
	informat codvbt $4. ;
	informat dathuw $8. ;
	informat dathon $8. ;
	informat dtbvbt $8. ;
	informat dtevbt $8. ;
	informat gbdtb8 $8. ;
	informat leeftd 3.0 ;
	informat leeft1 3.0 ;
	informat hhtypev $2. ;
	informat uniou1 $14. ;
	informat uniou2 $14. ;
	informat gslou1 $1. ;
	informat gslou2 $1. ;
	informat gblou1 $4. ;
	informat gblou2 $4. ;
	informat gbdou1 $8. ;
	informat gbdou2 $8. ;
	informat huisnv $5. ;
	informat huislv $1. ;
	informat hstoev $4. ;
	informat ptkodv $6. ;
	informat nwegem $4. ;
	informat lndemi $4. ;
	informat geldig_op $8. ;
	informat tydber $8. ;
	informat adrs15v $15. ;
	informat stkodv $5. ;
	informat bagidsv $16. ;
	informat numidsv $16. ;
	informat brtk15v $4. ;
	informat bctk15v $3. ;
	informat stad15v $1. ;
	informat i22gebv $4. ;
	informat i27gebv $4. ;
	informat altbrt15v $4. ;
	informat rayon15v $4. ;
	informat brtk10v $4. ;
	informat hfdkod $20. ;
	informat migrln $4. ;

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
	format codvbt $4. ;
	format dathuw $8. ;
	format dathon $8. ;
	format dtbvbt $8. ;
	format dtevbt $8. ;
	format gbdtb8 $8. ;
	format leeftd 3.0 ;
	format leeft1 3.0 ;
	format hhtypev $2. ;
	format uniou1 $14. ;
	format uniou2 $14. ;
	format gslou1 $1. ;
	format gslou2 $1. ;
	format gblou1 $4. ;
	format gblou2 $4. ;
	format gbdou1 $8. ;
	format gbdou2 $8. ;
	format huisnv $5. ;
	format huislv $1. ;
	format hstoev $4. ;
	format ptkodv $6. ;
	format nwegem $4. ;
	format lndemi $4. ;
	format geldig_op $8. ;
	format tydber $8. ;
	format adrs15v $15. ;
	format stkodv $5. ;
	format bagidsv $16. ;
	format numidsv $16. ;
	format brtk15v $4. ;
	format bctk15v $3. ;
	format stad15v $1. ;
	format i22gebv $4. ;
	format i27gebv $4. ;
	format altbrt15v $4. ;
	format rayon15v $4. ;
	format brtk10v $4. ;
	format hfdkod $20. ;
	format migrln $4. ;

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
	hhtypev $
	uniou1 $
	uniou2 $
	gslou1 $
	gslou2 $
	gblou1 $
	gblou2 $
	gbdou1 $
	gbdou2 $
	huisnv $
	huislv $
	hstoev $
	ptkodv $
	nwegem $
	lndemi $
	geldig_op $
	tydber $
	adrs15v $
	stkodv $
	bagidsv $
	numidsv $
	brtk15v $
	bctk15v $
	stad15v $
	i22gebv $
	i27gebv $
	altbrt15v $
	rayon15v $
	brtk10v $
	hfdkod $
	migrln $;

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
	hhtypev = "huishoudentype op het adres voor de mutatie"
	uniou1 = "unieke code ouder1"
	uniou2 = "unieke code ouder2"
	gslou1 = "geslacht van ouder1"
	gslou2 = "geslacht van ouder2"
	gblou1 = "geboortelandcode ouder1"
	gblou2 = "geboortelandcode ouder2"
	gbdou1 = "geboortedatum van ouder1"
	gbdou2 = "geboortedatum van ouder2"
	huisnv = "huisnummer voor de mutatie"
	huislv = "huisletter voor de mutatie"
	hstoev = "huisnummertoevoeging voor de mutatie"
	ptkodv = "postcode voor de mutatie"
	nwegem = "code van de volgende gemeente van inschrijving"
	lndemi = "code van het land van emigratie"
	geldig_op = "mutatiedatum"
	tydber = "tijdstip van verwerking mutatie"
	adrs15v = "15 positie adrescode voor mutatie"
	stkodv = "straatcode voor de mutatie"
	bagidsv = "landelijke bagidentificatie van het adresseerbaar object voor de mutatie"
	numidsv = "landelijke bagnummeridentificatie voor de mutatie"
	brtk15v = "buurtindeling 2015 voor de mutatie"
	bctk15v = "buurtcombinatieindeling 2015 voor de mutatie"
	stad15v = "stadsdeelindeling 2015 voor de mutatie"
	i22gebv = "gebiedsgericht werken indeling in 22 gebieden voor de mutatie"
	i27gebv = "gebiedsgericht werken indeling in 27 gebieden voor de mutatie"
	altbrt15v = "alternatieve buurtindeling stadsdelen 2015 voor de mutatie"
	rayon15v = "rayon indeling stadsdelen 2015 voor de mutatie"
	brtk10v = "buurtindeling 2010 voor de mutatie"
	hfdkod = "hoofdcode mutatiestatistiek"
	migrln = "code van volgende gemeente/land van emigratie";

if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;