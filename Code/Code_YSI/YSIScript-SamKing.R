##YSI Data 
library(tidyverse)
library(dplyr)
library(lubridate)
library(ggplot2)



ysiday<-ysi19
ysiday$date<-as.Date(ysiday$date)
ysiday$conductivity<-ifelse(ysiday$conductivity>70,0, ysiday$conductivity) #remove section with weird conductivity
ysiday[ysiday==0]<-NA #change 0s to NA
ysiday<-ysiday[complete.cases(ysiday),] #rm NAs


#calculate mean and sd for each variable 
ysiday<- select(ysiday, -Time)
ysi_long<-pivot_longer(data=ysiday, cols= -date, names_to= "measurement", values_to= "value")

ysiday_means<- ysi_long %>%
  group_by(date, measurement) %>%
  summarize(vari_mean = mean(value),
            vari_se= sd(value)/sqrt(n()))
ysiday_means

#plot of all the data daily means
ggplot(data= ysiday_means, mapping = aes(x= date, y= vari_mean)) +
  geom_line () +
  geom_errorbar(mapping= aes (ymin= vari_mean - vari_se, ymax= vari_mean + vari_se), width=0.2) +
  #geom_smooth(method="loess")+
  ylab(label = "Measurement mean values") + #change y label
  facet_wrap(~variable, scales="free_y") #creates subplots; adjust scales on each y axis instead of standardizing
ggsave(filename= "ysi_meansall.png") #saves file in directory 

###just the ones for symposium
ysiday_few<-select(ysiday, -Time, -salinity, -conductivity, -orp, -bga)
ysifew_long<-pivot_longer(data=ysiday_few, cols= -date, names_to= "measurement", values_to= "value")
levels(ysifew_long$measurement)<-c("Chlorophyll a", "Dissolved Oxygen", "pH", "Temperature (C)")

ysifew_means<- ysifew_long %>%
  group_by(date, measurement) %>%
  summarize(vari_mean = mean(value),
            vari_se= sd(value)/sqrt(n()))

meas.names<-c("Chlorophyll a"= "Chlorophyll a","2"= "Dissolved Oxygen", "3"="pH", "4"="Temperature (C)")

ggplot(data= ysifew_means, mapping = aes(x= date, y= vari_mean)) +
  geom_line () +
  facet_wrap(~measurement scales="free_y")+
  #geom_errorbar(mapping= aes (ymin= vari_mean - vari_se, ymax= vari_mean + vari_se), width=0.2) +
  scale_x_date(date_labels = "%m/%y", date_breaks = "2 month") +
  #geom_smooth(method="loess")+
  ylab(label = "Measurement mean values") + #change y label
  xlab(label= "Date") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

##adjust timescale for Diane 
YSI.combo$Date<-as.Date(YSI.combo$Date)
YSI.combo[YSI.combo==0]<-NA #change 0s to NA

combo<-select(YSI.combo, -Time)
combo_long<-pivot_longer(data=combo, cols= -Date, names_to= "measurement", values_to= "value")
levels(combo_long$measurement)<-c("Chlorophyll a", "Dissolved Oxygen", "pH", "Temperature (C)")

combo_means<- combo_long %>%
  group_by(Date, measurement) %>%
  summarize(vari_mean = mean(value),
            vari_se= sd(value)/sqrt(n()))

ggplot(data= combo_means, mapping = aes(x= Date, y= vari_mean)) +
  geom_line (size=.6) +
  facet_wrap(~measurement, scales="free_y")+
  #geom_errorbar(mapping= aes (ymin= vari_mean - vari_se, ymax= vari_mean + vari_se), width=0.2) +
  scale_x_date(date_labels = "%m/%y", date_breaks = "2 month") +
  #geom_smooth(method="loess")+
  ylab(label = "Measurement mean values") + #change y label
  xlab(label= "Date") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())


#no zeros
YSI.combo.nz$Date<-as.Date(YSI.combo.nz$Date)
#YSI.combo[YSI.combo==0]<-NA #change 0s to NA

combo.nz<-select(YSI.combo.nz, -Time)
combo_long.nz<-pivot_longer(data=combo.nz, cols= -Date, names_to= "measurement", values_to= "value")
levels(combo_long.nz$measurement)<-c("Chlorophyll a", "Dissolved Oxygen", "pH", "Temperature (C)")

combo_means.nz<- combo_long.nz %>%
  group_by(Date, measurement) %>%
  summarize(vari_mean = mean(value),
            vari_se= sd(value)/sqrt(n()))

ggplot(data= combo_means.nz, mapping = aes(x= Date, y= vari_mean)) +
  geom_line (size=.4
             ) +
  facet_wrap(~measurement, scales="free_y")+
  #geom_errorbar(mapping= aes (ymin= vari_mean - vari_se, ymax= vari_mean + vari_se), width=0.2) +
  scale_x_date(date_labels = "%m/%y", date_breaks = "2 month") +
  #geom_smooth(method="loess")+
  ylab(label = "Mean Daily Meaurement Values") + #change y label
  xlab(label= "Date") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())


#calculate monthly mean 
ysimonth_means<-ysi_long %>%
  mutate(Month=month(date)) %>%
  group_by(Month, variable) %>% 
  summarize(vari_mean = mean(measurement),
            vari_se= sd(measurement)/sqrt(n()))
ysimonth_means

#plot of all the data monthly means
ggplot(data= ysimonth_means, mapping = aes(x= Month, y= vari_mean)) +
  geom_line () +
  geom_errorbar(mapping= aes (ymin= vari_mean - vari_se, ymax= vari_mean + vari_se), width=0.2) +
  #geom_smooth(method="loess")+
  ylab(label = "Measurement mean values") + #change y label
  facet_wrap(~variable, scales="free_y") #creates subplots; adjust scales on each y axis instead of standardizing
ggsave(filename= "ysimonth_means.png") #saves file in directory

##Calculate by month
ysimonth<-ysiday
ysimonth$date<-month(ysiday$date) #convert to month


ysi_long2<-pivot_longer(data=ysimonth, cols= -date, names_to= "variable", values_to= "measurement")
ysimonth_means<- ysi_long2 %>%
  group_by(date, variable) %>%
  summarize(vari_mean = mean(measurement),
            vari_se= sd(measurement)/sqrt(n()))
ysimonth_means


ggplot(data= ysimonth_means, mapping = aes(x= date, y= vari_mean)) +
  geom_line () +
  geom_errorbar(mapping= aes (ymin= vari_mean - vari_se, ymax= vari_mean + vari_se), width=0.2) +
  geom_smooth(method="loess")+
  ylab(label = "Measurement mean values") + #change y label
  xlab(label="Month") +
  facet_wrap(~variable, scales="free_y") #creates subplots; adjust scales on each y axis instead of standardizing
ggsave(filename= "ysi_monthmeansall_smooth.png") #saves file in directory 





#explore seasonality: 
#upper, lower, month

#create dataset with maxs and mins for each variable
ysi_trends<-ysi_long %>%
  group_by(date, variable) %>%
  summarize(v.max= max(measurement),
            v.min= min(measurement))

ysi_trends.temp<-subset(ysi_trends, variable=="temp") #subset to just look at temp max/mins

plot(ysi_trends.temp$v.max, type='l') #view trends

length(ysi_trends.temp$v.max)
#295
index<-1:295
time<-index/295 #not a full year of data

#seasonal cycle equation: y= a +Bsin(2pi*t)+y(2pi*t)+E
model<-lm(ysi_trends.temp$v.max~ sin(time*2*pi)+cos(time*2*pi))
model.min<-lm(ysi_trends.temp$v.min~ sin(time*2*pi)+cos(time*2*pi))
plot(time, ysi_trends.temp$v.max) #plot max temps
lines(time, predict(model), col="black", lwd=2) #add model to plot
points(time, ysi_trends.temp$v.min, col="blue")
lines(time, predict(model.min), col="blue", lwd=2)

summary(model)
#R2 0.6445 p<2.2e-16
plot(model$resid)
windows(7,4)
par(mfrow=c(1,2))
acf(model$resid, main="")
acf(model$resid, type="p", main="")

#season for DO 
ysi_trends.do<-subset(ysi_trends, variable=="do")
model2<-lm(ysi_trends.do$v.max~ sin(time*2*pi)+cos(time*2*pi)) #DO max model 
plot(time, ysi_trends.do$v.max, ylim=c(75, 110)) #plot max do
lines(time, predict(model2), col="red", lwd=2) #add model to plot
summary(model)

model2.2<-lm(ysi_trends.do$v.min ~ sin(time*2*pi)+cos(time*2*pi)) #calculate for DO min
points(time, ysi_trends.do$v.min, col="blue") #add min to plot
lines(time, predict(model2.2), col="blue", lwd=2) #add min model to plot


#r=0.6645 p<2.2e-16
plot(model2$resid)
windows(7,4)
par(mfrow=c(1,2))
acf(model$resid, main="")
acf(model$resid, type="p", main="")



#check by month 
#check other trends
#add in other years of data




##Wavelet stuff

library(WaveletComp)

#example from instructions
#x=periodic.series(start.period=50, length=1000)
#x= x+0.2*rnorm(1000)
#mydata<-data.frame(x=x)
#my.w<-analyze.wavelet(mydata, "x", loess.span = 0,
#            dt=1, dj=1/250,
#             lowerPeriod = 16,
#            upperPeriod = 128,
#            make.pval = TRUE, n.sim= 10)
#wt.image(my.w, color.key = "quantile", n.levels=250, 
# legend.params = list("wavelet power levels"))

#prepare data
ysidata<-as.data.frame(ysi19)
ysidata$conductivity<-ifelse(ysidata$conductivity>70,0, ysidata$conductivity) #remove section with weird conductivity
ysidata[ysidata==0]<-NA #change 0s to NA
ysidata<-ysidata[complete.cases(ysidata),]

#temperature 
ysi.temp<-ysidata[, c("date", "temp")]

my.w<- analyze.wavelet(ysi.temp, "temp", loess.span = 0,
                       dt=1, dj=1/250,
                       lowerPeriod = 16,
                       upperPeriod = 128,
                       make.pval = TRUE, n.sim= 10)
wt.image(my.w, color.key = "quantile", n.levels=250, 
         legend.params = list("wavelet power levels"))

#temperature 
ysi.ph<-ysidata[, c("date", "ph")]

w.ph<- analyze.wavelet(ysi.ph, "ph", loess.span = 0,
                       dt=1, dj=1/250,
                       lowerPeriod = 16,
                       upperPeriod = 128,
                       make.pval = TRUE, n.sim= 10)
wt.image(w.ph, color.key = "quantile", n.levels=250, 
         legend.params = list("wavelet power levels"))

#missing: period (hours) on y axis and month on x axis 
#         or period(days) on y axis and month on x axis











