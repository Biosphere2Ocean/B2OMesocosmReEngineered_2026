---------------------------------------------
# GENERAL INFORMATION
This repository contains data and code for the associated manuscript "The Biosphere 2 Ocean mesocosm: (re)engineered for state-of-the-art coral reef resilience experiments". 

## CONTACT INFORMATION
Principal Investigator: Diane Thompson
ORCID: 0000-0002-6181-1259  
Institution: University of Arizona  
Email: thompsod@arizona.edu  

Co-Investigator/Responsible for Repository: Renee Grambihler 
ORCID: 0009-0009-2263-0533  
Institution: University of Arizona  
Email: rgrambihler@me.com

## DATA INFORMATION
Date of data collection: 2011-07-22 - 2024-09-05  

Geographic location of data collection: Biosphere 2 Ocean, Oracle, Arizona, USA  

Funding sources:  

## SHARING/ACCESS INFORMATION 
License:  
CC BY 4.0 (Data)  
MIT (Code)  

Main Dataset Access and Citation: 
In addition to in this repository, Biosphere 2 Ocean raw data from 2021-05-26 - 2024-09-05 can also be accessed from the Biosphere 2 Database: https://biosphere2.org/biosphere-2-ocean-scada-data).

***Need Preferred Citation for B2O dataset***

Ancilliary Dataset Access and Citation: NCEI World Ocean Database
National Oceanic and Atmospheric Administration; NOAA Atlantic Oceanographic and Meteorological Laboratory; Cooperative Institute for Marine and Atmospheric Studies (2018). National Coral Reef Monitoring Program: Carbonate chemistry data collected in the Atlantic Ocean. NOAA National Centers for Environmental Information. Dataset. https://doi.org/10.25921/vfz0-dg77. Accessed Sept 9 2024.

Ecosystem Sciences Division, Pacific Islands Fisheries Science Center (2018). National Coral Reef Monitoring Program: Water chemistry of the coral reefs in the Pacific Ocean. NOAA National Centers for Environmental Information. Dataset. https://doi.org/10.25921/nnk7-5f86. Accessed Sept 9 2024.

---------------------------------------------
# SUMMARY 
As climate change and anthropogenic pressures accelerate the decline of coral reef ecosystems globally, there is a critical need for scalable, controlled experimental platforms that enable robust testing of reef resilience strategies. The Biosphere 2 Ocean (B2O)—a 2.6-million-liter, closed-system mesocosm—has been re-engineered to address this need. Originally constructed in the late 1980s to replicate a Caribbean reef, the B2O now features advanced life support systems, upgraded hydrodynamics, precise thermal regulation, and programmable lighting to simulate future ocean conditions. The associated paper outlines a three-phase research program focused on restoring degraded reef systems and developing pan-global, climate-resilient coral communities. The data, statistical analyses, and visualizations contained within this repository are associated with Phase 1, which involved physical and biological remediation, detailed monitoring of water quality and biogeochemical cycling, and the reintroduction of key herbivores. 


# METHODOLOGICAL INFORMATION
## COLLECTION AND GENERATION OF DATA
The data used in this analysis labeled 'YSI' were recorded by multiple instruments between 2011 and 2024 and stored in the Biosphere 2 SCADA Database. Over this time period, various Multiparameter Sondes (YSI brand) recorded environmental parameters at 15-minute intervals. The parameters were Temperature (ºF), Temperature (ºC), pH, pH (mV), Salinity (PSU), Conductivity (µS/cm), Conductivity, Non-Linear Function (µS/cm), Conductivity, Specific (µS/cm), Dissolved Oxygen (mg/L), Dissolved Oxygen, Saturated (%), Dissolved Oxygen, Local (%), Oxygen Reduction Potential (mV), Chlorophyll (RFU), Total Algae (RFU), Chlorophyll (µg/L), Total Algae (cells/L), and Total Dissolved Solids (mg/L). 

The data used in this analysis labeled 'Hach' were measured using colorimetry and titration tests (Hach brand), which were performed twice weekly and included the parameters Turbidity (FAU), Phosphate (mg/L), Nitrate Mid-Range, Nitrate High-Range (mg/L), pH, Alkalinity (mg/L CaCO3), Silica (mg/L), Iron (mg/L), and Ammonia (mg/L).

Additional data from tropical oceans around the world were retrieved from the NCEI World Ocean Database to compare to the B2O data. 

## PROCESSING DATA
Due to the large nature of the YSI dataset, data were quality controlled by removing outlier points that exceeded 2 standard deviations from the daily mean or median. The comparison to either mean or median depended on if the distriution of the day's data was normal or not. A normal distribution compared to the mean, and a non-normal distribution compared to the median. Additionally, cutoff values were identified based on the known possible bounds for each variable in general (eg. silicate cannot be less than 0 mg/L) and during different points in the data's history. Data outside of these values were considered outliers and removed. 

Hach data were quality controlled by identifying general cutoff values and removing data points outside of those values. 

Statistical analyses for the YSI and Hach data invovled taking the median of all variables at daily, weekly, monthly, and yearly time intervals. 

Statistical analyses for the World Oceans data invovled taking the mean of each region for each year of the dataset in addition to taking the mean of each region for the combined years 2021-2024. 

---------------------------------------------

# DATA AND FILE OVERVIEW
The following is a data tree of the files contained within this repository. Full summaries and variable descriptions for each file can be found in the next section titled "Data Specific Information".

.  
├── README.md: This document  
├── Metadata: directory containing additional metadata file for YSI data
    └── YSI-metadata.xlsx
├── Code: directory containing all code that accompanies this manuscript  
    ├── 01-DataWrangling: subdirectory containing code files for wrangling data files used in downstream analyses  
    │   ├── 01-YSI-DataWrangling-2011-2022.Rmd  
    │   ├── 02-YSI-DataWrangling-2022-Present.Rmd  
    │   ├── 03-Hach-DataWrangling.Rmd  
    │   └── 04-WorldOceans-DataWrangling.Rmd  
    ├── 02-QualityControl: subdirectory containing code files for quality controlling cleaned files from data wrangling code  
    │   ├── Hach-DataQC.Rmd  
    │   └── YSI-DataQC.Rmd  
    ├── 03-Statistics: subdirectory containing code file for running statistics on the cleaned and quality controlled data   
    │   └── HachYSI-DescriptiveStatistics.Rmd
    ├── 04-FigureMaking: subdirectory containing code files for making the figures in the associated manuscript that are associated with this dataset  
    │   ├── HachYSI-Figures.Rmd
    │   └── WorldOceans-Figures.Rmd
├── InputData: directory containing data files input to code  
    ├── Raw: subdirectory 
    │   ├── Hach: subdirectory containing data file from colorimetry and titration nutrients water quality testing 
    │   │   └── B2ONutrientData.xlsx
    │   ├── YSI: subdirectory containing environmental data files from YSI multiparameter sondes in the Biosphere 2 Ocean
    │   │   ├── ProDSS: subdirectory containing data files from YSI ProDSS multiparameter sonde
    │   │   │   └── prodssbackup-231117-240112.csv
    │   │   ├── SCADA_2011_2021: subdirectory containing files from YSI EXO multiparameter sonde from 2011-2021
    │   │   │   ├── Ocean_FTP_Data - pre 2014-8-11.csv
    │   │   │   ├── Ocean_FTP_Data.csv
    │   │   │   ├── Ocean_FTP_Data_Acq.csv
    │   │   │   └── ocean_scada_data_2016_2021.xlsx
    │   │   ├── SCADA_2019_2022: subdirectory containing data files from YSI EXO2 and EXO3 multiparameter sondes from 2019-2022 
    │   │   │   ├── UAB2_B240001_YSI_EXO3_CHLORO_617107.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_COND_U_617936.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_NLF_CO_661668.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_ODO__L_632594.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_ODO__S_635338.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_ODO_MG_645798.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_ORP_MV_647084.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_PH_662411.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_PH_MV_663459.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_SAL_PS_647937.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_SPCOND_648943.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_TAL_PE_650659.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_TDS_MG_653051.csv
    │   │   │   ├── UAB2_B240001_YSI_EXO3_TEMP_C_655738.csv
    │   │   │   └── UAB2_B240001_YSI_EXO3_TEMP_F_659351.csv
    │   │   └── SCADA_2022_2024: subdirectory containing files from YSI EXO3 multiparameter sonde from 2022-2024
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_CHLOROPHYLL_RFU.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_COND_USPCM.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_NLF_COND_USPCM.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_ODO__LOCAL.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_ODO__SAT.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_ODO_MGPL.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_ORP_MV.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_PH.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_PH_MV.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_SAL_PSU.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_SPCOND_USPCM.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_TAL_PE_RFU.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_TDS_MGPL.csv
    │   │   │   ├── UAB2_BIO1_B4000_YSI_EXO3_TEMP_C.csv
    │   │   │   └── UAB2_BIO1_B4000_YSI_EXO3_TEMP_F.csv
    │   └── WorldOceans: subdirectory containing files used to compile water quality data from oceans around the world, these files were not directly used in code but rather manipulated in MS Excel to compile a cleaned file called `01-Clean-WorldOceanData.csv`
    │   │   ├── CRCP_Carbonate_Chemistry_Atlantic_be0f_43c1_53bd.csv
    │   │   └── CRCP_Carbonate_Chemistry_Pacific_2198_7707_9695.csv
    ├── Clean: subdirectory containing cleaned data files run through Data Wrangling code and Quality Control code  
    │   ├── 01-DataWrangling: subdirectory containing cleaned data files from Data Wrangling 
    │   │   ├── Hach-Data-Clean.csv
    │   │   ├── WorldOceans-Data-Clean-Final.csv
    │   │   ├── WorldOceans-Data-Clean.csv
    │   │   ├── YSI-Data-Clean-2011-2022.csv
    │   │   └── YSI-Data-Clean-All.csv
    │   ├── 02-QualityControl: subdirectory containing data files output from Quality Control code
    │   │   ├── Hach-Data-QC.csv
    │   │   ├── YSI-Data-QC.csv
    │   │   └── YSI-Data-QC-Cutoff.csv
├── OutputData: directory containing data files output from Statistics code  
    │   ├── DescriptiveStatistics: subdirectory containing data files output from Statistics code
    │   │   ├── HachYSI-Data-Medians-All.csv
    │   │   ├── HachYSI-Data-Medians-Daily.csv
    │   │   ├── HachYSI-Data-Medians-Weekly.csv
    │   │   ├── HachYSI-Data-Medians-Monthly.csv
    │   │   ├── HachYSI-Data-Medians-Yearly.csv
    │   │   ├── WorldOceans-Data-Mean-2021-2024.csv
    │   │   └── WorldOceans-Data-MeanPerYear.csv
├── Figures: directory containing figures produced from the Figure Making code files in this manuscript  
    │   ├── HachYSI-1x3CurrentPlot.png
    │   ├── HachYSI-1x3HistoryPlot.png
    │   ├── HachYSI-NutWatQualPlot-Climatology.png
    │   └── HachYSI-NutWatQualPlot-TimeSeries.png
└── B2OMesocosmReEngineered_2026.Rproj: R project file for repository

---------------------------------------------
# DATA-SPECIFIC INFORMATION