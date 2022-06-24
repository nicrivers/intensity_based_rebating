library(tidyverse)
library(readxl)

directory <- "./ibr_graphs"

dat <- read_excel("output_ele_eite.xlsx", col_names = c("scen","item", "sector", "value"))

setwd(directory)

# width and height
plot_width = 6
plot_height = 6
onecol <- "#000004"
twosec <- c("EITE" = "#000004", "non-EITE" = "#fcffa4")

dat$elec <- gsub("\\_[A-Za-z]+$","",dat$scen)
dat$rebate <- str_replace(dat$scen,dat$elec,"")
dat$rebate <- gsub("\\_","",dat$rebate)
dat$rebate <- toupper(dat$rebate)

# Rename rebates
dat <- dat %>%
  mutate(rebate = case_when(rebate == "LSR" ~ "LS",
                            rebate == "OBR" ~ "O",
                            rebate == "ABR" ~ "A",
                            rebate == "IBOR" ~ "IO",
                            rebate == "IBER" ~ "IE"),
         rebate = factor(rebate, levels = c("LS", "O", "A", "IO", "IE")))

# plots

supp.labs <- c("Electricity treated as EITE", "Electricity treated as non-EITE")
names(supp.labs) <- c("ele_eite","ele_not_eite")

# Output
ggplot(dat %>% filter(item=="Output"), aes(x=rebate, y=value/100, fill=sector)) + 
  facet_wrap(~elec,
             labeller = labeller(elec=supp.labs)) + 
  geom_col(position="dodge", alpha=0.5, colour="black") +
  scale_y_continuous(name="Sector output (%)", labels=scales::percent_format()) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave("output_elec_eite.png", width = plot_width, height = plot_height)

# Emissions
ggplot(dat %>% filter(item=="Emissions", sector != "all"), aes(x=rebate, y=value/100, fill=sector)) + 
  facet_wrap(~elec,
             labeller = labeller(elec=supp.labs)) + 
  geom_col(position="dodge", alpha=0.5, colour="black") +
  scale_y_continuous(name="Sector Emissions (%)", labels=scales::percent_format()) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave("emissions_elec_eite.png", width = plot_width, height = plot_height)

# co2 price
ggplot(dat %>% filter(item=="CO2 price($)", sector != "all"), aes(x=rebate, y=value, fill=sector)) + 
  facet_wrap(~elec,
             labeller = labeller(elec=supp.labs)) + 
  geom_col(position="dodge", alpha=0.5, colour="black") +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]), labels=scales::dollar_format()) +
  theme_bw() +
  geom_hline(yintercept = 0) +
  labs(x=NULL) +
  scale_fill_manual(values=twosec)
ggsave("co2price_elec_eite.png", width = plot_width, height = plot_height)



# relative to LSR
datw <- dat %>%
  select(-scen) %>%
  pivot_wider(names_from=rebate, values_from = value) %>%
  mutate(across(where(is.double), ~ . / LS)) %>%
  pivot_longer(cols = 4:8, names_to = "rebate", values_to = "value")

ggplot(datw %>% filter(item=="Welfare", rebate!="LS"),
       aes(x=elec,y=value-1)) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name="Consumption loss relative to LS (%)", labels=scales::percent_format()) +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave("welfare_elec_eite.png", width = plot_width, height = plot_height)

ggplot(datw %>% filter(item=="CO2 price($)", sector == "EITE", rebate != "LS"),
       aes(x=elec,y=value-1)) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name=bquote("Opportunity cost of "~CO[2]~", relative to LS"), labels=scales::percent_format()) +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave("co2price_elec_eite.png", width = plot_width, height = plot_height)

ggplot(datw %>% filter(item=="Output", sector == "EITE", rebate != "LS"),
       aes(x=elec,y=value-1)) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name="Output reduction EITE, relative to LS (%)", labels=scales::percent_format()) +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave("output_elec_eite.png", width = plot_width, height = plot_height)

ggplot(datw %>% filter(item=="Emissions", sector == "EITE", rebate != "LS"),
       aes(x=elec,y=value-1)) +
  geom_col(position="dodge", fill=onecol, alpha=0.5) +
  facet_wrap(~factor(rebate, levels=c("O","A","IO","IE"))) +
  theme_bw() +
  theme(legend.position = "none", axis.text.x = element_text(angle=90,hjust = 0, vjust=0.5)) +
  scale_y_continuous(name="Emission reduction EITE, relative to LS (%)", labels=scales::percent_format()) +
  geom_hline(yintercept = 0) +
  labs(x=NULL)
ggsave("emission_elec_eite.png", width = plot_width, height = plot_height)
