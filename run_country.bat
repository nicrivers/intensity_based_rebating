if not exist lst\nul mkdir lst
if not exist gdx\nul mkdir gdx

del gdx\*.gdx

FOR %%r in (USA, CAN, ARG, ANZ, BRA, CHN, FRA, DEU, IND, IDN, ITA, JPN, MEX, RUS, SAU, ZAF, KOR, TUR, GBR) DO (

gams model --region=%%r --ds=rebate_11s_G20_3f
gams model s=mdl --region=%%r --run=yes --ds=rebate_11s_G20_3f

gams scen r=mdl gdx=gdx\%%r_lsr.gdx --target=20 --rebate=LSR --metric=equal-p
gams scen r=mdl gdx=gdx\%%r_obr.gdx --target=20 --rebate=OBR --metric=equal-p
gams scen r=mdl gdx=gdx\%%r_abr.gdx --target=20 --rebate=ABR --metric=equal-p
gams scen r=mdl gdx=gdx\%%r_ibor.gdx --target=20 --rebate=IBOR --metric=equal-p
gams scen r=mdl gdx=gdx\%%r_iber.gdx --target=20 --rebate=IBER --metric=equal-p

)

gams merge_country
Rscript ibr_country.R