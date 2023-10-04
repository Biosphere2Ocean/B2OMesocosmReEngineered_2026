library(data.table)
library(tidyverse)
library(stringi)
library(lubridate)
library(dplyr)
library(tsibble)
library(tibbletime) 
library(ggplot2)
library(readxl) #including readxl package to read some of the folder files in excel format
#note: I prefer the package tsibble which includes some new features. tibbletime is actually retired. but tsibble was having trouble parsing the time column for some reason. it is more tempermental. there is also a timetk package I haven't used as much

#import hobo ph data
setwd("Data/RawData/RawData_HOBO/pH/") #your data directory. might work with the "Box Sync" client as well, haven't tried
path = "Data/RawData/RawData_HOBO/pH/"
csv <- list.files(path, pattern = ".csv") #create list of csvs in directory
#xls<-list.files(path, pattern = ".xls") #create list of excel files in director

#bind csv files into list. skips the first 2 lines. creates a column noting the source file of each entry
hobocsvlist<-Map(cbind, lapply(csv, fread,sep=",",skip=2), filename = csv)

#bind xls files into list. skips the first line. creates a column noting the source file of each entry
#hoboxlslist<-Map(cbind, lapply(xls, read_excel,skip=1), filename = xls)

hobocsv<-rbindlist(hobocsvlist,use.names=TRUE,fill=TRUE) #bind csv list entries into single merged data frame
hobocsv<-hobocsv[,c(1:4,15)]#exclude some of the calibration related data
colnames(hobocsv)<-c("Datetime","TempF","mV","pH","filename") #rename columns
hobocsv$Datetime<-as_datetime(hobocsv$Datetime) #change col1 format to date

#hoboxls<-rbindlist(hoboxlslist,use.names=TRUE,fill=TRUE) #bind xls list into single merged data frame
#hoboxls<-hoboxls[,c(2:6)] #remove col1
#colnames(hoboxls)<-c("Datetime","TempF","mV","pH","filename") #rename columns
#hoboxls$Datetime<-as_datetime(hoboxls$Datetime)#change col1 format to date

hoboph<- hobocsv #rbind(hobocsv,hoboxls) #bind the two data frames
hoboph$Date<-as_date(hoboph$Datetime) #create a date-only column
hoboph<- distinct(hoboph)#remove any duplicate rows
hoboph<-subset(hoboph,is.na(hoboph$Datetime)==FALSE) #remove any NAs



hoboph <- hoboph %>% 
  mutate_at(c(2:4), as.numeric) #make any columns that might be stuck as factors numeric
hoboph<-as_tbl_time(hoboph,index=Datetime) #create a time tibble
hobotbl<- hoboph %>% arrange(ymd_hms(hoboph$Datetime)) #order by day

#this syntax can be used to aggregate the data by all sorts of periods including week, hour, etc
hobophday<-hobotbl %>%
  collapse_by("day") %>%
  group_by(Datetime,Date)%>%
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))

#subset out dates after October
fall<-hobophday %>% 
  filter_time('2021-10-01 0:00' ~ '2022-06-10 12:00')


#create plots for data points
ggplot(fall,aes(Date,pH))+
  geom_point(cex=1,alpha=0.5)+
  ylab(expression(paste("pH")))+
  xlab(element_blank())+
  theme_classic(base_size=20)+
  theme(legend.position = "bottom")
