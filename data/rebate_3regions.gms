*	Define region aggregation

set rr  Regions in the aggregation /
*	Individual regions
	USA 'United States',
	CAN 'Canada',
	ROW 'Rest of the World'
	/;

*	Permit the mapping to cover GTAP Versions 8, 9 and 10:

alias (ur,*);

$onembedded

SET mapr(ur,rr) Mapping of GTAP Regions (from-to) /
*	Individual countries
	USA.USA ! United States of America
	CAN.CAN ! China
	/;

mapr(r,"ROW")$(not (sum(rr, mapr(r,rr)))) = yes;

*	We define mappings for regions in all GTAP versions.  
*	Remove those which are not in the current dataset.

set	notr(ur)	Labels which are not in r;
option notr<mapr;
notr(r) = no;
mapr(notr,rr) = no;

*	See that each region in the source data has been mapped:

abort$(card(mapr)<>card(r))	"Error: card(mapr)<>card(r).";
