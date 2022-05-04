*	Define sector aggregation

set	ii	Goods in the aggregation /
	GAS	Natural gas works
	ELE	Electricity and heat 
	OIL	Refined oil products
	COL	Coal 
	CRU	Crude oil

*.	EIT	Energy-intensive goods
	I_S	Iron and steel industry
	NFM	Non-ferrous metals
	NMM	Non-metallic minerals
	PPP	Paper-pulp-print
	CHM	Chemical and pharmacetical and rubber plastics

	ROI	Rest of economy
	/;

alias (ui,*);

set mapi(ui,ii)  Mapping for sectors and goods /
1
	(GAS,GDT).GAS	Natural gas works
	ELE.ELE		Electricity and heat 
	OIL.OIL		Refined oil products
	COL.COL		Coal transformation
	CRU.CRU		Crude oil

	I_S.I_S		Iron and steel industry 
	NFM.NFM		Non-ferrous metals 
	NMM.NMM		Non-metallic minerals
	PPP.PPP		Paper-pulp-print
	CHM.CHM 	Chemical products
	BPH.CHM 	Basic pharmaceutical products
	RPP.CHM 	Rubber and plastic products

	/;

mapi(i,"ROI")$(not (sum(ii, mapi(i,ii)))) = yes;


*	We define mappings for commodities in all GTAP versions.  
*	Remove those which are not in the current dataset.


set	noti(ui)	Labels which are not in i;
option noti<mapi;
noti(i) = no;

mapi(noti,ii) = no;

abort$(card(mapi)<>card(i))	"Error: card(mapi)<>card(i).";
