# OceanWaterQuality
## Repository Description
YSI Exo Sonde and HOBO data files and analysis pipeline

Responsible member(s): Renee Grambihler, grambihler@arizona.edu

## Repository Organization
README.md: readme file

exos.R: R file
- initial YSI exo sonde QC and analysis file
- Author/source: Dan Killam

hoboph.R: R file
- initial HOBO pH QC and analysis file
- Author/source: Dan Killam

YSI Data: folder
- YSI exo sonde data files, csv
    - StartDate_EndDate_YSI.csv
    - raw csv files downloaded off of YSI exo sonde in B2 Ocean
    - File Naming Format: YYMMDD_YYMMDD.csv
    - Variable Names: 
        - Date (MM/DD/YYYY)
        - Time (HH:mm:ss)
        - Time (Fract. Sec)
        - Site Name
        - Chlorophyll RFU
        - Cond µS/cm
        - nLF Cond µS/cm
        - ODO % sat
        - ODO % local
        - ODO mg/L
        - ORP mV
        - Sal psu
        - SpCond µS/cm
        - TAL PE RFU
        - TDS mg/L
        - Wiper Position volt
        - pH
        - pH mV
        - Temp °C
        - Battery V
        - Cable Pwr V
- YSI_Calibration_Times.csv
    - datetimes of calibrations for YSI exo sonde
    - Variable Names: 
        - Date (MM/DD/YYYY)
        - Time Start (HH:mm:ss)
        - Time End (HH:mm:ss)
- Subfolder(s): 
  - UTF-8 versions: UTF-8 csv versions of some YSI data files

## Change Log
09/06/22: Renee created and populated repository and filled out readme