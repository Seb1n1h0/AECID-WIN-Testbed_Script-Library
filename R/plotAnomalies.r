library(ggplot2)
library(simtimer)

setwd("C:\\Temp\\WorkspacePy\\Aminer\\Files")

dat <- read.csv('AECID-WIN-Dataset_Payload.csv', sep=',', header=T)

dat$event <- factor(dat$event)
#dat$time <- round(dat$time / 60) * 60
dat$time <- round(dat$time / 10) * 10
dat <- unique(dat)
dat$time <- as.datetime(dat$time, as.POSIXct("1970-01-01 00:00:00", tz = "UTC"))

#dat <- dat[dat$time > as.POSIXct("2024-02-20 00:00:00", tz = "UTC") & dat$time < as.POSIXct("2024-02-28 00:00:00", tz = "UTC"),]
ggplot(dat, aes(x=time, y=event, color=name)) + #, shape=name)) +
  geom_point() +
  xlab("Time") +
  ylab("Winlog Event ID") +
  scale_color_discrete(name="Host") +
  #scale_shape_discrete(name="Host") +
  #scale_x_datetime(date_labels = "%Y %d %b %Hh") +
  scale_x_datetime(date_labels = "%Y %d %b %H:%M") +
  geom_vline(xintercept=as.POSIXct("2024-02-20 07:12:40", tz = "UTC"), color="red") +
  theme_bw() +
  theme(legend.position = "right")


dat2 <- read.csv('anomalies_payload.csv', sep=',', header=T)
dat2$event <- factor(dat2$event)
dat2$time = as.datetime(dat2$time, as.POSIXct("1970-01-01 00:00:00", tz = "UTC"))
dat2 <- dat2[dat2$type!="seq",]
#dat2$type_sh <- 0
#dat2[dat2$type=="name_event_combo",]$type_sh <- 7
#dat2[dat2$type=="source_target_combo",]$type_sh <- 8
#dat2[dat2$type=="seq",]$type_sh <- 9

ggplot() + #, shape=name)) +
  geom_point(data=dat, mapping=aes(x=time, y=event, color=name)) +
  geom_point(data=dat2, mapping=aes(x=time, y=event, shape=type), size=4, color="red") +
  scale_shape_manual(values=c(7, 8, 9, 10, 11), name="Detector") +
  xlab("Time") +
  ylab("Winlog Event ID") +
  scale_color_discrete(name="Host") +
  #scale_shape_discrete(name="Host") +
  #scale_x_datetime(date_labels = "%Y %d %b %Hh") +
  scale_x_datetime(date_labels = "%Y %d %b %H:%M") +
  geom_vline(xintercept=as.POSIXct("2024-02-20 07:12:40", tz = "UTC"), color="red") +
  theme_bw() +
  theme(legend.position = "right")