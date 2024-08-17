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
library(shinythemes)
library(bslib)
library(tidyverse)
library(lubridate)

# Import data -----
# all data are medians of each indicated interval except for the daily hach 
#  which are "raw" data points since hach is taken once per day (Mon & Fri)
# daily Hach and YSI data
dfDaily <- read_csv("SourceData/01-HachYSI-Data-Daily.csv", col_names = TRUE)
# weekly Hach and YSI data 
dfWeekly <- read_csv("SourceData/02-HachYSI-Data-Weekly.csv", col_names = TRUE)
# monthly Hach and YSI data 
dfMonthly <- read_csv("SourceData/03-HachYSI-Data-Monthly.csv", col_names = TRUE)
# yearly Hach and YSI data 
dfYearly <- read_csv("SourceData/04-HachYSI-Data-Yearly.csv", col_names = TRUE)
# all Hach and YSI data: combo of all above files with "Time Interval" column to 
# denote which interval (daily, weekly, etc) the data comes from
#dfAll <- read_csv("SourceData/05-HachYSI-Data-All.csv", col_names = TRUE)

# Define variables -----

# dfAll_pivot <- dfAll %>%
#   pivot_longer(cols = `Temperature (ºF)`:`Ammonia (mg/L)`, 
#                names_to = "variables_col",
#                values_to = "values_col")

# character vector of all day dates in YSI data
date_range <- dfAll %>%
  filter(`Time Interval` == "Daily") %>%
  select(Date) %>%
  mutate(Date = as.Date(Date))

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

# dataframe of data to plot as basis/background of plots: these are the daily medians/observations which is the most data available
dfBaseData <- dfAll %>%
  filter(`Time Interval` == "Daily") %>%
  mutate(Date = as.Date(Date))

# User Interface -----
ui <- fluidPage(
  titlePanel(title = div(img(src = "https://biosphere2.org/sites/default/files/Webheader-Biosphere_0_0.png",
                             width = 250),
                         "Ocean Systems Water Quality", style = "color: #49595e;")
  ),
  navbarPage(title = NULL,
             # About Page
             tabPanel(title = "About",
                      # metadata: where data came from, time period, variables tracked, units, explanations of variables, 
             ),
             
             # Overall Trends Page
             tabPanel("Overall Trends",
                      sidebarLayout(
                        # column: fixed width, date range input and inputs for 4 plots
                        sidebarPanel(
                          # input date range
                          dateRangeInput(inputId = "OverallDateRange", 
                                         label = "Select Date Range",
                                         start = date_range$Date[1],
                                         end = tail(date_range$Date, n=1),
                                         min = date_range$Date[1],
                                         max = tail(date_range$Date, n=1)),
                          hr(),
                          # plot 1 input
                          selectInput(inputId = "OverallVariable1", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "Temperature (ºC)"),
                          selectInput(inputId = "OverallMedian1",
                                      label = "Select moving median period",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck1",
                                        label = "Add Loess Curve",
                                        value = FALSE),
                          hr(),
                          # plot 2 input
                          selectInput(inputId = "OverallVariable2", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "None"),
                          selectInput(inputId = "OverallMedian2",
                                      label = "Select moving median period",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck2",
                                        label = "Add Loess Curve",
                                        value = FALSE),
                          hr(),
                          # plot 3 input
                          selectInput(inputId = "OverallVariable3", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "None"),
                          selectInput(inputId = "OverallMedian3",
                                      label = "Select moving median period",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck3",
                                        label = "Add Loess Curve",
                                        value = FALSE),
                          hr(),
                          # plot 4 input
                          selectInput(inputId = "OverallVariable4", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "None"),
                          selectInput(inputId = "OverallMedian4",
                                      label = "Select moving median period",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck4",
                                        label = "Add Loess Curve",
                                        value = FALSE)
                        ),
                        mainPanel(
                          # column that will fill remainder of page
                          fillCol(
                            fillRow(conditionalPanel("input.OverallVariable1 != None",
                                                     plotOutput("OverallTrendsPlot1"),
                                                     textOutput("testText"))),
                            fillRow(conditionalPanel("input.OverallVariable2 != None",
                                                     plotOutput("OverallTrendsPlot2")))
                          ),
                          # column that will pop up on end of previous column 
                          fillCol(
                            fillRow(conditionalPanel("input.OverallVariable3 != None",
                                                     plotOutput("OverallTrendsPlot3"))),
                            fillRow(conditionalPanel("input.OverallVariable4 != None",
                                                     plotOutput("OverallTrendsPlot4")))
                          )
                        )
                      )
             ),
             
             # Seasonal Trends Page
             tabPanel(title = "Seasonal Trends",
                      
             ),
             
             # Correlations Page
             tabPanel(title = "Correlations",
                      
             ),
             
             # Significant Correlations Page
             tabPanel(title = "Significant Correlations",
                      
             ),
             
             # Correlations Tables Page
             tabPanel(title = "Correlations Tables",
                      
             ),
             
             # Data in Context Page
             tabPanel(title = "Data in Context",
                      
             ),
             
             # B1 Comparisons Page
             tabPanel(title = "B1 Comparisons",
                      
             )
  )
)




# Server Logic -----
server <- function(input, output) {
  # About
  
  # Overall Trends
  ## Plot 1
  output$OverallTrendsPlot1 <- renderPlot({
    
    # # check which dataset is being viewed
    # if (input$dataset3 == "Raw Data") {
    #   # use raw data csv
    #   data <- dfYSI
    #   subt <- "Pre-QC: All Outliers Still Present"
    # } else if (input$dataset3 == "Clean Data") {
    #   # use qc'd data csv
    #   data <- dfYSI
    #   subt <- "Post-QC: Data Outside 2-Sigma from Mean has been Removed"
    # }
    # 
    # if (input$variable3 == "None") {
    #   x <- 1
    # } else {
    #   colnames(data)[3:19] <- var_choices[2:18]
    #   data <- data[, c("date", input$variable3)]
    #   colnames(data) <- c("date", "input_var")
      
      # line graph of input variable
    
      # dfAll_otp1 <- dfAll[, c("Time Interval", "Date", input$OverallVariable1)]
      # colnames(dfAll_otp1) <- c("Time Interval", "Date", "input_var")
      
      dfAll %>%
        filter(Date >= input$OveralldateRange[1] & Date <= input$OveralldateRange[2]) %>%
        filter(`Time Interval` == input$OverallMedian1) %>%
        mutate(Date = as.Date(Date)) %>%
        ggplot(aes(x = Date, 
                   y = input$OverallVariable1))+
        geom_line()+
        # geom_smooth() +
        # scale_x_date(date_breaks = "1 year",
        #              date_labels = "%b %Y") +
        #scale_x_continuous(breaks = NULL)+
        theme_bw() + 
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background = element_blank(), 
              axis.line = element_line(colour = "black"))+
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
        theme(strip.background = element_rect(fill = "white"))
  })
  
  ## Plot 2
  output$OverallTrendsPlot2 <- renderPlot({
    dfAll %>%
      filter(Date >= input$OveralldateRange[1] & Date <= input$OveralldateRange[2]) %>%
      filter(`Time Interval` == input$OverallMedian2) %>%
      mutate(Date = as.Date(Date)) %>%
      ggplot(aes_string(x = "Date", 
                        y = input$OverallVariable2)) +
      geom_line()+
      # geom_smooth() +
      # scale_x_date(date_breaks = "1 year",
      #              date_labels = "%b %Y") +
      theme_bw() + 
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(), 
            panel.background = element_blank(), 
            axis.line = element_line(colour = "black"))+
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
      theme(strip.background = element_rect(fill = "white"))
  })
  
  ## Plot 3
  output$OverallTrendsPlot3 <- renderPlot({
    dfAll %>%
      filter(Date >= input$OveralldateRange[1] & Date <= input$OveralldateRange[2]) %>%
      filter(`Time Interval` == input$OverallMedian3) %>%
      select(Date, input$OverallVariable3) %>%
      ggplot(aes_string(x = "Date", 
                        y = input$OverallVariable3)) +
      geom_line()+
      # geom_smooth() +
      # scale_x_date(date_breaks = "1 year",
      #              date_labels = "%b %Y") +
      theme_bw() + 
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(), 
            panel.background = element_blank(), 
            axis.line = element_line(colour = "black"))+
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
      theme(strip.background = element_rect(fill = "white"))
  })
  
  ## Plot 4
  output$OverallTrendsPlot4 <- renderPlot({
    dfAll %>%
      filter(Date >= input$OveralldateRange[1] & Date <= input$OveralldateRange[2]) %>%
      filter(`Time Interval` == input$OverallMedian4) %>%
      mutate(Date = as.Date(Date)) %>%
      ggplot(aes_string(x = "Date", 
                        y = input$OverallVariable4)) +
      geom_line()+
      # geom_smooth() +
      # scale_x_date(date_breaks = "1 year",
      #              date_labels = "%b %Y") +
      theme_bw() + 
      theme(panel.grid.major = element_blank(), 
            panel.grid.minor = element_blank(), 
            panel.background = element_blank(), 
            axis.line = element_line(colour = "black"))+
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
      theme(strip.background = element_rect(fill = "white"))
  })
  
  
}


# Run App -----
shinyApp(ui = ui, server = server)
