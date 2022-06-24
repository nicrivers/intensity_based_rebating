library(tidyverse)
library(readxl)

directory <- "./ibr_graphs"

dat <- read_excel("output_country.xlsx", col_names = c("scen","item", "sector", "value"))

setwd(directory)

# width and height
plot_width = 6
plot_height = 6
onecol <- "#1B9E77"

dat$country <- gsub("\\_[A-Za-z]+$","",dat$scen)
dat$rebate <- gsub("^[A-Za-z]+\\_","",dat$scen)
dat$rebate <- toupper(dat$rebate)

# Rename rebates
dat <- dat %>%
  mutate(rebate = case_when(rebate == "LSR" ~ "LS",
                            rebate == "OBR" ~ "O",
                            rebate == "ABR" ~ "A",
                            rebate == "IBOR" ~ "IO",
                            rebate == "IBER" ~ "IE"),
         rebate = factor(rebate, levels = c("LS", "O", "A", "IO", "IE")))

# relative to LSR
datw <- dat %>%
  select(-scen) %>%
  pivot_wider(names_from=rebate, values_from = value) %>%
  mutate(across(where(is.double), ~ . / LS)) %>%
  pivot_longer(cols = 4:8, names_to = "rebate", values_to = "value")

ggplot(datw %>% filter(item=="Welfare", rebate!="LS"),
       aes(x=country,y=value-1)) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name="Consumption loss relative to LS (%)", labels=scales::percent_format()) +
  geom_hline(yintercept = c(0,1)) +
  labs(x=NULL)
ggsave("welfare_country.png", width = plot_width, height = plot_height)

ggplot(datw %>% filter(item=="CO2 price($)", sector == "EITE", rebate != "LS"),
       aes(x=country,y=value)) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~", relative to LSR"), labels=scales::percent_format()) +
  geom_hline(yintercept = c(0,1)) +
  labs(x=NULL)
ggsave("co2price_country.png", width = plot_width, height = plot_height)

ggplot(datw %>% filter(item=="Output", sector == "EITE", rebate != "LS"),
       aes(x=country,y=value)) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name="Output reduction EITE, relative to LS (%)", labels=scales::percent_format()) +
  geom_hline(yintercept = c(0,1)) +
  labs(x=NULL)
ggsave("output_country.png", width = plot_width, height = plot_height)

ggplot(datw %>% filter(item=="Emissions", sector == "EITE", rebate != "LS"),
       aes(x=country,y=value)) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name="Emission reduction EITE, relative to LS (%)", labels=scales::percent_format()) +
  geom_hline(yintercept = c(0,1)) +
  labs(x=NULL)
ggsave("emission_country.png", width = plot_width, height = plot_height)