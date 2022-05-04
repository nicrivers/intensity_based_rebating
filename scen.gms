$STitle	CO2 emission regulation scenarios

*	For sector-specific testing of rebate rules without recalibration of model.gms we can revise the set of EIT sectors here:
*	Recall im model.gms: $if %ds%==rebate_11s_6r_3f	set eite(g) /i_s,nfm,nmm,ppp,chm,ele,oil/; //eit(g)$eite(g)= yes;
eit(g)$eite(g)	= yes;
*.eit("oil") = no;
display eit;

*	We can also respecify capital in EITE sectors to be sector-specific in order to mimic short-run adjustment
*$set ssk no
$if not set ssk	$set ssk no

if(%ssk%,
	PS.l("res",g)$eit(g)	= PF.l("cap");
	e0("cap")		= e0("cap") - sum(g$eit(g),  RVF.l("cap",g));
	ks0("res",g)$eit(g)	= RVF.l("cap",g);
	f0("res",g)$eit(g)	= f0("cap",g);
	tf("res",g)$eit(g)	= tf("cap",g);
	tf0("res",g)$eit(g)	= tf0("cap",g);
	f0("cap",g)$eit(g)	= 0;
	tf("cap",g)$eit(g)	= 0;
	tf0("cap",g)$eit(g)	= 0; 
);


soe.iterlim = 0;
$include soe.gen
solve soe using mcp;
abort$(abs(soe.objval) > objtol) "Benchmark replication fails.", soe.objval;

$ontext

Dimensions for systematic sensitivity analysis (see ssa.gms)
- target:	xx% (reduction in % from BMK)				! Reference CO2 emission reduction target
- rebate:	lsr, obr, abr, ibr, bcr					! Rebate scenarios
- metric:	p (constant price) , q (constant quantity)		! Fixing emission price or emission quantity at reference level

N.B.: The default elasticities in KLEM are:
		esub_e(g)	= 0.5;
		esub_kl_e(g)	= 0.5;
		esub_kle_m(g)	= 0.5;
		esub_m(g)	= 0;
		esub_k_l(g)	= esubva(g);
      For sensitivity analysis on the ease of decarbonization in the power system
      we may check one set of runs where we assign (if we do this outside ssa.gms
      just re-assign value in model.gms): 
		esub_kl_e("ele") = 2; 


Reference scenarios:
- ref_q:	Reference scenario with exogenous emission reduction target (this yiels the reference emission price ref_p)
- ref_p:	Reference scenario with exogenous emission price to achieve the exogenous emission reduction target (as specified with ref_q) 

Alternative rebate scenarios - here we distinguish between scenarios were we keep the emission price at the reference level (suffix _p)
and scenarios we keep domestic emissions at the reference level (suffix _q):
- obr:		Output-based rebate	
- abr:		Abatement-based rebate
- ibr		Intensity-based rebate
- bcr		"British-Columbia"-type rebate
$offtext

*	Verify benchmark replication
soe.iterlim = 0;
$include soe.gen
solve soe using mcp;
abort$(abs(soe.objval) gt objtol)"Model does not calibrate.", soe.objval

$batinclude report '"bmk"'




*------------- Reference scenarios ---------------------------------------------------
soe.iterlim = 100000;

*	Set CO2 emission reduction target for reference case 
$if not set target	$set target 20

*	Set rebate scenario
$if not set rebate	$set rebate LSR

*	Set metric for alternative rebate scenarios
$if not set metric	$set metric equal-p

*	First we solve the reference case
co2lim = sum(g, eco2(g))*(1-%target%/100);

$include soe.gen
solve soe using mcp;

parameter	ref_p	Reference emission price,
		ref_q	Reference emission quantity,
		ref_phi	Reference rationing multiplier;

ref_q = co2lim;
ref_p = PCO2E.l/PD.l("c");

display ref_p;
$batinclude report '"ref_q"'

*	Verify that we can replicate the reference equilibrium by 
*	setting an emission price (dual) rather than the emission target (primal)
co2lim	= sum(g, eco2(g));
ptgt	= ref_p;
PHI.lo = 0; PHI.l = 1; PHI.UP = +inf;

$include soe.gen
solve soe using mcp;
ref_phi  = PHI.l;
$batinclude report '"ref_p"'
abort$(abs(welfare("abs","ref_p") - welfare("abs","ref_q")) gt 1e-6)"Fails to replicate REF-Q";



*----------- Alternative rebate variants  ----------------------------------------------------------
PHI.fx = 1;

*	Upper bounds for rebate variants IBOR and IBER
iup(g)$(y0(g) and eit(g)) = CO2.l(g)/(y0(g)*Y.l(g));


*	Metric: Constant emission price (p) or constant emission reduction (q)
$if %metric%==equal-p	ptgt = ref_p; PHI.lo = 0; PHI.l = ref_phi; PHI.UP = +inf;
$if %metric%==equal-q	ptgt = 0; co2lim = ref_q; PHI.fx = 1; 


*	Specific rebate scenario
$if not set lsr		$set lsr no
$if not set obr		$set obr no
$if not set abr		$set abr no
$if not set ibor	$set ibor no
$if not set iber	$set iber no

$if %rebate%==LSR	$set lsr yes
$if %rebate%==OBR	$set obr yes
$if %rebate%==ABR	$set abr yes
$if %rebate%==IBOR	$set ibor yes
$if %rebate%==IBER	$set iber yes


*	Re-assign scenario settings pending on the specific scenario
if (%obr%,
obr  = 1;  PSI.LO(g)$eit(g) = 0; PSI.UP(g)$eit(g) = +0.99;
);

if (%abr%,
abr = 1; RHO.LO(g)$eit(g) = -0.99; RHO.UP(g)$eit(g) = +inf; 
);

if (%ibor%,
ibr = 1; RHO.LO(g)$eit(g) = -0.99; RHO.UP(g)$eit(g) = +inf; PSI.LO(g)$eit(g) = 0; PSI.UP(g)$eit(g) = +0.99;
);

if (%iber%,
bcr = 1; RHO.LO(g)$eit(g) = -0.99; RHO.UP(g)$eit(g) = +inf; PSI.lo(g)$eit(g) = 0; PSI.up(g)$eit(g) = +0.99;
);

$include soe.gen
solve soe using mcp; 


abort$(abs(soe.objval) gt objtol)"Model does not solve.", soe.objval
$batinclude report '"scn"'


*-----------------------------------	Generate various report arrays -------------------------------------------------------------------
set	scn	Scenarios /bmk,ref_q,ref_p,scn/;

*	Report differences and percentage changes as compared to benchmark without climate policy 
gdp("pct",gdpcat,gdpitem,scn)$gdp("abs",gdpcat,gdpitem,"bmk")	= 100*(gdp("abs",gdpcat,gdpitem,scn)/gdp("abs",gdpcat,gdpitem,"bmk") - 1);
gdp("dif",gdpcat,gdpitem,scn)					= gdp("abs",gdpcat,gdpitem,scn) - gdp("abs",gdpcat,gdpitem,"bmk");

quants("pct",qitem,gp,scn)$quants("abs",qitem,gp,"bmk")		= 100*(quants("abs",qitem,gp,scn)/quants("abs",qitem,gp,"bmk") - 1);
quants("dif",qitem,gp,scn)					= quants("abs",qitem,gp,scn) - quants("abs",qitem,gp,"bmk");

prices("pct",pitem,g,scn)$prices("abs",pitem,g,"bmk")		= 100*(prices("abs",pitem,g,scn)/prices("abs",pitem,g,"bmk") - 1);
prices("dif",pitem,g,scn)					= prices("abs",pitem,g,scn) - prices("abs",pitem,g,"bmk");


co2emit("pct",gp,scn)$co2emit("abs",gp,"bmk")			= 100*(co2emit("abs",gp,scn)/co2emit("abs",gp,"bmk") - 1);
co2emit("dif",gp,scn)						= co2emit("abs",gp,scn) - co2emit("abs",gp,"bmk");


welfare("pct",scn)$welfare("abs","bmk")				= 100*(welfare("abs",scn)/welfare("abs","bmk") - 1);
welfare("dif",scn)						= welfare("abs",scn) - welfare("abs","bmk");


summary("pct",sitem,gp,scn)$summary("abs",sitem,gp,"bmk")	= 100*(summary("abs",sitem,gp,scn)/summary("abs",sitem,gp,"bmk") - 1);
summary("dif",sitem,gp,scn)					= summary("abs",sitem,gp,scn) - summary("abs",sitem,gp,"bmk");


*	Report differences and percentage changes as compared to the reference climate policy (ref) with LSR rebate, i.e. ref_q or ref_p

gdp("pct_ref",gdpcat,gdpitem,scn)$gdp("abs",gdpcat,gdpitem,"ref_p") = 100*(gdp("abs",gdpcat,gdpitem,scn)/gdp("abs",gdpcat,gdpitem,"ref_p") - 1);
gdp("dif_ref",gdpcat,gdpitem,scn)				= gdp("abs",gdpcat,gdpitem,scn) - gdp("abs",gdpcat,gdpitem,"ref_p");

quants("pct_ref",qitem,gp,scn)$quants("abs",qitem,gp,"ref_p")	= 100*(quants("abs",qitem,gp,scn)/quants("abs",qitem,gp,"ref_p") - 1);
quants("dif_ref",qitem,gp,scn)					= quants("abs",qitem,gp,scn) - quants("abs",qitem,gp,"ref_p");

prices("pct_ref",pitem,g,scn)$prices("abs",pitem,g,"ref_p")	= 100*(prices("abs",pitem,g,scn)/prices("abs",pitem,g,"ref_p") - 1);
prices("dif_ref",pitem,g,scn)					= prices("abs",pitem,g,scn) - prices("abs",pitem,g,"ref_p");


co2emit("pct_ref",gp,scn)$co2emit("abs",gp,"ref_p")		= 100*(co2emit("abs",gp,scn)/co2emit("abs",gp,"ref_p") - 1);
co2emit("dif_ref",gp,scn)					= co2emit("abs",gp,scn) - co2emit("abs",gp,"ref_p");


welfare("pct_ref",scn)$welfare("abs","ref_p")			= 100*(welfare("abs",scn)/welfare("abs","ref_p") - 1);
welfare("dif_ref",scn)						= welfare("abs",scn) - welfare("abs","ref_p");


summary("pct_ref",sitem,gp,scn)$summary("abs",sitem,gp,"ref_p") = 100*(summary("abs",sitem,gp,scn)/summary("abs",sitem,gp,"ref_p") - 1);
summary("dif_ref",sitem,gp,scn)					= summary("abs",sitem,gp,scn) - summary("abs",sitem,gp,"ref_p");

*	Finally add a welfare metric where we account for the environmental benefits of emissions changes as compared to the REF-scenario (ref_q, ref_p)
parameter welf_emit	Welfare accounting with environmental benefits relative to reference scenario;

welf_emit(scn,"abs")				  = summary("abs","welfare","all",scn) + summary("abs","CO2 price","EITE","ref_p")*(summary("abs","Emissions","all","ref_p") 
							- summary("abs","Emissions","all",scn))/1000;
welf_emit(scn,"pct_ref")$welf_emit("ref_p","abs") = 100*(welf_emit(scn,"abs")/welf_emit("ref_p","abs") - 1);
welf_emit(scn,"diff_ref")		          = welf_emit(scn,"abs") - welf_emit("ref_p","abs");


parameter chk_eb	Check environmental benefit accounting;

chk_eb(scn,"welf-wo-eb") = summary("abs","welfare","all",scn);
chk_eb(scn,"welf")	 = welf_emit(scn,"abs");
chk_eb(scn,"eb")	 = summary("abs","CO2 price","eite","ref_p")*(summary("abs","Emissions","all","ref_p") - summary("abs","Emissions","all",scn))/1000;
chk_eb(scn,"eb_Gt")	 = (summary("abs","Emissions","all","ref_p") - summary("abs","Emissions","all",scn))/1000;
chk_eb(scn,"co2p")	 = summary("abs","CO2 price","eite","ref_p");

display chk_eb;

option summary:3:3:1;
display summary;


*	Here we specify the report arrays that we use for the PIVOT-table/chart reports via ssa.gms/pivot.gms
parameter macro, sector;

macro(sitem,gp)$(not sameas(sitem,"CO2 price"))	  = summary("pct",sitem,gp,"scn");
macro("CO2 price($)",gp)	  = summary("abs","CO2 price",gp,"scn");
sector("Output",g)		  = quants("pct","Y",g,"scn");
sector("Price",g)		  = prices("pct","PY",g,"scn");
sector("Emissions",g)		  = quants("pct","CO2",g,"scn");
sector("Intensity",g)		  = quants("pct","Int",g,"scn");
sector("Emissions","EITE")        = quants("pct","CO2","EITE","scn");
sector("Emissions","non-EITE")    = quants("pct","CO2","non-EITE","scn");
sector("Output","EITE")	          = quants("pct","Y","EITE","scn");
sector("Output","non-EITE")       = quants("pct","Y","non-EITE","scn");
sector("Intensity","EITE")        = quants("pct","Int","EITE","scn");
sector("Intensity","non-EITE")    = quants("pct","Int","non-EITE","scn");
sector("CO2 price($)",g)	  = prices("abs","PCO2",g,"scn");
sector("Int-IUP(abs)",g)	  = 1000*iup(g);
sector("Int-mdl(abs)",g)	  = quants("abs","Int",g,"scn");
sector("CO2 price($)","non-EITE") = prices("abs","PCO2","roi","scn");
sector("CO2 price($)","c")        = prices("abs","PCO2","c","scn");

display macro, sector;

display eit;

parameter diagnostics;

diagnostics("Emission(%)",g)$eit(g)	= quants("pct","CO2",g,"scn");
diagnostics("Emission(%)","EITE")	= quants("pct","CO2","EITE","scn");
diagnostics("Emission(%)","non-EITE")	= quants("pct","CO2","non-EITE","scn");
diagnostics("Emission(%)","c")		= quants("pct","CO2","C","scn");
diagnostics("Emission(%)","all")	= quants("pct","CO2","all","scn");
diagnostics("Intensity",g)$eit(g)	= 1000*quants("abs","CO2",g,"scn")/quants("abs","Y",g,"scn");
diagnostics("IUP",g)$eit(g)		= 1000*iup(g);
diagnostics("PCO2",g)$eit(g)		= sector("CO2 price($)",g);
diagnostics("PCO2","EITE")		= macro("CO2 price($)","EITE");
diagnostics("PCO2","non-EITE")		= sector("CO2 price($)","non-EITE");
diagnostics("PCO2","c")			= sector("CO2 price($)","c");
diagnostics("RHO",g)$eit(g)		= RHO.l(g);

option diagnostics:3:1:1;
display diagnostics;



$ontext
execute_unload 'report_%region%.gdx', inc, gdp, quants prices, co2emit, welfare, summary, welf_emit;

$onecho >gdxxrw.txt
par=gdp		rng="gdp!a2"	   cdim=0
par=inc		rng="inc!a2"	   cdim=0
par=quants	rng="quants!a2"	   cdim=0
par=prices	rng="prices!a2"	   cdim=0
par=welfare	rng="welfare!a2"   cdim=0
par=co2emit	rng="co2emit!a2"   cdim=0
par=summary	rng="summary!a2"   cdim=0
par=welf_emit	rng="welf_emit!a2" cdim=0
$offecho

execute 'gdxxrw i=report_%region%.gdx o=report_%region%.xlsx @gdxxrw.txt';
$offtext







