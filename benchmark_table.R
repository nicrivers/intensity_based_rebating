# Delete existing direcotry
directory <- "./ibr_graphs"
#unlink(directory, recursive=T)

library(tidyverse)
library(readxl)
library(kableExtra)

# Arguments from the command line
args <- commandArgs(trailingOnly = TRUE)
if (is.na(args[1])) {country = "USA"} else {country = args[1]}

print(paste0("Making graphs for ", country))

setwd(directory)

### Configure table of benchmark data
eite_sectors = c("oil", "ppp", "nmm", "i_s", "nfm", "chm")
fd_sectors = c("c", "g", "i")
n_eite = length(eite_sectors)
n_fd = length(fd_sectors)
n_sector = 14 # total number of sectors



# Table of benchmark data
read_excel(paste0("../bmk_",country,".xlsx"), sheet = "bmk") %>%
  rename(Sector = ...1, Name = ...2) %>%
  mutate(Sector = tolower(Sector)) %>%
  mutate(Sector = gsub("roi","roe",Sector)) %>%
  # Y - Production
  # D - Domestic consumption = D + M (Chris defines D as domestic production for domestic consumption only)
  mutate(D = D + M) %>%
  mutate(eite_sector = (Sector %in% eite_sectors)) %>%
  mutate(fd_sector = (Sector %in% fd_sectors)) %>%
  arrange(fd_sector, eite_sector) %>%  
  select(-eite_sector, -fd_sector) %>%
  select(-Sector) %>%
  pivot_longer(cols=-c(1), names_to = "Measure", values_to = "abs") %>%
  group_by(Measure) %>%
  mutate(pct = abs / sum(abs, na.rm=T), 
         pct = scales::percent(pct,accuracy = 0.1)) %>%
  pivot_wider(names_from = "Measure", values_from = c("abs", "pct")) %>%
  select(-pct_Int) %>%
  relocate(contains("abs")) %>%
  relocate(contains(c("_Int"))) %>%
  relocate(contains(c("_CO2"))) %>%
  relocate(contains(c("_M"))) %>%
  relocate(contains(c("_X"))) %>%
  relocate(contains(c("_D"))) %>%
  relocate(contains(c("_Y"))) %>%
  relocate(contains(c("Name"))) %>%
  kbl(booktabs=T, "latex",
      caption = "Benchmark sector output, trade, and emissions\\label{tab:benchmarkout}") %>%
  add_header_above(c(" " = 1, "Y" = 2, "D" = 2, "X" = 2, "M" = 2, "CO2" = 2, "Int" = 1)) %>%
  kable_styling() %>%
  pack_rows("EITE sectors", n_sector - n_eite - n_fd + 1, n_sector - n_fd) %>%
  pack_rows("Non-EITE sectors", 1, n_sector - n_eite - n_fd) %>%
  pack_rows("Final demand sectors", n_sector - n_fd + 1, n_sector) %>%
  footnote(threeparttable = TRUE, general = "Y refers to production, D is domestic consumption, X is exports, and M is imports in billions of dollars. CO$_2$ is domestic emissions of carbon dioxide in millions of metric tonnes. Int is CO$_2$ intensity in tonnes of CO$_2$ emissions per 1,000 dollars of production") %>%
  save_kable(paste0("benchmark_table_percents.tex"), keep_tex = TRUE)

