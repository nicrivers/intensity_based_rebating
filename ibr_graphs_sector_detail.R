# Delete existing direcotry
directory <- "./ibr_graphs"

library(tidyverse)
library(readxl)
library(kableExtra)

# Arguments from the command line
args <- commandArgs(trailingOnly = TRUE)
if (is.na(args[1])) {country = "USA"} else {country = args[1]}

print(paste0("Making graphs for ", country))

# Download the main data
dat <- read_excel("report.xlsx", sheet = "sector") %>%
  filter(target == 20,
         !industry %in% c("EITE","non-EITE")) %>%
  # EITE sectors
  filter(industry %in% c("chm","i_s","nfm","nmm","oil","ppp"))

dir.create(directory, showWarnings = FALSE)
setwd(directory)


# two-Sector colours
onecol <- "#1B9E77"
twosec <- c("EITE" = "#1B9E77", "non-EITE" = "#D95F02")
threesec <- c("EITE" = "#1B9E77", "non-EITE" = "#D95F02", "C" ="#7570B3")

# range
maxemit <- dat %>% filter(item == "Emissions") %>% pull(value) %>% min() %>% floor()
minoutput <- dat %>% filter(item == "Output") %>% pull(value) %>% max() %>% ceiling()
maxoutput <- dat %>% filter(item == "Output") %>% pull(value) %>% min() %>% floor()
maxprice <- dat %>% filter(item == "CO2 price($)") %>% pull(value) %>% max() %>% ceiling()

# width and height
plot_width = 4
plot_height = 4

# Rename rebates
dat <- dat %>%
  mutate(rebate = case_when(rebate == "LSR" ~ "LS",
                            rebate == "OBR" ~ "O",
                            rebate == "ABR" ~ "A",
                            rebate == "IBOR" ~ "IO",
                            rebate == "IBER" ~ "IE"),
         rebate = factor(rebate, levels = c("LS", "O", "A", "IO", "IE")))


ggplot(dat %>% filter(item == "Output",  metric == "equal-p"),
       aes(x=rebate, y=value/100, fill=industry)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector output (%)", labels=scales::percent_format(accuracy=1), limits=c(maxoutput/100,minoutput/100)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_discrete()
ggsave(paste0("output_p_eite",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Output", metric == "equal-q"),
       aes(x=rebate, y=value/100, fill=industry)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector output (%)", labels=scales::percent_format(accuracy=1), limits=c(maxoutput/100,minoutput/100)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_discrete()
ggsave(paste0("output_q_eite",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Emissions", metric == "equal-p"),
       aes(x=rebate, y=value/100, fill=industry)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector emissions (%)", labels=scales::percent_format(accuracy=1), limits=c(maxemit/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_discrete()
ggsave(paste0("co2_p_eite",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "Emissions", metric == "equal-q"),
       aes(x=rebate, y=value/100, fill=industry)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name="Sector emissions (%)", labels=scales::percent_format(accuracy=1), limits=c(maxemit/100,0)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_discrete()
ggsave(paste0("co2_q_eite",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "CO2 price($)", metric == "equal-q"),
       aes(x=rebate, y=value, fill=industry)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~" ($/t)"), labels=scales::dollar_format(), limits=c(0,maxprice)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_discrete()
ggsave(paste0("pco2_q_eite",country,".png"), width=plot_width, height=plot_height)

ggplot(dat %>% filter(item == "CO2 price($)", metric == "equal-p"),
       aes(x=rebate, y=value, fill=industry)) +
  geom_col(alpha=0.5, colour="black", position="dodge") +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~" ($/t)"), labels=scales::dollar_format(), limits=c(0,maxprice)) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_discrete()
ggsave(paste0("pco2_p_eite",country,".png"), width=plot_width, height=plot_height)

