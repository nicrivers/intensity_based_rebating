$call 'gdxmerge gdx\*.gdx id=macro,ibr,obr,bcr,abr'
$gdxin merged.gdx
parameter macro,ibr,obr,bcr,iber,abr ;
$load macro,ibr,obr,bcr,abr
display macro,ibr,obr,bcr,abr;

execute_unload 'pivotdata.gdx',macro;

execute 'gdxxrw i=pivotdata.gdx o=output_country.xlsx par=macro cdim=0'