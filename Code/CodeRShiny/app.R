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
dfRaw <- read_csv(file = "Data/OceanWaterQualityFrame.csv")
dfClean <- read_csv(file = "Data/QCOceanWaterQualityFrame.csv")

# Define variables -----
#  character vector of variable choices. modified from column names of datasets 
var_choices <- c("None",
                 "Temperature (ºF)",
                 "Temperature (ºC)",
                 "pH",
                 "pH (mV)",
                 "Salinity (PSU)",
                 "Conductivity µS/cm",
                 "NLF Conductivity (µS/cm)",
                 "Specific Conductivity (µS/cm)",
                 "Dissolved Oxygen (mg/L)",
                 "Dissolved Oxygen, Saturated (%)",
                 "Dissolved Oxygen, Local (%)",
                 "ORP (mV)",
                 "Chlorophyll (RFU)", 
                 "Chlorophyll (µg/L)",
                 "Total Algae (RFU)",
                 "Total Algae (cells/L)",
                 "Total Dissolved Solids (mg/L)")

# User Interface -----
ui <- navbarPage("Biosphere 2 Ocean Systems Water Quality",
                 theme = bs_theme(bootswatch = "minty"),
                 # tabPanel("Data QC: Before and After",
                 #          fluidRow(
                 #            column(12,
                 #                   wellPanel(
                 #                     h1("All-Variable Comparison"),
                 #                     dateRangeInput("dateRange", 
                 #                                    label = "Select Date Range",
                 #                                    start = dfRaw$date[1],
                 #                                    end = tail(dfRaw$date, n=1),
                 #                                    min = dfRaw$date[1],
                 #                                    max = tail(dfRaw$date, n=1))))
                 #          ),
                 #          fluidRow(
                 #            column(6,
                 #                   wellPanel(
                 #                     plotOutput("rawallvariablePlot",
                 #                                height = "1400"))),
                 #            column(6, 
                 #                   wellPanel(
                 #                     plotOutput("cleanallvariablePlot",
                 #                              height = "1400px")))
                 #          )
                 # ),
                          
                 tabPanel("QC Variable Comparisons",
                          fluidRow(
                            # skinnier column with date range input and inputs for 4 plots
                            column(2, wellPanel(
                              dateRangeInput("dateRange", 
                                             label = "Select Date Range",
                                             start = dfRaw$date[1],
                                             end = tail(dfRaw$date, n=1),
                                             min = dfRaw$date[1],
                                             max = tail(dfRaw$date, n=1)),
                              hr(),
                              radioButtons("dataset1", label = "Select Dataset", choices = c("Raw Data", "Clean Data")),
                              selectInput("variable1", 
                                          label = "Select Variable to Plot", 
                                          choices = var_choices,
                                          selected = "Temperature (ºF)"),
                              hr(),
                              radioButtons("dataset2", label = "Select Dataset", choices = c("Raw Data", "Clean Data")),
                              selectInput("variable2", 
                                          label = "Select Variable to Plot", 
                                          choices = var_choices),
                              hr(),
                              radioButtons("dataset3", label = "Select Dataset", choices = c("Raw Data", "Clean Data")),
                              selectInput("variable3", 
                                          label = "Select Variable to Plot", 
                                          choices = var_choices),
                              hr(),
                              radioButtons("dataset4", label = "Select Dataset", choices = c("Raw Data", "Clean Data")),
                              selectInput("variable4", 
                                          label = "Select Variable to Plot", 
                                          choices = var_choices)
                                   )
                              ),
                            column(5,
                                   conditionalPanel("input.variable1 != None",
                                     plotOutput("plot1", height = "600px")),
                                   conditionalPanel("input.variable2 != None",
                                     plotOutput("plot2", height = "600px"))
                                   ),
                            column(5,
                                   conditionalPanel("input.variable3 != None",
                                     plotOutput("plot3", height = "600px")),
                                   conditionalPanel("input.variable4 != None",
                                     plotOutput("plot4", height = "600px"))
                                   )
                          )
                   
                 )
)

# Server Logic -----
server <- function(input, output) {
  # tab 1
  ## raw data all variable plot
  # output$rawallvariablePlot <- renderPlot({
  #   
  #   data <- dfRaw
  #   # change column names of data to input variable options (ie: temp_f becomes Temperature (ºF))
  #   colnames(data)[3:19] <- var_choices[2:18]
  #   
  #   # make data long format
  #   dataPivot <- data %>%
  #     pivot_longer(cols = `Temperature (ºF)`:`Total Dissolved Solids (mg/L)`,
  #                  names_to = "variable",
  #                  values_to = "variable_value") %>%
  #     mutate(date = as.Date(date, format = "%Y/%m/%d"))
  #   
  #   # line graph of every variable - facet wrapped 
  #   dataPivot %>%
  #     ggplot(aes(x = date, 
  #                y = variable_value)) +
  #     geom_line() +
  #     facet_wrap(~variable, ncol = 3, scales = "free")+
  #     scale_x_date(breaks = waiver(), date_breaks = "1 year", date_labels = "%b %Y") +
  #     theme_bw() + 
  #     theme(panel.grid.major = element_blank(), 
  #           panel.grid.minor = element_blank(), 
  #           panel.background = element_blank(), 
  #           axis.line = element_line(colour = "black"))+
  #     theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  #     theme(strip.background = element_rect(fill = "white"))+
  #     theme(axis.text = element_text(size = 18),
  #           axis.title = element_text(size = 25), 
  #           plot.title = element_text(size = 35),
  #           strip.text.x = element_text(size = 20))+
  #     labs(title = "Pre-QC: All Outliers Still Present")+
  #     xlab("Date")+
  #     ylab("Variable Value")
  # })
  # 
  # ## clean data all variable plot
  # output$cleanallvariablePlot <- renderPlot({
  #   data <- dfClean
  #   # change column names of data to input variable options (ie: temp_f becomes Temperature (ºF))
  #   colnames(data)[3:19] <- var_choices[2:18]
  #   
  #   # make data long format
  #   dataPivot <- data %>%
  #     pivot_longer(cols = `Temperature (ºF)`:`Total Dissolved Solids (mg/L)`,
  #                  names_to = "variable",
  #                  values_to = "variable_value") %>%
  #     mutate(date = as.Date(date, format = "%Y/%m/%d"))
  #   
  #   # line graph of every variable - facet wrapped 
  #   dataPivot %>%
  #     ggplot(aes(x = date, 
  #                y = variable_value)) +
  #     geom_line() +
  #     facet_wrap(~variable, ncol = 3, scales = "free")+
  #     scale_x_date(breaks = waiver(), date_breaks = "1 year", date_labels = "%b %Y") +
  #     theme_bw() + 
  #     theme(panel.grid.major = element_blank(), 
  #           panel.grid.minor = element_blank(), 
  #           panel.background = element_blank(), 
  #           axis.line = element_line(colour = "black"))+
  #     theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  #     theme(strip.background = element_rect(fill = "white"))+
  #     theme(axis.text = element_text(size = 18),
  #           axis.title = element_text(size = 25), 
  #           plot.title = element_text(size = 35),
  #           strip.text.x = element_text(size = 20))+
  #     labs(title = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  #     xlab("Date")+
  #     ylab("Variable Value")
  # })

  
  
  # tab 2
  # create reactive variable to hold dataset choice
  # df_choice <- reactive({
  #   req(input$dataset1)
  #   if (input$dataset1 == "Raw Data") {
  #     #use raw data csv
  #     data <- dfRaw
  #     subt <- "Pre-QC: All Outliers Still Present"
  #   } else if (input$dataset1 == "Clean Data") {
  #     # use qc'd data csv
  #     data <- dfClean
  #     subt <- "Post-QC: Data Outside 2-Sigma from Mean has been Removed"
  #   }
  # })
  
  ## plot 1
  output$plot1 <- renderPlot({
    # check which dataset is being viewed
    if (input$dataset1 == "Raw Data") {
      # use raw data csv
      data <- dfRaw
      subt <- "Pre-QC: All Outliers Still Present"
    } else if (input$dataset1 == "Clean Data") {
      # use qc'd data csv
      data <- dfClean
      subt <- "Post-QC: Data Outside 2-Sigma from Mean has been Removed"
    }
    
    if (input$variable1 == "None") {
      x <- 1
    } else {
      colnames(data)[3:19] <- var_choices[2:18]
      data <- data[, c("date", input$variable1)]
      colnames(data) <- c("date", "input_var")
      
      # line graph of input variable
      data %>%
        filter(date >= input$dateRange[1] & date <= input$dateRange[2]) %>%
        ggplot(aes(x = date,
                   y = input_var)) +
        geom_line()+
        scale_x_date(breaks = waiver(), date_breaks = "6 months", date_labels = "%b %Y") +
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank(),
              axis.line = element_line(colour = "black"))+
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
        theme(strip.background = element_rect(fill = "white"))+
        theme(axis.text = element_text(size = 20),
              axis.title = element_text(size = 25),
              plot.title = element_text(size = 35),
              plot.subtitle = element_text(size = 30),
              strip.text.x = element_text(size = 25))+
        labs(title = paste("Biosphere 2 Ocean", input$variable1),
             subtitle = subt)+
        xlab("Date")+
        ylab(input$variable1)
    }
  })
  
  ## plot 2
  output$plot2 <- renderPlot({
    # check which dataset is being viewed
    if (input$dataset2 == "Raw Data") {
      # use raw data csv
      data <- dfRaw
      subt <- "Pre-QC: All Outliers Still Present"
    } else if (input$dataset2 == "Clean Data") {
      # use qc'd data csv
      data <- dfClean
      subt <- "Post-QC: Data Outside 2-Sigma from Mean has been Removed"
    }
    
    if (input$variable2 == "None") {
      x <- 1
    } else {
      colnames(data)[3:19] <- var_choices[2:18]
      data <- data[, c("date", input$variable2)]
      colnames(data) <- c("date", "input_var")
      
      # line graph of input variable
      data %>%
        filter(date >= input$dateRange[1] & date <= input$dateRange[2]) %>%
        ggplot(aes(x = date,
                   y = input_var)) +
        geom_line()+
        scale_x_date(breaks = waiver(), date_breaks = "6 months", date_labels = "%b %Y") +
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank(),
              axis.line = element_line(colour = "black"))+
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
        theme(strip.background = element_rect(fill = "white"))+
        theme(axis.text = element_text(size = 20),
              axis.title = element_text(size = 25),
              plot.title = element_text(size = 35),
              plot.subtitle = element_text(size = 30),
              strip.text.x = element_text(size = 25))+
        labs(title = paste("Biosphere 2 Ocean", input$variable2),
             subtitle = subt)+
        xlab("Date")+
        ylab(input$variable2)
    }
  })
  
  # plot 3
  output$plot3 <- renderPlot({
    # check which dataset is being viewed
    if (input$dataset3 == "Raw Data") {
      # use raw data csv
      data <- dfRaw
      subt <- "Pre-QC: All Outliers Still Present"
    } else if (input$dataset3 == "Clean Data") {
      # use qc'd data csv
      data <- dfClean
      subt <- "Post-QC: Data Outside 2-Sigma from Mean has been Removed"
    }
    
    if (input$variable3 == "None") {
      x <- 1
    } else {
      colnames(data)[3:19] <- var_choices[2:18]
      data <- data[, c("date", input$variable3)]
      colnames(data) <- c("date", "input_var")
      
      # line graph of input variable
      data %>%
        filter(date >= input$dateRange[1] & date <= input$dateRange[2]) %>%
        ggplot(aes(x = date,
                   y = input_var)) +
        geom_line()+
        scale_x_date(breaks = waiver(), date_breaks = "6 months", date_labels = "%b %Y") +
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank(),
              axis.line = element_line(colour = "black"))+
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
        theme(strip.background = element_rect(fill = "white"))+
        theme(axis.text = element_text(size = 20),
              axis.title = element_text(size = 25),
              plot.title = element_text(size = 35),
              plot.subtitle = element_text(size = 30),
              strip.text.x = element_text(size = 25))+
        labs(title = paste("Biosphere 2 Ocean", input$variable3),
             subtitle = subt)+
        xlab("Date")+
        ylab(input$variable3)
    }
  })
  
  # plot 4
  output$plot4 <- renderPlot({
    # check which dataset is being viewed
    if (input$dataset4 == "Raw Data") {
      # use raw data csv
      data <- dfRaw
      subt <- "Pre-QC: All Outliers Still Present"
    } else if (input$dataset4 == "Clean Data") {
      # use qc'd data csv
      data <- dfClean
      subt <- "Post-QC: Data Outside 2-Sigma from Mean has been Removed"
    }
    
    if (input$variable4 == "None") {
      x <- 1
    } else {
      colnames(data)[3:19] <- var_choices[2:18]
      data <- data[, c("date", input$variable4)]
      colnames(data) <- c("date", "input_var")
      
      # line graph of input variable
      data %>%
        filter(date >= input$dateRange[1] & date <= input$dateRange[2]) %>%
        ggplot(aes(x = date,
                   y = input_var)) +
        geom_line()+
        scale_x_date(breaks = waiver(), date_breaks = "6 months", date_labels = "%b %Y") +
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              panel.background = element_blank(),
              axis.line = element_line(colour = "black"))+
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
        theme(strip.background = element_rect(fill = "white"))+
        theme(axis.text = element_text(size = 20),
              axis.title = element_text(size = 25),
              plot.title = element_text(size = 35),
              plot.subtitle = element_text(size = 30),
              strip.text.x = element_text(size = 25))+
        labs(title = paste("Biosphere 2 Ocean", input$variable4),
             subtitle = subt)+
        xlab("Date")+
        ylab(input$variable4)
    }
  })
}


# Run App -----
shinyApp(ui = ui, server = server)
