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
# all Hach and YSI data: combo of all above files with "Time Interval" column to 
# denote which interval (daily, weekly, etc) the data comes from
dfAll <- read_csv("SourceData/05-HachYSI-Data-All.csv", col_names = TRUE) %>%
  rename(pH = `pH (YSI)`)

# Define variables -----
# character vector of all day dates in YSI data
date_range <- dfAll %>%
  filter(`Time Interval` == "Daily") %>%
  select(Date)

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
                          
                          # CHECK BOX GROUP MIGHT FIX UI ISSUE?
                          
                          dateRangeInput(inputId = "OverallDateRange", 
                                         label = "Select Date Range",
                                         start = date_range$Date[1],
                                         end = tail(date_range$Date, n=1),
                                         min = date_range$Date[1],
                                         max = tail(date_range$Date, n=1)),
                          hr(),
                          # plot 1 input
                          p(h4("Top Left Plot")),
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
                                        value = FALSE),
                          hr(),
                          # plot 2 input
                          p(h4("Top Right Plot")),
                          selectInput(inputId = "OverallVariable2", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "Salinity (PSU)"),
                          selectInput(inputId = "OverallMedian2",
                                      label = "Select Median Interval",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck2",
                                        label = "Add Loess Curve",
                                        value = FALSE),
                          hr(),
                          # plot 3 input
                          p(h4("Bottom Left Plot")),
                          selectInput(inputId = "OverallVariable3", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "pH"),
                          selectInput(inputId = "OverallMedian3",
                                      label = "Select Median Interval",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck3",
                                        label = "Add Loess Curve",
                                        value = FALSE),
                          hr(),
                          # plot 4 input
                          p(h4("Bottom Right Plot")),
                          selectInput(inputId = "OverallVariable4", 
                                      label = "Select Variable to Plot", 
                                      choices = var_choices,
                                      selected = "Nitrate, Mid-Range (mg/L)"),
                          selectInput(inputId = "OverallMedian4",
                                      label = "Select Median Interval",
                                      choices = median_period_choices,
                                      selected = "Daily"),
                          checkboxInput(inputId = "OverallLoessCheck4",
                                        label = "Add Loess Curve",
                                        value = FALSE)
                        ),
                        mainPanel(
                          # textOutput("helpText"),
                          #works. will use for now
                          column(6,
                                 conditionalPanel(
                                   "input.OverallVariable1 != None",
                                   plotOutput("OverallTrendsPlot1")),
                                 conditionalPanel(
                                   "input.OverallVariable2 != None",
                                   plotOutput("OverallTrendsPlot3"))
                          ),
                          column(6,
                                 conditionalPanel(
                                   "input.OverallVariable3 != None",
                                   plotOutput("OverallTrendsPlot2")),
                                 conditionalPanel(
                                   "input.OverallVariable4 != None",
                                   plotOutput("OverallTrendsPlot4"))
                          )
                          
                          #works
                          # fluidRow(
                          #   conditionalPanel("input.OverallVariable1 != None",
                          #                    plotOutput("OverallTrendsPlot1")),
                          #   conditionalPanel("input.OverallVariable2 != None",
                          #                    plotOutput("OverallTrendsPlot2"))
                          # )
                          
                          #does not work
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
                          
                          #Does not work
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
  # output$helpText <- renderText({
  #   paste(input$OverallDateRange[1], input$OverallDateRange[2])
  #   paste(class(input$OverallDateRange[1]), class(input$OverallDateRange[2]))
  # })
  
  output$OverallTrendsPlot1 <- renderPlot({
  ## Plot 1
    # scale_x_date() options
    # default 
    datebreaks <- "1 year"
    datelabels <- "%Y"
    
    if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
      datebreaks <- "2 weeks"
      datelabels <- "%b %d %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
      datebreaks <- "1 month"
      datelabels <- "%b %Y"
    } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
      datebreaks <- "4 months"
      datelabels <- "%b %Y"
    } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
      datebreaks <- "6 months"
      datelabels <- "%b %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
      datebreaks <- "1 year"
      datelabels <- "%Y"
    }
    
    # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
    dfAll_otp1 <- dfAll[, c("Time Interval", "Date", input$OverallVariable1)]
    colnames(dfAll_otp1) <- c("Time Interval", "Date", "input_var")
    
    otp1 <- ggplot(data = dfAll_otp1[dfAll_otp1$`Time Interval` == "Daily" & dfAll_otp1$Date >= input$OverallDateRange[1] & dfAll_otp1$Date <= input$OverallDateRange[2], ],
                   aes(x = Date, 
                       y = input_var))+
      geom_point(color = "lightgray",
                alpha = 0.4,
                size = 6) +
      geom_line(data = dfAll_otp1[dfAll_otp1$`Time Interval` == input$OverallMedian1 & dfAll_otp1$Date >= input$OverallDateRange[1] & dfAll_otp1$Date <= input$OverallDateRange[2] & !is.na(dfAll_otp1$input_var), ],
                aes(x = Date,
                    y = input_var), 
                size = 0.75) +
      scale_x_date(date_breaks = datebreaks,
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
      otp1 <- otp1 + geom_smooth(data = dfAll_otp1[dfAll_otp1$`Time Interval` == input$OverallMedian1 & dfAll_otp1$Date >= input$OverallDateRange[1] & dfAll_otp1$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
      otp1
    } else {
      otp1
    }
    
  })
  
  ## Plot 2
  output$OverallTrendsPlot2 <- renderPlot({
    # scale_x_date() options
    # default 
    datebreaks <- "1 year"
    datelabels <- "%Y"
    
    if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
      datebreaks <- "2 weeks"
      datelabels <- "%b %d %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
      datebreaks <- "1 month"
      datelabels <- "%b %Y"
    } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
      datebreaks <- "4 months"
      datelabels <- "%b %Y"
    } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
      datebreaks <- "6 months"
      datelabels <- "%b %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
      datebreaks <- "1 year"
      datelabels <- "%Y"
    }
    
    # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
    dfAll_otp2 <- dfAll[, c("Time Interval", "Date", input$OverallVariable2)]
    colnames(dfAll_otp2) <- c("Time Interval", "Date", "input_var")
    
    otp2 <- ggplot(data = dfAll_otp2[dfAll_otp2$`Time Interval` == "Daily" & dfAll_otp2$Date >= input$OverallDateRange[1] & dfAll_otp2$Date <= input$OverallDateRange[2], ],
                   aes(x = Date, 
                       y = input_var))+
      geom_point(color = "lightgray",
                 alpha = 0.4,
                 size = 6) +
      geom_line(data = dfAll_otp2[dfAll_otp2$`Time Interval` == input$OverallMedian2 & dfAll_otp2$Date >= input$OverallDateRange[1] & dfAll_otp2$Date <= input$OverallDateRange[2] & !is.na(dfAll_otp2$input_var), ],
                aes(x = Date,
                    y = input_var), 
                size = 0.75) +
      scale_x_date(date_breaks = datebreaks,
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
      otp2 <- otp2 + geom_smooth(data = dfAll_otp2[dfAll_otp2$`Time Interval` == input$OverallMedian2 & dfAll_otp2$Date >= input$OverallDateRange[1] & dfAll_otp2$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
      otp2
    } else {
      otp2
    }
  })
  
  ## Plot 3
  output$OverallTrendsPlot3 <- renderPlot({
    # scale_x_date() options
    # default 
    datebreaks <- "1 year"
    datelabels <- "%Y"
    
    if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
      datebreaks <- "2 weeks"
      datelabels <- "%b %d %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
      datebreaks <- "1 month"
      datelabels <- "%b %Y"
    } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
      datebreaks <- "4 months"
      datelabels <- "%b %Y"
    } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
      datebreaks <- "6 months"
      datelabels <- "%b %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
      datebreaks <- "1 year"
      datelabels <- "%Y"
    }
    
    # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
    dfAll_otp3 <- dfAll[, c("Time Interval", "Date", input$OverallVariable3)]
    colnames(dfAll_otp3) <- c("Time Interval", "Date", "input_var")
    
    otp3 <- ggplot(data = dfAll_otp3[dfAll_otp3$`Time Interval` == "Daily" & dfAll_otp3$Date >= input$OverallDateRange[1] & dfAll_otp3$Date <= input$OverallDateRange[2], ],
                   aes(x = Date, 
                       y = input_var))+
      geom_point(color = "lightgray",
                 alpha = 0.4,
                 size = 6) +
      geom_line(data = dfAll_otp3[dfAll_otp3$`Time Interval` == input$OverallMedian3 & dfAll_otp3$Date >= input$OverallDateRange[1] & dfAll_otp3$Date <= input$OverallDateRange[2]  & !is.na(dfAll_otp3$input_var), ],
                aes(x = Date,
                    y = input_var), 
                size = 0.75) +
      scale_x_date(date_breaks = datebreaks,
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
      otp3 <- otp3 + geom_smooth(data = dfAll_otp3[dfAll_otp3$`Time Interval` == input$OverallMedian3 & dfAll_otp3$Date >= input$OverallDateRange[1] & dfAll_otp3$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
      otp3
    } else {
      otp3
    }
  })
  
  ## Plot 4
  output$OverallTrendsPlot4 <- renderPlot({
    # scale_x_date() options
    # default 
    datebreaks <- "1 year"
    datelabels <- "%Y"
    
    if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 182) {
      datebreaks <- "2 weeks"
      datelabels <- "%b %d %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 365) {
      datebreaks <- "1 month"
      datelabels <- "%b %Y"
    } else if (365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 2*365) {
      datebreaks <- "4 months"
      datelabels <- "%b %Y"
    } else if (2*365 < as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) 
               & as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) <= 5*365) {
      datebreaks <- "6 months"
      datelabels <- "%b %Y"
    } else if (as.numeric(difftime(input$OverallDateRange[2], input$OverallDateRange[1])) > 5*365) {
      datebreaks <- "1 year"
      datelabels <- "%Y"
    }
    
    # use dfAll with daily median data to plot base plot; put input variable into format ggplot can read easily
    dfAll_otp4 <- dfAll[, c("Time Interval", "Date", input$OverallVariable4)]
    colnames(dfAll_otp4) <- c("Time Interval", "Date", "input_var")
    
    otp4 <- ggplot(data = dfAll_otp4[dfAll_otp4$`Time Interval` == "Daily" & dfAll_otp4$Date >= input$OverallDateRange[1] & dfAll_otp4$Date <= input$OverallDateRange[2], ],
                   aes(x = Date, 
                       y = input_var))+
      geom_point(color = "lightgray",
                 alpha = 0.4,
                 size = 6) +
      geom_line(data = dfAll_otp4[dfAll_otp4$`Time Interval` == input$OverallMedian4 & dfAll_otp4$Date >= input$OverallDateRange[1] & dfAll_otp4$Date <= input$OverallDateRange[2]& !is.na(dfAll_otp4$input_var), ],
                aes(x = Date,
                    y = input_var), 
                size = 0.75) +
      scale_x_date(date_breaks = datebreaks,
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
      otp4 <- otp4 + geom_smooth(data = dfAll_otp4[dfAll_otp4$`Time Interval` == input$OverallMedian4 & dfAll_otp4$Date >= input$OverallDateRange[1] & dfAll_otp4$Date <= input$OverallDateRange[2], ],
                                 aes(x = Date,
                                     y = input_var),
                                 linewidth = 3)
      otp4
    } else {
      otp4
    }
  })
  
  
}


# Run App -----
shinyApp(ui = ui, server = server)
