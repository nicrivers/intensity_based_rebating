# Delete existing direcotry
directory <- "./ibr_graphs"
#unlink(directory, recursive=T)

library(tidyverse)
library(readxl)
library(kableExtra)
library(ggrepel)

# Arguments from the command line
args <- commandArgs(trailingOnly = TRUE)
if (is.na(args[1])) {country = "USA"} else {country = args[1]}

print(paste0("Making graphs for ", country))

# Download the main data
dat <- read_excel("report.xlsx", sheet = "macro") %>%
  filter(target == 20)

#dir.create(directory)
setwd(directory)


# two-Sector colours
onecol <- "#000004"
twosec <- c("EITE" = "#000004", "non-EITE" = "#fcffa4")

# range
maxemit <- dat %>% filter(item == "Emissions") %>% pull(value) %>% min() %>% floor()
maxemitall <- dat %>% filter(item == "Emissions", sector == "all") %>% pull(value) %>% min() %>% floor()
minoutput <- dat %>% filter(item == "Output") %>% pull(value) %>% max() %>% ceiling()
maxoutput <- dat %>% filter(item == "Output") %>% pull(value) %>% min() %>% floor()
maxprice <- dat %>% filter(item == "CO2 price($)") %>% pull(value) %>% max() %>% ceiling()
maxwelf <- dat %>% filter(item == "Welfare") %>% mutate(value=value*10) %>% pull(value) %>% min() %>% floor()
maxwelf <- maxwelf/10

# width and height
plot_width = 4
plot_height = 4

# Two axis figure
dat %>% 
  filter(item %in% c("Output","CO2 price($)"), 
         sector == "EITE", 
         metric == "equal-p") %>% 
  pivot_wider(names_from="item", values_from = "value") %>% 
  ggplot(aes(x=`CO2 price($)`, y=Output,label=rebate)) + 
  geom_text_repel() +
  geom_point() +
  theme_bw() +
  labs(x="Opportunity cost of emissions in EITE sectors ($/t)",
       y="Reduction of EITE sector output (%)")
ggsave("two_axis.png", width=plot_width, height=plot_height)


ggplot(dat %>% filter(item=="Welfare", metric == "equal-q"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100)) +
  geom_col(fill=onecol, alpha=0.5, colour="black") +
  scale_y_continuous(name="Consumption loss (%)", labels=scales::percent_format(), limits=c(maxwelf/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave(paste0("welfare_q",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item=="Welfare", metric == "equal-p"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100)) +
  geom_col(fill=onecol, alpha=0.5, colour="black") +
  scale_y_continuous(name="Consumption loss (%)", labels=scales::percent_format(), limits=c(maxwelf/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave(paste0("welfare_p",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Output", sector != "all", metric == "equal-p"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector output (%)", labels=scales::percent_format(), limits=c(maxoutput/100,minoutput/100)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("output_p",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Output", sector != "all", metric == "equal-q"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector output (%)", labels=scales::percent_format(), limits=c(maxoutput/100,minoutput/100)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("output_q",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Emissions", sector != "all", metric == "equal-p"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector emissions (%)", labels=scales::percent_format(), limits=c(maxemit/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("co2_p",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Emissions", sector != "all", metric == "equal-q"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector emissions (%)", labels=scales::percent_format(), limits=c(maxemit/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("co2_q",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "CO2 price($)", metric == "equal-q"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~" ($/t)"), labels=scales::dollar_format(), limits=c(0,maxprice)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("pco2_q",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "CO2 price($)", metric == "equal-p"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~" ($/t)"), labels=scales::dollar_format(), limits=c(0,maxprice)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("pco2_p",country,".png"), width=plot_width, height=plot_height)


ggplot(dat %>% filter(item == "Emissions", sector=="all", metric == "equal-p"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100)) +
  geom_col(alpha=0.5, colour="black", position="dodge", fill=onecol) +
  scale_y_continuous(name="Change in total emissions", labels=scales::percent_format(), limits=c(maxemitall/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave(paste0("co2all_p",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Emissions", sector=="all", metric == "equal-q"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=value/100)) +
  geom_col(alpha=0.5, colour="black", position="dodge", fill=onecol) +
  scale_y_continuous(name="Change in total emissions", labels=scales::percent_format(), limits=c(maxemitall/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave(paste0("co2all_q",country,".png"), width=plot_width, height=plot_height)

# Dollars per tonne
bmk <- read_excel(paste0("../bmk_",country,".xlsx"))

dat %>% 
  filter(item %in% c("Welfare", "Emissions"), 
         target == 20, 
         metric == "equal-p", 
         sector=="all") %>% 
  pivot_wider(names_from=item) %>% 
  mutate(Emissions = Emissions/100*bmk %>% filter(!is.na(CO2)) %>% summarise(CO2=sum(CO2)) %>% pull(), 
         Welfare=Welfare/100*bmk %>% filter(...2 == "Consumption") %>% pull(Y),
         dollars_per_tonne=Welfare/Emissions*1000) %>%
  ggplot(aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=dollars_per_tonne)) +
  geom_col(alpha=0.5, colour="black", position="dodge", fill=onecol) +
  theme_bw() +
  geom_hline(yintercept=0) +
  labs(x=NULL,
       y="Average cost per tonne of emission reductions ($/t)")
ggsave(paste0("dollars_per_tonne_p",country,".png"), width=plot_width, height=plot_height)

dat %>% 
  filter(item %in% c("Welfare", "Emissions"), 
         target == 20, 
         metric == "equal-q", 
         sector=="all") %>% 
  pivot_wider(names_from=item) %>% 
  mutate(Emissions = Emissions/100*bmk %>% filter(!is.na(CO2)) %>% summarise(CO2=sum(CO2)) %>% pull(), 
         Welfare=Welfare/100*bmk %>% filter(...2 == "Consumption") %>% pull(Y),
         dollars_per_tonne=Welfare/Emissions*1000) %>%
  ggplot(aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=dollars_per_tonne)) +
  geom_col(alpha=0.5, colour="black", position="dodge", fill=onecol) +
  theme_bw() +
  geom_hline(yintercept=0) +
  labs(x=NULL,
       y="Average cost per tonne of emission reductions ($/t)")
ggsave(paste0("dollars_per_tonne_q",country,".png"), width=plot_width, height=plot_height)


# Calculate changes in emission intensity
dat_int <- inner_join(
  dat %>%
    filter(item == "Emissions") %>%
    select(sector, rebate, co2e=value, metric),
  dat %>%
    filter(item == "Output") %>%
    select(sector, rebate, prod=value, metric)
) %>%
  mutate(
    intensity = 100 * ((1 + co2e/100) / (1 + prod/100) - 1)
  )

maxint <- dat_int %>% pull(intensity) %>% min() %>% floor()

ggplot(dat_int %>% filter(metric == "equal-p"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=intensity/100, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name=bquote("Change in total "~CO[2]~" intensity"), labels=scales::percent_format(), limits=c(maxint/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("int_p",country,".png"), width=plot_width, height=plot_height)

ggplot(dat_int %>% filter(metric == "equal-q"),
       aes(x=factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")), y=intensity/100, fill=sector)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name=bquote("Change in total "~CO[2]~" intensity"), labels=scales::percent_format(), limits=c(maxint/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave(paste0("int_q",country,".png"), width=plot_width, height=plot_height)


## Stringency graphs
dats <- read_excel("../report.xlsx", sheet = "macro") %>%
  filter(metric == "equal-q") %>%
  mutate(target = as.numeric(target)) %>%
  filter(target <= 55) %>%
  mutate(rebate = factor(rebate, levels=c("LSR","OBR","ABR","IBOR","IBER")))

# welfare comparison by stringency
ggplot(dats %>% filter(item == "Welfare"), aes(x=target/100, y=value/100, colour = rebate)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name="Consumption loss") +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("stringency_welfare",country,".png"), width=plot_width, height=plot_height)

# Relative to LSR
ggplot(inner_join(dats %>% filter(item == "Welfare", rebate != "LSR"),
                  dats %>% filter(item == "Welfare", rebate == "LSR") %>% rename(LSR=value) %>% select(-rebate)
                ) %>%
         mutate(relative_to_LSR = value / LSR - 1), aes(x=target/100, y=relative_to_LSR, colour = rebate)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name="Consumption loss relative to LSR",limits = c(0,.47)) +
  scale_color_brewer(palette = "Set1") 
ggsave(paste0("stringency_welfare_relative",country,".png"), width=plot_width, height=plot_height)


# sector output comparison by stringency
ggplot(dats %>% filter(item == "Output")
       , aes(x=target/100, y=value/100, colour = rebate, linetype = sector)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name="Change in output") +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("stringency_output",country,".png"), width=plot_width, height=plot_height)

# Relative to LSR
ggplot(inner_join(dats %>% filter(item == "Output", rebate != "LSR"),
                  dats %>% filter(item == "Output", rebate == "LSR") %>% rename(LSR=value) %>% select(-rebate)
) %>%
  mutate(relative_to_LSR = value / LSR - 1), aes(x=target/100, y=relative_to_LSR, colour = rebate, linetype=sector)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name="Change in output relative to LSR") +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("stringency_output_relative",country,".png"), width=plot_width, height=plot_height)


# sector emissions comparison by stringency
ggplot(dats %>% filter(item == "Emissions", sector != "all"), aes(x=target/100, y=value/100, colour = rebate, linetype = sector)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name="Change in emissions") +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("strongency_emissions",country,".png"), width=plot_width, height=plot_height)

# Relative to LSR
ggplot(inner_join(dats %>% filter(item == "Emissions", rebate != "LSR"),
                  dats %>% filter(item == "Emissions", rebate == "LSR") %>% rename(LSR=value) %>% select(-rebate)
) %>%
  mutate(relative_to_LSR = value / LSR - 1) %>%
  filter(sector != "all"), aes(x=target/100, y=relative_to_LSR, colour = rebate, linetype=sector)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name="Change in emissions relative to LSR") +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("stringency_emissions_relative",country,".png"), width=plot_width, height=plot_height)

# sector co2 price comparison by stringency
ggplot(dats %>% filter(item == "CO2 price($)", sector != "all"), aes(x=target/100, y=value, colour = rebate, linetype = sector)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~" ($/t)"), labels=scales::dollar_format()) +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("stringency_price",country,".png"), width=plot_width, height=plot_height)

# Relative to LSR
ggplot(inner_join(dats %>% filter(item == "CO2 price($)", rebate != "LSR"),
                  dats %>% filter(item == "CO2 price($)", rebate == "LSR") %>% rename(LSR=value) %>% select(-rebate)
) %>%
  mutate(relative_to_LSR = value / LSR - 1) %>%
  filter(sector != "all"), aes(x=target/100, y=relative_to_LSR, colour = rebate, linetype=sector)) +
  geom_line() +
  theme_bw() +
  geom_hline(yintercept = 0) +
  scale_x_continuous(labels = scales::percent_format(), name="Economy-wide emission reduction") +
  scale_y_continuous(labels = scales::percent_format(), name=bquote("Opportunity cost of "~CO[2]~" relative to LSR")) +
  scale_color_brewer(palette = "Set1")
ggsave(paste0("stringency_price_relative",country,".png"), width=plot_width, height=plot_height)

