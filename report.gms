$STitle		GAMS Code for Reporting

parameter pnum	Numeraire price index;

pnum     = PD.l("c");

$ifthen.undefined not defined fmt




set	fmt	Report formats	/
		"abs"		Absolute value, 
		"pct"		Percentage change from BMK,
		"dif"		Difference from BMK
		"pct_ref"	Percentage change from reference scenario,
		"dif_ref"	Difference from reference scenario
		/,

	gdpcat	GDP Categories  /
		expend		Expenditure (C + G + I - (X-M)),
		income		Income (Factor income + taxes),
		valueadded	Sectoral factor earnings plus tax payments, 
		total		Total GDP/,

	gdpitem GDP items /
		"X-M",set.g,set.f, revCO2, revTF, revTY, revTI, revREC,
		expend,income,valueadded,chksum/,

	incitem	Income items /
		c	Private consumption,
		g	Government consumption,
		i	Investment consumption,
		vb	Balance of payment (deficit or surplus), 
		set.f	Factors, 
		taxrev	Tax revenues/,

	qitem	Quantity items /
		Y	Total output,
		D	Domestic supply, 
		X	Export supply , 
		M	Import demand
		Int	Emission intensity
		CO2	CO2 emissions  /,

	pitem	Price items /
		PD	Domestic supply price
		PY	Composite output price
		PE	Export price
		PM	Import price 
		set.f	Factor price 
		PCO2	CO2 price
		/,

	sitem	Summary report items /Welfare, Emissions, Output, Intensity, 'CO2 price'/;

alias (gdpit,gdpitem);


set	gp(*)		Sectors in report,
	mapg(g,*)	Mapping of sectors;


parameter
        gdp(fmt,gdpcat,gdpitem,*)	GDP accouting,
        vadd(g,gdpitem)			Intermediate accounts for GDP on a value-added basis,
*.        inc(fmt,incitem,*)		Income decomposition,
        inc(fmt,*,*)			Income decomposition,
        quants(fmt,qitem,*,*)		Quantities (sector) at benchmark prices,
        prices(fmt,*,g,*)		Prices (sector),
        welfare(fmt,*)			Welfare (money-metric utility),	
        co2emit(fmt,*,*)		CO2 emissions (in Gt),
	summary(fmt,sitem,*,*)		Summary report of key indicators;

$endif.undefined

gp(g) = yes; gp("all") = yes; gp("EITE") = yes; gp("non-EITE") = yes;
mapg(i,"EITE") = no; mapg(i,"non-EITE") = no;
mapg(g,g) = yes; mapg(g,"all") = yes; mapg(i,"EITE")$eit(i) = yes; mapg(i,"non-EITE")$(not eit(i)) = yes;


$ondotl
*	GDP expenditure-based
	gdp("abs","expend","c",%1)		=   RA/pnum;
	gdp("abs","expend","g",%1)		=   s0("g")*PD("g")/pnum;
	gdp("abs","expend","i",%1)		=   s0("i")*PD("i")/pnum;
	gdp("abs","expend","x-m",%1)		= - vb*PFX/pnum;

*	GDP income-based
	gdp("abs","income",gdpitem(f),%1)$mf(f)	=  (PF(f)*e0(f))/pnum;
	gdp("abs","income",gdpitem(f),%1)$sf(f)	=   sum(g, PS(f,g)*ks0(f,g))/pnum;
	gdp("abs","income","revTY",%1)  	=   sum(g, PY(g)*y0(g)*Y(g)*ty(g))/pnum;
	gdp("abs","income","revTI",%1)  	=   sum((i,g), PA(i)*RVI(i,g)*ti(i,g))/pnum;
	gdp("abs","income","revTF",%1)  	=   sum(g, sum(f, (PF(f)$mf(f) + PS(f,g)$sf(f))*RVF(f,g)*tf(f,g)))/pnum;
	gdp("abs","income","revCO2",%1)		=   sum(g, PCO2(g)*CO2(g))/pnum;
	gdp("abs","income","revREC",%1)		= - sum(g, PY(g)*y0(g)*Y(g)*PSI(g))/pnum;

*	GDP value-added- based
	vadd(i,gdpitem(f))$mf(f)= RVF(f,i)*PF.L(f)/pnum;
	vadd(i,gdpitem(f))$sf(f)= RVF(f,i)*PS.L(f,i)/pnum;
	vadd(g,"revTY")  	= (PY(g)*y0(g)*Y(g)*ty(g))/pnum;
	vadd(g,"revTI")  	= sum(i, PA(i)*RVI(i,g)*ti(i,g))/pnum;
	vadd(g,"revTF")  	= sum(f, (PF(f)$mf(f) + PS(f,g)$sf(f))*RVF(f,g)*tf(f,g))/pnum;
	vadd(g,"revCO2")	= (PCO2(g)*CO2(g))/pnum;
	vadd(g,"revREC")	= - (PY(g)*y0(g)*Y(g)*PSI(g))/pnum;

	gdp("abs","valueadded",gdpitem(g),%1)	= sum(gdpit,vadd(g,gdpit));
	gdp("abs","total","valueadded",%1)	= sum((g,gdpitem),vadd(g,gdpitem));


*	GDP totals
	gdp("abs","total","expend",%1) =   gdp("abs","expend","c",%1)
					 + gdp("abs","expend","g",%1)
					 + gdp("abs","expend","i",%1)	
			   		 + gdp("abs","expend","x-m",%1);
	gdp("abs","total","income",%1) =   sum(gdpitem(f), gdp("abs","income",gdpitem,%1)) + gdp("abs","income","res",%1)
					 + gdp("abs","income","revTY",%1) 
					 + gdp("abs","income","revTI",%1) 
					 + gdp("abs","income","revTF",%1) 
					 + gdp("abs","income","revCO2",%1)
					 + gdp("abs","income","revREC",%1);

	gdp("abs","total","chksum",%1) =   abs(gdp("abs","total","expend",%1) - gdp("abs","total","income",%1)) 
					 + abs(gdp("abs","total","expend",%1) - gdp("abs","total","valueadded",%1)) ;

*	Emissions and welfare
	co2emit("abs",gp,%1)	= sum(g$mapg(g,gp), CO2(g));
        welfare("abs",%1)	= RA/pnum;

*	Income components/decomposition        
        inc("abs","c",%1)		= RA/PD("c");
        inc("abs","vb",%1)		= vb*PFX/PD("c");
	inc("abs","g",%1)		= -s0("g")*PD("g")/PD("c");
	inc("abs","i",%1)		= -s0("i")*PD("i")/PD("c");
        inc("abs",mf,%1)		= PF(mf)*e0(mf)/PD("c");
	inc("abs",sf,%1)		= sum(g, PS(sf,g)*ks0(sf,g))/PD("c");
        inc("abs","taxrev",%1)		=  gdp("abs","income","revTY",%1) 
					 + gdp("abs","income","revTI",%1) 
					 + gdp("abs","income","revTF",%1) 
					 + gdp("abs","income","revCO2",%1)
					 + gdp("abs","income","revREC",%1);

*	Sector-specific quantities
	quants("abs","Y",gp,%1)		= sum(g$mapg(g,gp), Y(g)*y0(g));
	quants("abs","D",gp,%1)		= sum(g$mapg(g,gp), RVS(g));
        quants("abs","X",gp,%1)		= sum(g$mapg(g,gp), RVX(g));
        quants("abs","M",gp,%1)		= sum(i$mapg(i,gp), RVM(i));
        quants("abs","CO2",gp,%1)	= sum(g$mapg(g,gp), CO2(g));
        quants("abs","Int",gp,%1)$quants("abs","Y",gp,%1)	= 1000*quants("abs","CO2",gp,%1)/quants("abs","Y",gp,%1);	

*	Prices
        prices("abs","PD",g,%1)		= PD(g)/pnum;
        prices("abs","PY",g,%1)		= PY(g)/pnum;
        prices("abs",f,g,%1)$mf(f)	= PF(f)/pnum;
        prices("abs",f,g,%1)$sf(f)	= PS(f,g)/pnum;
	prices("abs","PCO2",g,%1)	= PCO2(g)/pnum;

	summary("abs","Welfare","all",%1)          = welfare("abs",%1);
	summary("abs","Emissions","all",%1)        = co2emit("abs","all",%1);	
	summary("abs","Emissions","EITE",%1)       = co2emit("abs","EITE",%1);	
	summary("abs","Emissions","non-EITE",%1)   = co2emit("abs","non-EITE",%1);	
	summary("abs","Output","EITE",%1)	   = quants("abs","Y","EITE",%1);
	summary("abs","Output","non-EITE",%1)	   = quants("abs","Y","non-EITE",%1);
	summary("abs","Intensity","EITE",%1)$summary("abs","Output","EITE",%1)		= 1000*summary("abs","Emissions","EITE",%1)/summary("abs","Output","EITE",%1);
	summary("abs","Intensity","non-EITE",%1)$summary("abs","Output","non-EITE",%1)  = 1000*summary("abs","Emissions","non-EITE",%1)/summary("abs","Output","non-EITE",%1);
	summary("abs","CO2 price","EITE",%1)	   = (sum(i$eit(i), PCO2(i)*CO2(i))/sum(i$eit(i), CO2(i)))/pnum;
	summary("abs","CO2 price","non-EITE",%1)   = (sum(i$(not eit(i)), PCO2(i)*CO2(i))/sum(i$(not eit(i)), CO2(i)))/pnum;

$offdotl