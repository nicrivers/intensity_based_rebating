*	Define sector aggregation

set	ii	Goods in the aggregation /
	GAS	Natural gas works
	ELE	Electricity and heat 
	OIL	Refined oil products
	COL	Coal 
	CRU	Crude oil
	EIT	Energy-intensive goods
	ROI	Rest of economy
	/;

alias (ui,*);

set mapi(ui,ii)  Mapping for sectors and goods /

	(GAS,GDT).GAS				Natural gas works
	ELE.ELE					Electricity and heat 
	OIL.OIL					Refined oil products
	COL.COL					Coal transformation
	CRU.CRU					Crude oil

	I_S.EIT					Iron and steel industry (IRONSTL)
	(CRP,CHM,BPH,RPP).EIT			Chemical industry (CHEMICAL)
	NFM.EIT					Non-ferrous metals (NONFERR)
	NMM.EIT					Non-metallic minerals (NONMET)
	PPP.EIT					Paper-pulp-print (PAPERPRO)
	(ATP,OTP,WTP).EIT			Transport
	/;

mapi(i,"ROI")$(not (sum(ii, mapi(i,ii)))) = yes;


*	We define mappings for commodities in all GTAP versions.  
*	Remove those which are not in the current dataset.


set	noti(ui)	Labels which are not in i;
option noti<mapi;
noti(i) = no;

mapi(noti,ii) = no;

abort$(card(mapi)<>card(i))	"Error: card(mapi)<>card(i).";
