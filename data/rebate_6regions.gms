*	Define the target regions in the aggregation and their mapping to GTAPinGAMS

set rr  Regions in the aggregation /
	CHN		China and Hong Kong
	IND		India
	USA		United States
	EUR		Europe
	OG20		Other G20 (CAN-AUS-NZL-MEX-CHL-KOR-JPN-RUS)
	ROW		Rest of world /;

$eolcom !

*	Permit the mapping to cover GTAP Versions 8, 9 and 10:

alias (ur,*);

set mapr(ur,rr) Mapping of GTAP Regions (from-to) /
	(CHN,HKG).CHN	!	China and Hong Kong
	IND.IND		!	India
	USA.USA		!	United States
	(		!	Europe 
		FRA	!	France
		DEU	!	Germany
		ITA	!	Italy
		AUT	!	Austria
		BEL	!	Belgium
		DNK	!	Denmark
		FIN	!	Finland
		GRC	!	Greece
		IRL	!	Ireland
		LUX	!	Luxembourg
		NLD	!	Netherlands
		PRT	!	Portugal
		ESP	!	Spain
		SWE	!	Sweden
		CZE	!	Czech Republic
		HUN	!	Hungary
		MLT	!	Malta
		POL	!	Poland
		ROU	!	Romania
		SVK	!	Slovakia
		SVN	!	Slovenia
		EST	!	Estonia
		LVA	!	Latvia
		LTU	!	Lithuania
		BGR	!	Bulgaria
		CYP	!	Cyprus
	).EUR
	(		!	Other G20 
		AUS	!	Australia
		NZL	!	New Zealand
		MEX	!	Mexico
		CHL	!	Chile
		KOR	!	Korea
		JPN	!	Japan
		RUS	!	Russia
		CAN	!	Canada
		).OG20

	/;

mapr(r,"row")$(not sum(mapr(r,rr),1)) = yes;


*	We define mappings for regions in all GTAP versions.  
*	Remove those which are not in the current dataset.

set	notr(ur)	Labels which are not in r;
option notr<mapr;
notr(r) = no;
mapr(notr,rr) = no;

*	See that each region in the source data has been mapped:

abort$(card(mapr)<>card(r))	"Error: card(mapr)<>card(r).";
