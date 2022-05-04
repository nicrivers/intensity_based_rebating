if not exist lst\nul mkdir lst
if not exist gdx\nul mkdir gdx

del gdx\*.gdx

:: Need to create model_elec_eite.gms
:: This is a copy of model.gms with ele treated as eite

set region=USA


:: First run with electricity sector treated as non-EITE

gams model --ds=rebate_11s_G20_3f
gams model s=mdl --run=yes --ds=rebate_11s_G20_3f

gams scen r=mdl gdx=gdx\ele_not_eite_lsr.gdx --target=20 --rebate=LSR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_not_eite_obr.gdx --target=20 --rebate=OBR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_not_eite_abr.gdx --target=20 --rebate=ABR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_not_eite_ibor.gdx --target=20 --rebate=IBOR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_not_eite_iber.gdx --target=20 --rebate=IBER --metric=equal-p

del mdl.*

:: Second run with electricity sector treated as EITE

gams model_elec_eite --ds=rebate_11s_G20_3f
gams model_elec_eite s=mdl --run=yes --ds=rebate_11s_G20_3f

gams scen r=mdl gdx=gdx\ele_eite_lsr.gdx --target=20 --rebate=LSR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_eite_obr.gdx --target=20 --rebate=OBR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_eite_abr.gdx --target=20 --rebate=ABR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_eite_ibor.gdx --target=20 --rebate=IBOR --metric=equal-p
gams scen r=mdl gdx=gdx\ele_eite_iber.gdx --target=20 --rebate=IBER --metric=equal-p


gams merge_ele_eite
Rscript ibr_ele_eite.R