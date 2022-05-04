# Intensity based rebating

## Description
This file contains all code required to replicate the figures and tables in the paper:

Bohringer, C., C. Fischer, and N. Rivers, "Intensity-based Rebating of Emissions Pricing Revenues".

## Requirements
To execute the files contained in this repository, you will require:
- GAMS version 34 or above with a license for PATH and MPSGE
- R version 4 or above, with the following packages
    - tidyverse
    - kableExtra
    - readxl

All files are executed on Windows OS. The path environment variable should be set so that both GAMS and R can be called from the command line.

## Instructions
To replicate Table 2, and Figures 5, 6, 7, 13, 14, 17, 18, an 19, execute the file:
```
runall.bat
```

To replicate Figures 15 and 16, execute the file:
```
run_country.bat
```

To replicate Figures 20, 21, an 22, execute the file:
```
run_elec_eite.bat
```