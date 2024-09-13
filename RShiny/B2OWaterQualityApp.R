#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Import Libraries -----
library(shiny)
library(DT)
library(shinythemes)
library(bslib)
library(tidyverse)
library(lubridate)
library(Hmisc)
library(corrplot)
library(ggcorrplot)
library(leaflet)
library(scales)
source("Dependencies/CorrelationFunction.R")
options(scipen = 999)

# Import data -----
# all data are medians of each indicated interval except for the daily hach 
#  which are "raw" data points since hach is taken once per day (Mon & Fri)
# all Hach and YSI data: combo of all above files with "Time Interval" column to 
# denote which interval (daily, weekly, etc) the data comes from
dfAll <- read_csv("SourceData/05-HachYSI-Data-All.csv", col_names = TRUE) %>%
  select(-`pH_Hach`, -`Conductivity, Non-Linear Function (µS/cm)`, -`Conductivity, Specific (µS/cm)`,
         -`Dissolved Oxygen, Saturated (%)`, -`pH (mV)`, ) %>%
  rename(pH = `pH (YSI)`) %>%
  rename(`Turbidity (FAU)` = `Turbidity (RFU)`)

# World Oceans Data for B1 Comparisons
dfWOD <- read_csv("SourceData/02-Clean-WorldOceanData-Final.csv")%>%
  # add singular Iron datapoint that refuses to load even though it's on the csv :(
  mutate(`Iron (mg/L)` = ifelse(`Silicate (mg/L)` == "0.21", "0.024", `Iron (mg/L)`))%>%
  # filter out data before B2 data exists
  filter(Date >= "2011-01-01")


# Data Wrangling -----
## Correlations
# create nested list of correlation matrices: p-values, n, r values
cor_mat_stats <- dfAll %>%
  filter(`Time Interval` == "Daily") %>%
  select(-`Time Interval`, -Date) 
cor_mat_stats <- rcorr(as.matrix(cor_mat_stats))
# full flattened correlation matrix: table of correlation pairings using matrices created in cor_mat_stats
cor_mat_stats_flat <- flattenCorrMatrix(cor_mat_stats$r, cor_mat_stats$P) %>%
  mutate(across(3:4, ~ round(.x, 4)))
# flattened correlation matrix with only p-values <= 0.05: table of correlation pairings created in cor_mat_stats
cor_mat_stats_flat_sig <- cor_mat_stats_flat %>%
  filter(p_value <= 0.05)
corrTable <- cor_mat_stats_flat %>%
  rename(`Variable 1` = row,
         `Variable 2` = column, 
         `Correlation Coefficient` = cor_coeff,
         `P-Value` = p_value) %>%
  mutate(`Correlation Coefficient` = ifelse(is.na(`Correlation Coefficient`) == TRUE,
                                            "Not enough data",
                                            `Correlation Coefficient`),
         `P-Value` = ifelse(is.na(`P-Value`) == TRUE,
                            "Not enough data",
                            `P-Value`))
## B1 Comparisons
dfAll_map <- dfAll %>%
  filter(`Time Interval` == "Yearly") %>%
  select(Date, `Temperature (ºC)`, `Salinity (PSU)`, `Phosphate (mg/L)`,
         `Silica (mg/L)`, `Nitrate, Mid-Range (mg/L)`, pH, `Alkalinity (mg/L CaCO3)`,
         `Iron (mg/L)`) %>%
  rename(`Silicate (mg/L)` = `Silica (mg/L)`,
         `Alkalinity (mg/L)` = `Alkalinity (mg/L CaCO3)`,
         `Nitrate (mg/L)` = `Nitrate, Mid-Range (mg/L)`) %>%
  add_column(Ocean = "Biosphere 2", .after = "Date") %>%
  add_column(Region = "Arizona", .after = "Ocean") %>%
  add_column(Location = "Biosphere 2", .after = "Region") %>%
  mutate(Latitude = 32.57864107499588,
         Longitude = -110.85128223373218) %>%
  mutate(Year = year(Date)) %>%
  relocate(Year, .after = Date) %>%
  select(-Date)
dfWOD_map <- dfWOD %>%
  select(-`Chlorophyll (µg/L)`, -`Dissolved Organic Carbon (µmol/kg)`, -`Depth (m)`) %>%
  mutate(Year = year(Date)) %>%
  select(-Date) %>%
  group_by(Year, Location) %>%
  mutate(`Temperature (ºC)` = median(`Temperature (ºC)`, na.rm = TRUE),
         `Salinity (PSU)` = median(`Salinity (PSU)`, na.rm = TRUE),
         `Phosphate (mg/L)` = median(`Phosphate (mg/L)`, na.rm = TRUE),
         `Silicate (mg/L)` = median(`Silicate (mg/L)`, na.rm = TRUE),
         `Nitrate (mg/L)` = median(`Nitrate (mg/L)`, na.rm = TRUE),
         `pH` = median(`pH`, na.rm = TRUE),
         `Alkalinity (mg/L)` = median(`Alkalinity (mg/L)`, na.rm = TRUE),
         `Iron (mg/L)` = median(`Iron (mg/L)`, na.rm = TRUE)) %>%
  relocate(Year, .before = Ocean) %>%
  unique() %>%
  mutate(`Iron (mg/L)` = as.double(`Iron (mg/L)`))
dfMap <- rbind(dfWOD_map, dfAll_map) %>%
  mutate(across(where(is.numeric), ~round(.x, digits = 5)))


# Define UI variables -----
# character vector of all day dates in YSI data
date_range_overall <- dfAll %>%
  filter(`Time Interval` == "Daily") %>%
  select(Date)

date_range_seasonal <- dfAll %>%
  filter(`Time Interval` == "Yearly") %>%
  select(Date) %>%
  mutate(Date = substring(Date, 1,4))
date_range_seasonal <- as.vector(date_range_seasonal$Date)

#  character vector of variable choices. modified from column names of datasets 
var_choices <- c("None",
                 "Ammonia (mg/L)",
                 "Alkalinity (mg/L CaCO3)", 
                 "Chlorophyll (RFU)",
                 "Conductivity (µS/cm)",
                 "Dissolved Oxygen (mg/L)",
                 "Dissolved Oxygen, Local (%)",
                 "Iron (mg/L)",
                 "Nitrate, Mid-Range (mg/L)", 
                 "Nitrate, High-Range (mg/L)",
                 "Oxygen Reduction Potential (mV)",
                 "pH",
                 "Phosphate (mg/L)",
                 "Salinity (PSU)",
                 "Silica (mg/L)",
                 "Temperature (ºC)",
                 "Temperature (ºF)",
                 "Total Algae (RFU)",
                 "Total Dissolved Solids (mg/L)",
                 "Turbidity (FAU)")

# character vector of UI choices for `Time Interval`
median_period_choices <- c("Daily", "Weekly", "Monthly", "Yearly")

#tags$style(HTML(".radio-inline {margin-right: 42px;}"))

# User Interface -----
ui <- page_fillable(
  # title panel
  titlePanel(title = div(imageOutput("B2Header", inline = TRUE), 
                         "Ocean Water Quality Dashboard", 
                         style = "color: #49595e;"),
             windowTitle = "Biosphere2OceanWaterQuality"),
  # page with navigation bar at top to click to other pages (panels)
  page_navbar(title = NULL,
              inverse = FALSE,
              ##### About Page #####
              nav_panel(title = "About",
                        fluidPage(
                          fluidRow(
                            column(
                              width = 7,
                              imageOutput("B2OImage")
                            ),
                            column(
                              width = 5,
                              p("The visualizations presented on this site are made from water quality parameter data collected from a combination of sources over the course of the Biosphere 2 Ocean (B2O) project."),
                              br(),
                              p("For questions about this site and/or the data used here, please contact Renee Grambihler: grambihler@arizona.edu")
                            )
                          ),
                       accordion(
                         open = FALSE,
                         accordion_panel(
                           "Metadata",
                           h6("Variable Meanings and Units"),
                           p("Ammonia (mg/L): amount of Ammonia (NH3) in range 0.01-0.50 measured in mg/L"),
                           p("Alkalinity (mg/L CaCO3): amount of Calcium Carbonate (CaCO3) in range 100-400 measured in mg/L"), 
                           p("Chlorophyll (RFU): amount of Chlorophyll measured in Relative Fluorescence Units"),
                           p("Conductivity (µS/cm): measures Electrical Conductance in micro-Semens/cm; salinity measurements are calculated from this value"),
                           p("Dissolved Oxygen (mg/L): amount of Oxygen dissolved in seawater measured in mg/L"),
                           p("Dissolved Oxygen, Local (%): amount of Oxygen dissolved in seawater measured by percent"),
                           p("Iron (mg/L): amount of Iron in range 0.009-1.400 measured in mg/L"),
                           p("Nitrate, Mid-Range (mg/L): amount of Nitrate (NO3-) from 0.2-5.0 measured in mg/L"), 
                           p("Nitrate, High-Range (mg/L): amount of Nitrate (NO3-) from 0.3-30.0 measured in mg/L"),
                           p("Oxygen Reduction Potential (mV): measures ability of water to gain or lose electrons measured in miliVolts; used as indication of amount of oxygen in the water"),
                           p("pH: pH"),
                           p("Phosphate (mg/L): amount of Phosphate (PO4 3-) in range 0.02-2.50 measured in mg/L"),
                           p("Salinity (PSU): amount of salt measured in Practical Salinity Units; equivalent to PPT"),
                           p("Silica (mg/L): amount of Silica (SiO2) in range 0.01-1.60 measured in mg/L"),
                           p("Temperature (ºC): temperature measured in Celcius"),
                           p("Temperature (ºF): temperature measured in Fahrenheit"),
                           p("Total Algae (RFU): amount of Phycoerytherin algae measured in Relative Fluorescence Units"),
                           p("Total Dissolved Solids (mg/L): amount of solids dissolved in the water measured in mg/L"),
                           p("Turbidity (FAU): measures water transparency in the range 21-1000 Formazine Attenuation Units")
                         ),
                         accordion_panel(
                           "Data Sources",
                           h6("Biosphere 2 Ocean"),
                           p("Data starts in 2011 with Temperature (ºC), Salinity (ppt), Conductivity (mS/cm), Oxygen Reduction Potential (mV) (abbreviated as ORP), and pH."),
                           p("In 2014, a YSI 6600 V2 multiparameter sonde was installed in the B2O and set to record Temperature (ºF and ºC), pH, Salinity (ppt), Conductivity (mS/cm), ORP (mV), Phycoerythrin (RFU), Chlorophyll (µg/L), and Dissolved Oxygen (%)."),
                           p("In 2018, the ocean team started collecting weekly nutrient samples of Turbidity (FAU), Phosphate (mg/L), Nitrate (mg/L), Alkalinity (mg/L), Silicate (mg/L), and Iron (mg/L). This is done via colorimetry and digital titration (Hach brand)."),
                           p("In 2021, a new YSI EXO3 sonde was installed in the B2O and set to record Temperature (ºF and ºC), pH, Salinity (PSU), Conductivity (µS/cm), Dissolved Oxygen (mg/L and %), ORP (mV), Chlorophyll (RFU), Total Algae (RFU), and Total Dissolved Solids (RFU) at 15-minute intervals."),
                           h6("Biosphere 1 Oceans"),
                           p("Data from Biosphere 1 oceans (Atlantic, Pacific, etc) were downloaded and compiled from NOAA databases (see References for citation).")
                         ),
                         accordion_panel(
                           "Quality Control",
                           h6("Overall"),
                           p("Data was run through a function that identifies outlier data points beyond 2 standard deviations from the monthly mean or median for each variable. The use of mean or median was decided by running a Shapiro-Wilk Test for Normality on the data for each month. Normal data was compared to the mean. Non-normal data was compared to the median. Outliers beyond 2 standard deviations were turned into NA values."),
                           h6("For this website"),
                           p("Data used in this website is from the overall quality control process. However, to increase the usefulness of visualizations, medians of the data were taken on daily, weekly, monthly, and yearly intervals. The smallest unit of data presented here is a median of data taken in a 24-hour period. Median was used because the original quality control revealed that most of the data tends to be non-normal, though the size of this dataset does usually give the same mean and median value for at least monthly and yearly intervals.")
                         ),
                         accordion_panel(
                           "Historical Context",
                           p("While most of the data follows the same seasonal trends that are exhibited by B1 oceans, there are some discrepancies that can be explained through the history of the B2O."),
                           h6("1996-2013:"),
                           p("The B2O was largely un-cared for and unmonitored until 2013. The Biosphere 2 facility was acquired by the University of Arizona in July 2011, which is where our dataset starts, but its validity from 2011-2013 cannot be 100% confirmed."),
                           h6("2013-2018:"),
                           p("Dr. Rafe Sagarin became employed as the Ocean Program Director and decided to model the B2O after the Sea of Cortez due to its proximity, meaning that seasonal cycles would be similar in both systems. This allowed for a detailed education program about the Sea of Cortez and its importance for the weather patterns of Tucson."),
                           p("In 2014, Dr. Sagarin introduced a YSI 6600 V2 Multiparameter Sonde to the B2O, which increased the number of parameters and the validity of the data recorded."),
                           p("In 2015, Dr. Julia Cole succeeded Dr. Sagarin as Ocean Research Director. With a background in coral research (specifically in using coral skeletons to reconstruct past climate conditions), Dr. Cole decided the new purpose of the B2O would be to replicate conditions found in tropical oceans and use the system as an experimental mesocosm for testing the validity of radical solutions for coral reef restoration both in current and future projected climactic conditions."),
                           p("The increase in salinity seen from 2015-2018 is due to staff mixing artificial saltwater and adding it to the system to better replicate the conditions seen on coral reefs in tropical oceans worldwide."),
                           h6("2018-Present:"),
                           p("In 2018, Dr. Cole left her position as Ocean Research Director and was succeeded by fellow coral paleogeologist, Dr. Diane Thompson, who still currently holds this position. Dr. Thompson has continued the purpose of the B2O as an experimental mesocosm dedicated to testing solutions for coral reef restoration that are not yet currently able to be deployed in B1 Oceans."),
                           p("During this time, Dr. Thompson has overseen the installation of a temperature regulator that can change the temperature of all 700,000-gallons of water by 2ºC in 24 hours. This is the reason why the temperature data flattens out in 2019. She also installed a new YSI EXO3 Multiparameter Sonde to replace the old one."),
                           p("From 2018-2020, the B2O team pulled out 1000s of pounds of algae from the reef, which can be seen throughout the data."),
                           p("2020-2021 brought with it the COVID-19 pandemic and a turnover in staff, which left the B2O understaffed, a possible contributor to any major and/or sudden shifts and gaps in the data."),
                           p("Staffing has been stable since 2022 with the hiring of Research Specialists Lia Crocker and Renee Grambihler who have backgrounds in engineering and bioinformatics, respectively.")
                         ),
                         accordion_panel(
                           "References",
                           p("National Oceanic and Atmospheric Administration; NOAA Atlantic Oceanographic and Meteorological Laboratory; Cooperative Institute for Marine and Atmospheric Studies (2018). National Coral Reef Monitoring Program: Carbonate chemistry data collected in the Atlantic Ocean. [indicate subset used]. NOAA National Centers for Environmental Information. Dataset. https://doi.org/10.25921/vfz0-dg77. Accessed Sept 9 2024. "),
                           p("Ecosystem Sciences Division, Pacific Islands Fisheries Science Center (2018). National Coral Reef Monitoring Program: Water chemistry of the coral reefs in the Pacific Ocean. [indicate subset used]. NOAA National Centers for Environmental Information. Dataset. https://doi.org/10.25921/nnk7-5f86. Accessed Sept 9 2024. "),
                           p("NCEI World Ocean Database ")
                         )
                       )
              )
              ),
              
              ##### Time Series Page #####
              nav_panel("Time Series",
                        navset_card_tab(
                          ##### Overall Trends Tab #####
                          nav_panel("Overall Trends",
                                    layout_sidebar(
                                      # sidebar
                                      sidebar = sidebar(
                                        # sidebar arguments
                                        position = "left",
                                        open = "always",
                                        width = 350,
                                        padding = 50,
                                        # sidebar contents in accordion style
                                        accordion(
                                          # start with top left panel open
                                          open = "Top Left Plot",
                                          # date range input
                                          # always seen
                                          dateRangeInput(inputId = "OverallDateRange", 
                                                         label = "Select Date Range",
                                                         start = date_range_overall$Date[1],
                                                         end = tail(date_range_overall$Date, n=1),
                                                         min = date_range_overall$Date[1],
                                                         max = tail(date_range_overall$Date, n=1)
                                          ),
                                          # Overall Plot 1 Input
                                          accordion_panel(
                                            "Top Left Plot",
                                            selectInput(inputId = "OverallVariable1", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "Temperature (ºC)"),
                                            selectInput(inputId = "OverallMedian1",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices,
                                                        selected = "Daily"),
                                            checkboxInput(inputId = "OverallLoessCheck1",
                                                          label = "Add Loess Curve",
                                                          value = FALSE)
                                          ),
                                          # Overall Plot 2 Input
                                          accordion_panel(
                                            "Bottom Left Plot",
                                            selectInput(inputId = "OverallVariable2", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "None"),
                                            selectInput(inputId = "OverallMedian2",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices,
                                                        selected = "Daily"),
                                            checkboxInput(inputId = "OverallLoessCheck2",
                                                          label = "Add Loess Curve",
                                                          value = FALSE)
                                          ),
                                          # Overall Plot 3 Input
                                          accordion_panel(
                                            "Top Right Plot",
                                            selectInput(inputId = "OverallVariable3", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "None"),
                                            selectInput(inputId = "OverallMedian3",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices,
                                                        selected = "Daily"),
                                            checkboxInput(inputId = "OverallLoessCheck3",
                                                          label = "Add Loess Curve",
                                                          value = FALSE)
                                          ), 
                                          # Overall Plot 4 Input
                                          accordion_panel(
                                            "Bottom Right Plot",
                                            selectInput(inputId = "OverallVariable4", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "None"),
                                            selectInput(inputId = "OverallMedian4",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices,
                                                        selected = "Daily"),
                                            checkboxInput(inputId = "OverallLoessCheck4",
                                                          label = "Add Loess Curve",
                                                          value = FALSE)
                                          )
                                        )
                                      ),
                                      # main panel: top row
                                      layout_column_wrap(
                                        width = 1/2,
                                        conditionalPanel("input.OverallVariable1 !== 'None'",
                                                         plotOutput("OverallTrendsPlot1")
                                        ),
                                        conditionalPanel("input.OverallVariable3 !== 'None'",
                                                         plotOutput("OverallTrendsPlot3")
                                        )
                                      ),
                                      # main panel: bottom row
                                      layout_column_wrap(
                                        width = 1/2,
                                        conditionalPanel("input.OverallVariable2 !== 'None'",
                                                         plotOutput("OverallTrendsPlot2")
                                        ),
                                        conditionalPanel("input.OverallVariable4 !== 'None'",
                                                         plotOutput("OverallTrendsPlot4")
                                        )
                                      )
                                    )
                                    
                          ),
                          ##### Seasonal Trends Tab #####
                          nav_panel("Seasonal Trends",
                                    layout_sidebar(
                                      # sidebar
                                      sidebar = sidebar(
                                        # sidebar arguments
                                        position = "left",
                                        open = "always",
                                        width = 350,
                                        padding = 50,
                                        # sidebar contents in accordion style
                                        accordion(
                                          # start with top left panel open
                                          open = "Top Left Plot",
                                          # date range input
                                          # always seen
                                          checkboxGroupInput(
                                            inputId = "SeasonalDateRange",
                                            label = "Select Years to Plot",
                                            choices = date_range_seasonal,
                                            selected = date_range_seasonal
                                          ),
                                          # Seasonal Plot 1 Input
                                          accordion_panel(
                                            "Top Left Plot",
                                            selectInput(inputId = "SeasonalVariable1", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "Temperature (ºC)"),
                                            selectInput(inputId = "SeasonalMedian1",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices[median_period_choices != "Yearly"],
                                                        selected = "Daily"),
                                            radioButtons(inputId = "SeasonalineLoess1",
                                                         label = "Choose Plot Type",
                                                         choices = c("Line Plot",
                                                                     "Loess Plot"),
                                                         selected = "Loess Plot")
                                          ),
                                          # Seasonal Plot 2 Input
                                          accordion_panel(
                                            "Bottom Left Plot",
                                            selectInput(inputId = "SeasonalVariable2", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "None"),
                                            selectInput(inputId = "SeasonalMedian2",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices[median_period_choices != "Yearly"],
                                                        selected = "Daily"),
                                            radioButtons(inputId = "SeasonalineLoess2",
                                                         label = "Choose Plot Type",
                                                         choices = c("Line Plot",
                                                                     "Loess Plot"),
                                                         selected = "Loess Plot")
                                          ),
                                          # Seasonal Plot 3 Input
                                          accordion_panel(
                                            "Top Right Plot",
                                            selectInput(inputId = "SeasonalVariable3", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "None"),
                                            selectInput(inputId = "SeasonalMedian3",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices[median_period_choices != "Yearly"],
                                                        selected = "Daily"),
                                            radioButtons(inputId = "SeasonalineLoess3",
                                                         label = "Choose Plot Type",
                                                         choices = c("Line Plot",
                                                                     "Loess Plot"),
                                                         selected = "Loess Plot")
                                          ), 
                                          # Seasonal Plot 4 Input
                                          accordion_panel(
                                            "Bottom Right Plot",
                                            selectInput(inputId = "SeasonalVariable4", 
                                                        label = "Select Variable to Plot", 
                                                        choices = var_choices,
                                                        selected = "None"),
                                            selectInput(inputId = "SeasonalMedian4",
                                                        label = "Select Median Interval",
                                                        choices = median_period_choices[median_period_choices != "Yearly"],
                                                        selected = "Daily"),
                                            radioButtons(inputId = "SeasonalineLoess4",
                                                         label = "Choose Plot Type",
                                                         choices = c("Line Plot",
                                                                     "Loess Plot"),
                                                         selected = "Loess Plot")
                                          )
                                        )
                                      ),
                                      # main panel: top row
                                      layout_column_wrap(
                                        width = 1/2,
                                        conditionalPanel("input.SeasonalVariable1 !== 'None'",
                                                         plotOutput("SeasonalTrendsPlot1")
                                        ),
                                        conditionalPanel("input.SeasonalVariable3 !== 'None'",
                                                         plotOutput("SeasonalTrendsPlot3")
                                        )
                                      ),
                                      # main panel: bottom row
                                      layout_column_wrap(
                                        width = 1/2,
                                        conditionalPanel("input.SeasonalVariable2 !== 'None'",
                                                         plotOutput("SeasonalTrendsPlot2")
                                        ),
                                        conditionalPanel("input.SeasonalVariable4 !== 'None'",
                                                         plotOutput("SeasonalTrendsPlot4")
                                        )
                                      )
                                    )
                                    
                          )
                        )
              ),
              
              ##### Correlations Page #####
              nav_panel(title = "Correlations",
                        navset_card_tab(
                          ##### Matrices Tab #####
                          nav_panel("Matrices",
                                    layout_sidebar(
                                      sidebar = sidebar(
                                        radioButtons(
                                          inputId = "CorrMatrixButton",
                                          label = "Choose Matrix Data",
                                          choices = c("All Correlations","Significant Correlations"),
                                          selected = "All Correlations"
                                        )
                                      ),
                                      layout_column_wrap(
                                        width = 1,
                                        plotOutput("CorrPlot",
                                                   height = "1000px")
                                      )
                                    )
                          ),
                          ##### Tables Tab #####
                          nav_panel("Tables",
                                    layout_sidebar(
                                      sidebar = sidebar(
                                        radioButtons(
                                          inputId = "CorrTableButton",
                                          label = "Choose Table Data",
                                          choices = c("All Correlations","Significant Correlations"),
                                          selected = "All Correlations"
                                        )
                                      ),
                                      layout_column_wrap(
                                        width = 1,
                                        height = "1000px",
                                        DTOutput("CorrTable")
                                      )
                                    )
                          )
                        )
              ),
              
              ##### B1 Comparisons Page #####
              nav_panel(title = "B1 Comparisons",
                        layout_column_wrap(
                          width = 1,
                          heights_equal = "row",
                          leafletOutput("MapB1Comps",
                                        height = 300),
                          tags$style(HTML(".radio-inline {margin-right: 42px;}")),
                          radioButtons(
                            inputId = "MapButtons",
                            label = "Filter Data By:",
                            choices = c("None",
                                        "Ocean, 2011-Present",
                                        "Ocean, 2018-Present"),
                            selected = "None",
                            inline = TRUE
                          ),
                          DTOutput("TableB1Comps",
                                   height = 1000, 
                                   fill = FALSE)
                        )
              )
  )
)

# Server Logic -----
server <- function(input, output) {
  ##### Website Header #####
  # header image
    output$B2Header <- renderImage({
      list(src = "SourceImages/Webheader-Biosphere_0_0.png",
           style = 'height: 25%; width: 200px')
    }, deleteFile = FALSE)
  ##### About #####
    # b2o image
    output$B2OImage <- renderImage({
      list(src = "SourceImages/B2O-image.png", style='width: 600px; height: 350px')
    }, deleteFile = FALSE)
  ##### Time Series #####
    ##### Overall Trends #####
    # Plot 1
    output$OverallTrendsPlot1 <- renderPlot({
      # scale_x_date() options
      # default 
      datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
      datelabels <- "%Y"
      if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "2 week"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %d %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "4 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "6 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
        datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
        datelabels <- "%Y"
      }
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_otp <- dfAll[, c("Time Interval", "Date", input$OverallVariable1)]
      colnames(dfAll_otp) <- c("Time Interval", "Date", "input_var")
      
      otp <- ggplot(data = dfAll_otp[dfAll_otp$`Time Interval` == "Daily" & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                    aes(x = Date, 
                        y = input_var))+
        geom_point(color = "lightgray",
                   alpha = 0.4,
                   size = 6) +
        geom_line(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian1 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2] & !is.na(dfAll_otp$input_var), ],
                  aes(x = Date,
                      y = input_var), 
                  size = 0.75) +
        scale_x_date(breaks = datebreaks,
                     date_labels = datelabels) +
        theme_bw() + 
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16), 
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        ylab(input$OverallVariable1) +
        ggtitle(input$OverallVariable1)
      
      if (input$OverallLoessCheck1 == TRUE) {
        otp <- otp + geom_smooth(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian1 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
        otp
      } else {
        otp
      }
      
    })
    # Plot 2
    output$OverallTrendsPlot2 <- renderPlot({
      # scale_x_date() options
      # default 
      datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
      datelabels <- "%Y"
      if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "2 week"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %d %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "4 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "6 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
        datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
        datelabels <- "%Y"
      }
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_otp <- dfAll[, c("Time Interval", "Date", input$OverallVariable2)]
      colnames(dfAll_otp) <- c("Time Interval", "Date", "input_var")
      
      otp <- ggplot(data = dfAll_otp[dfAll_otp$`Time Interval` == "Daily" & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                    aes(x = Date, 
                        y = input_var))+
        geom_point(color = "lightgray",
                   alpha = 0.4,
                   size = 6) +
        geom_line(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian2 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2] & !is.na(dfAll_otp$input_var), ],
                  aes(x = Date,
                      y = input_var), 
                  size = 0.75) +
        scale_x_date(breaks = datebreaks,
                     date_labels = datelabels) +
        theme_bw() + 
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16), 
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        ylab(input$OverallVariable2) +
        ggtitle(input$OverallVariable2)
      
      if (input$OverallLoessCheck2 == TRUE) {
        otp <- otp + geom_smooth(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian2 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
        otp
      } else {
        otp
      }
      
    })
    # Plot 3
    output$OverallTrendsPlot3 <- renderPlot({
      # scale_x_date() options
      # default 
      datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
      datelabels <- "%Y"
      if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "2 week"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %d %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "4 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "6 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
        datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
        datelabels <- "%Y"
      }
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_otp <- dfAll[, c("Time Interval", "Date", input$OverallVariable3)]
      colnames(dfAll_otp) <- c("Time Interval", "Date", "input_var")
      
      otp <- ggplot(data = dfAll_otp[dfAll_otp$`Time Interval` == "Daily" & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                    aes(x = Date, 
                        y = input_var))+
        geom_point(color = "lightgray",
                   alpha = 0.4,
                   size = 6) +
        geom_line(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian3 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2] & !is.na(dfAll_otp$input_var), ],
                  aes(x = Date,
                      y = input_var), 
                  size = 0.75) +
        scale_x_date(breaks = datebreaks,
                     date_labels = datelabels) +
        theme_bw() + 
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16), 
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        ylab(input$OverallVariable3) +
        ggtitle(input$OverallVariable3)
      
      if (input$OverallLoessCheck3 == TRUE) {
        otp <- otp + geom_smooth(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian3 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
        otp
      } else {
        otp
      }
      
    })
    # Plot 4
    output$OverallTrendsPlot4 <- renderPlot({
      # scale_x_date() options
      # default 
      datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
      datelabels <- "%Y"
      if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "2 week"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %d %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "4 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
                 & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
        datebreaks <- append(seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "6 month"), as.Date(input$OverallDateRange[2]))
        datelabels <- "%b %Y"
      } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
        datebreaks <- seq(as.Date(input$OverallDateRange[1]), as.Date(input$OverallDateRange[2]), by = "1 year")
        datelabels <- "%Y"
      }
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_otp <- dfAll[, c("Time Interval", "Date", input$OverallVariable4)]
      colnames(dfAll_otp) <- c("Time Interval", "Date", "input_var")
      
      otp <- ggplot(data = dfAll_otp[dfAll_otp$`Time Interval` == "Daily" & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                    aes(x = Date, 
                        y = input_var))+
        geom_point(color = "lightgray",
                   alpha = 0.4,
                   size = 6) +
        geom_line(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian4 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2] & !is.na(dfAll_otp$input_var), ],
                  aes(x = Date,
                      y = input_var), 
                  size = 0.75) +
        scale_x_date(breaks = datebreaks,
                     date_labels = datelabels) +
        theme_bw() + 
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16), 
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        ylab(input$OverallVariable4) +
        ggtitle(input$OverallVariable4)
      
      if (input$OverallLoessCheck4 == TRUE) {
        otp <- otp + geom_smooth(data = dfAll_otp[dfAll_otp$`Time Interval` == input$OverallMedian4 & dfAll_otp$Date >= input$OverallDateRange[1] & dfAll_otp$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
        otp
      } else {
        otp
      }
      
    })
    ##### Seasonal Trends #####
    # Plot 1
    output$SeasonalTrendsPlot1 <- renderPlot({
      # put dates into usable formats
      dates_vector <- input$SeasonalDateRange
      dfDates <- data.frame(Date = dates_vector) %>%
        mutate(Date = paste(Date,"01-01",sep = "-"),
               Date = as.Date(Date))
      dfDates <- rbind(dfDates, tail(dfAll[dfAll$`Time Interval` == "Daily", "Date"], n=1))
      
      # select geom_line() or geom_smooth()
      geometry <- geom_smooth(se = F)
      if (input$SeasonalineLoess1 == "Line Plot") {
        geometry <- geom_line()
      }
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_stp <- dfAll %>%
        mutate(year = year(Date)) %>%
        filter(year %in% dates_vector)
      dfAll_stp <- dfAll_stp[, c("Time Interval", "Date", input$SeasonalVariable1)]
      colnames(dfAll_stp) <- c("Time Interval", "Date", "input_var")
      dfAll_stp <- na.omit(dfAll_stp)

      stp <- ggplot(data = dfAll_stp[dfAll_stp$`Time Interval` == input$SeasonalMedian1 & dfAll_stp$Date >= dfDates$Date[1] & dfAll_stp$Date <= tail(dfDates$Date, n=1), ],
                     aes(x = as.Date(yday(Date), "2021-01-01"), #use each day of the year as the x axis data
                         color = factor(year(Date)), #plot data from each year separately as its own color
                         y = input_var)) + #use nutrient values as y axis data
        geometry +
        scale_x_date(date_breaks = "months", 
                     date_labels = "%B") +
        # theme code is for making background of plot nice
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16),
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        labs(title = input$SeasonalVariable1, 
             x = "Date", 
             y = input$SeasonalVariable1,
             color = "Year")
      stp
      
    })
    # Plot 2
    output$SeasonalTrendsPlot2 <- renderPlot({
      # put dates into usable formats
      dates_vector <- input$SeasonalDateRange
      dfDates <- data.frame(Date = dates_vector) %>%
        mutate(Date = paste(Date,"01-01",sep = "-"),
               Date = as.Date(Date))
      dfDates <- rbind(dfDates, tail(dfAll[dfAll$`Time Interval` == "Daily", "Date"], n=1))
      
      # select geom_line() or geom_smooth()
      geometry <- geom_smooth(se = F)
      if (input$SeasonalineLoess2 == "Line Plot") {
        geometry <- geom_line()
      } 
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_stp <- dfAll %>%
        mutate(year = year(Date)) %>%
        filter(year %in% dates_vector)
      dfAll_stp <- dfAll_stp[, c("Time Interval", "Date", input$SeasonalVariable2)]
      colnames(dfAll_stp) <- c("Time Interval", "Date", "input_var")
      dfAll_stp <- na.omit(dfAll_stp)
      
      stp <- ggplot(data = dfAll_stp[dfAll_stp$`Time Interval` == input$SeasonalMedian2 & dfAll_stp$Date >= dfDates$Date[1] & dfAll_stp$Date <= tail(dfDates$Date, n=1), ],
                     aes(x = as.Date(yday(Date), "2021-01-01"), #use each day of the year as the x axis data
                         color = factor(year(Date)), #plot data from each year separately as its own color
                         y = input_var)) + #use nutrient values as y axis data
        geometry +
        scale_x_date(date_breaks = "months", 
                     date_labels = "%B") +
        # theme code is for making background of plot nice
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16),
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        labs(title = input$SeasonalVariable2, 
             x = "Date", 
             y = input$SeasonalVariable2,
             color = "Year")
      stp
      
    })
    # Plot 3
    output$SeasonalTrendsPlot3 <- renderPlot({
      # put dates into usable formats
      dates_vector <- input$SeasonalDateRange
      dfDates <- data.frame(Date = dates_vector) %>%
        mutate(Date = paste(Date,"01-01",sep = "-"),
               Date = as.Date(Date))
      dfDates <- rbind(dfDates, tail(dfAll[dfAll$`Time Interval` == "Daily", "Date"], n=1))
      
      # select geom_line() or geom_smooth()
      geometry <- geom_smooth(se = F)
      if (input$SeasonalineLoess3 == "Line Plot") {
        geometry <- geom_line()
      } 
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_stp <- dfAll %>%
        mutate(year = year(Date)) %>%
        filter(year %in% dates_vector)
      dfAll_stp <- dfAll_stp[, c("Time Interval", "Date", input$SeasonalVariable3)]
      colnames(dfAll_stp) <- c("Time Interval", "Date", "input_var")
      dfAll_stp <- na.omit(dfAll_stp)
      
      
      stp <- ggplot(data = dfAll_stp[dfAll_stp$`Time Interval` == input$SeasonalMedian3 & dfAll_stp$Date >= dfDates$Date[1] & dfAll_stp$Date <= tail(dfDates$Date, n=1), ],
                     aes(x = as.Date(yday(Date), "2021-01-01"), #use each day of the year as the x axis data
                         color = factor(year(Date)), #plot data from each year separately as its own color
                         y = input_var)) + #use nutrient values as y axis data
        geometry +
        scale_x_date(date_breaks = "months", 
                     date_labels = "%B") +
        # theme code is for making background of plot nice
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16),
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        labs(title = input$SeasonalVariable3, 
             x = "Date", 
             y = input$SeasonalVariable3,
             color = "Year")
      stp
      
    })
    # Plot 4
    output$SeasonalTrendsPlot4 <- renderPlot({
      # put dates into usable formats
      dates_vector <- input$SeasonalDateRange
      dfDates <- data.frame(Date = dates_vector) %>%
        mutate(Date = paste(Date,"01-01",sep = "-"),
               Date = as.Date(Date))
      dfDates <- rbind(dfDates, tail(dfAll[dfAll$`Time Interval` == "Daily", "Date"], n=1))
      
      # select geom_line() or geom_smooth()
      geometry <- geom_smooth(se = F)
      if (input$SeasonalineLoess4 == "Line Plot") {
        geometry <- geom_line()
      } 
      
      # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
      dfAll_stp <- dfAll %>%
        mutate(year = year(Date)) %>%
        filter(year %in% dates_vector)
      dfAll_stp <- dfAll_stp[, c("Time Interval", "Date", input$SeasonalVariable4)]
      colnames(dfAll_stp) <- c("Time Interval", "Date", "input_var")
      dfAll_stp <- na.omit(dfAll_stp)
      
      
      stp <- ggplot(data = dfAll_stp[dfAll_stp$`Time Interval` == input$SeasonalMedian4 & dfAll_stp$Date >= dfDates$Date[1] & dfAll_stp$Date <= tail(dfDates$Date, n=1), ],
                     aes(x = as.Date(yday(Date), "2021-01-01"), #use each day of the year as the x axis data
                         color = factor(year(Date)), #plot data from each year separately as its own color
                         y = input_var)) + #use nutrient values as y axis data
        geometry +
        scale_x_date(date_breaks = "months", 
                     date_labels = "%B") +
        # theme code is for making background of plot nice
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank())+
        theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 16),
              axis.text.y = element_text(size = 16),
              axis.title.x = element_text(size = 18),
              axis.title.y = element_blank(),
              plot.title = element_text(size = 20))+
        theme(strip.background = element_rect(fill = "white")) +
        labs(title = input$SeasonalVariable4, 
             x = "Date", 
             y = input$SeasonalVariable4,
             color = "Year")
      stp
      
    })
    
    
  
  ##### Correlations #####
    ##### Matrices #####
    # Correlations Plots
    output$CorrPlot <- renderPlot({
      # correlations R values
      cormat_RValues <- as.data.frame(cor_mat_stats$r)
      # correlations P values
      cormat_PValues <-  as.data.frame(cor_mat_stats$P)
      
      # change row names of dataframes to be the column names
      row_names <- colnames(cormat_PValues)
      rownames(cormat_PValues) <- row_names
      rownames(cormat_RValues) <- row_names
      
      # turn both dataframes into matrices
      cormat_RValues <- as.matrix(cormat_RValues)
      cormat_PValues <- as.matrix(cormat_PValues)
      
      # turn NAs into insignificant values
      cormat_PValues[is.na(cormat_PValues)] <- 1.00
      cormat_RValues[is.na(cormat_RValues)] <- 0.00
      
      if (input$CorrMatrixButton == "All Correlations") {
        # Correlogram
        ggcorrplot(cormat_RValues,
                   outline.color = "white",
                   ggtheme = ggplot2::theme_gray(),
                   colors = c("#6D9EC1", "white", "#E46726"),
                   title = "All Correlations",
                   lab = TRUE,
                   lab_size = 5,
                   tl.cex = 18,
                   legend.title = "Correlation Strength") +
          theme(plot.title = element_text(size = 20))
        
      } else if (input$CorrMatrixButton == "Significant Correlations") {
        # Correlogram with Significance
        ggcorrplot(cormat_RValues,
                   p.mat = cormat_PValues,
                   outline.color = "white",
                   ggtheme = ggplot2::theme_gray(),
                   colors = c("#6D9EC1", "white", "#E46726"),
                   title = "Significant Correlations",
                   lab = TRUE,
                   insig = "blank",
                   lab_size = 5,
                   tl.cex = 18,
                   legend.title = "Correlation Strength")+
          theme(plot.title = element_text(size = 20))
      }
      
    })
    ##### Tables #####
    # Data Table
    output$CorrTable <- renderDT(
      if (input$CorrTableButton == "All Correlations") {
        datatable(corrTable,
                  fillContainer = getOption("DT.fillContainer", TRUE))
      } else {
        corrTable_filter <- corrTable %>%
          filter(`P-Value` <= 0.05)
        datatable(corrTable_filter,
                  fillContainer = getOption("DT.fillContainer", TRUE))
      },
      filter = list(position = "top")
    )
  
  
  ##### B1 Comparisons #####
    ##### Map #####
    output$MapB1Comps <- renderLeaflet({
     
      dfMap_loc <- dfMap %>%
        filter(Year <= 2011 | Year >= 2018) %>%
        select(-Year) %>%
        group_by(Location, Latitude, Longitude) %>%
        summarise(across(4:11, ~median(.x, na.rm = TRUE)))
      
      labelText <- paste0(dfMap_loc$Location,
                          "<hr>",
                          "Temperature (ºC): ", as.character(dfMap_loc$`Temperature (ºC)`),
                          "<br>",
                          "Salinity (PSU): ", as.character(dfMap_loc$`Salinity (PSU)`),
                          "<br>",
                          "Phosphate (mg/L): ", as.character(dfMap_loc$`Phosphate (mg/L)`),
                          "<br>",
                          "Silicate (mg/L): ", as.character(dfMap_loc$`Silicate (mg/L)`),
                          "<br>",
                          "Nitrate (mg/L): ", as.character(dfMap_loc$`Nitrate (mg/L)`),
                          "<br>",
                          "pH: ", as.character(dfMap_loc$pH),
                          "<br>",
                          "Alkalinity (mg/L): ", as.character(dfMap_loc$`Alkalinity (mg/L)`),
                          "<br>",
                          "Iron (mg/L): ", as.character(dfMap_loc$`Iron (mg/L)`))
      
      leaflet(data = dfMap_loc) %>%
        addTiles() %>%
        addCircleMarkers(lng = ~Longitude,
                         lat = ~Latitude,
                         label = lapply(labelText,
                                        htmltools::HTML))
      
    })
    ##### Data Table #####
    output$TableB1Comps <- renderDT({
      # original dataframe
      dfMap_all <- dfMap %>%
        select(-Latitude, -Longitude, -Region) 
      
      # medians of each ocean by year
      dfMap_ocean <- dfMap_all %>%
        group_by(Year, Ocean) %>%
        summarise_if(is.numeric, median, na.rm = TRUE)
      
      dfMap_recent <- dfMap_all %>%
        filter(Year >= "2018") %>%
        group_by(Year, Ocean) %>%
        summarise_if(is.numeric, median, na.rm = TRUE)
      
      if (input$MapButtons == "None") {
        datatable(dfMap_all,
                  rownames = FALSE,
                  fillContainer = getOption("DT.fillContainer", TRUE),
                  options = list(autoWidth = TRUE))
      } else if (input$MapButtons == "Ocean, 2011-Present") {
        datatable(dfMap_ocean,
                  rownames = FALSE,
                  fillContainer = getOption("DT.fillContainer", TRUE),
                  options = list(autoWidth = TRUE))
      } else if (input$MapButtons == "Ocean, 2018-Present") {
        datatable(dfMap_recent,
                  rownames = FALSE,
                  fillContainer = getOption("DT.fillContainer", TRUE),
                  options = list(autoWidth = TRUE))
      }
        
    })
    
}


# Run App -----
shinyApp(ui = ui, server = server)
