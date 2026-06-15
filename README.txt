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


---------------------------------------------
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
The following is a data tree of the files contained within this repository. Full summaries and variable descriptions for each data file can be found in the next section titled "Data-Specific Information". Short sumamries of the code files are listed in this section. 

.  
├── README.md: This document  
├── Metadata: directory containing additional metadata file for YSI data
    └── YSI-metadata.xlsx
├── Code: directory containing all code that accompanies this manuscript  
    ├── 01-DataWrangling: subdirectory containing code files for wrangling data files used in downstream analyses  
    │   ├── 01-YSI-DataWrangling-2011-2022.Rmd: Data wrangling code for YSI data from 2011-2022
    │   ├── 02-YSI-DataWrangling-2022-2024.Rmd: Data wrangling code for YSI data from 2022-2024
    │   ├── 03-Hach-DataWrangling.Rmd: Data wrangling code for Hach data
    │   └── 04-WorldOceans-DataWrangling.Rmd: Data wrangling code for World Oceans data  
    ├── 02-QualityControl: subdirectory containing code files for quality controlling cleaned files from data wrangling code  
    │   ├── Hach-DataQC.Rmd: quality control code for Hach data 
    │   └── YSI-DataQC.Rmd: quality control code for YSI data 
    ├── 03-Statistics: subdirectory containing code file for running statistics on the cleaned and quality controlled data   
    │   └── HachYSI-DescriptiveStatistics.Rmd: code for running descriptive statistics on Hach and YSI data
    ├── 04-FigureMaking: subdirectory containing code files for making the figures in the associated manuscript that are associated with this dataset  
    │   ├── HachYSI-Figures.Rmd: code for making Hach and YSI figures
    │   └── WorldOceans-Figures.Rmd: code for making World Oceans figures
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
    │   └── WorldOceans: subdirectory containing files used to compile water quality data from oceans around the world, these files were not directly used in code but rather manipulated in MS Excel to compile a cleaned file called `WorldOceans-Data-Clean.csv`
    │   │   ├── CRCP_Carbonate_Chemistry_Atlantic_be0f_43c1_53bd.csv
    │   │   └── CRCP_Carbonate_Chemistry_Pacific_2198_7707_9695.csv
    ├── Clean: subdirectory containing cleaned data files run through Data Wrangling code and Quality Control code  
    │   ├── 01-DataWrangling: subdirectory containing cleaned data files from Data Wrangling 
    │   │   ├── Hach-Data-Clean.csv
    │   │   ├── WorldOceans-Data-Clean-Final.csv
    │   │   ├── WorldOceans-Data-Clean.csv
    │   │   ├── WorldOceans-RegionsCoordinates-Clean.csv
    │   │   ├── YSI-Data-Clean-2011-2022.csv
    │   │   └── YSI-Data-Clean-All.csv
    │   ├── 02-QualityControl: subdirectory containing data files output from Quality Control code
    │   │   ├── Hach-Data-QC.csv
    │   │   ├── YSI-Data-QC.csv
    │   │   └── YSI-Data-QC-Cutoff.csv
├── OutputData: directory containing data files output from Statistics code  
    ├── HachYSI-Data-Medians-All.csv
    ├── HachYSI-Data-Medians-Daily.csv
    ├── HachYSI-Data-Medians-Weekly.csv
    ├── HachYSI-Data-Medians-Monthly.csv
    ├── HachYSI-Data-Medians-Yearly.csv
    ├── WorldOceans-Data-Mean-2021-2024.csv
    └── WorldOceans-Data-MeanPerYear.csv
├── Figures: directory containing figures produced from the Figure Making code files in this manuscript  
    ├── HachYSI-1x3CurrentPlot.png
    ├── HachYSI-1x3HistoryPlot.png
    ├── HachYSI-NutWatQualPlot-Climatology.png
    └── HachYSI-NutWatQualPlot-TimeSeries.png
└── B2OMesocosmReEngineered_2026.Rproj: R project file for repository


---------------------------------------------
# DATA-SPECIFIC INFORMATION
YSI-metadata.xlsx: spreadsheet of metadata for YSI data files
  Sheet 1: Metadata: lists and descriptions of variables, units, files, dates, and sources for files
    - Number of variables: 19
    - Number of cases/rows: 123
    - Variable List: 
        Variable_Name: alphanumeric; name of variables in each file
        Varible_Description: character; description of variable 
        Units: alphanumeric; units of variable 
        File_Name: alphanumeric; name of file variable is found in
        File_Start_Date: date; start date of file variable is found in; mm/dd/yy
        File_End_Date: date; end date of file variable is found in; mm/dd/yy
        Data_Source_File: character; where file is from, source of file
        Data_Source_Instrument: alphanumeric; instrument file is from
        Data_Source_Person: character; name of person file was obtained from
        Missing_Dates_Start_1: first start date (mm/dd/yy) of data missing from file
        Missing_Dates_End_1: first end date (mm/dd/yy) of data missing from file
        Missing_Dates_Start_2: second start date (mm/dd/yy) of data missing from file
        Missing_Dates_End_2: second end date (mm/dd/yy) of data missing from file
        Missing_Dates_Start_3: third start date (mm/dd/yy) of data missing from file
        Missing_Dates_End_3: third end date (mm/dd/yy) of data missing from file
        Missing_Dates_Start_4: fourth start date (mm/dd/yy) of data missing from file
        Missing_Dates_End_4: fourth end date (mm/dd/yy) of data missing from file
        Missing_Dates_Start_5: fifth start date (mm/dd/yy) of data missing from file
        Missing_Dates_End_5: fifth end date (mm/dd/yy) of data missing from file
    - Missing data codes: none/blank space
  Sheet 2: Data Check Matrix: matrix with variable names on y-axis and file names on x-axis to map which files contain which variables since there is overlap
    - Number of variables: 37
    - Number of cases/rows: 61
    - Variable List: 
        Variable_Name: alphanumeric; name of variable found in files
        ocean_scada_data_2016_2021.xlsx: YSI SCADA data from 12/6/2016 - 5/25/2021  
        UAB2_B240001_YSI_OCEANBGA_PE_593908.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for phycoerythrin
        UAB2_B240001_YSI_OCEANCHLORO_595563.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for chlorophyll in cells/L
        UAB2_B240001_YSI_OCEANCONDUC_597443.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for electrical conductivity in miliSiemens/cm
        UAB2_B240001_YSI_OCEANORP_598894.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for oxidative-reduction potential in mV
        UAB2_B240001_YSI_OCEANPH_600334.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for pH
        UAB2_B240001_YSI_OCEANSALANI_602884.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for salinity in ppt
        UAB2_B240001_YSI_OCEANTMP_604270.csv: YSI SCADA data from old database from 10/21/19-5/26/21 for temperature in degrees Celcius
        UAB2_BIO1_B4000_YSI_EXO3_BATTERY_V_688363.csv: YSI SCADA data from new database from 1/22/22-present for battery power of the instrument in Volts
        UAB2_BIO1_B4000_YSI_EXO3_CABLE_PWR_V_689040.csv: YSI SCADA data from new database from 1/22/22-present for cable power of the instrument in Volts
        UAB2_BIO1_B4000_YSI_EXO3_CHLOROPHYLL_RFU_687484.csv: YSI SCADA data from new database from 1/22/22-present for chlorophyll in RFU
        UAB2_BIO1_B4000_YSI_EXO3_COND_USPCM_686791.csv: YSI SCADA data from new database from 1/22/22-present for electrical conductivity in µSiemens/cm
        UAB2_BIO1_B4000_YSI_EXO3_DATE_MMDDYY_684687.csv: YSI SCADA data from new database from 1/22/22-present for date in mm-dd-yy
        UAB2_BIO1_B4000_YSI_EXO3_NLF_COND_USPCM_675074.csv: YSI SCADA data from new database from 1/22/22-present for non-linear electrical conductivity in µSiemens/cm
        UAB2_BIO1_B4000_YSI_EXO3_ODO__LOCAL_685469.csv: YSI SCADA data from new database from 1/22/22-present for local dissolved oxygen in %
        UAB2_BIO1_B4000_YSI_EXO3_ODO__SAT_683139.csv: YSI SCADA data from new database from 1/22/22-present for saturated dissolved oxygen in %
        UAB2_BIO1_B4000_YSI_EXO3_ODO_MGPL_684055.csv: YSI SCADA data from new database from 1/22/22-present for for dissolved oxygen in mg/L
        UAB2_BIO1_B4000_YSI_EXO3_ORP_MV_682052.csv: YSI SCADA data from new database from 1/22/22-present for oxidative-reduction potential in miliVolts
        UAB2_BIO1_B4000_YSI_EXO3_PH_673160.csv: YSI SCADA data from new database from 1/22/22-present for pH in pH units
        UAB2_BIO1_B4000_YSI_EXO3_PH_MV_672635.csv: YSI SCADA data from new database from 1/22/22-present for pH in miliVolts
        UAB2_BIO1_B4000_YSI_EXO3_SAL_PSU_682617.csv: YSI SCADA data from new database from 1/22/22-present for salinity in PSU
        UAB2_BIO1_B4000_YSI_EXO3_SPCOND_USPCM_681325.csv: YSI SCADA data from new database from 1/22/22-present for specific electrical conductivity in µSiemens/cm
        UAB2_BIO1_B4000_YSI_EXO3_TAL_PE_RFU_680581.csv: YSI SCADA data from new database from 1/22/22-present for for total algae phycoerytherin in RFU
        UAB2_BIO1_B4000_YSI_EXO3_TDS_MGPL_679560.csv: YSI SCADA data from new database from 1/22/22-present for total dissolved solids in mg/L
        UAB2_BIO1_B4000_YSI_EXO3_TEMP_C_680104.csv: YSI SCADA data from new database from 1/22/22-present for temperature in degrees Celcius
        UAB2_BIO1_B4000_YSI_EXO3_TEMP_F_675540.csv: YSI SCADA data from new database from 1/22/22-present for temperature in degrees Fahrenheit
        UAB2_BIO1_B4000_YSI_EXO3_TIME_HHMMSS_678335.csv: YSI SCADA data from new database from 1/22/22-present for time in HH:MM:SS
        UAB2_BIO1_B4000_YSI_EXO3_WIPER_POS_V_674331.csv: YSI SCADA data from new database from 1/22/22-present for wiper position in Volts
        Ocean_Data_new_15minAVG.csv: YSI SCADA data from 10/17/18-5/25/21 for multiple variables 
        Ocean_Data_new.csv: YSI SCADA data from 10/12/18-5/25/21 for multiple variables 
        Ocean_FTP_Data - pre 2014-8-11.csv: YSI SCADA data from 7/22/11-8/4/14 for multiple variables 
        Ocean_FTP_Data - upto_2014_10_20.csv: YSI SCADA data from 10/3/14-10/20/14 for multiple variables 
        Ocean_FTP_Data_Acq.csv: YSI SCADA data from 7/3/13-3/12/15 for multiple variables 
        Ocean_FTP_Data_Extended.csv: YSI SCADA data from 11/18/16-6/12/18 for multiple variables 
        Ocean_FTP_Data.csv: YSI SCADA data from 10/3/24-5/8/18 for multiple variables 
        Ocean_FTP_fullset_Data.csv: YSI SCADA data from 7/11/16-10/6/16 for multiple variables 
    - Missing data codes: none/blank space
  Sheet 3: Data Timeline: matrix with file or database name on y-axis and year on x-axis
    - Number of variables: 14
    - Number of cases/rows: 13
    - Variable List: 
        File_Name: character; name of file or database
        2011: date in m/dd/YY of interval of missing data points for 2011
        2012: date in m/dd/YY of interval of missing data points for 2012
        2013: date in m/dd/YY of interval of missing data points for 2013
        2014: date in m/dd/YY of interval of missing data points for 2014
        2015: date in m/dd/YY of interval of missing data points for 2015
        2016: date in m/dd/YY of interval of missing data points for 2016
        2017: date in m/dd/YY of interval of missing data points for 2017
        2018: date in m/dd/YY of interval of missing data points for 2018
        2019: date in m/dd/YY of interval of missing data points for 2019
        2020: date in m/dd/YY of interval of missing data points for 2020
        2021: date in m/dd/YY of interval of missing data points for 2021
        2022: date in m/dd/YY of interval of missing data points for 2022
        2023: date in m/dd/YY of interval of missing data points for 2023
    - Missing data codes: none/blank space

B2ONutrientData.xlsx: all Biosphere 2 Systems nutrient water quality data obtained via colorimetry and titration (Hach brand); systems include Ocean, Mangroves, and 2 Coral Raceways; sheet "Pre-formatted Data" holds data from 2017-2022; sheet "Data" holds data from 2022-2024 that is formatted more for analysis in R.
  Sheet 1: Pre-formatted Data
    - Number of variables: 40
    - Numer of rows: 252
    - Variable List: 
        Date: date in mm/dd/yyyy  
        Turbidity: numeric; Ocean turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)  
        Phosphate: numeric; Ocean phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
        Nitrate MR: numeric; Ocean nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
        Nitrate HR: numeric; Ocean nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
        pH: numeric; Ocean pH in pH units  
        Alkalinity: numeric; Ocean calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L  
        Silica: numeric; Ocean silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
        Iron: numeric; Ocean iron concentration in range 0.009-1.400 measured in mg/L  
        Ammonia: numeric; Ocean ammonia (NH3) concentration in range 0.01-0.50 measured in mg/L  
        ORP: numeric; Ocean oxidation-reduction potential (ORP) measured in miliVolts  
        Turbidity: numeric; Mangroves turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)  
        Phosphate: numeric; Mangroves phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
        Nitrate MR: numeric; Mangroves nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
        Nitrate HR: numeric; Mangroves nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
        pH: numeric; Mangroves pH in pH units  
        Alkalinity: numeric; Mangroves calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L
        Silica: numeric; Mangroves silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
        ORP: numeric; Mangroves oxidation-reduction potential (ORP) measured in miliVolts  
        Turbidity: numeric; Raceway 1 turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)  
        Phosphate: numeric; Raceway 1 phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
        Nitrate MR: numeric; Raceway 1 nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
        Nitrate HR: numeric; Raceway 1 nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
        pH: numeric; Raceway 1 pH in pH units  
        Alkalinity: numeric; Raceway 1 calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L
        Silica: numeric; Raceway 1 silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
        Iron: numeric; Raceway 1 iron concentration in range 0.009-1.400 measured in mg/L  
        Ammonia: numeric; Raceway 1 ammonia (NH3) concentration in range 0.01-0.50 measured in mg/L  
        ORP: numeric; Raceway 1 oxidation-reduction potential (ORP) measured in miliVolts  
        Turbidity: numeric; Raceway 2 turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)  
        Phosphate: numeric; Raceway 2 phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
        Nitrate MR: numeric; Raceway 2 nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
        Nitrate HR: numeric; Raceway 2 nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
        pH: numeric; Raceway 2 pH in pH units  
        Alkalinity: numeric; Raceway 2 calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L
        Silica: numeric; Raceway 2 silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
        Iron: numeric; Raceway 2 iron concentration in range 0.009-1.400 measured in mg/L  
        Ammonia: numeric; Raceway 2 ammonia (NH3) concentration in range 0.01-0.50 measured in mg/L  
        Initials: character; initials of person or people taking measurements  
        Notes: character; key for color coding, any notes from that measurement  
    - Missing data codes: "NA"
  Sheet 2: Data
    - Number of variables: 13 
    - Number of rows: 660
    - Number of variables: 
        Date: date in mm/dd/yyy
        Location: character; location of measurements; Ocean, Mangroves, Raceway 1, or Raceway 2  
        Turbidity: numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)
        Phosphate: numeric; phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
        Nitrate MR: numeric; nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
        Nitrate HR: numeric; nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
        pH: numeric; pH in pH units  
        Alkalinity: calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L  
        Silica: numeric; silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
        Iron: numeric; iron concentration in range 0.009-1.400 measured in mg/L  
        Ammonia: numeric; ammonia (NH3) concentration in range 0.01-0.50 measured in mg/L  
        Initials: character; initials of person or people taking measurements  
        Notes: character; any notes from that measurement  
    - Missing data codes: "NA"

prodssbackup-231117-240112.csv: YSI ProDSS Multiparameter Sonde data from 11/17/2023 - 1/10/2024 when EXO3 was sent in for maintenance
  - Number of variables: 14
  - Number of cases/rows: 3720
  - Variable List: 
      Date: date; mm/dd/yy
      Time: time; HH:MM:SS
      Site: character; name of site being measured
      Unit ID: numeric; identifier for instrument in YSI software
      User ID: character; identifier for person associated with dataset being recorded
      ∞F: numeric; temperature in degrees Celsius
      DO %: numeric; dissolved oxygen in %
      DO mg/L: numeric; dissolved oxygen in mg/L
      C-uS/cm: numeric; electric conductivity in µSiemens/cm
      SAL-PSU: numeric; salinity in Potential Salinity Units
      pH: numeric; pH in pH units
      ORP mV: numeric; oxidative-reduction potential in miliVolts
      Chl RFU: numeric; chlorophyll in Relative Fluorescent Units
      PE RFU: numeric; total algae phycoerythrin in Relative Fluorescent Units
  - Missing data codes: "NA" 
  

Ocean_FTP_Data - pre 2014-8-11.csv: YSI SCADA data from 7/22/11 - 8/4/14
  - Number of variables: 7
  - Number of cases/rows: 60819
  - Variable List:
      datetime: datetime  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Temp_Crabwalk_F: numeric; Temperature (ºF)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Temp_C: numeric; Temperature (ºC)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_pH: numeric; pH  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Salinity: numeric; Salinity (Practial Salinity Units)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Conductivity: numeric; Conductivity (miliSiemens/cm)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_ORP: numeric; Oxygen Reduction Potential (miliVolts)  
  - Missing data codes: "NA"

Ocean_FTP_Data.csv: YSI SCADA data from 10/3/14 - 12/6/2016
  - Number of variables: 7
  - Number of cases/rows: 68065
  - Variable List: 
      datetime: datetime  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Temp_Crabwalk_F: numeric; Temperature (ºF)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Temp_C: numeric; Temperature (ºC)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_pH: numeric; pH  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Salinity: numeric; Salinity (Practial Salinity Units)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Conductivity: numeric; Conductivity (miliSiemens/cm)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_ORP: numeric; Oxygen Reduction Potential (miliVolts)  
  - Missing data codes: "NA"

Ocean_FTP_Data_Acq.csv: YSI SCADA data from 8/4/2014 - 10/3/2014
  - Number of variables: 7
  - Number of cases/rows: 5757
  - Variable List: 
      Time: datetime  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Temp_Crabwalk_F: numeric; Temperature (ºF)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Temp_C: numeric; Temperature (ºC)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_pH: numeric; pH  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Salinity: numeric; Salinity (Practical Salinity Units)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_Conductivity: numeric; Conductivity (miliSiemens/cm)  
      \\b2cdaqp\b2cdaq\DES_SAV_PLC.Ocean_ORP: numeric; Oxygen Reduction Potential (miliVolts)  
  - Missing data codes: "NA"

ocean_scada_data_2016_2021.xlsx: YSI SCADA data from 12/6/2016 - 5/25/2021  
  - Number of variables: 12
  - Number of cases/rows: 152077
  - Variable List: 
      DateTime: datetime  
      Crabwalk_Temp: numeric; Temperature (ºF)  
      Ocean_Temp: numeric; Temperature (ºC)  
      Ocean_pH: numeric; pH  
      Ocean_Salinity: numeric; Salinity (PSU)  
      Ocean_Conductivity: numeric; Conductivity (miliSiemens/cm)  
      Ocean_ORP: numeric; Oxygen Reduction Potential (miliVolts)  
      Ocean_APE: numeric; Total Algae (RFU)  
      Ocean_Chlorophyll: numeric; Chlorophyll (µg/L)  
      Ocean_RO: numeric; RO water flow (gallons/min)  
      Ocean_BGA: numeric; Total Algae (cells/L)  
      Ocean_DO: numeric; Dissolved Oxygen, Saturated (%)  
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_CHLORO_617107.csv: YSI SCADA data from 5/26/21-2/23/22 for chlorohyll in Relative Fluorescence Units
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; chlorophyll value in RFU  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_COND_U_617936.csv: YSI SCADA data from 5/26/21-2/23/22 for electrical conductivity in uSiemens/cm  
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; electrical conductivity value in uSiemens/cm  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_NLF_CO_661668.csv: YSI SCADA data from 5/26/21-2/23/22 for electrical conductivity as a non-linear function in uSiemens/cm  
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; electrical conductivity as a non-linear function in µSiemens/cm
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_ODO__L_632594.csv: YSI SCADA data from 5/26/21-2/23/22 for local dissolved oxygen in %
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; local dissolved oxygen value in %  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_ODO__S_635338.csv: YSI SCADA data from 5/26/21-2/23/22 for saturated dissolved oxygen in %
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; saturated dissolved oxygen value in %  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_ODO_MG_645798.csv: YSI SCADA data from 5/26/21-2/23/22 for dissolved oxygen in mg/L  
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; numeric; dissolved oxygen in mg/L  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_ORP_MV_647084.csv: YSI SCADA data from 5/26/21-2/23/22 for oxidation-reduction potential (ORP) in miliVolts 
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; oxidation-reduction potential value in miliVolts 
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_PH_662411.csv: YSI SCADA data from 5/26/21-2/23/22 for pH in pH units
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; pH value in pH units  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_PH_MV_663459.csv: YSI SCADA data from 5/26/21-2/23/22 for pH in miliVolts
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; pH value in miliVolts 
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA"

UAB2_B240001_YSI_EXO3_SAL_PS_647937.csv: YSI SCADA data from 5/26/21-2/23/22 for salinity in Potential Salinity Units  
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; salinity value in Potential Salinity Units 
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA" 
  
UAB2_B240001_YSI_EXO3_SPCOND_648943.csv: YSI SCADA data from 5/26/21-2/23/22 for specific conductivity in µSiemens/cm 
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; specific conductivity value in µSiemens/cm  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA" 
  
UAB2_B240001_YSI_EXO3_TAL_PE_650659.csv: YSI SCADA data from 5/26/21-2/23/22 for total algae phycoerythrin in RFU
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; total algae phycoerythrin value in RFU  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA" 
  
UAB2_B240001_YSI_EXO3_TDS_MG_653051.csv: YSI SCADA data from 5/26/21-2/23/22 for total dissolved solids in mg/L
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: total dissolved solids value in mg/L   
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable    
  - Missing data codes: "NA" 
  
UAB2_B240001_YSI_EXO3_TEMP_C_655738.csv: YSI SCADA data from 5/26/21-2/23/22 for temperature in degrees Celcius
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; temperature value in degrees Celcius  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_B240001_YSI_EXO3_TEMP_F_659351.csv: YSI SCADA data from 5/26/21-2/23/22 for temperature in degrees Fahrenheit
  - Number of variables: 7
  - Number of cases/rows: 26130
  - Variable List: 
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; temperature value in degrees Fahrenheit 
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_CHLOROPHYLL_RFU.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for chlorophyll in Relative Fluorescent Units
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; chlorophyll value in RFU  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_COND_USPCM.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for electrical conductivity in uSiemens/cm  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; electrical conductivity value in uSiemens/cm  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_NLF_COND_USPCM.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for electrical conductivity as a non-linear function in µSiemens/cm
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; electrical conductivity as a non-linear function in µSiemens/cm  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_ODO__LOCAL.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for local dissolved oxygen in %  
  - Number of variables: 7
  - Number of cases/rows: 126120
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; local dissolved oxygen value in %  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_ODO__SAT.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for saturated dissolved oxygen in %  
  - Number of variables: 7
  - Number of cases/rows: 126120
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; saturated dissolved oxygen value in %  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_ODO_MGPL.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for dissolved oxygen in mg/L  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; dissolved oxygen in mg/L  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_ORP_MV.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for oxidation-reduction potential value in miliVolts  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: oxidation-reduction potential value in miliVolts  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_PH.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for pH in pH units  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; pH value in pH units  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_PH_MV.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for pH in miliVolts  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; pH value in miliVolts  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_SAL_PSU.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for salinity in Potential Salinity Units  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; salinity value in Potential Salinity Units  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_SPCOND_USPCM.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for specific conductivity in µSiemens/cm  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; specific conductivity value in µSiemens/cm  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_TAL_PE_RFU.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for total algae phycoerythrin in RFU  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; total algae phycoerythrin value in RFU  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_TDS_MGPL.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for total dissolved solids in mg/L  
  - Number of variables: 7 
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; total dissolved solids value in mg/L  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_TEMP_C.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for temperature in degrees Celcius  
  - Number of variables: 7
  - Number of cases/rows: 126078
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; temperature value in degrees Celcius  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
UAB2_BIO1_B4000_YSI_EXO3_TEMP_F.csv: YSI EXO3 Multiparameter Sonde data from SCADA database from 5/26/2021 - 12/31/2024 for temperature in degrees Fahrenheit  
  - Number of variables: 7
  - Number of cases/rows: 126167
  - Variable List:
      ID: numeric; individual datum id / row number  
      TIMESTAMP: datetime  
      TRENDFLAGS: numeric; metadata property from Niagara Framework that describes the condition or state of a recorded data point, identifies interruptions, restarts, and overrides/interpolation  
      STATUS: numeric; component variable built into Niagara Framework indicating the operational health, override status, or alarm condition of a point or device  
      VALUE: numeric; temperature value in degrees Fahrenheit  
      TRENDFLAGS_TAG: character; text value interpretation of `TRENDFLAGS` variable  
      STATUS_TAG: character; text value interpretation of `STATUS` variable  
  - Missing data codes: "NA" 
  
CRCP_Carbonate_Chemistry_Atlantic_be0f_43c1_53bd.csv
  - Number of variables: 28
  - Number of cases/rows: 2765
  - Variable List: 
      time: datetime; YYYY-mm-ddTHH:MM:SSZ in UTC
      CTDID: alphanumeric; CTD Cast Identifier: unique tag for each sampling event 
      Region: character; abbreviation for region of each measurement  
      Year: numeric; year
      Mission: alphanumeric; abbrebiation or title for each sampling mission
      Location: character; abbreviation for specific location of each measurement 
      UTCDate: date; yy/mm/dd in UTC
      UTCTime: time; time in HH:MM
      Date_UTC: datetime; YYYY-mm-ddTHH:MM:SSZ in UTC
      Sample_Depth_m: depth of measurement in meters
      DIC: numeric; dissolved inorganic carbon in µmol/kg
      TA: numeric; total alkalinity in µEquivalents/kg
      pH_measured: numeric; pH as a raw measurement in pH units
      pH_calculated: numeric; pH as calculated by software CO2SYS version 2.1 (Pierrot, D. E. Lewis, and D. W. R. Wallace. 2006.)
      pCO2: numeric; partial pressure of carbon dioxide in microatmospheres
      Aragonite_Sat: numeric; aragonite saturation state (no units)
      Calcdsalinity: numeric; salinity in PSU as calculated from density measurement
      Salinity_Bottle: numeric; salinity in PSU as calculated from density measurement
      Conductivity_Sm: electrical conductivity in Siemens/meter
      Salinity_CTD: numeric; salinity in PSU
      Temperature_C: numeric; temperature in degrees Celcius
      Pressure_db: numeric; atmosphereic pressure in dbar
      Density_Sigmat: numeric; seawater density as sigma-t in kg/m^3
      SiteID: alphanumeric; identifier for each site
      Survey_design: character; type of survey site, either "Permanent" or "Random"
      Sample_frequency: character; how often site was sampled
      Notes: character; notes
      accession_url: alphanumeric; hyperlink URL to access dataset for each measurement 
  - Missing data codes: "NaN" 
  - Link to full metadata: https://www.ncei.noaa.gov/data/oceans/ncei/ocads/metadata/0173496.html
  
CRCP_Carbonate_Chemistry_Pacific_2198_7707_9695.csv
  - Number of variables: 42
  - Number of cases/rows: 2524
  - Variable List: 
      time: datetime; YYYY-mm-ddTHH:MM:SSZ
      EXPOCODE: alphanumeic; expedition code, unique identifier for research expedition consisting of a "four-digit International Council for the Exploration of the Sea (ICES) platform code and the date of departure from port (UTC) in YYYYMMDD." (NOAA)
      CRUISE_ID: alphanumeric; code assigned to a cruise
      STATION_ID: alphanumeric; identifier for the station at the island or atoll (LOCATION) associated with the sample. Combines a 3-letter island code (derived from LOCATIONCODE) with a 2-4 digit site number
      CAST_NUMBER: alphanumeric; Cast number, where a cast is the lowering of equipment over the side at one station (STATION_ID). Cast_number is sequential and starts with 1 for each station
      SAMPLE_ID: numeric; unique numeric identifer for each water sample (4-digit number)
      YEAR_UTC: numeric; calendar year in UTC of sample
      MONTH_UTC: numeric; calendar month in UTC of sample
      DAY_UTC: numeric; calendar day in UTC of sample
      TIME_UTC: time; time in UTC (HH:MM:SS) of sample
      YEARDAY_UTC: numeric; Day number of sample in an annual cycle
      PRESSURE_DB_CTD: numeric; Hydrostatic pressure recorded from CTD at the depth where the sample was taken. unit: decibar
      PRESSURE_DB_CALCULATED: numeric; Pressure calculated from depth (using the R package "oce") for samples not associated with a CTD cast. unit: decibar
      DEPTH_METER: numeric; depth sample was taken at in meters
      TEMPERATURE_ITS90_CTD: numeric; In situ temperature recorded from CTD with the scale of ITS-90. unit: degrees Celcius
      TEMPERATURE_ITS90_FLAG: numeric; quality flag for TEMPERATURE_ITS90_CTD
      TEMPERATURE_ITS90_SCS: numeric; Temperature recorded by the Scientific Computer System (SCS) with the scale of ITS-90. units: degrees Celcius
      SALINITY_PSS78_CTD: numeric; Salinity calculated from conductivity recorded by CTD using the equation of the Practical Salinity Scale of 1978. units: Siemens/meter
      SALINITY_PSS78_CTD_FLAG: numeric; quality flag for TEMPERATURE_ITS90_SCS
      SALINITY_PSS78_BOTTLE: numeric; Salinity calculated from conductivity measured from discrete bottles using the equation of the Practical Salinity Scale of 1978. units: Siemens/meter
      SALINITY_PSS78_BOTTLE_FLAG: numeric; quality flag for SALINITY_PSS78_BOTTLE
      SALINITY_PSS78_SCS: numeric; Salinity recorded by the Scientific Computer System (SCS) using the equation of the Practical Salinity Scale of 1978. units: Siemens/meter
      DIC_UMOL_KG: numeric; dissolve inorganic carbon in µmols/kg
      DIC_UMOL_KG_FLAG: numeric; quality flag for DIC_UMOL_KG
      TALK_UMOL_KG: numeric; total alkalinity in µmol/kg
      TALK_UMOL_KG_FLAG: numeric; quality flag for TALK_UMOL_KG
      CTDCASTID_ESD: numeric; Unique numeric ID of CTD cast (4-digit number)
      ASSOC_OCC_SITEID: alphanumeric; An identifier for the fixed NCRMP climate site associated with the sample, if any. An OCC_SITEID is a 3-dimensional identifier that describes a location (LATITUDE_DEC and LONGITUDE_DEC) and depth of a fixed climate site and includes "OCC" prefix, a 3-letter location code (derived from LOCATIONCODE), and a 3-digit site number. A sample is assigned an ASSOC_OCC_SITEID only if its coordinates (LATITUDE_DEC and LONGITUDE_DEC) are within a 150-m radius of a pre-existing OCC_SITEID; otherwise, no ASSOC_OCC_SITEID is assigned
      REGION: character; The name of the region where the CTD cast was conducted in the Pacific Islands region: American Samoa, Pacific Remote Islands Areas, Guam and Marianas Islands, Hawaiian Archipelago
      REGIONCODE: character; Code for REGION: American Samoa (AMSM), Pacific Remote Island Areas (PRIA), Guam and Marianas Islands (CNMI), Main Hawaiian Islands (MHI), Northwestern Hawaiian Islands (NWHI)
      LOCATION: character; Name of island or atoll where the sample was collected in the Pacific Islands region (REGION)
      LOCATIONCODE: character; 3-Letter unique code for LOCATION.
      SURVEY_DESIGN: character; NCRMP survey design associated with the sample. Survey designs include: samples collected at permanent climate sites (Permanent); samples co-located with fish or benthic stratified random survey sites (Stratified_Random); samples at random sites not associated with climate, benthic, or fish sites (Random); samples conducted offshore to collect end member data (End_member); and samples collected to calibrate underway systems (Calibration). SURVEY_DESIGN does not apply to non-NCRMP data collected prior to 2013
      SAMPLE_FREQUENCY: character; Indicates if water sample is discrete (Single) or if the sample is part a series of water samples collected ~every 4 hrs in a ~24-hr period at the same STATION_ID (Diel)
      TEMPERATURE_ITS90_BEST: numeric; Best temperature value associated with the sample (degrees Celsius), derived from either TEMPERATURE_ITS90_CTD or TEMPERATURE_ITS90_SCS
      TEMPERATURE_ITS90_BEST_ORIGIN: character; Source of 'TEMPERATURE_ITS90_BEST' measurement: CTD (TEMPERATURE_ITS90_CTD) or SCS (TEMPERATURE_ITS90_SCS)
      SALINITY_PSS78_BEST: numeric; Best salinity value associated with the sample (PSU), derived from either SALINITY_PSS78_CTD, SALINITY_PSS78_BOTTLE, or SALINITY_PSS78_SCS
      SALINITY_PSS78_BEST_ORIGIN: character; Source of 'SALINITY_PSS78_BEST' measurement: CTD (SALINITY_PSS78_CTD), discrete bottle sample (SALINITY_PSS78_BOTTLE), or SCS (SALINITY_PSS78_SCS)
      PH_TS_CALCULATED: numeric; pH in pH units
      PCO2_UATM_CALCULATED: numeric; pCO2 (fCO2) autonomous in microatmospheres
      TIMESTAMP_UTC: datetime; Date and time of water sample in UTC YYYY-mm-ddTHH:MM:SSZ
      accession_url: alphanumeric; hyperlink URL to access dataset for each measurement 
  - Missing data codes: "NaN" 
  - Link to full metadata: https://www.ncei.noaa.gov/data/oceans/ncei/ocads/metadata/0232262.html

Hach-Data-Clean.csv: cleaned Hach nutrient water quality data for all locations from 2017-2024
  - Number of variables: 14
  - Number of cases/rows: 1668
  - Variable List: 
      Date: date; YYYY-mm-dd  
      Location: character; location of measurements: Ocean, Mangroves, Raceway 1, or Raceway 2  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)  
      Phosphate (mg/L): numeric; phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
      pH: pH in pH units  
      Alkalinity (mg/L CaCO3): numeric; calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; iron concentration in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; ammonia (NH3) concentration in range 0.01-0.50 measured in mg/L  
      ORP:  numeric;oxidation-reduction potential (ORP) measured in miliVolts  
      Initials: character; initials of person or people taking measurements  
      Notes: character; any notes from that measurement  
  - Missing data codes: "NA"
  
WorldOceans-Data-Clean-Final.csv: combination of `WorldOceans-RegionsCoordinates-Clean.csv` and `WorldOceans-Data-Clean.csv` coordinates for each location added
  - Number of variables: 17
  - Number of cases/rows: 5304
  - Variable List: 
      Date: date; YYYY-mm-dd 
      Ocean: character; name of ocean data was obtained from  
      Region: character; region of ocean that data was obtained from  
      Location: character; more specific geographic location than region, such as an island, state, atoll, or reef  
      Depth (m): numeric; depth underwater data was obtained from  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      Salinity (PSU): numeric; salinity in Potential Salinity Units  
      Phosphate (µmol/kg): numeric; phosphate concentration in µmol/kg  
      Silicate (µmol/kg): numeric; silicate concentration in µmol/kg    
      Nitrate (µmol/kg): numeric; nitrate concentration in µmol/kg  
      pH: numeric; pH in pH units  
      Chlorophyll (µg/L): numeric; chlorophyll concentration in µg/L   
      Alkalinity (µEq/L): numeric; alkalinity concentration in µEquivalents/L  
      Dissolved Organic Carbon (µmol/kg): numeric; dissolved organic carbon concentration in µmol/kg  
      Iron (mg/L): numeric; iron concentration in mg/L
      Latitude: numeric; latitude of region datum point  
      Longitude: numeric; longitude of region datum point
  - Missing data codes: "NA" 
  
WorldOceans-Data-Clean.csv: water quality data from Atlantic and Pacific Oceans from 2011-2024
  - Number of variables: 15
  - Number of cases/rows: 5307
  - Variable List: 
      Date: date; mm/dd/yy 
      Ocean: character; name of ocean data was obtained from  
      Region: character; region of ocean that data was obtained from  
      Location: character; more specific geographic location than region, such as an island, state, atoll, or reef
      Depth (m): numeric; depth underwater data was obtained from  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      Salinity (PSU): numeric; salinity in Potential Salinity Units  
      Phosphate (µmol/kg): numeric; phosphate concentration in µmol/kg  
      Silicate (µmol/kg): numeric; silicate concentration in µmol/kg    
      Nitrate (µmol/kg): numeric; nitrate concentration in µmol/kg  
      pH: numeric; pH in pH units  
      Chlorophyll (µg/L): numeric; chlorophyll concentration in µg/L   
      Alkalinity (µEq/L): numeric; alkalinity concentration in µEquivalents/L  
      Dissolved Organic Carbon (µmol/kg): numeric; dissolved organic carbon concentration in µmol/kg  
      Iron (mg/L): numeric; iron concentration in mg/L  
  - Missing data codes: "NA" 
  
WorldOceans-RegionsCoordinates-Clean.csv: ocean regions found in `WorldOceans-Data-Clean.csv` and their coordinates in longitude and latitude 
  - Number of variables: 3
  - Number of cases/rows: 58
  - Variable List: 
      Region: character; ocean region corresponding to those found in `WorldOceans-Data-Clean.csv`  
      Latitude: numeric; latitude of region datum point  
      Longitude: numeric; longitude of region datum point  
  - Missing data codes: "NA" 
  
YSI-Data-Clean-2011-2022.csv: all Biosphere 2 Ocean remote sensing Sonde data from 2011 - 2022
  - Number of variables: 19
  - Number of cases/rows: 312879
  - Variable List: 
      Date: date; YYYY-mm-dd
      Time: time; HH:MM:SS
      Temperature (ºF): numeric; temperature value in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature value in degrees Celcius  
      pH: numeric; pH value in pH units  
      pH (mV): numeric; pH value in miliVolts  
      Salinity (PSU): numeric; salinity value in Potential Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity value in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity value as a non-linear function in µSiemens/cm
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity value in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen value in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen value in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen value in %  
      Oxygen Reduction Potential (mV): numeric; oxidation-reduction potential value in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll value in RFU  
      Total Algae (RFU): numeric; total algae phycoerythrin value in RFU  
      Chlorophyll (µg/L): numeric; chlorophyll value in µg/L  
      Total Algae (cells/L): numeric; total algae phycoerythrin value in cells/L
      Total Dissolved Solids (mg/L): numeric; total dissolved solids value in mg/L  
  - Missing data codes: "NA" 
  
YSI-Data-Clean-All.csv: all Biosphere 2 Ocean remote sensing Sonde data from 2011 - 2024  
  - Number of variables: 19
  - Number of cases/rows: 361216
  - Variable List:
      Date: date; YYYY-mm-dd
      Time: time; HH:MM:SS  
      Temperature (ºF): numeric; temperature value in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature value in degrees Celcius  
      pH: numeric; pH value in pH units  
      pH (mV): numeric; pH value in miliVolts  
      Salinity (PSU): numeric; salinity value in Potential Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity value in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity value as a non-linear function in µSiemens/cm
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity value in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen value in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen value in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen value in %  
      Oxygen Reduction Potential (mV): numeric; oxidation-reduction potential value in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll value in RFU  
      Total Algae (RFU): numeric; total algae phycoerythrin value in RFU  
      Chlorophyll (µg/L): numeric; chlorophyll value in µg/L  
      Total Algae (cells/L): numeric; total algae phycoerythrin value in cells/L
      Total Dissolved Solids (mg/L): numeric; total dissolved solids value in mg/L  
  - Missing data codes: "NA" 

Hach-Data-QC.csv: Hach nutrient water quality data after being run through quality control parameters
  - Number of variables: 11
  - Number of cases/rows: 1665
  - variables:  
      Date: date; YYYY-mm-dd 
      Location: character; location of measurements; Ocean, Mangroves, Raceway 1, or Raceway 2  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units (FAU)  
      Phosphate (mg/L): numeric; phosphate (PO4 3-) concentration in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; nitrate (NO3-) mid-range concentration from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; nitrate (NO3-) high-range from 0.3-30.0 measured in mg/L  
      pH: pH in pH units  
      Alkalinity (mg/L CaCO3): numeric; calcium carbonate (CaCO3) concentration in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; silica (SiO2) concentration in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; iron concentration in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; ammonia (NH3) concentration in range 0.01-0.50 measured in mg/L  
  - Missing data codes: "NA" 
  
YSI-Data-QC.csv: all Biosphere 2 Ocean remote sensing multiparameter sonde water quality data after being run through quality control parameters of removing data more than 2 standard deviations outside of the daily mean or median depending on normality of the day's data
  - Number of variables: 19
  - Number of cases/rows: 361216
  - Variable List:
      Date: date; YYYY-mm-dd 
      Time: time; HH:MM:SS
      Temperature (ºF): numeric; temperature value in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature value in degrees Celcius  
      pH: numeric; pH value in pH units  
      pH (mV): numeric; pH value in miliVolts  
      Salinity (PSU): numeric; salinity value in Potential Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity value in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity value as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity value in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen value in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen value in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen value in %  
      Oxygen Reduction Potential (mV): numeric; oxidation-reduction potential value in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll value in RFU  
      Total Algae (RFU): numeric; total algae phycoerythrin value in RFU  
      Chlorophyll (µg/L): numeric; chlorophyll value in µg/L  
      Total Algae (cells/L): numeric; total algae phycoerythrin value in cells/L
      Total Dissolved Solids (mg/L): numeric; total dissolved solids value in mg/L  
  - Missing data codes: "NA" 
  
YSI-Data-QC-Cutoff.csv: all Biosphere 2 Ocean remote sensing multiparameter sonde water quality data after being run through quality control parameters and implementing cutoff values
  - Number of variables: 19
  - Number of cases/rows: 361216
  - Variable List:
      Date: date; YYYY-mm-dd 
      Time: time; HH:MM:SS
      Temperature (ºF): numeric; temperature value in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature value in degrees Celcius  
      pH: numeric; pH value in pH units  
      pH (mV): numeric; pH value in miliVolts  
      Salinity (PSU): numeric; salinity value in Potential Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity value in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity value as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity value in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen value in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen value in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen value in %  
      Oxygen Reduction Potential (mV): numeric; oxidation-reduction potential value in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll value in RFU  
      Total Algae (RFU): numeric; total algae phycoerythrin value in RFU  
      Chlorophyll (µg/L): numeric; chlorophyll value in µg/L  
      Total Algae (cells/L): numeric; total algae phycoerythrin value in cells/L
      Total Dissolved Solids (mg/L): numeric; total dissolved solids value in mg/L  
  - Missing data codes: "NA" 
  
HachYSI-Data-Medians-All.csv: all median time interval data combined for all colorimetry and titration nutrient data (hach) and multiparameter sonde data (ysi) for the Biosphere 2 Ocean from 2011-2024  
  - Number of variables: 26
  - Number of cases/rows: 5124
  - Variable List: 
      Time Interval: character; time interval at which the median is being taken, "daily", "weekly", "monthly", and "yearly" for this file  
      Date: date; YYYY-mm-dd  
      Temperature (ºF): numeric; temperature in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH (mV): numeric; pH in miliVolts  
      Salinity (PSU): numeric; salinity in Potenial Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen in %  
      Oxygen Reduction Potential (mV): numeric; oxidative-reduction potential in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll in Relative Fluorescent Units  
      Total Algae (RFU): numeric; total algae in Relative Fluorescent Units  
      Total Dissolved Solids (mg/L): numeric; total dissolved solids in mg/L  
      pH (YSI): numeric; pH in pH units from the YSI dataset  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units   
      Phosphate (mg/L): numeric; phosphate (PO4 3-) in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; Nitrate (NO3-) from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; Nitrate (NO3-) from 0.3-30.0 measured in mg/L  
      pH_Hach: numeric; pH in pH units from the Hach dataset  
      Alkalinity (mg/L CaCO3): numeric; Calcium Carbonate (CaCO3) in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; Silica (SiO2) in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; Iron in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; Ammonia (NH3) in range 0.01-0.50 measured in mg/L  
  - Missing data codes: "NA" 
  
HachYSI-Data-Medians-Daily.csv: daily median of all colorimetry and titration nutrient data (hach) and multiparameter sonde data (ysi) for the Biosphere 2 Ocean from 2011-2024  
  - Number of variables: 26
  - Number of cases/rows: 4321
  - Variable List: 
      Time Interval: character; time interval at which the median is being taken, "daily" for this file  
      Date: date; YYYY-mm-dd  
      Temperature (ºF): numeric; temperature in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH (mV): numeric; pH in miliVolts  
      Salinity (PSU): numeric; salinity in Potenial Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen in %  
      Oxygen Reduction Potential (mV): numeric; oxidative-reduction potential in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll in Relative Fluorescent Units  
      Total Algae (RFU): numeric; total algae in Relative Fluorescent Units  
      Total Dissolved Solids (mg/L): numeric; total dissolved solids in mg/L  
      pH (YSI): numeric; pH in pH units from the YSI dataset  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units   
      Phosphate (mg/L): numeric; phosphate (PO4 3-) in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; Nitrate (NO3-) from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; Nitrate (NO3-) from 0.3-30.0 measured in mg/L  
      pH_Hach: numeric; pH in pH units from the Hach dataset  
      Alkalinity (mg/L CaCO3): numeric; Calcium Carbonate (CaCO3) in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; Silica (SiO2) in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; Iron in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; Ammonia (NH3) in range 0.01-0.50 measured in mg/L  
  - Missing data codes: "NA" 
  
HachYSI-Data-Medians-Weekly.csv: weekly median of all colorimetry and titration nutrient data (hach) and multiparameter sonde data (ysi) for the Biosphere 2 Ocean from 2011-2024  
  - Number of variables: 26
  - Number of cases/rows: 635
  - Variable List: 
      Time Interval: character; time interval at which the median is being taken, "weekly" for this file  
      Date: date; YYYY-mm-dd  
      Temperature (ºF): numeric; temperature in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH (mV): numeric; pH in miliVolts  
      Salinity (PSU): numeric; salinity in Potenial Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen in %  
      Oxygen Reduction Potential (mV): numeric; oxidative-reduction potential in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll in Relative Fluorescent Units  
      Total Algae (RFU): numeric; total algae in Relative Fluorescent Units  
      Total Dissolved Solids (mg/L): numeric; total dissolved solids in mg/L  
      pH (YSI): numeric; pH in pH units from the YSI dataset  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units   
      Phosphate (mg/L): numeric; phosphate (PO4 3-) in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; Nitrate (NO3-) from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; Nitrate (NO3-) from 0.3-30.0 measured in mg/L  
      pH_Hach: numeric; pH in pH units from the Hach dataset  
      Alkalinity (mg/L CaCO3): numeric; Calcium Carbonate (CaCO3) in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; Silica (SiO2) in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; Iron in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; Ammonia (NH3) in range 0.01-0.50 measured in mg/L  
  - Missing data codes: "NA" 
  
HachYSI-Data-Medians-Monthly.csv: monthly median of all colorimetry and titration nutrient data (hach) and multiparameter sonde data (ysi) for the Biosphere 2 Ocean from 2011-2024  
  - Number of variables: 26
  - Number of cases/rows: 154
  - Variable List: 
      Time Interval: character; time interval at which the median is being taken, "monthly" for this file  
      Date: date; YYYY-mm-dd  
      Temperature (ºF): numeric; temperature in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH (mV): numeric; pH in miliVolts  
      Salinity (PSU): numeric; salinity in Potenial Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen in %  
      Oxygen Reduction Potential (mV): numeric; oxidative-reduction potential in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll in Relative Fluorescent Units  
      Total Algae (RFU): numeric; total algae in Relative Fluorescent Units  
      Total Dissolved Solids (mg/L): numeric; total dissolved solids in mg/L  
      pH (YSI): numeric; pH in pH units from the YSI dataset  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units   
      Phosphate (mg/L): numeric; phosphate (PO4 3-) in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; Nitrate (NO3-) from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; Nitrate (NO3-) from 0.3-30.0 measured in mg/L  
      pH_Hach: numeric; pH in pH units from the Hach dataset  
      Alkalinity (mg/L CaCO3): numeric; Calcium Carbonate (CaCO3) in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; Silica (SiO2) in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; Iron in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; Ammonia (NH3) in range 0.01-0.50 measured in mg/L  
  - Missing data codes: "NA" 
  
HachYSI-Data-Medians-Yearly.csv: yearly median of all colorimetry and titration nutrient data (hach) and multiparameter sonde data (ysi) for the Biosphere 2 Ocean from 2011-2024  
  - Number of variables: 26
  - Number of cases/rows: 14
  - Variable List: 
      Time Interval: character; time interval at which the median is being taken, "yearly" for this file  
      Date: date; YYYY-mm-dd  
      Temperature (ºF): numeric; temperature in degrees Fahrenheit  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH (mV): numeric; pH in miliVolts  
      Salinity (PSU): numeric; salinity in Potenial Salinity Units  
      Conductivity (µS/cm): numeric; electrical conductivity in µSiemens/cm  
      Conductivity, Non-Linear Function (µS/cm): numeric; electrical conductivity as a non-linear function in µSiemens/cm  
      Conductivity, Specific (µS/cm): numeric; specific electrical conductivity in µSiemens/cm  
      Dissolved Oxygen (mg/L): numeric; dissolved oxygen in mg/L  
      Dissolved Oxygen, Saturated (%): numeric; saturated dissolved oxygen in %  
      Dissolved Oxygen, Local (%): numeric; local dissolved oxygen in %  
      Oxygen Reduction Potential (mV): numeric; oxidative-reduction potential in miliVolts  
      Chlorophyll (RFU): numeric; chlorophyll in Relative Fluorescent Units  
      Total Algae (RFU): numeric; total algae in Relative Fluorescent Units  
      Total Dissolved Solids (mg/L): numeric; total dissolved solids in mg/L  
      pH (YSI): numeric; pH in pH units from the YSI dataset  
      Turbidity (FAU): numeric; turbidity (water transparency) in the range 21-1000 Formazine Attenuation Units   
      Phosphate (mg/L): numeric; phosphate (PO4 3-) in range 0.02-2.50 measured in mg/L  
      Nitrate, Mid-Range (mg/L): numeric; Nitrate (NO3-) from 0.2-5.0 measured in mg/L  
      Nitrate, High-Range (mg/L): numeric; Nitrate (NO3-) from 0.3-30.0 measured in mg/L  
      pH_Hach: numeric; pH in pH units from the Hach dataset  
      Alkalinity (mg/L CaCO3): numeric; Calcium Carbonate (CaCO3) in range 100-400 measured in mg/L  
      Silica (mg/L): numeric; Silica (SiO2) in range 0.01-1.60 measured in mg/L  
      Iron (mg/L): numeric; Iron in range 0.009-1.400 measured in mg/L  
      Ammonia (mg/L): numeric; Ammonia (NH3) in range 0.01-0.50 measured in mg/L  
  - Missing data codes: "NA" 
  
WorldOceans-Data-Mean-2021-2024.csv: table of mean of each variable for each region for total time range of 2021-2024
  - Number of variables: 10
  - Number of cases/rows: 9
  - Variable List:
      Ocean: character; name of ocean measurements were taken in  
      Region: character; region measurements were taken in  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH: numeric; pH in pH units  
      Salinity (PSU): numeric; salinity in Potential Salinity Units  
      Alkalinity (mg/L): numeric; alkalinity in mg/L  
      Phosphate (mg/L): numeric; phosphate in mg/L  
      Silicate (mg/L): numeric; silicate in mg/L  
      Nitrate (mg/L): numeric; nitrate in mg/L  
      Iron (mg/L): numeric; iron in mg/L  
  - Missing data codes: "NA" 
  
WorldOceans-Data-MeanPerYear.csv: table of mean of each variable for each region for each year from 2011-2024
  - Number of variables: 11
  - Number of cases/rows: 56
  - Variable List:
      Year: date; year as YYYY  
      Ocean: character; name of ocean measurements were taken in  
      Region: character; region measurements were taken in  
      Temperature (ºC): numeric; temperature in degrees Celcius  
      pH: numeric; pH in pH units  
      Salinity (PSU): numeric; salinity in Potential Salinity Units  
      Alkalinity (mg/L): numeric; alkalinity in mg/L  
      Phosphate (mg/L): numeric; phosphate in mg/L  
      Silicate (mg/L): numeric; silicate in mg/L  
      Nitrate (mg/L): numeric; nitrate in mg/L  
      Iron (mg/L): numeric; iron in mg/L  
  - Missing data codes: "NA" 

HachYSI-1x3CurrentPlot.png: Scatter plot of Temperature (ºC), Salinity (PSU), and pH from 2021-2024 to show environmental variability of B2O in recent years.
  
HachYSI-1x3HistoryPlot.png: Scatter plot of Temperature (ºC), Salinity (PSU), and pH from 2011-2024 to show historical context of B2O.
  
HachYSI-NutWatQualPlot-Climatology.png: Line plot showing seasonal variation of Temperature (ºC), Salinity (PSU), pH, Alkalinity (mg/L CaCO3), Nitrate (mg/L), Phosphate (mg/L), Silica (mg/L), Iron (mg/L), and Dissolved Oxygen (mg/L) over the course of each year (january - december) from 2021-2024. 
  
HachYSI-NutWatQualPlot-TimeSeries.png: Line plot with shaded ranges for Temperature (ºC), Salinity (PSU), pH, Alkalinity (mg/L CaCO3), Nitrate (mg/L), Phosphate (mg/L), Silica (mg/L), Iron (mg/L), and Dissolved Oxygen (mg/L) in B2O from 2020-2024. 