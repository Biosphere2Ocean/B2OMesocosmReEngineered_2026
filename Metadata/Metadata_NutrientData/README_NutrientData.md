# Biosphere 2 Marine Systems Nutrient Data
Repository for nutrient data analyses for all Biosphere 2 Ocean (B2O) marine systems: Ocean, Mangrove, and Raceways.

Responsible member(s): Renee Grambihler, grambihler@arizona.edu
Please contact responsible member(s) with questions about contents of repository, data, methods, etc.

# Repository Organization
**README.md: readme file**

**B2ONutrientData.xlsx: Microsoft Excel file**
- Author/Source: B2O team members
- Description: contains Hach colorimeter nutrient values for marine systems from 2017-present
- Contents: 
    - 3 sheets
        - Stats: quick averages of nutrients in each system from Pre-Formatted Data sheet
        - Data: format of data entry from October 2022 to present
        - Pre-formatted Data: format of data entry from December 2017 to October 2022
            - Purple: Ocean
            - Blue: Mangrove
            - Pink: Raceway 1
            - Purple: Raceway 2
    - Variables: 
        - Date: date of sample analysis
            - Pre-formatted Data: mm/dd/yyy
            - Data: mm/dd/yy
        - Location: location that sample was taken from 
            - Ocean, Mangrove, Raceway 1, Raceway 2
        - Turbidity: measures water transparancy in the range 21-1000 FAU
            - Units: Formazine attenuation unit (FAU)
        - Phosphate: detects 0.02-2.50 mg/L PO4
            - Units: mg/L
        - Nitrate MR: detects Mid-Range nitrate-N from 0.2-5.0 mg/L 
            - Units: mg/L
        - Nitrate HR: detects High-Range nitrate-N from 0.3-30.0 mg/L
            - Units: mg/L
        - pH: measures acidity/basicity in range 0-14
            - Units: pH units
        - Alkalinity: detects CaCO3 in range 100-400 mg/L
            - Units: mg/L
        - Silica: detects silica in range 0.01-1.60 mg/L
            - Units: mg/L
        - Iron: detects iron in range 0.009-1.400 mg/L
            - Units: mg/L
        - Ammonia: detects NH3-N in range 0.01-0.50 mg/L
            - Units: mg/L
        - ORP: measure of oxygen reduction potential
            - Units: mV
        - Initials: first and last initial of technician(s) performing analysis
        - Notes: any notes about that analysis

**HACH-data-visualizations.Rmd: R markdown file**
- Author/Source: Renee Grambihler
- Description: Contains code for data manipulation, statistical analyses, and visualizations of Hach colorimetry nutrient data

**Hach-data-visualizations.nb.html: HTML file**
- Author/Source: Renee Grambihler
- Description: html version of HACH-data-visualizations.Rmd

**RShinyApp: folder**
- **Nutrient-Data-B2O.R: R file**
    - Author/Source: Renee Grambihler
     - Description: RShiny app file for data visualizations of B2O nutrient data

**nutrient-data.Rproj: R project file**
- Author/Source: Renee Grambihler
- Description: R project for above files