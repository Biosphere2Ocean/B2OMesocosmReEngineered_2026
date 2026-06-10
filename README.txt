---------------------------------------------
# General Information
This repository contains data and code for the associated manuscript "The Biosphere 2 Ocean mesocosm: (re)engineered for state-of-the-art coral reef resilience experiments". 

## Contact Information
Principal Investigator: Diane Thompson
ORCID: 0000-0002-6181-1259  
Institution: University of Arizona  
Email: thompsod@arizona.edu  

Co-Investigator/Responsible for Repository: Renee Grambihler 
ORCID: 0009-0009-2263-0533  
Institution: University of Arizona  
Email: rgrambihler@me.com

## Data Information
Date of data collection: 2011-07-22 - 2024-9-05  

Geographic location of data collection: Biosphere 2 Ocean, Oracle, Arizona, USA  

Funding sources:  

Preferred citation: 


## Sharing/Access Information
License:  
CC BY 4.0 (Data)  
MIT (Code)  

Raw data can also be accessed from the [Biosphere 2 Database](https://biosphere2.org/biosphere-2-ocean-scada-data).

---------------------------------------------

# Methodological Information
This repository includes data files, quality control code, data analyses code, and figure-making code.

The data used in this analysis were recorded by multiple instruments between 2011 and 2024 and stored in the Biosphere 2 SCADA Database. Over this time period, various Multiparameter Sondes (YSI) recorded environmental parameters at 15-minute intervals, including temperature (◦C), salinity (PSU), pH, and dissolved oxygen (mg/L). Colorimetry and titration tests (Hach) were performed weekly and included alkalinity (mg/L), nitrate (mg/L), phosphate (mg/L), iron (mg/L), and silicate (mg/L).

## Collection and Generation of Data


## Processing Data

---------------------------------------------

# Data and File Overview
.  
├── README.md: This document  
├── Metadata: directory containing additional metadata files  
├── Code: directory containing all code that accompanies this manuscript  
    ├── 01-DataWrangling: subdirectory  
    │   ├── 01-YSI-DataWrangling-2011-2022.Rmd  
    │   ├── 02-YSI-DataWrangling-2022-Present.Rmd  
    │   ├── 03-Hach-DataWrangling.Rmd  
    │   ├── 04-HachYSI-DataWrangling.Rmd  
    │   └── 05-WorldOceans-DataWrangling.Rmd  
    ├── 02-QualityControl: subdirectory  
    │   ├── Hach-QualityControl.Rmd  
    │   └── YSI-DataQC.Rmd  
    ├── 03-Statistics: subdirectory  
    │   ├── 
    ├── 04-FigureMaking: subdirectory  
    │   ├── 
    ├── Functions: subdirectory 
    │   ├── 
├── InputData: directory containing data files input to code  
    ├── Raw: subdirectory 
    │   ├── Hach: subdirectory  
    │   ├── YSI: subdirectory containing environmental data files from YSI multiparameter sondes in the Biosphere 2 Ocean
    │   │   ├── ProDSS: subdirectory containing files from YSI ProDSS multiparameter sonde
        │   │   └── prodssbackup-231117-240112.csv
    │   │   ├── SCADA_2011_2021: subdirectory containing files from YSI EXO multiparameter sonde from 2011-2021
    │   │   ├── SCADA_2019_2022: subdirectory containing files from YSI EXO2 and EXO3 multiparameter sondes from 2019-2022 
    │   │   └── SCADA_2022_2024: subdirectory containing files from YSI EXO3 multiparameter sonde from 2022-2024,
    │   └── WorldOceans: subdirectory  
    ├── Clean: subdirectory containing cleaned data files run through data wrangling code  
    │   ├── 01-DataWrangling: subdirectory   
├── OutputData: directory containing data files output from code  
├── Figures: directory containing figures produced from the code files in this manuscript  

---------------------------------------------

# Data Specific Information