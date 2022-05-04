@echo off
if not exist lst\nul mkdir lst
if not exist gdx\nul mkdir gdx
if not exist ibr_graphs\nul mkdir ibr_graphs

del gdx\*.gdx
del lst\*.lst
del ibr_graphs\*.png
del ibr_graphs\*.tex
del ibr_graphs\*.pdf

:goto :ssa

:       Model base-year calibration
:	Pick region for SOE analysis
set region=USA

title	SOE data extraction: %region%
gams model --region=%region%

title	Calibrate SOE model: %region%
gams model s=mdl --region=%region% --run=yes   

:ssa
title Create batch file with scenarios
call gams ssa.gms

title Execute scenarios
call runmodel.bat
pause

:report
title Create Pivot-Table /-Chart
call pivot.bat

:create benchmark table
Rscript benchmark_table.R %region%

:create figures
Rscript ibr_graphs.R %region%
Rscript ibr_graphs_sector_detail.R %region%