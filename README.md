# OceanWaterQuality
## Repository Description
Biosphere 2 Ocean Water Quality Data Pipeline compiled from historical, YSI Exo Sonde, HOBO probe, and Colorimetry data. Includes data files, quality control, data analyses, and figure-making code (figures themselves are only included when they are finished products - contact member responsible for repository (see below) to gain access to in progress figures). 

Responsible member(s): Renee Grambihler, grambihler@arizona.edu  
Project Status: In Progress

## Repository Organization
- `README.md`: readme file
- `/Code`: contains all R scripts for wrangling, quality control, and data analyses
  - `/Code_HOBO`: scripts pertaining HOBO probe data
    - `/hoboph.R`: TBD
  - `/Code_NutrientData`: scripts pertaining to Colorimetry data from B2 Ocean, Coral Raceways, and Mangroves
  - `Code_RShiny`: scripts for RShiny data visualizations
  - `Code_YSI`: scripts pertaining to YSI and historical B2 Ocean data
- `/Data`: contains all data files used in R scripts
  - `/CleanData`: data files that have been cleaned/processed and are ready for analyses
    - `/CleanData_YSI`: clean Exo YSI Sonde data
      - `/01_DataWrangling`: compiling and wrangling data
      - `/02_QualityControl`: quality control pipeline
  - `/RawData`: raw data files
    - `/RawData_HOBO`: from HOBO sondes
    - `/RawData_NutrientData`: from Colorimetry 
    - `RawData_YSI`: from historical and YSI Exo Sonde
- `/Metadata`: contains all metadata files for code scripts and data
