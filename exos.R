library(data.table)
library(tidyverse)
library(stringi)
library(lubridate)
library(dplyr)
library(tsibble)
library(tibbletime) 
#note: I prefer the package tsibble which includes some new features. tibbletime is actually retired. but tsibble was having trouble parsing the time column for some reason. it is more tempermental. there is also a timetk package I haven't used as much

setwd("C:/Users/fried/OneDrive/Desktop/YSI Data") #your data directory. might work with the "Box Sync" client as well, haven't tried
files <- list.files(pattern = ".csv") #create list of files in directory

#bind files into a list. skips the first 8 lines (EXO summary data). creates a column noting the source file of each entry
exolist<-Map(cbind, lapply(files, fread,sep=",",skip=8), filename = files) 

#fread function can't work with the files as they come out of YSI (in UTF-16 format). 
#I had to re-save them in Excel to change them to UTF-8. The YSI outputs should either be converted in bulk in the future, or maybe there's a setting in the KorEXO template.
exodata<-rbindlist(exolist,use.names=TRUE,fill=TRUE) #bind list entries into single merged data frame

colnames(exodata)<-c("Date","Time","Time.fracsec","Sitename","Chlor.RFU","Cond.uScm",
                     "nLF.Cond.uScm","DO.percsat","DO.perclocal","DO.mgL","ORP.mV",
                     "S.PSU","SpCond.uScm","TAL.PE.RFU","TDS.mgL","Wiperpos.V",
                     "pH","pH.mV","TempC","BattV","CablepwrV","filename") #rename columns to easier names

#I find that R does best when you break up the date column into its parts and put them back together into a date
exodata<-exodata%>%separate(Date,c("Month","Day","Year"),sep="/") #break date into its parts
exodata<-exodata%>%separate(Time,c("Hour","Minute","Second")) #break time into its parts
exodata$Datetime<-ymd_hms(paste(exodata$Year,exodata$Month,exodata$Day," ",exodata$Hour,":",exodata$Minute,":",exodata$Second)) #paste them together again and make a date
exodata$Date<-as_date(date(exodata$Datetime)) #create a date column again

exodata<- distinct(exodata)#remove any duplicate rows
exodata<-subset(exodata,is.na(exodata$Datetime)==FALSE) #remove any NAs

exodata <- exodata %>% 
  mutate_at(c(9:25), as.numeric) #make any columns that might be stuck as factors numeric
exotbl<-as_tbl_time(exodata,index=Datetime) #create a time tibble
exotbl<- exotbl %>% arrange(ymd_hms(exotbl$Datetime)) #order by day

#this syntax can be used to aggregate the data by all sorts of periods including week, hour, etc
exoday<-exotbl %>%
  collapse_by("day") %>%
  group_by(Datetime,Date)%>%
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))


#create plots for data points
ggplot(exoday,aes(Date,pH))+
  geom_point(cex=1,alpha=0.5)+
  ylab(expression(paste("pH")))+
  xlab(element_blank())+
  theme_classic(base_size=20)+
  theme(legend.position = "bottom")
