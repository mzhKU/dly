dta <- ("../99_data/fahrzeiten_soll_ist_20170122_20170128.csv")
# dta <- ("../99_data/delay_data/fahrzeitensollist2017012920170204.csv")
# dta <- ("../99_data/delay_data/test-data.csv")

d <- read.table(dta, header=T, sep=",")

library(tidyverse)
library(lubridate)

d <- as.tibble(d)

# Only 'kurs' 4 because `d %>% count(kurs)` shows that
# kurs=4 has largest number of entries.
d1 <- d[d$linie==4,      ]
d1 <- d1[d1$kurs==4,     ] 
d1 <- d1[d1$richtung==1, ]

d1 <- d1 %>% select(betriebsdatum,
                    halt_kurz_von1, halt_kurz_nach1,
                    seq_von,        seq_nach,
                    soll_an_nach,   ist_an_nach1)

# Delay = Ist - Soll, if 'dly' positive, tram too late.
d1 <- mutate(d1, dly=ist_an_nach1 - soll_an_nach)

# To display the stations in order of travel,
# the stations have to be converted to `factor`.
g <- ggplot(d1, aes(soll_an_nach, dly)) +
            geom_point() + facet_wrap(~halt_kurz_nach1)
