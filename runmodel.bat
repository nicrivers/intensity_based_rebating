@echo off
if not exist lst\nul mkdir lst
if not exist gdx\nul mkdir gdx

if not "%1"=="" goto processor%1

sleep 1
start /HIGH runmodel 1
sleep 1
start /HIGH runmodel 2
sleep 1
start /HIGH runmodel 3
sleep 1
start /HIGH runmodel 4
goto :eof


:processor1
title Processor 1 (0%%)
gams scen r=mdl o=lst\1.lst gdx=gdx\1.gdx --target=10 --rebate=LSR --metric=equal-p
title Processor 1 (1%%)
gams scen r=mdl o=lst\2.lst gdx=gdx\2.gdx --target=10 --rebate=LSR --metric=equal-q
title Processor 1 (2%%)
gams scen r=mdl o=lst\3.lst gdx=gdx\3.gdx --target=10 --rebate=OBR --metric=equal-p
title Processor 1 (3%%)
gams scen r=mdl o=lst\4.lst gdx=gdx\4.gdx --target=10 --rebate=OBR --metric=equal-q
title Processor 1 (4%%)
gams scen r=mdl o=lst\5.lst gdx=gdx\5.gdx --target=10 --rebate=ABR --metric=equal-p
title Processor 1 (5%%)
gams scen r=mdl o=lst\6.lst gdx=gdx\6.gdx --target=10 --rebate=ABR --metric=equal-q
title Processor 1 (6%%)
gams scen r=mdl o=lst\7.lst gdx=gdx\7.gdx --target=10 --rebate=IBOR --metric=equal-p
title Processor 1 (7%%)
gams scen r=mdl o=lst\8.lst gdx=gdx\8.gdx --target=10 --rebate=IBOR --metric=equal-q
title Processor 1 (8%%)
gams scen r=mdl o=lst\9.lst gdx=gdx\9.gdx --target=10 --rebate=IBER --metric=equal-p
title Processor 1 (9%%)
gams scen r=mdl o=lst\10.lst gdx=gdx\10.gdx --target=10 --rebate=IBER --metric=equal-q
title Processor 1 (10%%)
gams scen r=mdl o=lst\11.lst gdx=gdx\11.gdx --target=11 --rebate=LSR --metric=equal-p
title Processor 1 (11%%)
gams scen r=mdl o=lst\12.lst gdx=gdx\12.gdx --target=11 --rebate=LSR --metric=equal-q
title Processor 1 (12%%)
gams scen r=mdl o=lst\13.lst gdx=gdx\13.gdx --target=11 --rebate=OBR --metric=equal-p
title Processor 1 (13%%)
gams scen r=mdl o=lst\14.lst gdx=gdx\14.gdx --target=11 --rebate=OBR --metric=equal-q
title Processor 1 (14%%)
gams scen r=mdl o=lst\15.lst gdx=gdx\15.gdx --target=11 --rebate=ABR --metric=equal-p
title Processor 1 (15%%)
gams scen r=mdl o=lst\16.lst gdx=gdx\16.gdx --target=11 --rebate=ABR --metric=equal-q
title Processor 1 (16%%)
gams scen r=mdl o=lst\17.lst gdx=gdx\17.gdx --target=11 --rebate=IBOR --metric=equal-p
title Processor 1 (17%%)
gams scen r=mdl o=lst\18.lst gdx=gdx\18.gdx --target=11 --rebate=IBOR --metric=equal-q
title Processor 1 (18%%)
gams scen r=mdl o=lst\19.lst gdx=gdx\19.gdx --target=11 --rebate=IBER --metric=equal-p
title Processor 1 (19%%)
gams scen r=mdl o=lst\20.lst gdx=gdx\20.gdx --target=11 --rebate=IBER --metric=equal-q
title Processor 1 (20%%)
gams scen r=mdl o=lst\21.lst gdx=gdx\21.gdx --target=12 --rebate=LSR --metric=equal-p
title Processor 1 (20%%)
gams scen r=mdl o=lst\22.lst gdx=gdx\22.gdx --target=12 --rebate=LSR --metric=equal-q
title Processor 1 (21%%)
gams scen r=mdl o=lst\23.lst gdx=gdx\23.gdx --target=12 --rebate=OBR --metric=equal-p
title Processor 1 (22%%)
gams scen r=mdl o=lst\24.lst gdx=gdx\24.gdx --target=12 --rebate=OBR --metric=equal-q
title Processor 1 (23%%)
gams scen r=mdl o=lst\25.lst gdx=gdx\25.gdx --target=12 --rebate=ABR --metric=equal-p
title Processor 1 (24%%)
gams scen r=mdl o=lst\26.lst gdx=gdx\26.gdx --target=12 --rebate=ABR --metric=equal-q
title Processor 1 (25%%)
gams scen r=mdl o=lst\27.lst gdx=gdx\27.gdx --target=12 --rebate=IBOR --metric=equal-p
title Processor 1 (26%%)
gams scen r=mdl o=lst\28.lst gdx=gdx\28.gdx --target=12 --rebate=IBOR --metric=equal-q
title Processor 1 (27%%)
gams scen r=mdl o=lst\29.lst gdx=gdx\29.gdx --target=12 --rebate=IBER --metric=equal-p
title Processor 1 (28%%)
gams scen r=mdl o=lst\30.lst gdx=gdx\30.gdx --target=12 --rebate=IBER --metric=equal-q
title Processor 1 (29%%)
gams scen r=mdl o=lst\31.lst gdx=gdx\31.gdx --target=13 --rebate=LSR --metric=equal-p
title Processor 1 (30%%)
gams scen r=mdl o=lst\32.lst gdx=gdx\32.gdx --target=13 --rebate=LSR --metric=equal-q
title Processor 1 (31%%)
gams scen r=mdl o=lst\33.lst gdx=gdx\33.gdx --target=13 --rebate=OBR --metric=equal-p
title Processor 1 (32%%)
gams scen r=mdl o=lst\34.lst gdx=gdx\34.gdx --target=13 --rebate=OBR --metric=equal-q
title Processor 1 (33%%)
gams scen r=mdl o=lst\35.lst gdx=gdx\35.gdx --target=13 --rebate=ABR --metric=equal-p
title Processor 1 (34%%)
gams scen r=mdl o=lst\36.lst gdx=gdx\36.gdx --target=13 --rebate=ABR --metric=equal-q
title Processor 1 (35%%)
gams scen r=mdl o=lst\37.lst gdx=gdx\37.gdx --target=13 --rebate=IBOR --metric=equal-p
title Processor 1 (36%%)
gams scen r=mdl o=lst\38.lst gdx=gdx\38.gdx --target=13 --rebate=IBOR --metric=equal-q
title Processor 1 (37%%)
gams scen r=mdl o=lst\39.lst gdx=gdx\39.gdx --target=13 --rebate=IBER --metric=equal-p
title Processor 1 (38%%)
gams scen r=mdl o=lst\40.lst gdx=gdx\40.gdx --target=13 --rebate=IBER --metric=equal-q
title Processor 1 (39%%)
gams scen r=mdl o=lst\41.lst gdx=gdx\41.gdx --target=14 --rebate=LSR --metric=equal-p
title Processor 1 (40%%)
gams scen r=mdl o=lst\42.lst gdx=gdx\42.gdx --target=14 --rebate=LSR --metric=equal-q
title Processor 1 (41%%)
gams scen r=mdl o=lst\43.lst gdx=gdx\43.gdx --target=14 --rebate=OBR --metric=equal-p
title Processor 1 (42%%)
gams scen r=mdl o=lst\44.lst gdx=gdx\44.gdx --target=14 --rebate=OBR --metric=equal-q
title Processor 1 (43%%)
gams scen r=mdl o=lst\45.lst gdx=gdx\45.gdx --target=14 --rebate=ABR --metric=equal-p
title Processor 1 (44%%)
gams scen r=mdl o=lst\46.lst gdx=gdx\46.gdx --target=14 --rebate=ABR --metric=equal-q
title Processor 1 (45%%)
gams scen r=mdl o=lst\47.lst gdx=gdx\47.gdx --target=14 --rebate=IBOR --metric=equal-p
title Processor 1 (46%%)
gams scen r=mdl o=lst\48.lst gdx=gdx\48.gdx --target=14 --rebate=IBOR --metric=equal-q
title Processor 1 (47%%)
gams scen r=mdl o=lst\49.lst gdx=gdx\49.gdx --target=14 --rebate=IBER --metric=equal-p
title Processor 1 (48%%)
gams scen r=mdl o=lst\50.lst gdx=gdx\50.gdx --target=14 --rebate=IBER --metric=equal-q
title Processor 1 (49%%)
gams scen r=mdl o=lst\51.lst gdx=gdx\51.gdx --target=15 --rebate=LSR --metric=equal-p
title Processor 1 (50%%)
gams scen r=mdl o=lst\52.lst gdx=gdx\52.gdx --target=15 --rebate=LSR --metric=equal-q
title Processor 1 (51%%)
gams scen r=mdl o=lst\53.lst gdx=gdx\53.gdx --target=15 --rebate=OBR --metric=equal-p
title Processor 1 (52%%)
gams scen r=mdl o=lst\54.lst gdx=gdx\54.gdx --target=15 --rebate=OBR --metric=equal-q
title Processor 1 (53%%)
gams scen r=mdl o=lst\55.lst gdx=gdx\55.gdx --target=15 --rebate=ABR --metric=equal-p
title Processor 1 (54%%)
gams scen r=mdl o=lst\56.lst gdx=gdx\56.gdx --target=15 --rebate=ABR --metric=equal-q
title Processor 1 (55%%)
gams scen r=mdl o=lst\57.lst gdx=gdx\57.gdx --target=15 --rebate=IBOR --metric=equal-p
title Processor 1 (56%%)
gams scen r=mdl o=lst\58.lst gdx=gdx\58.gdx --target=15 --rebate=IBOR --metric=equal-q
title Processor 1 (57%%)
gams scen r=mdl o=lst\59.lst gdx=gdx\59.gdx --target=15 --rebate=IBER --metric=equal-p
title Processor 1 (58%%)
gams scen r=mdl o=lst\60.lst gdx=gdx\60.gdx --target=15 --rebate=IBER --metric=equal-q
title Processor 1 (59%%)
gams scen r=mdl o=lst\61.lst gdx=gdx\61.gdx --target=16 --rebate=LSR --metric=equal-p
title Processor 1 (60%%)
gams scen r=mdl o=lst\62.lst gdx=gdx\62.gdx --target=16 --rebate=LSR --metric=equal-q
title Processor 1 (60%%)
gams scen r=mdl o=lst\63.lst gdx=gdx\63.gdx --target=16 --rebate=OBR --metric=equal-p
title Processor 1 (61%%)
gams scen r=mdl o=lst\64.lst gdx=gdx\64.gdx --target=16 --rebate=OBR --metric=equal-q
title Processor 1 (62%%)
gams scen r=mdl o=lst\65.lst gdx=gdx\65.gdx --target=16 --rebate=ABR --metric=equal-p
title Processor 1 (63%%)
gams scen r=mdl o=lst\66.lst gdx=gdx\66.gdx --target=16 --rebate=ABR --metric=equal-q
title Processor 1 (64%%)
gams scen r=mdl o=lst\67.lst gdx=gdx\67.gdx --target=16 --rebate=IBOR --metric=equal-p
title Processor 1 (65%%)
gams scen r=mdl o=lst\68.lst gdx=gdx\68.gdx --target=16 --rebate=IBOR --metric=equal-q
title Processor 1 (66%%)
gams scen r=mdl o=lst\69.lst gdx=gdx\69.gdx --target=16 --rebate=IBER --metric=equal-p
title Processor 1 (67%%)
gams scen r=mdl o=lst\70.lst gdx=gdx\70.gdx --target=16 --rebate=IBER --metric=equal-q
title Processor 1 (68%%)
gams scen r=mdl o=lst\71.lst gdx=gdx\71.gdx --target=17 --rebate=LSR --metric=equal-p
title Processor 1 (69%%)
gams scen r=mdl o=lst\72.lst gdx=gdx\72.gdx --target=17 --rebate=LSR --metric=equal-q
title Processor 1 (70%%)
gams scen r=mdl o=lst\73.lst gdx=gdx\73.gdx --target=17 --rebate=OBR --metric=equal-p
title Processor 1 (71%%)
gams scen r=mdl o=lst\74.lst gdx=gdx\74.gdx --target=17 --rebate=OBR --metric=equal-q
title Processor 1 (72%%)
gams scen r=mdl o=lst\75.lst gdx=gdx\75.gdx --target=17 --rebate=ABR --metric=equal-p
title Processor 1 (73%%)
gams scen r=mdl o=lst\76.lst gdx=gdx\76.gdx --target=17 --rebate=ABR --metric=equal-q
title Processor 1 (74%%)
gams scen r=mdl o=lst\77.lst gdx=gdx\77.gdx --target=17 --rebate=IBOR --metric=equal-p
title Processor 1 (75%%)
gams scen r=mdl o=lst\78.lst gdx=gdx\78.gdx --target=17 --rebate=IBOR --metric=equal-q
title Processor 1 (76%%)
gams scen r=mdl o=lst\79.lst gdx=gdx\79.gdx --target=17 --rebate=IBER --metric=equal-p
title Processor 1 (77%%)
gams scen r=mdl o=lst\80.lst gdx=gdx\80.gdx --target=17 --rebate=IBER --metric=equal-q
title Processor 1 (78%%)
gams scen r=mdl o=lst\81.lst gdx=gdx\81.gdx --target=18 --rebate=LSR --metric=equal-p
title Processor 1 (79%%)
gams scen r=mdl o=lst\82.lst gdx=gdx\82.gdx --target=18 --rebate=LSR --metric=equal-q
title Processor 1 (80%%)
gams scen r=mdl o=lst\83.lst gdx=gdx\83.gdx --target=18 --rebate=OBR --metric=equal-p
title Processor 1 (81%%)
gams scen r=mdl o=lst\84.lst gdx=gdx\84.gdx --target=18 --rebate=OBR --metric=equal-q
title Processor 1 (82%%)
gams scen r=mdl o=lst\85.lst gdx=gdx\85.gdx --target=18 --rebate=ABR --metric=equal-p
title Processor 1 (83%%)
gams scen r=mdl o=lst\86.lst gdx=gdx\86.gdx --target=18 --rebate=ABR --metric=equal-q
title Processor 1 (84%%)
gams scen r=mdl o=lst\87.lst gdx=gdx\87.gdx --target=18 --rebate=IBOR --metric=equal-p
title Processor 1 (85%%)
gams scen r=mdl o=lst\88.lst gdx=gdx\88.gdx --target=18 --rebate=IBOR --metric=equal-q
title Processor 1 (86%%)
gams scen r=mdl o=lst\89.lst gdx=gdx\89.gdx --target=18 --rebate=IBER --metric=equal-p
title Processor 1 (87%%)
gams scen r=mdl o=lst\90.lst gdx=gdx\90.gdx --target=18 --rebate=IBER --metric=equal-q
title Processor 1 (88%%)
gams scen r=mdl o=lst\91.lst gdx=gdx\91.gdx --target=19 --rebate=LSR --metric=equal-p
title Processor 1 (89%%)
gams scen r=mdl o=lst\92.lst gdx=gdx\92.gdx --target=19 --rebate=LSR --metric=equal-q
title Processor 1 (90%%)
gams scen r=mdl o=lst\93.lst gdx=gdx\93.gdx --target=19 --rebate=OBR --metric=equal-p
title Processor 1 (91%%)
gams scen r=mdl o=lst\94.lst gdx=gdx\94.gdx --target=19 --rebate=OBR --metric=equal-q
title Processor 1 (92%%)
gams scen r=mdl o=lst\95.lst gdx=gdx\95.gdx --target=19 --rebate=ABR --metric=equal-p
title Processor 1 (93%%)
gams scen r=mdl o=lst\96.lst gdx=gdx\96.gdx --target=19 --rebate=ABR --metric=equal-q
title Processor 1 (94%%)
gams scen r=mdl o=lst\97.lst gdx=gdx\97.gdx --target=19 --rebate=IBOR --metric=equal-p
title Processor 1 (95%%)
gams scen r=mdl o=lst\98.lst gdx=gdx\98.gdx --target=19 --rebate=IBOR --metric=equal-q
title Processor 1 (96%%)
gams scen r=mdl o=lst\99.lst gdx=gdx\99.gdx --target=19 --rebate=IBER --metric=equal-p
title Processor 1 (97%%)
gams scen r=mdl o=lst\100.lst gdx=gdx\100.gdx --target=19 --rebate=IBER --metric=equal-q
title Processor 1 (98%%)
gams scen r=mdl o=lst\101.lst gdx=gdx\101.gdx --target=20 --rebate=LSR --metric=equal-p
title Processor 1 (99%%)
gams scen r=mdl o=lst\102.lst gdx=gdx\102.gdx --target=20 --rebate=LSR --metric=equal-q
title Processor 1 (100%%)
goto :eof


:processor2
title Processor 2 (0%%)
gams scen r=mdl o=lst\103.lst gdx=gdx\103.gdx --target=20 --rebate=OBR --metric=equal-p
title Processor 2 (1%%)
gams scen r=mdl o=lst\104.lst gdx=gdx\104.gdx --target=20 --rebate=OBR --metric=equal-q
title Processor 2 (2%%)
gams scen r=mdl o=lst\105.lst gdx=gdx\105.gdx --target=20 --rebate=ABR --metric=equal-p
title Processor 2 (3%%)
gams scen r=mdl o=lst\106.lst gdx=gdx\106.gdx --target=20 --rebate=ABR --metric=equal-q
title Processor 2 (4%%)
gams scen r=mdl o=lst\107.lst gdx=gdx\107.gdx --target=20 --rebate=IBOR --metric=equal-p
title Processor 2 (5%%)
gams scen r=mdl o=lst\108.lst gdx=gdx\108.gdx --target=20 --rebate=IBOR --metric=equal-q
title Processor 2 (6%%)
gams scen r=mdl o=lst\109.lst gdx=gdx\109.gdx --target=20 --rebate=IBER --metric=equal-p
title Processor 2 (7%%)
gams scen r=mdl o=lst\110.lst gdx=gdx\110.gdx --target=20 --rebate=IBER --metric=equal-q
title Processor 2 (8%%)
gams scen r=mdl o=lst\111.lst gdx=gdx\111.gdx --target=21 --rebate=LSR --metric=equal-p
title Processor 2 (9%%)
gams scen r=mdl o=lst\112.lst gdx=gdx\112.gdx --target=21 --rebate=LSR --metric=equal-q
title Processor 2 (10%%)
gams scen r=mdl o=lst\113.lst gdx=gdx\113.gdx --target=21 --rebate=OBR --metric=equal-p
title Processor 2 (11%%)
gams scen r=mdl o=lst\114.lst gdx=gdx\114.gdx --target=21 --rebate=OBR --metric=equal-q
title Processor 2 (12%%)
gams scen r=mdl o=lst\115.lst gdx=gdx\115.gdx --target=21 --rebate=ABR --metric=equal-p
title Processor 2 (13%%)
gams scen r=mdl o=lst\116.lst gdx=gdx\116.gdx --target=21 --rebate=ABR --metric=equal-q
title Processor 2 (14%%)
gams scen r=mdl o=lst\117.lst gdx=gdx\117.gdx --target=21 --rebate=IBOR --metric=equal-p
title Processor 2 (15%%)
gams scen r=mdl o=lst\118.lst gdx=gdx\118.gdx --target=21 --rebate=IBOR --metric=equal-q
title Processor 2 (16%%)
gams scen r=mdl o=lst\119.lst gdx=gdx\119.gdx --target=21 --rebate=IBER --metric=equal-p
title Processor 2 (17%%)
gams scen r=mdl o=lst\120.lst gdx=gdx\120.gdx --target=21 --rebate=IBER --metric=equal-q
title Processor 2 (18%%)
gams scen r=mdl o=lst\121.lst gdx=gdx\121.gdx --target=22 --rebate=LSR --metric=equal-p
title Processor 2 (19%%)
gams scen r=mdl o=lst\122.lst gdx=gdx\122.gdx --target=22 --rebate=LSR --metric=equal-q
title Processor 2 (20%%)
gams scen r=mdl o=lst\123.lst gdx=gdx\123.gdx --target=22 --rebate=OBR --metric=equal-p
title Processor 2 (20%%)
gams scen r=mdl o=lst\124.lst gdx=gdx\124.gdx --target=22 --rebate=OBR --metric=equal-q
title Processor 2 (21%%)
gams scen r=mdl o=lst\125.lst gdx=gdx\125.gdx --target=22 --rebate=ABR --metric=equal-p
title Processor 2 (22%%)
gams scen r=mdl o=lst\126.lst gdx=gdx\126.gdx --target=22 --rebate=ABR --metric=equal-q
title Processor 2 (23%%)
gams scen r=mdl o=lst\127.lst gdx=gdx\127.gdx --target=22 --rebate=IBOR --metric=equal-p
title Processor 2 (24%%)
gams scen r=mdl o=lst\128.lst gdx=gdx\128.gdx --target=22 --rebate=IBOR --metric=equal-q
title Processor 2 (25%%)
gams scen r=mdl o=lst\129.lst gdx=gdx\129.gdx --target=22 --rebate=IBER --metric=equal-p
title Processor 2 (26%%)
gams scen r=mdl o=lst\130.lst gdx=gdx\130.gdx --target=22 --rebate=IBER --metric=equal-q
title Processor 2 (27%%)
gams scen r=mdl o=lst\131.lst gdx=gdx\131.gdx --target=23 --rebate=LSR --metric=equal-p
title Processor 2 (28%%)
gams scen r=mdl o=lst\132.lst gdx=gdx\132.gdx --target=23 --rebate=LSR --metric=equal-q
title Processor 2 (29%%)
gams scen r=mdl o=lst\133.lst gdx=gdx\133.gdx --target=23 --rebate=OBR --metric=equal-p
title Processor 2 (30%%)
gams scen r=mdl o=lst\134.lst gdx=gdx\134.gdx --target=23 --rebate=OBR --metric=equal-q
title Processor 2 (31%%)
gams scen r=mdl o=lst\135.lst gdx=gdx\135.gdx --target=23 --rebate=ABR --metric=equal-p
title Processor 2 (32%%)
gams scen r=mdl o=lst\136.lst gdx=gdx\136.gdx --target=23 --rebate=ABR --metric=equal-q
title Processor 2 (33%%)
gams scen r=mdl o=lst\137.lst gdx=gdx\137.gdx --target=23 --rebate=IBOR --metric=equal-p
title Processor 2 (34%%)
gams scen r=mdl o=lst\138.lst gdx=gdx\138.gdx --target=23 --rebate=IBOR --metric=equal-q
title Processor 2 (35%%)
gams scen r=mdl o=lst\139.lst gdx=gdx\139.gdx --target=23 --rebate=IBER --metric=equal-p
title Processor 2 (36%%)
gams scen r=mdl o=lst\140.lst gdx=gdx\140.gdx --target=23 --rebate=IBER --metric=equal-q
title Processor 2 (37%%)
gams scen r=mdl o=lst\141.lst gdx=gdx\141.gdx --target=24 --rebate=LSR --metric=equal-p
title Processor 2 (38%%)
gams scen r=mdl o=lst\142.lst gdx=gdx\142.gdx --target=24 --rebate=LSR --metric=equal-q
title Processor 2 (39%%)
gams scen r=mdl o=lst\143.lst gdx=gdx\143.gdx --target=24 --rebate=OBR --metric=equal-p
title Processor 2 (40%%)
gams scen r=mdl o=lst\144.lst gdx=gdx\144.gdx --target=24 --rebate=OBR --metric=equal-q
title Processor 2 (41%%)
gams scen r=mdl o=lst\145.lst gdx=gdx\145.gdx --target=24 --rebate=ABR --metric=equal-p
title Processor 2 (42%%)
gams scen r=mdl o=lst\146.lst gdx=gdx\146.gdx --target=24 --rebate=ABR --metric=equal-q
title Processor 2 (43%%)
gams scen r=mdl o=lst\147.lst gdx=gdx\147.gdx --target=24 --rebate=IBOR --metric=equal-p
title Processor 2 (44%%)
gams scen r=mdl o=lst\148.lst gdx=gdx\148.gdx --target=24 --rebate=IBOR --metric=equal-q
title Processor 2 (45%%)
gams scen r=mdl o=lst\149.lst gdx=gdx\149.gdx --target=24 --rebate=IBER --metric=equal-p
title Processor 2 (46%%)
gams scen r=mdl o=lst\150.lst gdx=gdx\150.gdx --target=24 --rebate=IBER --metric=equal-q
title Processor 2 (47%%)
gams scen r=mdl o=lst\151.lst gdx=gdx\151.gdx --target=25 --rebate=LSR --metric=equal-p
title Processor 2 (48%%)
gams scen r=mdl o=lst\152.lst gdx=gdx\152.gdx --target=25 --rebate=LSR --metric=equal-q
title Processor 2 (49%%)
gams scen r=mdl o=lst\153.lst gdx=gdx\153.gdx --target=25 --rebate=OBR --metric=equal-p
title Processor 2 (50%%)
gams scen r=mdl o=lst\154.lst gdx=gdx\154.gdx --target=25 --rebate=OBR --metric=equal-q
title Processor 2 (51%%)
gams scen r=mdl o=lst\155.lst gdx=gdx\155.gdx --target=25 --rebate=ABR --metric=equal-p
title Processor 2 (52%%)
gams scen r=mdl o=lst\156.lst gdx=gdx\156.gdx --target=25 --rebate=ABR --metric=equal-q
title Processor 2 (53%%)
gams scen r=mdl o=lst\157.lst gdx=gdx\157.gdx --target=25 --rebate=IBOR --metric=equal-p
title Processor 2 (54%%)
gams scen r=mdl o=lst\158.lst gdx=gdx\158.gdx --target=25 --rebate=IBOR --metric=equal-q
title Processor 2 (55%%)
gams scen r=mdl o=lst\159.lst gdx=gdx\159.gdx --target=25 --rebate=IBER --metric=equal-p
title Processor 2 (56%%)
gams scen r=mdl o=lst\160.lst gdx=gdx\160.gdx --target=25 --rebate=IBER --metric=equal-q
title Processor 2 (57%%)
gams scen r=mdl o=lst\161.lst gdx=gdx\161.gdx --target=26 --rebate=LSR --metric=equal-p
title Processor 2 (58%%)
gams scen r=mdl o=lst\162.lst gdx=gdx\162.gdx --target=26 --rebate=LSR --metric=equal-q
title Processor 2 (59%%)
gams scen r=mdl o=lst\163.lst gdx=gdx\163.gdx --target=26 --rebate=OBR --metric=equal-p
title Processor 2 (60%%)
gams scen r=mdl o=lst\164.lst gdx=gdx\164.gdx --target=26 --rebate=OBR --metric=equal-q
title Processor 2 (60%%)
gams scen r=mdl o=lst\165.lst gdx=gdx\165.gdx --target=26 --rebate=ABR --metric=equal-p
title Processor 2 (61%%)
gams scen r=mdl o=lst\166.lst gdx=gdx\166.gdx --target=26 --rebate=ABR --metric=equal-q
title Processor 2 (62%%)
gams scen r=mdl o=lst\167.lst gdx=gdx\167.gdx --target=26 --rebate=IBOR --metric=equal-p
title Processor 2 (63%%)
gams scen r=mdl o=lst\168.lst gdx=gdx\168.gdx --target=26 --rebate=IBOR --metric=equal-q
title Processor 2 (64%%)
gams scen r=mdl o=lst\169.lst gdx=gdx\169.gdx --target=26 --rebate=IBER --metric=equal-p
title Processor 2 (65%%)
gams scen r=mdl o=lst\170.lst gdx=gdx\170.gdx --target=26 --rebate=IBER --metric=equal-q
title Processor 2 (66%%)
gams scen r=mdl o=lst\171.lst gdx=gdx\171.gdx --target=27 --rebate=LSR --metric=equal-p
title Processor 2 (67%%)
gams scen r=mdl o=lst\172.lst gdx=gdx\172.gdx --target=27 --rebate=LSR --metric=equal-q
title Processor 2 (68%%)
gams scen r=mdl o=lst\173.lst gdx=gdx\173.gdx --target=27 --rebate=OBR --metric=equal-p
title Processor 2 (69%%)
gams scen r=mdl o=lst\174.lst gdx=gdx\174.gdx --target=27 --rebate=OBR --metric=equal-q
title Processor 2 (70%%)
gams scen r=mdl o=lst\175.lst gdx=gdx\175.gdx --target=27 --rebate=ABR --metric=equal-p
title Processor 2 (71%%)
gams scen r=mdl o=lst\176.lst gdx=gdx\176.gdx --target=27 --rebate=ABR --metric=equal-q
title Processor 2 (72%%)
gams scen r=mdl o=lst\177.lst gdx=gdx\177.gdx --target=27 --rebate=IBOR --metric=equal-p
title Processor 2 (73%%)
gams scen r=mdl o=lst\178.lst gdx=gdx\178.gdx --target=27 --rebate=IBOR --metric=equal-q
title Processor 2 (74%%)
gams scen r=mdl o=lst\179.lst gdx=gdx\179.gdx --target=27 --rebate=IBER --metric=equal-p
title Processor 2 (75%%)
gams scen r=mdl o=lst\180.lst gdx=gdx\180.gdx --target=27 --rebate=IBER --metric=equal-q
title Processor 2 (76%%)
gams scen r=mdl o=lst\181.lst gdx=gdx\181.gdx --target=28 --rebate=LSR --metric=equal-p
title Processor 2 (77%%)
gams scen r=mdl o=lst\182.lst gdx=gdx\182.gdx --target=28 --rebate=LSR --metric=equal-q
title Processor 2 (78%%)
gams scen r=mdl o=lst\183.lst gdx=gdx\183.gdx --target=28 --rebate=OBR --metric=equal-p
title Processor 2 (79%%)
gams scen r=mdl o=lst\184.lst gdx=gdx\184.gdx --target=28 --rebate=OBR --metric=equal-q
title Processor 2 (80%%)
gams scen r=mdl o=lst\185.lst gdx=gdx\185.gdx --target=28 --rebate=ABR --metric=equal-p
title Processor 2 (81%%)
gams scen r=mdl o=lst\186.lst gdx=gdx\186.gdx --target=28 --rebate=ABR --metric=equal-q
title Processor 2 (82%%)
gams scen r=mdl o=lst\187.lst gdx=gdx\187.gdx --target=28 --rebate=IBOR --metric=equal-p
title Processor 2 (83%%)
gams scen r=mdl o=lst\188.lst gdx=gdx\188.gdx --target=28 --rebate=IBOR --metric=equal-q
title Processor 2 (84%%)
gams scen r=mdl o=lst\189.lst gdx=gdx\189.gdx --target=28 --rebate=IBER --metric=equal-p
title Processor 2 (85%%)
gams scen r=mdl o=lst\190.lst gdx=gdx\190.gdx --target=28 --rebate=IBER --metric=equal-q
title Processor 2 (86%%)
gams scen r=mdl o=lst\191.lst gdx=gdx\191.gdx --target=29 --rebate=LSR --metric=equal-p
title Processor 2 (87%%)
gams scen r=mdl o=lst\192.lst gdx=gdx\192.gdx --target=29 --rebate=LSR --metric=equal-q
title Processor 2 (88%%)
gams scen r=mdl o=lst\193.lst gdx=gdx\193.gdx --target=29 --rebate=OBR --metric=equal-p
title Processor 2 (89%%)
gams scen r=mdl o=lst\194.lst gdx=gdx\194.gdx --target=29 --rebate=OBR --metric=equal-q
title Processor 2 (90%%)
gams scen r=mdl o=lst\195.lst gdx=gdx\195.gdx --target=29 --rebate=ABR --metric=equal-p
title Processor 2 (91%%)
gams scen r=mdl o=lst\196.lst gdx=gdx\196.gdx --target=29 --rebate=ABR --metric=equal-q
title Processor 2 (92%%)
gams scen r=mdl o=lst\197.lst gdx=gdx\197.gdx --target=29 --rebate=IBOR --metric=equal-p
title Processor 2 (93%%)
gams scen r=mdl o=lst\198.lst gdx=gdx\198.gdx --target=29 --rebate=IBOR --metric=equal-q
title Processor 2 (94%%)
gams scen r=mdl o=lst\199.lst gdx=gdx\199.gdx --target=29 --rebate=IBER --metric=equal-p
title Processor 2 (95%%)
gams scen r=mdl o=lst\200.lst gdx=gdx\200.gdx --target=29 --rebate=IBER --metric=equal-q
title Processor 2 (96%%)
gams scen r=mdl o=lst\201.lst gdx=gdx\201.gdx --target=30 --rebate=LSR --metric=equal-p
title Processor 2 (97%%)
gams scen r=mdl o=lst\202.lst gdx=gdx\202.gdx --target=30 --rebate=LSR --metric=equal-q
title Processor 2 (98%%)
gams scen r=mdl o=lst\203.lst gdx=gdx\203.gdx --target=30 --rebate=OBR --metric=equal-p
title Processor 2 (99%%)
gams scen r=mdl o=lst\204.lst gdx=gdx\204.gdx --target=30 --rebate=OBR --metric=equal-q
title Processor 2 (100%%)
gams scen r=mdl o=lst\205.lst gdx=gdx\205.gdx --target=30 --rebate=ABR --metric=equal-p
title Processor 2 (100%%)
goto :eof


:processor3
title Processor 3 (0%%)
gams scen r=mdl o=lst\206.lst gdx=gdx\206.gdx --target=30 --rebate=ABR --metric=equal-q
title Processor 3 (1%%)
gams scen r=mdl o=lst\207.lst gdx=gdx\207.gdx --target=30 --rebate=IBOR --metric=equal-p
title Processor 3 (2%%)
gams scen r=mdl o=lst\208.lst gdx=gdx\208.gdx --target=30 --rebate=IBOR --metric=equal-q
title Processor 3 (3%%)
gams scen r=mdl o=lst\209.lst gdx=gdx\209.gdx --target=30 --rebate=IBER --metric=equal-p
title Processor 3 (4%%)
gams scen r=mdl o=lst\210.lst gdx=gdx\210.gdx --target=30 --rebate=IBER --metric=equal-q
title Processor 3 (5%%)
gams scen r=mdl o=lst\211.lst gdx=gdx\211.gdx --target=31 --rebate=LSR --metric=equal-p
title Processor 3 (6%%)
gams scen r=mdl o=lst\212.lst gdx=gdx\212.gdx --target=31 --rebate=LSR --metric=equal-q
title Processor 3 (7%%)
gams scen r=mdl o=lst\213.lst gdx=gdx\213.gdx --target=31 --rebate=OBR --metric=equal-p
title Processor 3 (8%%)
gams scen r=mdl o=lst\214.lst gdx=gdx\214.gdx --target=31 --rebate=OBR --metric=equal-q
title Processor 3 (9%%)
gams scen r=mdl o=lst\215.lst gdx=gdx\215.gdx --target=31 --rebate=ABR --metric=equal-p
title Processor 3 (10%%)
gams scen r=mdl o=lst\216.lst gdx=gdx\216.gdx --target=31 --rebate=ABR --metric=equal-q
title Processor 3 (11%%)
gams scen r=mdl o=lst\217.lst gdx=gdx\217.gdx --target=31 --rebate=IBOR --metric=equal-p
title Processor 3 (12%%)
gams scen r=mdl o=lst\218.lst gdx=gdx\218.gdx --target=31 --rebate=IBOR --metric=equal-q
title Processor 3 (13%%)
gams scen r=mdl o=lst\219.lst gdx=gdx\219.gdx --target=31 --rebate=IBER --metric=equal-p
title Processor 3 (14%%)
gams scen r=mdl o=lst\220.lst gdx=gdx\220.gdx --target=31 --rebate=IBER --metric=equal-q
title Processor 3 (15%%)
gams scen r=mdl o=lst\221.lst gdx=gdx\221.gdx --target=32 --rebate=LSR --metric=equal-p
title Processor 3 (16%%)
gams scen r=mdl o=lst\222.lst gdx=gdx\222.gdx --target=32 --rebate=LSR --metric=equal-q
title Processor 3 (17%%)
gams scen r=mdl o=lst\223.lst gdx=gdx\223.gdx --target=32 --rebate=OBR --metric=equal-p
title Processor 3 (18%%)
gams scen r=mdl o=lst\224.lst gdx=gdx\224.gdx --target=32 --rebate=OBR --metric=equal-q
title Processor 3 (19%%)
gams scen r=mdl o=lst\225.lst gdx=gdx\225.gdx --target=32 --rebate=ABR --metric=equal-p
title Processor 3 (20%%)
gams scen r=mdl o=lst\226.lst gdx=gdx\226.gdx --target=32 --rebate=ABR --metric=equal-q
title Processor 3 (20%%)
gams scen r=mdl o=lst\227.lst gdx=gdx\227.gdx --target=32 --rebate=IBOR --metric=equal-p
title Processor 3 (21%%)
gams scen r=mdl o=lst\228.lst gdx=gdx\228.gdx --target=32 --rebate=IBOR --metric=equal-q
title Processor 3 (22%%)
gams scen r=mdl o=lst\229.lst gdx=gdx\229.gdx --target=32 --rebate=IBER --metric=equal-p
title Processor 3 (23%%)
gams scen r=mdl o=lst\230.lst gdx=gdx\230.gdx --target=32 --rebate=IBER --metric=equal-q
title Processor 3 (24%%)
gams scen r=mdl o=lst\231.lst gdx=gdx\231.gdx --target=33 --rebate=LSR --metric=equal-p
title Processor 3 (25%%)
gams scen r=mdl o=lst\232.lst gdx=gdx\232.gdx --target=33 --rebate=LSR --metric=equal-q
title Processor 3 (26%%)
gams scen r=mdl o=lst\233.lst gdx=gdx\233.gdx --target=33 --rebate=OBR --metric=equal-p
title Processor 3 (27%%)
gams scen r=mdl o=lst\234.lst gdx=gdx\234.gdx --target=33 --rebate=OBR --metric=equal-q
title Processor 3 (28%%)
gams scen r=mdl o=lst\235.lst gdx=gdx\235.gdx --target=33 --rebate=ABR --metric=equal-p
title Processor 3 (29%%)
gams scen r=mdl o=lst\236.lst gdx=gdx\236.gdx --target=33 --rebate=ABR --metric=equal-q
title Processor 3 (30%%)
gams scen r=mdl o=lst\237.lst gdx=gdx\237.gdx --target=33 --rebate=IBOR --metric=equal-p
title Processor 3 (31%%)
gams scen r=mdl o=lst\238.lst gdx=gdx\238.gdx --target=33 --rebate=IBOR --metric=equal-q
title Processor 3 (32%%)
gams scen r=mdl o=lst\239.lst gdx=gdx\239.gdx --target=33 --rebate=IBER --metric=equal-p
title Processor 3 (33%%)
gams scen r=mdl o=lst\240.lst gdx=gdx\240.gdx --target=33 --rebate=IBER --metric=equal-q
title Processor 3 (34%%)
gams scen r=mdl o=lst\241.lst gdx=gdx\241.gdx --target=34 --rebate=LSR --metric=equal-p
title Processor 3 (35%%)
gams scen r=mdl o=lst\242.lst gdx=gdx\242.gdx --target=34 --rebate=LSR --metric=equal-q
title Processor 3 (36%%)
gams scen r=mdl o=lst\243.lst gdx=gdx\243.gdx --target=34 --rebate=OBR --metric=equal-p
title Processor 3 (37%%)
gams scen r=mdl o=lst\244.lst gdx=gdx\244.gdx --target=34 --rebate=OBR --metric=equal-q
title Processor 3 (38%%)
gams scen r=mdl o=lst\245.lst gdx=gdx\245.gdx --target=34 --rebate=ABR --metric=equal-p
title Processor 3 (39%%)
gams scen r=mdl o=lst\246.lst gdx=gdx\246.gdx --target=34 --rebate=ABR --metric=equal-q
title Processor 3 (40%%)
gams scen r=mdl o=lst\247.lst gdx=gdx\247.gdx --target=34 --rebate=IBOR --metric=equal-p
title Processor 3 (41%%)
gams scen r=mdl o=lst\248.lst gdx=gdx\248.gdx --target=34 --rebate=IBOR --metric=equal-q
title Processor 3 (42%%)
gams scen r=mdl o=lst\249.lst gdx=gdx\249.gdx --target=34 --rebate=IBER --metric=equal-p
title Processor 3 (43%%)
gams scen r=mdl o=lst\250.lst gdx=gdx\250.gdx --target=34 --rebate=IBER --metric=equal-q
title Processor 3 (44%%)
gams scen r=mdl o=lst\251.lst gdx=gdx\251.gdx --target=35 --rebate=LSR --metric=equal-p
title Processor 3 (45%%)
gams scen r=mdl o=lst\252.lst gdx=gdx\252.gdx --target=35 --rebate=LSR --metric=equal-q
title Processor 3 (46%%)
gams scen r=mdl o=lst\253.lst gdx=gdx\253.gdx --target=35 --rebate=OBR --metric=equal-p
title Processor 3 (47%%)
gams scen r=mdl o=lst\254.lst gdx=gdx\254.gdx --target=35 --rebate=OBR --metric=equal-q
title Processor 3 (48%%)
gams scen r=mdl o=lst\255.lst gdx=gdx\255.gdx --target=35 --rebate=ABR --metric=equal-p
title Processor 3 (49%%)
gams scen r=mdl o=lst\256.lst gdx=gdx\256.gdx --target=35 --rebate=ABR --metric=equal-q
title Processor 3 (50%%)
gams scen r=mdl o=lst\257.lst gdx=gdx\257.gdx --target=35 --rebate=IBOR --metric=equal-p
title Processor 3 (51%%)
gams scen r=mdl o=lst\258.lst gdx=gdx\258.gdx --target=35 --rebate=IBOR --metric=equal-q
title Processor 3 (52%%)
gams scen r=mdl o=lst\259.lst gdx=gdx\259.gdx --target=35 --rebate=IBER --metric=equal-p
title Processor 3 (53%%)
gams scen r=mdl o=lst\260.lst gdx=gdx\260.gdx --target=35 --rebate=IBER --metric=equal-q
title Processor 3 (54%%)
gams scen r=mdl o=lst\261.lst gdx=gdx\261.gdx --target=36 --rebate=LSR --metric=equal-p
title Processor 3 (55%%)
gams scen r=mdl o=lst\262.lst gdx=gdx\262.gdx --target=36 --rebate=LSR --metric=equal-q
title Processor 3 (56%%)
gams scen r=mdl o=lst\263.lst gdx=gdx\263.gdx --target=36 --rebate=OBR --metric=equal-p
title Processor 3 (57%%)
gams scen r=mdl o=lst\264.lst gdx=gdx\264.gdx --target=36 --rebate=OBR --metric=equal-q
title Processor 3 (58%%)
gams scen r=mdl o=lst\265.lst gdx=gdx\265.gdx --target=36 --rebate=ABR --metric=equal-p
title Processor 3 (59%%)
gams scen r=mdl o=lst\266.lst gdx=gdx\266.gdx --target=36 --rebate=ABR --metric=equal-q
title Processor 3 (60%%)
gams scen r=mdl o=lst\267.lst gdx=gdx\267.gdx --target=36 --rebate=IBOR --metric=equal-p
title Processor 3 (60%%)
gams scen r=mdl o=lst\268.lst gdx=gdx\268.gdx --target=36 --rebate=IBOR --metric=equal-q
title Processor 3 (61%%)
gams scen r=mdl o=lst\269.lst gdx=gdx\269.gdx --target=36 --rebate=IBER --metric=equal-p
title Processor 3 (62%%)
gams scen r=mdl o=lst\270.lst gdx=gdx\270.gdx --target=36 --rebate=IBER --metric=equal-q
title Processor 3 (63%%)
gams scen r=mdl o=lst\271.lst gdx=gdx\271.gdx --target=37 --rebate=LSR --metric=equal-p
title Processor 3 (64%%)
gams scen r=mdl o=lst\272.lst gdx=gdx\272.gdx --target=37 --rebate=LSR --metric=equal-q
title Processor 3 (65%%)
gams scen r=mdl o=lst\273.lst gdx=gdx\273.gdx --target=37 --rebate=OBR --metric=equal-p
title Processor 3 (66%%)
gams scen r=mdl o=lst\274.lst gdx=gdx\274.gdx --target=37 --rebate=OBR --metric=equal-q
title Processor 3 (67%%)
gams scen r=mdl o=lst\275.lst gdx=gdx\275.gdx --target=37 --rebate=ABR --metric=equal-p
title Processor 3 (68%%)
gams scen r=mdl o=lst\276.lst gdx=gdx\276.gdx --target=37 --rebate=ABR --metric=equal-q
title Processor 3 (69%%)
gams scen r=mdl o=lst\277.lst gdx=gdx\277.gdx --target=37 --rebate=IBOR --metric=equal-p
title Processor 3 (70%%)
gams scen r=mdl o=lst\278.lst gdx=gdx\278.gdx --target=37 --rebate=IBOR --metric=equal-q
title Processor 3 (71%%)
gams scen r=mdl o=lst\279.lst gdx=gdx\279.gdx --target=37 --rebate=IBER --metric=equal-p
title Processor 3 (72%%)
gams scen r=mdl o=lst\280.lst gdx=gdx\280.gdx --target=37 --rebate=IBER --metric=equal-q
title Processor 3 (73%%)
gams scen r=mdl o=lst\281.lst gdx=gdx\281.gdx --target=38 --rebate=LSR --metric=equal-p
title Processor 3 (74%%)
gams scen r=mdl o=lst\282.lst gdx=gdx\282.gdx --target=38 --rebate=LSR --metric=equal-q
title Processor 3 (75%%)
gams scen r=mdl o=lst\283.lst gdx=gdx\283.gdx --target=38 --rebate=OBR --metric=equal-p
title Processor 3 (76%%)
gams scen r=mdl o=lst\284.lst gdx=gdx\284.gdx --target=38 --rebate=OBR --metric=equal-q
title Processor 3 (77%%)
gams scen r=mdl o=lst\285.lst gdx=gdx\285.gdx --target=38 --rebate=ABR --metric=equal-p
title Processor 3 (78%%)
gams scen r=mdl o=lst\286.lst gdx=gdx\286.gdx --target=38 --rebate=ABR --metric=equal-q
title Processor 3 (79%%)
gams scen r=mdl o=lst\287.lst gdx=gdx\287.gdx --target=38 --rebate=IBOR --metric=equal-p
title Processor 3 (80%%)
gams scen r=mdl o=lst\288.lst gdx=gdx\288.gdx --target=38 --rebate=IBOR --metric=equal-q
title Processor 3 (81%%)
gams scen r=mdl o=lst\289.lst gdx=gdx\289.gdx --target=38 --rebate=IBER --metric=equal-p
title Processor 3 (82%%)
gams scen r=mdl o=lst\290.lst gdx=gdx\290.gdx --target=38 --rebate=IBER --metric=equal-q
title Processor 3 (83%%)
gams scen r=mdl o=lst\291.lst gdx=gdx\291.gdx --target=39 --rebate=LSR --metric=equal-p
title Processor 3 (84%%)
gams scen r=mdl o=lst\292.lst gdx=gdx\292.gdx --target=39 --rebate=LSR --metric=equal-q
title Processor 3 (85%%)
gams scen r=mdl o=lst\293.lst gdx=gdx\293.gdx --target=39 --rebate=OBR --metric=equal-p
title Processor 3 (86%%)
gams scen r=mdl o=lst\294.lst gdx=gdx\294.gdx --target=39 --rebate=OBR --metric=equal-q
title Processor 3 (87%%)
gams scen r=mdl o=lst\295.lst gdx=gdx\295.gdx --target=39 --rebate=ABR --metric=equal-p
title Processor 3 (88%%)
gams scen r=mdl o=lst\296.lst gdx=gdx\296.gdx --target=39 --rebate=ABR --metric=equal-q
title Processor 3 (89%%)
gams scen r=mdl o=lst\297.lst gdx=gdx\297.gdx --target=39 --rebate=IBOR --metric=equal-p
title Processor 3 (90%%)
gams scen r=mdl o=lst\298.lst gdx=gdx\298.gdx --target=39 --rebate=IBOR --metric=equal-q
title Processor 3 (91%%)
gams scen r=mdl o=lst\299.lst gdx=gdx\299.gdx --target=39 --rebate=IBER --metric=equal-p
title Processor 3 (92%%)
gams scen r=mdl o=lst\300.lst gdx=gdx\300.gdx --target=39 --rebate=IBER --metric=equal-q
title Processor 3 (93%%)
gams scen r=mdl o=lst\301.lst gdx=gdx\301.gdx --target=40 --rebate=LSR --metric=equal-p
title Processor 3 (94%%)
gams scen r=mdl o=lst\302.lst gdx=gdx\302.gdx --target=40 --rebate=LSR --metric=equal-q
title Processor 3 (95%%)
gams scen r=mdl o=lst\303.lst gdx=gdx\303.gdx --target=40 --rebate=OBR --metric=equal-p
title Processor 3 (96%%)
gams scen r=mdl o=lst\304.lst gdx=gdx\304.gdx --target=40 --rebate=OBR --metric=equal-q
title Processor 3 (97%%)
gams scen r=mdl o=lst\305.lst gdx=gdx\305.gdx --target=40 --rebate=ABR --metric=equal-p
title Processor 3 (98%%)
gams scen r=mdl o=lst\306.lst gdx=gdx\306.gdx --target=40 --rebate=ABR --metric=equal-q
title Processor 3 (99%%)
gams scen r=mdl o=lst\307.lst gdx=gdx\307.gdx --target=40 --rebate=IBOR --metric=equal-p
title Processor 3 (100%%)
goto :eof


:processor4
title Processor 4 (0%%)
gams scen r=mdl o=lst\308.lst gdx=gdx\308.gdx --target=40 --rebate=IBOR --metric=equal-q
title Processor 4 (1%%)
gams scen r=mdl o=lst\309.lst gdx=gdx\309.gdx --target=40 --rebate=IBER --metric=equal-p
title Processor 4 (2%%)
gams scen r=mdl o=lst\310.lst gdx=gdx\310.gdx --target=40 --rebate=IBER --metric=equal-q
title Processor 4 (3%%)
gams scen r=mdl o=lst\311.lst gdx=gdx\311.gdx --target=41 --rebate=LSR --metric=equal-p
title Processor 4 (4%%)
gams scen r=mdl o=lst\312.lst gdx=gdx\312.gdx --target=41 --rebate=LSR --metric=equal-q
title Processor 4 (5%%)
gams scen r=mdl o=lst\313.lst gdx=gdx\313.gdx --target=41 --rebate=OBR --metric=equal-p
title Processor 4 (6%%)
gams scen r=mdl o=lst\314.lst gdx=gdx\314.gdx --target=41 --rebate=OBR --metric=equal-q
title Processor 4 (7%%)
gams scen r=mdl o=lst\315.lst gdx=gdx\315.gdx --target=41 --rebate=ABR --metric=equal-p
title Processor 4 (8%%)
gams scen r=mdl o=lst\316.lst gdx=gdx\316.gdx --target=41 --rebate=ABR --metric=equal-q
title Processor 4 (9%%)
gams scen r=mdl o=lst\317.lst gdx=gdx\317.gdx --target=41 --rebate=IBOR --metric=equal-p
title Processor 4 (10%%)
gams scen r=mdl o=lst\318.lst gdx=gdx\318.gdx --target=41 --rebate=IBOR --metric=equal-q
title Processor 4 (11%%)
gams scen r=mdl o=lst\319.lst gdx=gdx\319.gdx --target=41 --rebate=IBER --metric=equal-p
title Processor 4 (12%%)
gams scen r=mdl o=lst\320.lst gdx=gdx\320.gdx --target=41 --rebate=IBER --metric=equal-q
title Processor 4 (13%%)
gams scen r=mdl o=lst\321.lst gdx=gdx\321.gdx --target=42 --rebate=LSR --metric=equal-p
title Processor 4 (14%%)
gams scen r=mdl o=lst\322.lst gdx=gdx\322.gdx --target=42 --rebate=LSR --metric=equal-q
title Processor 4 (15%%)
gams scen r=mdl o=lst\323.lst gdx=gdx\323.gdx --target=42 --rebate=OBR --metric=equal-p
title Processor 4 (16%%)
gams scen r=mdl o=lst\324.lst gdx=gdx\324.gdx --target=42 --rebate=OBR --metric=equal-q
title Processor 4 (17%%)
gams scen r=mdl o=lst\325.lst gdx=gdx\325.gdx --target=42 --rebate=ABR --metric=equal-p
title Processor 4 (18%%)
gams scen r=mdl o=lst\326.lst gdx=gdx\326.gdx --target=42 --rebate=ABR --metric=equal-q
title Processor 4 (19%%)
gams scen r=mdl o=lst\327.lst gdx=gdx\327.gdx --target=42 --rebate=IBOR --metric=equal-p
title Processor 4 (20%%)
gams scen r=mdl o=lst\328.lst gdx=gdx\328.gdx --target=42 --rebate=IBOR --metric=equal-q
title Processor 4 (20%%)
gams scen r=mdl o=lst\329.lst gdx=gdx\329.gdx --target=42 --rebate=IBER --metric=equal-p
title Processor 4 (21%%)
gams scen r=mdl o=lst\330.lst gdx=gdx\330.gdx --target=42 --rebate=IBER --metric=equal-q
title Processor 4 (22%%)
gams scen r=mdl o=lst\331.lst gdx=gdx\331.gdx --target=43 --rebate=LSR --metric=equal-p
title Processor 4 (23%%)
gams scen r=mdl o=lst\332.lst gdx=gdx\332.gdx --target=43 --rebate=LSR --metric=equal-q
title Processor 4 (24%%)
gams scen r=mdl o=lst\333.lst gdx=gdx\333.gdx --target=43 --rebate=OBR --metric=equal-p
title Processor 4 (25%%)
gams scen r=mdl o=lst\334.lst gdx=gdx\334.gdx --target=43 --rebate=OBR --metric=equal-q
title Processor 4 (26%%)
gams scen r=mdl o=lst\335.lst gdx=gdx\335.gdx --target=43 --rebate=ABR --metric=equal-p
title Processor 4 (27%%)
gams scen r=mdl o=lst\336.lst gdx=gdx\336.gdx --target=43 --rebate=ABR --metric=equal-q
title Processor 4 (28%%)
gams scen r=mdl o=lst\337.lst gdx=gdx\337.gdx --target=43 --rebate=IBOR --metric=equal-p
title Processor 4 (29%%)
gams scen r=mdl o=lst\338.lst gdx=gdx\338.gdx --target=43 --rebate=IBOR --metric=equal-q
title Processor 4 (30%%)
gams scen r=mdl o=lst\339.lst gdx=gdx\339.gdx --target=43 --rebate=IBER --metric=equal-p
title Processor 4 (31%%)
gams scen r=mdl o=lst\340.lst gdx=gdx\340.gdx --target=43 --rebate=IBER --metric=equal-q
title Processor 4 (32%%)
gams scen r=mdl o=lst\341.lst gdx=gdx\341.gdx --target=44 --rebate=LSR --metric=equal-p
title Processor 4 (33%%)
gams scen r=mdl o=lst\342.lst gdx=gdx\342.gdx --target=44 --rebate=LSR --metric=equal-q
title Processor 4 (34%%)
gams scen r=mdl o=lst\343.lst gdx=gdx\343.gdx --target=44 --rebate=OBR --metric=equal-p
title Processor 4 (35%%)
gams scen r=mdl o=lst\344.lst gdx=gdx\344.gdx --target=44 --rebate=OBR --metric=equal-q
title Processor 4 (36%%)
gams scen r=mdl o=lst\345.lst gdx=gdx\345.gdx --target=44 --rebate=ABR --metric=equal-p
title Processor 4 (37%%)
gams scen r=mdl o=lst\346.lst gdx=gdx\346.gdx --target=44 --rebate=ABR --metric=equal-q
title Processor 4 (38%%)
gams scen r=mdl o=lst\347.lst gdx=gdx\347.gdx --target=44 --rebate=IBOR --metric=equal-p
title Processor 4 (39%%)
gams scen r=mdl o=lst\348.lst gdx=gdx\348.gdx --target=44 --rebate=IBOR --metric=equal-q
title Processor 4 (40%%)
gams scen r=mdl o=lst\349.lst gdx=gdx\349.gdx --target=44 --rebate=IBER --metric=equal-p
title Processor 4 (41%%)
gams scen r=mdl o=lst\350.lst gdx=gdx\350.gdx --target=44 --rebate=IBER --metric=equal-q
title Processor 4 (42%%)
gams scen r=mdl o=lst\351.lst gdx=gdx\351.gdx --target=45 --rebate=LSR --metric=equal-p
title Processor 4 (43%%)
gams scen r=mdl o=lst\352.lst gdx=gdx\352.gdx --target=45 --rebate=LSR --metric=equal-q
title Processor 4 (44%%)
gams scen r=mdl o=lst\353.lst gdx=gdx\353.gdx --target=45 --rebate=OBR --metric=equal-p
title Processor 4 (45%%)
gams scen r=mdl o=lst\354.lst gdx=gdx\354.gdx --target=45 --rebate=OBR --metric=equal-q
title Processor 4 (46%%)
gams scen r=mdl o=lst\355.lst gdx=gdx\355.gdx --target=45 --rebate=ABR --metric=equal-p
title Processor 4 (47%%)
gams scen r=mdl o=lst\356.lst gdx=gdx\356.gdx --target=45 --rebate=ABR --metric=equal-q
title Processor 4 (48%%)
gams scen r=mdl o=lst\357.lst gdx=gdx\357.gdx --target=45 --rebate=IBOR --metric=equal-p
title Processor 4 (49%%)
gams scen r=mdl o=lst\358.lst gdx=gdx\358.gdx --target=45 --rebate=IBOR --metric=equal-q
title Processor 4 (50%%)
gams scen r=mdl o=lst\359.lst gdx=gdx\359.gdx --target=45 --rebate=IBER --metric=equal-p
title Processor 4 (51%%)
gams scen r=mdl o=lst\360.lst gdx=gdx\360.gdx --target=45 --rebate=IBER --metric=equal-q
title Processor 4 (52%%)
gams scen r=mdl o=lst\361.lst gdx=gdx\361.gdx --target=46 --rebate=LSR --metric=equal-p
title Processor 4 (53%%)
gams scen r=mdl o=lst\362.lst gdx=gdx\362.gdx --target=46 --rebate=LSR --metric=equal-q
title Processor 4 (54%%)
gams scen r=mdl o=lst\363.lst gdx=gdx\363.gdx --target=46 --rebate=OBR --metric=equal-p
title Processor 4 (55%%)
gams scen r=mdl o=lst\364.lst gdx=gdx\364.gdx --target=46 --rebate=OBR --metric=equal-q
title Processor 4 (56%%)
gams scen r=mdl o=lst\365.lst gdx=gdx\365.gdx --target=46 --rebate=ABR --metric=equal-p
title Processor 4 (57%%)
gams scen r=mdl o=lst\366.lst gdx=gdx\366.gdx --target=46 --rebate=ABR --metric=equal-q
title Processor 4 (58%%)
gams scen r=mdl o=lst\367.lst gdx=gdx\367.gdx --target=46 --rebate=IBOR --metric=equal-p
title Processor 4 (59%%)
gams scen r=mdl o=lst\368.lst gdx=gdx\368.gdx --target=46 --rebate=IBOR --metric=equal-q
title Processor 4 (60%%)
gams scen r=mdl o=lst\369.lst gdx=gdx\369.gdx --target=46 --rebate=IBER --metric=equal-p
title Processor 4 (60%%)
gams scen r=mdl o=lst\370.lst gdx=gdx\370.gdx --target=46 --rebate=IBER --metric=equal-q
title Processor 4 (61%%)
gams scen r=mdl o=lst\371.lst gdx=gdx\371.gdx --target=47 --rebate=LSR --metric=equal-p
title Processor 4 (62%%)
gams scen r=mdl o=lst\372.lst gdx=gdx\372.gdx --target=47 --rebate=LSR --metric=equal-q
title Processor 4 (63%%)
gams scen r=mdl o=lst\373.lst gdx=gdx\373.gdx --target=47 --rebate=OBR --metric=equal-p
title Processor 4 (64%%)
gams scen r=mdl o=lst\374.lst gdx=gdx\374.gdx --target=47 --rebate=OBR --metric=equal-q
title Processor 4 (65%%)
gams scen r=mdl o=lst\375.lst gdx=gdx\375.gdx --target=47 --rebate=ABR --metric=equal-p
title Processor 4 (66%%)
gams scen r=mdl o=lst\376.lst gdx=gdx\376.gdx --target=47 --rebate=ABR --metric=equal-q
title Processor 4 (67%%)
gams scen r=mdl o=lst\377.lst gdx=gdx\377.gdx --target=47 --rebate=IBOR --metric=equal-p
title Processor 4 (68%%)
gams scen r=mdl o=lst\378.lst gdx=gdx\378.gdx --target=47 --rebate=IBOR --metric=equal-q
title Processor 4 (69%%)
gams scen r=mdl o=lst\379.lst gdx=gdx\379.gdx --target=47 --rebate=IBER --metric=equal-p
title Processor 4 (70%%)
gams scen r=mdl o=lst\380.lst gdx=gdx\380.gdx --target=47 --rebate=IBER --metric=equal-q
title Processor 4 (71%%)
gams scen r=mdl o=lst\381.lst gdx=gdx\381.gdx --target=48 --rebate=LSR --metric=equal-p
title Processor 4 (72%%)
gams scen r=mdl o=lst\382.lst gdx=gdx\382.gdx --target=48 --rebate=LSR --metric=equal-q
title Processor 4 (73%%)
gams scen r=mdl o=lst\383.lst gdx=gdx\383.gdx --target=48 --rebate=OBR --metric=equal-p
title Processor 4 (74%%)
gams scen r=mdl o=lst\384.lst gdx=gdx\384.gdx --target=48 --rebate=OBR --metric=equal-q
title Processor 4 (75%%)
gams scen r=mdl o=lst\385.lst gdx=gdx\385.gdx --target=48 --rebate=ABR --metric=equal-p
title Processor 4 (76%%)
gams scen r=mdl o=lst\386.lst gdx=gdx\386.gdx --target=48 --rebate=ABR --metric=equal-q
title Processor 4 (77%%)
gams scen r=mdl o=lst\387.lst gdx=gdx\387.gdx --target=48 --rebate=IBOR --metric=equal-p
title Processor 4 (78%%)
gams scen r=mdl o=lst\388.lst gdx=gdx\388.gdx --target=48 --rebate=IBOR --metric=equal-q
title Processor 4 (79%%)
gams scen r=mdl o=lst\389.lst gdx=gdx\389.gdx --target=48 --rebate=IBER --metric=equal-p
title Processor 4 (80%%)
gams scen r=mdl o=lst\390.lst gdx=gdx\390.gdx --target=48 --rebate=IBER --metric=equal-q
title Processor 4 (81%%)
gams scen r=mdl o=lst\391.lst gdx=gdx\391.gdx --target=49 --rebate=LSR --metric=equal-p
title Processor 4 (82%%)
gams scen r=mdl o=lst\392.lst gdx=gdx\392.gdx --target=49 --rebate=LSR --metric=equal-q
title Processor 4 (83%%)
gams scen r=mdl o=lst\393.lst gdx=gdx\393.gdx --target=49 --rebate=OBR --metric=equal-p
title Processor 4 (84%%)
gams scen r=mdl o=lst\394.lst gdx=gdx\394.gdx --target=49 --rebate=OBR --metric=equal-q
title Processor 4 (85%%)
gams scen r=mdl o=lst\395.lst gdx=gdx\395.gdx --target=49 --rebate=ABR --metric=equal-p
title Processor 4 (86%%)
gams scen r=mdl o=lst\396.lst gdx=gdx\396.gdx --target=49 --rebate=ABR --metric=equal-q
title Processor 4 (87%%)
gams scen r=mdl o=lst\397.lst gdx=gdx\397.gdx --target=49 --rebate=IBOR --metric=equal-p
title Processor 4 (88%%)
gams scen r=mdl o=lst\398.lst gdx=gdx\398.gdx --target=49 --rebate=IBOR --metric=equal-q
title Processor 4 (89%%)
gams scen r=mdl o=lst\399.lst gdx=gdx\399.gdx --target=49 --rebate=IBER --metric=equal-p
title Processor 4 (90%%)
gams scen r=mdl o=lst\400.lst gdx=gdx\400.gdx --target=49 --rebate=IBER --metric=equal-q
title Processor 4 (91%%)
gams scen r=mdl o=lst\401.lst gdx=gdx\401.gdx --target=50 --rebate=LSR --metric=equal-p
title Processor 4 (92%%)
gams scen r=mdl o=lst\402.lst gdx=gdx\402.gdx --target=50 --rebate=LSR --metric=equal-q
title Processor 4 (93%%)
gams scen r=mdl o=lst\403.lst gdx=gdx\403.gdx --target=50 --rebate=OBR --metric=equal-p
title Processor 4 (94%%)
gams scen r=mdl o=lst\404.lst gdx=gdx\404.gdx --target=50 --rebate=OBR --metric=equal-q
title Processor 4 (95%%)
gams scen r=mdl o=lst\405.lst gdx=gdx\405.gdx --target=50 --rebate=ABR --metric=equal-p
title Processor 4 (96%%)
gams scen r=mdl o=lst\406.lst gdx=gdx\406.gdx --target=50 --rebate=ABR --metric=equal-q
title Processor 4 (97%%)
gams scen r=mdl o=lst\407.lst gdx=gdx\407.gdx --target=50 --rebate=IBOR --metric=equal-p
title Processor 4 (98%%)
gams scen r=mdl o=lst\408.lst gdx=gdx\408.gdx --target=50 --rebate=IBOR --metric=equal-q
title Processor 4 (99%%)
gams scen r=mdl o=lst\409.lst gdx=gdx\409.gdx --target=50 --rebate=IBER --metric=equal-p
title Processor 4 (100%%)
gams scen r=mdl o=lst\410.lst gdx=gdx\410.gdx --target=50 --rebate=IBER --metric=equal-q
title Processor 4 (100%%)
