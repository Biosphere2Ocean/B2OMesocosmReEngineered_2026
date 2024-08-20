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
dfDaily <- read_csv("SourceData/01-HachYSI-Data-Daily.csv", col_names = TRUE) %>%
  rename(pH = `pH (YSI)`)
# weekly Hach and YSI data 
dfWeekly <- read_csv("SourceData/02-HachYSI-Data-Weekly.csv", col_names = TRUE) %>%
  rename(pH = `pH (YSI)`)
# monthly Hach and YSI data 
dfMonthly <- read_csv("SourceData/03-HachYSI-Data-Monthly.csv", col_names = TRUE) %>%
  rename(pH = `pH (YSI)`)
# yearly Hach and YSI data 
dfYearly <- read_csv("SourceData/04-HachYSI-Data-Yearly.csv", col_names = TRUE) %>%
  rename(pH = `pH (YSI)`)
# all Hach and YSI data: combo of all above files with "Time Interval" column to 
# denote which interval (daily, weekly, etc) the data comes from
dfAll <- read_csv("SourceData/05-HachYSI-Data-All.csv", col_names = TRUE) %>%
  rename(pH = `pH (YSI)`)

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
                        position = "left",
                        fluid = TRUE,
                        # column: fixed width, date range input and inputs for 4 plots
                        sidebarPanel(
                          # input date range
                          
                          # CHECK BOX GROUP MIGHT FIX UI ISSUE
                          
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
                          #works
                          # column(6,
                          #        conditionalPanel("input.OverallVariable1 != None",
                          #                         plotOutput("OverallTrendsPlot1", height = "600px")),
                          #        conditionalPanel("input.OverallVariable2 != None",
                          #                         plotOutput("OverallTrendsPlot2", height = "600px"))
                          # ),
                          # column(6,
                          #        conditionalPanel("input.OverallVariable3 != None",
                          #                         plotOutput("OverallTrendsPlot3", height = "600px")),
                          #        conditionalPanel("input.OverallVariable4 != None",
                          #                         plotOutput("OverallTrendsPlot4", height = "600px"))
                          # )
                          
                          #works
                          # fluidRow(
                          #   conditionalPanel("input.OverallVariable1 != None",
                          #                    plotOutput("OverallTrendsPlot1")),
                          #   conditionalPanel("input.OverallVariable2 != None",
                          #                    plotOutput("OverallTrendsPlot2"))
                          # )
                          
                          fluidRow(
                            conditionalPanel(
                              "input.OverallVariable1 != None",
                              plotOutput("OverallTrendsPlot1")
                            ),
                            conditionalPanel(
                              "input.OverallVariable2 != None",
                              plotOutput("OverallTrendsPlot2")
                            )
                          )
                        
                        
                          # fluidRow(
                          #   plotOutput("OverallTrendsPlot1"),
                          #   plotOutput("OverallTrendsPlot2"),
                          #   plotOutput("OverallTrendsPlot3"),
                          #   plotOutput("OverallTrendsPlot4")
                          # )
                          # conditionalPanel(condition = "input.OverallVariable3 == 'None'",
                          #                  fluidRow(
                          #                    plotOutput("OverallTrendsPlot1"),
                          #                    plotOutput("OverallTrendsPlot2")
                          #                  )
                          # ),
                          # conditionalPanel(condition = "input.OverallVariable3 != 'None'",
                          #                  fluidRow(
                          #                    column(6,
                          #                           plotOutput("OverallTrendsPlot1")),
                          #                    column(6,
                          #                           plotOutput("OverallTrendsPlot3"))
                          #                  ),
                          #                  fluidRow(
                          #                    column(6,
                          #                           plotOutput("OverallTrendsPlot2")),
                          #                    column(6,
                          #                           plotOutput("OverallTrendsPlot4"))
                          #                  )
                          #                  
                          # )
                          
                          # fluidRow(
                          #     plotOutput("OverallTrendsPlot1"),
                          #     plotOutput("OverallTrendsPlot2"),
                          #   conditionalPanel(
                          #     condition = "input.OverallVariable3 =! None",
                          #     fluidRow(
                          #       column(6,
                          #              plotOutput("OverallTrendsPlot1")),
                          #       column(6,
                          #              plotOutput("OverallTrendsPlot3"))
                          #     ),
                          #     fluidRow(
                          #       column(6,
                          #              plotOutput("OverallTrendsPlot2")),
                          #       column(6,
                          #              plotOutput("OverallTrendsPlot4"))
                          #     )
                          #   )
                          # )
                          
                          # column(5,
                          #        conditionalPanel("input.variable1 != None",
                          #                         plotOutput("plot1", height = "600px")),
                          #        conditionalPanel("input.variable2 != None",
                          #                         plotOutput("plot2", height = "600px"))
                          # ),
                          # column(5,
                          #        conditionalPanel("input.variable3 != None",
                          #                         plotOutput("plot3", height = "600px")),
                          #        conditionalPanel("input.variable4 != None",
                          #                         plotOutput("plot4", height = "600px"))
                          # )
                          
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
    # line graph of input variable
    
    dfAll_otp1 <- dfBaseData[, c("Time Interval", "Date", input$OverallVariable1)]
    colnames(dfAll_otp1) <- c("Time Interval", "Date", "input_var")
    
    dfAll_otp1 %>%
      filter(between(Date,input$OverallDateRange[1], input$OverallDateRange[2])) %>%
      filter(`Time Interval` == input$OverallMedian1) %>%
      mutate(Date = as.Date(Date)) %>%
      ggplot(aes(x = Date, 
                 y = input_var))+
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
    # }
  })
  
  ## Plot 2
  output$OverallTrendsPlot2 <- renderPlot({
    dfAll_otp2 <- dfBaseData[, c("Time Interval", "Date", input$OverallVariable2)]
    colnames(dfAll_otp2) <- c("Time Interval", "Date", "input_var")
    
    dfAll_otp2 %>%
      filter(between(Date,input$OverallDateRange[1], input$OverallDateRange[2])) %>%
      filter(`Time Interval` == input$OverallMedian2) %>%
      mutate(Date = as.Date(Date)) %>%
      ggplot(aes(x = Date, 
                 y = input_var))+
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
  
  ## Plot 3
  output$OverallTrendsPlot3 <- renderPlot({
    dfAll_otp3 <- dfBaseData[, c("Time Interval", "Date", input$OverallVariable3)]
    colnames(dfAll_otp3) <- c("Time Interval", "Date", "input_var")
    
    dfAll_otp3 %>%
      filter(between(Date,input$OverallDateRange[1], input$OverallDateRange[2])) %>%
      filter(`Time Interval` == input$OverallMedian3) %>%
      mutate(Date = as.Date(Date)) %>%
      ggplot(aes(x = Date, 
                 y = input_var))+
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
  
  ## Plot 4
  output$OverallTrendsPlot4 <- renderPlot({
    dfAll_otp4 <- dfBaseData[, c("Time Interval", "Date", input$OverallVariable4)]
    colnames(dfAll_otp4) <- c("Time Interval", "Date", "input_var")
    
    dfAll_otp4 %>%
      filter(between(Date,input$OverallDateRange[1], input$OverallDateRange[2])) %>%
      filter(`Time Interval` == input$OverallMedian4) %>%
      mutate(Date = as.Date(Date)) %>%
      ggplot(aes(x = Date, 
                 y = input_var))+
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
  
  
}


# Run App -----
shinyApp(ui = ui, server = server)
