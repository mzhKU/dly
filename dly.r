# Es wird Verspätung gerechnet.
# Negative Verspätung heisst, das Fahrzeug ist zu früh an
# der Station angekommen.

# leu$versp <- leu$ist_an_von - leu$soll_an_von
# kum_versp <- tapply(leu$versp, leu$betriebsdatum, FUN=sum)

library(data.table)
d <- read.csv("linie10richtung1.dat", header=T)
d <- d[c("betriebsdatum", "kurs", "halt_kurz_von1", "soll_an_von", "ist_an_von")]

stationen_linie_10 <- c("BABH07", "BERN", "BGLA07", "BOEO",
                        "BPLA", "CENT", "ETHZ", "FLUG07",
                        "FRAF07", "GGLA07", "GLIN07", "HALB",
                        "HEGG",
                        "HIRS", "IRCH", "KINK", "LANM",
                        "LETZ", "LEUT", "MIBU", "RBAU07",
                        "RIGI", "SALE", "SOER", "UNTR07",
                        "WINK", "ZOER")

d <- as.data.table(d)
d$betriebsdatum <- as.Date(d$betriebsdatum, format="%d.%m.%y")

# ****************************************
# Note: Which course should be considered?
# ****************************************
#d5 <- d[d$kurs==5]
d <- d[d$halt_kurz_von1 %in% stationen_linie_10]

d$versp <- d$ist_an_von - d$soll_an_von

library(ggplot2)

g <- ggplot(d, aes(betriebsdatum, versp))
g <- g + geom_line() + facet_wrap(~halt_kurz_von1)
g <- g + theme(axis.text.x = element_text(angle=45, size=18),
               axis.title.x = element_text(size=24),
               axis.title.y = element_text(size=24),
               axis.text.y = element_text(size=20))
g <- g + theme(strip.text.x = element_text(size=18))
g <- g + xlab("Date of Operation")
g <- g + ylab("Total Delay/d [s]")
g <- g + scale_x_date(date_breaks="5 months")
# print(g)
