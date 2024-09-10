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
source("Dependencies/CorrelationFunction.R")
options(scipen = 999)

# Import data -----
# all data are medians of each indicated interval except for the daily hach 
#  which are "raw" data points since hach is taken once per day (Mon & Fri)
# all Hach and YSI data: combo of all above files with "Time Interval" column to 
# denote which interval (daily, weekly, etc) the data comes from
dfAll <- read_csv("SourceData/05-HachYSI-Data-All.csv", col_names = TRUE) %>%
  select(-`pH_Hach`) %>%
  rename(pH = `pH (YSI)`)

# Data Wrangling -----
## Correlations
# create nested list of correlation matrices: p-values, n, r values
cor_mat_stats <- dfAll %>%
  filter(`Time Interval` == "Daily") %>%
  select(-`Time Interval`, -Date, -`pH (mV)`, -`Conductivity, Non-Linear Function (µS/cm)`,
         -`Conductivity, Specific (µS/cm)`, -`Dissolved Oxygen, Saturated (%)`) 
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
                 "Conductivity, Non-Linear Function (µS/cm)",
                 "Conductivity, Specific (µS/cm)",
                 "Dissolved Oxygen (mg/L)",
                 "Dissolved Oxygen, Local (%)",
                 "Dissolved Oxygen, Saturated (%)",
                 "Iron (mg/L)",
                 "Nitrate, Mid-Range (mg/L)", 
                 "Nitrate, High-Range (mg/L)",
                 "Oxygen Reduction Potential (mV)",
                 "pH",
                 "pH (mV)",
                 "Phosphate (mg/L)",
                 "Salinity (PSU)",
                 "Silica (mg/L)",
                 "Temperature (ºC)",
                 "Temperature (ºF)",
                 "Total Algae (RFU)",
                 "Total Dissolved Solids (mg/L)",
                 "Turbidity (RFU)")

# character vector of UI choices for `Time Interval`
median_period_choices <- c("Daily", "Weekly", "Monthly", "Yearly")

# User Interface -----
ui <- fluidPage(
  titlePanel(title = div(img(src = "https://biosphere2.org/sites/default/files/Webheader-Biosphere_0_0.png",
                             width = 250),
                         "Ocean Systems Water Quality", style = "color: #49595e;")
  ),
  page_navbar(title = NULL,
              inverse = FALSE,
              ##### About Page #####
              nav_panel(title = "About",
                        # metadata: where data came from, time period, variables tracked, units, explanations of variables, DATA IN CONTEXT PAGE
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
                        
              )
  )
)




# Server Logic -----
server <- function(input, output) {
  ##### About #####
  
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
        corrTable
      } else {
        corrTable %>%
          filter(`P-Value` <= 0.05)
      },
      filter = list(position = "top")
    )
  
}


# Run App -----
shinyApp(ui = ui, server = server)
