$Title	 GTAPinGAMS -- SOE model (stripped out)

set dummy /EITE, non-EITE, 'CO2 price', Output, Emissions, Intensity, LSR, OBR, ABR, IBOR, IBER/;

*	N.B.:	First: To create the SOE dataset and calibrate the model (to default region -- you can also select a region in the batch-file -- see run.bat)
*				gams soe 
*		Second: To save the model as a save-file (for subsequent scenario runs that restart on the save-file) invoke:
*				gams soe --run=yes s=mdl
*		Third: To run scenarios invoke:
*				gams scen r=mdl

*	Specify multi-region multi-sector data set (current options:rebate3s-3r or rebate7s-3r 
$set datadir data\
$if not set yr    $set yr    14
*.$if not set ds    $set ds    rebate_11s_G20_3f
$if not set ds    $set ds    rebate_11s_6r_3f

*	What region do we consider for SOE analysis?
$if not set region $set region usa
$setglobal region %region%


*	Option to set initial tax to zero ($set tax no) and compute a first-best benchmark
$if not set tax $set tax no

*	Initially we extract multi-region GTAP dataset ($set ds ...) towards a single country dataset
*	==> execute_unload 'gtapsoe.gdx'
*	Once this is done, we can invoke the current file again to process the single-country model calibration
*	and the option to re-calculate a new benchmark without initial tax distortions
*	==> execute 'gams soe --run=yes o=data.lst'
*--------------------------------------------------------------------------------------------------------------------------------------------------------------
$if set run $goto run

$include "%system.fp%gtapdata"

parameter
	vdm_(g)		Aggregate demand for domestic output,
	vom_(g)		Total supply at market prices,
	vxm_(g)         Export market supply,

	vim_(i)		Aggregate imports,
	evom_(f)	Aggregate factor endowment at market prices,
	vfm_(f,g)	Endowments - Firms' purchases at market prices,
	vdfm_(i,g)	Intermediates - firms' domestic purchases at market prices,
	vifm_(i,g)	Intermediates - firms' imports at market prices,
	vxmd_(i,r)	Trade - bilateral exports at market prices,
	vtwr_(i,j,s)	Trade - Margins for international transportation at world prices,

	rto_(g)		Output (or income) subsidy rates
	rtf_(f,g)	Primary factor and commodity rates taxes 
	rtfd_(i,g)	Firms domestic tax rates
	rtfi_(i,g)	Firms' import tax rates
	rtxs_(i,r)	Export subsidy rates
	rtms_(i,r)	Import taxes rates

	eco2d_(i,g)	CO2 emissions in domestic fuels - Mt CO2,
	eco2i_(i,g)	CO2 emissions in foreign fuels - Mt CO2;


vom_(g)		= vom(g,"%region%");
vdm_(g)		= vdm(g,"%region%");
vxm_(g)		= vxm(g,"%region%");

vim_(i)		= vim(i,"%region%");
evom_(f)	= evom(f,"%region%");
vfm_(f,g)	= vfm(f,g,"%region%");
vdfm_(i,g)	= vdfm(i,g,"%region%");
vifm_(i,g)	= vifm(i,g,"%region%");
vxmd_(i,r)	= vxmd(i,r,"%region%");
vtwr_(i,j,s)	= vtwr(i,j,s,"%region%");

rto_(g)		= rto(g,"%region%");
rtf_(f,g)	= rtf(f,g,"%region%");
rtfd_(i,g)	= rtfd(i,g,"%region%");
rtfi_(i,g)	= rtfi(i,g,"%region%");
rtxs_(i,r)	= rtxs(i,r,"%region%");
rtms_(i,r)	= rtms(i,r,"%region%");
eco2d_(i,g)	= eco2d(i,g,"%region%");
eco2i_(i,g)	= eco2i(i,g,"%region%");


*	Filter sets to get rid  of LES set elements (sd, dd)
set i_(*), g_(*);

g_(g)$vom_(g)  = yes;
i_(i)$(g_(i)) = yes;

display g_, i_;

rtfd_(i,"sd") = 0; rtfd_(i,"dd") = 0;
rtfi_(i,"sd") = 0; rtfi_(i,"dd") = 0;
vom_("sd") = 0; vom_("dd") = 0;

display rtfd, rtfi;
execute_unload 'gtapsoe.gdx',  i_=i, g_=g, f, r, sf, mf,
	vom_=vom, vxm_=vxm, vdfm_=vdfm, vifm_=vifm, vfm_=vfm, evom_=evom, vim_=vim, vxm_=vxm, vtwr_=vtwr, vxmd_=vxmd, 
	rto_=rto, rtf_=rtf, rtfd_=rtfd, rtfi_=rtfi, rtxs_=rtxs, rtms_=rtms, eco2d_=eco2d, eco2i_=eco2i,
	etadx, esub, esubva, esubdm, esubt,esubd, esubm, etrae;

*.execute 'gams soe --run=yes o=soe.lst';
$exit

*--------------------------------------------------------------------------------------------------------------------------------------------------------------
*	Here we start with processing the SOE model based on previously generated dataset gtapsoe.gdx
*	We first make sure that we replicate the base-year data with the basic SOE model ($model:basic) and the standard GTAPinGAMS notations.
*	We then relabel arrays/parameters towards a more compact notation and add the climate/energy policy logic to the model ($model:rebate).
*	Finally, we can activate the option to re-center the model towards an initial first-best equailibrium without prior tax distortions ($set notax yes).
$label run

$gdxin 'gtapsoe.gdx'

set	g(*)	Goods plus C - SD - DD -- G and I,
	i(g)	Goods
	f(*)	Factors
	r(*)	Regions
	sf(f)	Sluggish primary factors (sector-specific),
	mf(f)	Mobile primary factors;

$load g i f r sf mf

alias (r,s), (i,j);

parameter
	vdm(g)		Aggregate demand for domestic output,
	vom(g)		Total supply at market prices,
	vxm(g)          Export market supply,

	vim(i)		Aggregate imports,
	evom(f)		Aggregate factor endowment at market prices,
	vfm(f,g)	Endowments - Firms' purchases at market prices,
	vdfm(i,g)	Intermediates - firms' domestic purchases at market prices,
	vifm(i,g)	Intermediates - firms' imports at market prices,
	vxmd(i,r)	Trade - bilateral exports at market prices,
	vtwr(i,j,s)	Trade - Margins for international transportation at world prices,

	rto(g)		Output (or income) subsidy rates
	rtf(f,g)	Primary factor and commodity rates taxes 
	rtfd(i,g)	Firms domestic tax rates
	rtfi(i,g)	Firms' import tax rates
	rtxs(i,r)	Export subsidy rates
	rtms(i,r)	Import taxes rates,

	etadx(g)        Export elasticity of transformation D vs E,
	esubdm(i)	Elasticity of substitution D vs M,
	esubt(i)	Elasticity of top-level input substitution',
	esubd(i)	Elasticity of substitution (M versus D),
	esubva(g)	Elasticity of substitution between factors,
	esubm(i)	Intra-import elasticity of substitution,
	etrae(f)	Elasticity of transformation,

	eco2d(i,g)	CO2 emissions in domestic fuels - Mt CO2,
	eco2i(i,g)	CO2 emissions in foreign fuels - Mt CO2;

$loaddc vom vxm vim evom vfm vdfm vifm vxmd vtwr rto rtf rtfd rtfi rtxs rtms  eco2d eco2i
$loaddc etadx esubdm esubt esubd esubva esubm etrae 
$gdxin


parameter	vdm(g)	Supply to the domestic market;
vdm(g) = vom(g) - vxm(g);

parameter
	rtf0(f,g)	Primary factor and commodity rates taxes 
	rtfd0(i,g)	Firms domestic tax rates
	rtfi0(i,g)	Firms' import tax rates
	rtxs0(i,r)	Export subsidy rates
	rtms0(i,r)	Import taxes rates;

rtf0(f,g)  = rtf(f,g);
rtfd0(i,g) = rtfd(i,g);
rtfi0(i,g) = rtfi(i,g);

rtxs0(i,s) = rtxs(i,s);
rtms0(i,s) = rtms(i,s);

display rtxs0, rtms0;

parameter	pvxmd(i,s)	Import price (power of benchmark tariff)
		pvtwr(i,s)	Import price for transport services;

pvxmd(i,s) = (1+rtms0(i,s)) * (1-rtxs0(i,s));
pvtwr(i,s) = 1+rtms0(i,s);

parameter	esub(g)	Top-level elasticity;
esub(i) = esubt(i);
esub("c") = 1;

parameter	vm(i,s)	Import gross CIF;
vm(i,s) = sum(j,vtwr(j,i,s))*pvtwr(i,s) + vxmd(i,s)*pvxmd(i,s);
option vim:3:0:1;
display vim;

option vm:3:0:1;
display vm;


parameter	vb	Current account /0/;

vb = vom("c") + vom("g") + vom("i") 
	- sum(f, evom(f))
	- sum(g,  vom(g)*rto(g))
	- sum(g,  sum(i, vdfm(i,g)*rtfd(i,g) + vifm(i,g)*rtfi(i,g)))
	- sum(g,  sum(f, vfm(f,g)*rtf(f,g)))
	- sum((i,s), rtms(i,s) *  (vxmd(i,s) * (1-rtxs(i,s)) + sum(j,vtwr(j,i,s))));



*	Check GDP accounting:
parameter byr_gdp	Base year GDP;

*    Income based GDP includes facor earnings plus tax revenue:
byr_gdp("income")  =
     sum(f, evom(f))
    + sum(g,  vom(g)*rto(g))
    + sum(g,  sum(i, vdfm(i,g)*rtfd(i,g) + vifm(i,g)*rtfi(i,g)))
    + sum(g,  sum(f, vfm(f,g)*rtf(f,g)))
    + sum((i,s), rtms(i,s) *  (vxmd(i,s) * (1-rtxs(i,s)) + sum(j,vtwr(j,i,s))));

*    Production based GDP includes the value of output at market prices plus import
*    tariff revenue less export subsidies:

byr_gdp("production")  =  sum(g, vom(g)) -   sum((i,g), vdfm(i,g) + vifm(i,g))
    + sum((i,s), rtms(i,s) *  (vxmd(i,s) * (1-rtxs(i,s)) + sum(j,vtwr(j,i,s))));


*    Expenditure based GDP:
byr_gdp("expend")  =   vom("c") + vom("g") + vom("i") - vb;

display byr_gdp;

*	Lower the unrealistically high intra-import elasticity of substution for gas in the GTAP dataset (esubm(gas) = 32.579)
*	to double of the elasticitiy of substitution D vs M (esubd(gas) = 6.438),
esubm("gas") = 2*esubd("gas");

display esubd, esubm;

$ontext
$model:gtapsoe

$sectors:
	Y(g)$vom(g)		! Supply
	M(i)$vim(i)		! Imports
	MS(i,s)$vm(i,s)
	FT(sf)$evom(sf)

$commodities:
	P(g)$vdm(g)		! Domestic output price
	PM(j)$vim(j)		! Import price
	PMS(i,s)$vm(i,s)
	PF(f)$evom(f)		! Primary factors rent
	PS(f,g)$(sf(f)*vfm(f,g))! Sector-specific primary factors
	PFX			! Real exchange rate (SOE model)

$consumers:
	RA			! Representative agent
	ROW			! Rest of world 

$auxiliary:
	X(i)			! Export index
	VX			! Value of exports index

$prod:Y(g)$vom(g) s:0 m:esub(g) va:esubva(g) i.tl(m):esubd(i)  
	o:P(g)		q:vom(g)	a:RA  t:rto(g)	p:(1-rto(g))
	i:P(i)		q:vdfm(i,g)	p:(1+rtfd0(i,g)) i.tl:  a:RA t:rtfd(i,g)
	i:PM(i)		q:vifm(i,g)	p:(1+rtfi0(i,g)) i.tl:  a:RA t:rtfi(i,g)
	i:PS(sf,g)	q:vfm(sf,g)	p:(1+rtf0(sf,g))  va:   a:RA t:rtf(sf,g)
	i:PF(mf)	q:vfm(mf,g)	p:(1+rtf0(mf,g))  va:   a:RA t:rtf(mf,g)


$prod:M(i)$vim(i)	s:esubm(i) 
	o:PM(i)		q:vim(i)
	i:PMS(i,s)	q:vm(i,s)

$prod:MS(i,s)$vm(i,s)  s:0
	o:PMS(i,s)	q:vm(i,s)
	i:PFX		q:(sum(j,vtwr(j,i,s)))	p:pvtwr(i,s)	a:RA  t:rtms(i,s)
	i:PFX		q:vxmd(i,s)		p:pvxmd(i,s)	a:ROW t:(-rtxs(i,s)) a:RA t:(rtms(i,s)*(1-rtxs(i,s)))

$prod:FT(sf)$evom(sf)  t:etrae(sf)
	o:PS(sf,j)	q:vfm(sf,j)
	i:PF(sf)	q:evom(sf)

$demand:RA  
	d:P("c")	q:vom("c")
	e:P("g")	q:(-vom("g"))
	e:P("i")	q:(-vom("i"))
	e:PFX		q:vb
	e:PF(f)		q:evom(f)
*.	e:P("sd")	q:(-vom("sd"))
	e:P(i)		q:(-vxm(i))		r:X(i)
	e:PFX		q:(sum(g,vxm(g)))	r:VX

$demand:ROW
	d:PFX

$constraint:X(i)
	X(i) =e= (P(i)/PFX)**(-esubm(i));

$constraint:VX
	VX =e= sum(i, P(i)*X(i)*vxm(i))/sum(i,vxm(i));

$report:
	v:V_VDFM(i,g)	i:P(i)		prod:Y(g)
	v:V_VIFM(i,g)	i:PM(i)		prod:Y(g)
	v:V_VFM(f,g)	i:PF(f)		prod:Y(g)

$offtext
$sysinclude mpsgeset gtapsoe

X.l(i)  = 1;
VX.l	= 1;

gtapsoe.iterlim = 0;
$include gtapsoe.gen
solve gtapsoe using mcp;
abort$(abs(gtapsoe.objval) > 1e-3) "Benchmark replication of basic SOE model with GTAPinGAMS notation fails.";

*--------------------------------------------------------------------------------------------------------------------------------------------------------------
*	Next we relabel parameter notations, simplify some model logic and include additional climate/energy policy logic	
parameter 
	y0(g)	 Domestic production
	x0(g)	 Exports, 
	i0(i,g)	 Intermediate inputs, 
	a0(i)	 Armington supply, 
	e0(f)	 Factor endowment, 
	f0(f,g)	 Factor demand, 
	s0(g)	 Domestic supply, 
	m0(i)	 Imports, 
	v0	 Balance of payment,

	ty0(g)	 Base-year output taxes or subsidies
	tf0(f,g) Base-year factor taxes
	ti0(i,g) Base-year intermediate input taxes
	ty(g)	 Output taxes or subsidies
	tf(f,g)	 Factor taxes
	ti(i,g)	 Intermediate input taxes;

y0(g)	= vom(g);
i0(i,g)	= vdfm(i,g) + vifm(i,g);
f0(f,g)	= vfm(f,g);
e0(f)	= evom(f);
x0(i)	= vxm(i);
m0(i)	= sum(g, vifm(i,g));
s0(g)	= y0(g) - x0(g);
a0(i)	= s0(i) + m0(i);

ty0(g)	= rto(g);
tf0(f,g)= rtf0(f,g);
ti0(i,g)$(vdfm(i,g)+vifm(i,g))= (vdfm(i,g)*rtfd0(i,g) + vifm(i,g)*rtfi0(i,g))/(vdfm(i,g)+vifm(i,g));

ty(g) = ty0(g); tf(f,g) = tf0(f,g); ti(i,g) = ti0(i,g);

*.parameter zprf;
*.zprf(g) = y0(g)*(1-rto( - sum(i,d0(i,g)) - sum(f, f0(f,g));



*	Merge import tariffs and export subsidies into imports/exports (VB adjustments)
*.parameter pfxtax(i,s);
*.pfxtax(i,s) =  (sum(j,vtwr(j,i,s)))*rtms(i,s) + vxmd(i,s)*(pvxmd(i,s) - 1) + rtxs(i,s)*vxmd(i,s);
*.vb = vb + sum((i,s), pfxtax(i,s));
*.vb = vb + sum((i,s), pfxtax(i,s)) + sum((i,s), rtxs(i,s)*vxmd(i,s));
vb	= - sum(i, x0(i) - m0(i));

*	KLEM nesting of production inputs
parameter
        esub_kle_m(g)	Elasticity of substitution between KLE and M,
        esub_m(g)	Elasticity of substitution within material composite,
        esub_kl_e(g)	Elasticity of substitution between KL and E,
        esub_k_l(g)	Elasticity of substitution between K and L,
        esub_e(g)	Elasticity of susbstituion within energy composite;	

*	Assign KLEM elasticities (preferably based on empirical estimates)
esub_k_l(g)	= esubva(g);
esub_e(g)	= 0.5;
esub_kl_e(g)	= 0.5;
esub_kle_m(g)	= 0.5;

esub_m(g)	= 0;

esub_e("c")	= 0.5;	
esub_m("c")	= 0.5;
esub_kle_m("c") = 0;

esub_e("g")	 = 0;
esub_e("i")	 = 0;


**NR
*	We may want to increase the CO2 substitution elasticities in the power sector to account for "cheap" fossil fuel substituion and the
*	scope of RES-E penetration
esub_e("ele")    = 2;
esub_kl_e("ele") = 1;

*	Fossil fuel sectors xe(g) get calibrated to exogenous supply elasticities
parameter
	esubr(g)	Substitution elasticity between specific energy resource and other inputs,
	thetar(g)	Resource value share,
	etar(g)		Exogenous fossil fuel supply elasticites,
	r0(g)		Specific factor earnings;

esubr(g)    = 0;
etar("col") = 4; 
etar("gas") = 1; 
etar("cru") = 1; 


* ------ Extensions for CO2 emission control policies -------------------------------------------------
set	xe(g)	(Primary) Energy sectors to be calibrated to exogenous supply elasticities / 
$if %ds%==rebate3s-3r		ene
$if %ds%==rebate7s-3r		col,cru,gas
$if %ds%==rebate_11s_G20_3f	col,cru,gas
$if %ds%==rebate_11s_6r_3f	col,cru,gas
/;

set	fe(i)	Fuels with CO2 emissions from combustion /
$if %ds%==rebate3s-3r		ene
$if %ds%==rebate7s-3r		col,gas,oil
$if %ds%==rebate_11s_G20_3f	col,gas,oil
$if %ds%==rebate_11s_6r_3f	col,gas,oil
/;

*.set	ele(i)	Electricity (in case we distinguish electric and non-electric energy)
$if %ds%==rebate3s-3r		set ele(i); ele(i) = no;
$if %ds%==rebate7s-3r		set ele(i) /ele/;
$if %ds%==rebate_11s_G20_3f	set ele(i) /ele/;
$if %ds%==rebate_11s_6r_3f	set ele(i) /ele/;


set	e(i)	Fuels with CO2 emissions and electricity/
$if %ds%==rebate3s-3r		ene
$if %ds%==rebate7s-3r		col,gas,oil,ele
$if %ds%==rebate_11s_G20_3f	col,gas,oil,ele
$if %ds%==rebate_11s_6r_3f	col,gas,oil,ele
/;

set	eite(g)	Emissionintensive sectors /
$if %ds%==rebate3s-3r	eit
$if %ds%==rebate7s-3r	eit,ele
$if %ds%==rebate_11s_G20_3f	i_s,nfm,nmm,ppp,chm,oil,ele
$if %ds%==rebate_11s_6r_3f	i_s,nfm,nmm,ppp,chm,oil,ele
/;

set	eit(g)	Actual (active) emission-intensive sectors subject to rebates;

eit(g)$eite(g) = yes;

*	Syntax for CO2 emission control and rebate policies
*	- GTAP monetary units are provided in billion USD
*	- CO2 emissions are originally provided in million USD
*	  We scale these to billion tons of CO2 (Gt CO2) such that
*	  the (shadow) price of CO2 emissions is readily provided in USD/tCO2

parameter
	co20(i,g)	Base-year CO2 emissions by fuel and sector (Gt),
	eco2(g)		CO2 emission demand by sector (Gt),
	co2lim		CO2 emission endowments (Gt),
	ptgt		Exogenous target price for CO2 (USD per ton of CO2);

co20(i,g) = (eco2d(i,g) + eco2i(i,g))/1000;
eco2(g)   = sum(i, co20(i,g));
co2lim    = sum(g, eco2(g));
ptgt	  = 0;

*	Rebate parameterization
parameter
	obr	Flag for output-based rebating			/0/,
	abr	Flag for abatement based rebating		/0/,	
	ibr	Flag for intensity-based rebating		/0/,
	bcr	Flag for British-Columbia rebating		/0/;

parameter	iup(g)	Upper threshold for intensity rebate;		

iup(g) = 0; 

display esubd, esubm;

parameter ks0(f,g)	Sector-specific capital;

ks0(sf,g) = f0(sf,g);

$ontext
$model:soe

$sectors:
	Y(g)$y0(g)		! Domestic production
	T(g)$s0(g)		! Output transformation
	A(i)$a0(i)		! Armington composite
	CO2(g)$eco2(g)		! CO2 emission flow

$commodities:
	PD(g)$s0(g)		! Domestic supply price
	PY(g)$y0(g)		! Domestic production price
	PA(i)$a0(i)		! Price of Armington composite
	PF(f)$(mf(f)*e0(f))	! Primary factors rent
	PS(f,g)$(sf(f)*f0(f,g))	! Resource price 
	PFX			! Real exchange rate (SOE model)
	PCO2(g)$eco2(g)		! Sectoral CO2 emission price
	PCO2e			! Economy-wide CO2 emission price

$consumers:
	RA			! Representative agent

$auxiliary:
	PHI$ptgt	! Rationing of CO2 budget to hit exogenous CO2 price
	RHO(g)		! Tax on emission inputs
	PSI(g)		! Subsidy on production output

*	Output transformation
$prod:T(g)$s0(g) t:etadx(g)
	o:PFX		q:x0(g)
	o:PD(g)		q:s0(g)	
	i:PY(g)		q:y0(g)

*	Domestic production except fossil fuels
$prod:Y(g)$(y0(g) and not xe(g))  s:esub_kle_m(g)  m(s):esub_m(g) vae(s):esub_kl_e(g) e(vae):esub_e(g) va(vae):esub_k_l(g) fe.tl(e):0 
	o:PY(g)		q:y0(g)		p:(1-ty0(g))	a:RA	t:ty(g)	a:RA n:PSI(g)	m:(-1)	
	i:PA(i)		q:i0(i,g)	p:(1+ti0(i,g))	a:RA	t:ti(i,g)  i.tl:$fe(i)	m:$(not e(i)) e:$ele(i)
	i:PCO2(g)#(fe)	q:co20(fe,g)	p:1e-6	fe.tl:						
	i:PF(mf)	q:f0(mf,g)	p:(1+tf0(mf,g))	a:RA	t:tf(mf,g)  va: 
	i:PS(sf,g)	q:f0(sf,g)	p:(1+tf0(sf,g))	a:RA	t:tf(sf,g)  va: 

*	Energy (fossil fuel) production
$prod:Y(g)$(y0(g) and xe(g))  s:esubr(g) id:0
	o:PY(g)		q:y0(g)		p:(1-ty0(g))	a:RA  t:ty(g)
	i:PA(i)		q:i0(i,g)	p:(1+ti0(i,g))	a:RA	t:ti(i,g)	id:
	i:PCO2(g)#(fe)	q:co20(fe,g)	p:1e-6					id:
	i:PF(mf)	q:f0(mf,g)	p:(1+tf0(mf,g))	a:RA	t:tf(mf,g)	id: 
	i:PS(sf,g)	q:f0(sf,g)	p:(1+tf0(sf,g))	a:RA	t:tf(sf,g)

*	Armington supply
$prod:A(i)$a0(i)	s:esubd(i) 
	o:PA(i)		q:a0(i)
	i:PD(i)		q:s0(i)
	i:PFX		q:m0(i)

*	 CO2 emission flows
$prod:CO2(g)$eco2(g)
	o:PCO2(g)	q:1	
	i:PCO2E		q:1	p:1e-6   a:RA n:RHO(g)	
	i:PF("lab")	q:1e-6

*	Represenative agent
$demand:RA  
	d:PD("c")	q:s0("c")
	e:PD("g")	q:(-s0("g"))
	e:PD("i")	q:(-s0("i"))
	e:PFX		q:vb
	e:PF(mf)	q:e0(mf)
	e:PS(sf,g)	q:ks0(sf,g)
	e:PCO2E		q:co2lim	r:PHI$ptgt

*	Targeting of exogenous CO2 price
$constraint:PHI$ptgt
	PCO2E =e= PD("c")*ptgt;

*	OBR-IBR-BCR: Implicit output subsidy through revenue recycling
$constraint:PSI(g)$(obr or ibr or bcr)
	PSI(g)*PY(g)*Y(g)*y0(g) =e= PCO2(g)*CO2(g);

*	ABR emission pricing
$constraint:RHO(g)$abr
*.	RHO(g) =e= ((eco2(g)/(eco2(g) - CO2(g)))- 1);
	(RHO(g) + 1)*(eco2(g) - CO2(g)) =e= eco2(g);

*	IBR emission pricing 
$constraint:RHO(g)$ibr
*.	RHO(g) =e= (iup(g)/(iup(g) - (CO2(g)/(Y(g)*y0(g)))) - 1);
**.	(RHO(g) + 1)*(iup(g) - (CO2(g)/(Y(g)*y0(g)))) =e= iup(g);
	(RHO(g) + 1)*((Y(g)*y0(g))*iup(g) - CO2(g)) =e= iup(g)*Y(g)*y0(g);

*	BCR emission pricing
$constraint:RHO(g)$bcr 
*.	RHO(g) =e= (((CO2(g)/(Y(g)*y0(g)))/(iup(g) - (CO2(g))/(Y(g)*y0(g)))) - 1);
**.	(RHO(g) + 1)*(iup(g) - (CO2(g))/(Y(g)*y0(g))) =e= (CO2(g)/(Y(g)*y0(g)));
	(RHO(g) + 1)*((Y(g)*y0(g))*iup(g) - (CO2(g))) =e= CO2(g);

$report:
	v:RVS(g)	 o:PD(g)	prod:T(g)
	v:RVX(g)	 o:PFX		prod:T(g)
	v:RVM(i)	 i:PFX		prod:A(i)
	v:RVF(f,g)$mf(f) i:PF(f)	prod:Y(g)
	v:RVF(f,g)$sf(f) i:PS(f,g)	prod:Y(g)
	v:RVI(i,g)	 i:PA(i)	prod:Y(g)
$offtext
$sysinclude mpsgeset soe

soe.iterlim = 0;

CO2.l(g)  = eco2(g);
PCO2.l(g) = 1e-6;
PCO2E.l   = 1e-6;
PHI.fx	  = 1; 
RHO.fx(g) = 0;
PSI.fx(g) = 0;

PCO2.fx(g)$(not eco2(g)) = 0;
CO2.fx(g)$(not eco2(g))  = 0;

soe.workspace = 1024;
$include soe.gen
solve soe using mcp;

parameter objtol	Tolerance for benchmark replication /1e-3/;
abort$(abs(soe.objval) gt objtol)"Model does not calibrate.", soe.objval;

*	Treatment of capital earnngs:
*	1. Move all capital earnings (res, cap) in fossil fuel sectors into sector-specific resource (res)
*	2. Move all capital earnings (res, cap) in other sectors into malleable capital (cap)


*	Calibrate fossil fuel cost function to exogenous supply elasticities
*	etar	=	Elasticity of supply
*	esubr	=	Elasticity of substitution
*	thetar	=	Cost share of specific factor input

*	etar = esubr * thetar/(1-thetar)

*	ad 1.	Move all capital earnings in XE sectors into specific capital and calibrate top-level CES esubr
*		to align locally with an exogenous supply elasticity etar(xe)

*	etar = esubr * thetar/(1-thetar)


*	ad 1.	Move all capital earnings in XE sectors into specific capital and calibrate top-level CES esubr
*		to align locally with an exogenous supply elasticity etar(xe)

tf0("res",xe)$(sum(sf, f0(sf,xe)) + f0("cap",xe)) 
		= (sum(sf, f0(sf,xe)*tf0(sf,xe)) + f0("cap",xe)*tf0("cap",xe))/(sum(sf, f0(sf,xe)) + f0("cap",xe));
tf0("cap",xe)= 0;
tf0(sf,xe)$(not sameas(sf,"res")) = 0;
tf(sf,xe)	= tf0(sf,xe);
tf(mf,xe)	= tf0(mf,xe);
f0(sf,xe)	= f0(sf,xe) + f0("cap",xe);
f0("cap",xe)	= 0;
e0("cap")	= sum(i,f0("cap",i));
ks0(sf,i)	= f0(sf,i);

thetar(xe)$y0(xe)	     = f0("res",xe)*(1+tf0("res",xe))/(y0(xe)*(1-ty0(xe)));
esubr(xe)$(1-thetar(xe)) = etar(xe)*thetar(xe)/(1-thetar(xe));

$include SOE.GEN
solve soe using mcp;
abort$(abs(soe.objval) > objtol) "Recalibration of fossil fuel supply sectors fails.", soe.objval;

*	ad 2.	Move all capital earnings (res, cap) in sectors other than XE into malleable capital (cap)
loop(g$((not xe(g)) and sum(sf, f0(sf,g))),
    tf0("cap",g)$(sum(sf, f0(sf,g)) + f0("cap",g)) 
        = (sum(sf, f0(sf,g)*tf0(sf,g)) + f0("cap",g)*tf0("cap",g))/(sum(sf, f0(sf,g)) + f0("cap",g));
    tf0(sf,g)     = 0;
    tf(sf,g)      = tf0(sf,g);
    tf(mf,g)      = tf0(mf,g);
    f0("cap",g)   = f0("cap",g) + sum(sf, f0(sf,g));
    f0(sf,g)	  = 0;
    e0("cap")     = sum(i,f0("cap",i));
    ks0(sf,i)	  = f0(sf,i);
    PS.l("res",g) = 0;
);
$include SOE.GEN
solve soe using mcp;
abort$(abs(soe.objval) > objtol) "Recalibration of capital earnings fails.", soe.objval;


parameter gdp_compare, co2_compare;;
$batinclude report '"bmk"'

gdp_compare("expend","before")       = gdp("abs","total","expend","bmk");
gdp_compare("income","before")       = gdp("abs","total","income","bmk");    
gdp_compare("valuadded","before")    = gdp("abs","total","valueadded","bmk");
co2_compare(fe,g,"before")$i0(fe,g)  = (RVI.l(fe,g)/i0(fe,g))*co20(fe,g);
co2_compare(fe,"all","before")	     = sum(g,co2_compare(fe,g,"before"));
co2_compare("all","all","before")    = sum((fe,g),co2_compare(fe,g,"before")); 


if( (not %tax%),
ty(g)	  = 0;
ti(i,g)   = 0;
tf(f,g)   = 0;
*	We need to relax the carbon constraint to make sure that CO2 pricing does not kick in
co2lim  = 1000*co2lim;

soe.iterlim = 1000;
$include soe.gen
solve soe using mcp;

*	Then make sure that we solve the benchmark at a binding co2lim with a shadow price of zero
*	We also need to update the reference emission flows to sectors:
eco2(g)  = CO2.l(g);
co2lim   = sum(g, CO2.l(g));
soe.iterlim = 0;
$include soe.gen
solve soe using mcp;

);

$batinclude report '"bmk"'

gdp_compare("expend","after")       = gdp("abs","total","expend","bmk");
gdp_compare("income","after")       = gdp("abs","total","income","bmk");    
gdp_compare("valuadded","after")    = gdp("abs","total","valueadded","bmk");
co2_compare(fe,g,"after")$i0(fe,g)  = (RVI.l(fe,g)/i0(fe,g))*co20(fe,g);
co2_compare(fe,"all","after")	    = sum(g,co2_compare(fe,g,"after"));
co2_compare("all","all","after")    = sum((fe,g),co2_compare(fe,g,"after")); 


gdp_compare("expend","pctdev")$gdp_compare("expend","before")  	    = 100*(gdp_compare("expend","after")/gdp_compare("expend","before")  - 1);     
gdp_compare("income","pctdev")$gdp_compare("income","before")       = 100*(gdp_compare("income","after")/gdp_compare("income","before") - 1);     
gdp_compare("valuadded","pctdev")$gdp_compare("valuadded","before") = 100*(gdp_compare("valuadded","after")/gdp_compare("valuadded","before")  - 1);  
co2_compare(fe,g,"pctdev")$co2_compare(fe,g,"before")		    = 100*(co2_compare(fe,g,"after")/co2_compare(fe,g,"before")  - 1);
co2_compare(fe,"all","pctdev")$co2_compare(fe,"all","before")	    = 100*(co2_compare(fe,"all","after")/co2_compare(fe,"all","before")  - 1);	     
co2_compare("all","all","pctdev")$co2_compare("all","all","before") = 100*(co2_compare("all","all","after")/co2_compare("all","all","before") - 1);  

display gdp_compare, co2_compare;

parameter chk_zprf, chk_mkt;

set fd(g) /c,g,i/;

chk_zprf(g) = PY.l(g)*Y.l(g)*y0(g)*(1-ty(g)) - sum(f, RVF.l(f,g)*PF.l(f)*(1+tf(f,g))) - CO2.l(g)*PCO2.l(g) - sum(i, RVI.l(i,g)*PA.l(i)*(1+ti(i,g)));
chk_mkt(i)  = PY.l(i)*Y.l(i)*y0(i) + RVM.l(i)*PFX.l - sum(g, RVI.l(i,g)*PA.l(i)) - RVX.l(i)*PFX.l;
chk_mkt(fd(g)) = PY.l(g)*Y.l(g)*y0(g) - RVS.l(g)*PD.l(g);


display chk_zprf, chk_mkt;

*	For the re-computed benchmark without initial tax distortions we dump economic data and CO2 emission data into a GDX-file / Excel sheet
parameter sam(*,*)	Economic data in billion USD 2014 
	  co20r(fe,g)	CO2 emission data (in Mt CO2);

sam(i,i)		   =   y0(i)*Y.l(i)*PY.l(i) - RVI.l(i,i)*PA.l(i);
*.loop(g$fd(g), sam(g,g)     = y0(g)*Y.l(g)*PY.l(g));
sam(i,g)$(not sameas(i,g)) = - RVI.l(i,g)*PA.l(i);
sam(f,i)$mf(f)		   = - RVF.l(f,i)*PF.l(f);	
sam(f,i)$sf(f)		   = - RVF.l(f,i)*PS.l(f,i);
sam(i,"exp")		   = - RVX.l(i)*PFX.l;
sam("imp",i)		   =   RVM.l(i)*PFX.l;
display sam;

co20r(fe,g)$i0(fe,g)  = round(1000*RVI.l(fe,g)/i0(fe,g)*co20(fe,g),1);

parameter chk_sam;
alias (g,gg);

chk_sam(i,"row") = sam(i,i)+ sam("imp",i) + sum(g$(not sameas(i,g)), sam(i,g)) + sam(i,"exp");
chk_sam(g,"col") = sum(i, sam(i,g)) + sum(f, sam(f,g)) + sam("res",g) + sum(fd(g)$sameas(g,fd), (y0(g)*Y.l(g)*PY.l(g)));

display chk_sam;
option sam:2:1:1;

set rc	Items of SAM /set.f, set.g, exp, imp/;

alias (rc, rc_);
sam(rc,rc_) = round(sam(rc,rc_), 1);


$ontext
execute_unload '%region%.gdx' sam, co20r;

$onecho > gdxxrw.txt
par=sam	  rng=sam!a1 rdim=1 cdim=1
par=co20r rng=co2r!a1 rdim=1 cdim=1
$offecho
execute 'gdxxrw i=%region%.gdx o=data_%region%.xlsx @gdxxrw.txt';
$offtext

display co20r;


parameter intensity	Emission intensity (g CO2 per dollar);

intensity(g)$y0(g) = 1000*CO2.l(g)/(y0(g)*Y.l(g));

option intensity:3:0:1;

display intensity;


*	Base-year statistics
parameter bmk(*,*,*)	Benchmark statistics;

set label /'Refined petroleum products','Natural gas','Coal','Crude oil','Rest of economy', 'Pulp and paper', 'Non-metal minerals', 'Iron and steel'
	   'Non-ferrous metals', 'Electricity', 'Chemicals', 'Consumption', 'Government', 'Investment'/;

set gl(g,label)	/oil.'Refined petroleum products',
		 gas.'Natural gas',
		 col.'Coal',
		 cru.'Crude oil',
		 roi.'Rest of economy',
		 ppp.'Pulp and paper',
		 nmm.'Non-metal minerals',
		 i_s.'Iron and steel',
		 nfm.'Non-ferrous metals',
		 ele.'Electricity',
		 chm.'Chemicals',
		 c.'Consumption',
		 g.'Government',
		 i.'Investment'	/;

bmk(gl(g,label),qitem)	=  round(quants("abs",qitem,g,"bmk"),0);
bmk(gl(g,label),"cap")	= 0;
bmk(gl(g,label),"CO2")	=  round(1000*quants("abs","CO2",g,"bmk"));
bmk(gl(g,label),"Int")$bmk(gl,"Y") =  round(1000*bmk(gl,"CO2")/bmk(gl,"Y"),0);


parameter bmk_emit Sectoral CO2 emissions by fuel input (in Mt and pct);

bmk_emit(g,fe,"Mt")$i0(fe,g)	= 1000*RVI.l(fe,g)/i0(fe,g)*co20(fe,g);
bmk_emit(g,"all","Mt")		= sum(fe,bmk_emit(g,fe,"Mt"));  
bmk_emit(g,fe,"%")$bmk_emit(g,"all","Mt") = 100*bmk_emit(g,fe,"Mt")/bmk_emit(g,"all","Mt");
bmk_emit(g,"all","%")		= sum(fe, bmk_emit(g,fe,"%"));

option bmk_emit:1:2:1;
display bmk_emit;

option bmk:0:2:1;
display bmk;


execute_unload 'bmk_%region%.gdx' bmk, bmk_emit;

$onecho >gdxxrw.txt
par=bmk		rng=bmk!a1	rdim=2 cdim=1
par=bmk_emit	rng=bmk_emit!a1 rdim=2 cdim=1
$offecho
*.execute 'gdxxrw i=bmk_%region%.gdx o=bmk_%region%.xlsx @gdxxrw.txt';
