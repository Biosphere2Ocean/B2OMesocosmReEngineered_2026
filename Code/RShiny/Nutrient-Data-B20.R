#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#-----------------------
# load libraries
library(shiny)
library(shinythemes)
library(tidyverse)

#-----------------------
# load data
## download B20NutrientData excel file from the Box as a csv and import it into R with your own filepath in "" below 
HachNutrientData <- read_csv("/Users/grambihler/Documents/data/nutrient-data/B2ONutrientData.csv")

#-----------------------
# data wrangling
## get rid of (...##) at end of column names
for (col in 1:ncol(HachNutrientData)){
  colnames(HachNutrientData)[col] <-  gsub("\\.*[0123456789]", "", colnames(HachNutrientData)[col])
}

## separating large dataframe into separate ones for each testing location (Ocean, Mangrove, etc) in order to add a Location column 
OceanFrame <- HachNutrientData[, 1:10] %>%
  mutate(Location = "Ocean")

MangroveFrame <- HachNutrientData[, c(1, 11:16)] %>%
  mutate(Location = "Mangrove",
         Alkalinity = NA, 
         Silica = NA, 
         Iron = NA)

RacewayFrame1 <- HachNutrientData[, c(1, 17:25)] %>%
  mutate(Location = "Raceway 1")

RacewayFrame2 <- HachNutrientData[, c(1, 26:33)] %>%
  mutate(Location = "Raceway 2",
         ORP = NA)

## combine the rows to get longer format data
HachNutrientData <- rbind(OceanFrame, MangroveFrame, RacewayFrame1, RacewayFrame2)

## pivot data to get actual long format dataframe
HachNutrientDataPivot <- HachNutrientData %>%
  pivot_longer(cols = Turbidity:ORP,
               names_to = "Nutrients", 
               values_to = "Nutrient Values") %>%
  drop_na()

## change Nutrient Values column to numeric from character
HachNutrientDataPivot$`Nutrient Values` <- as.numeric(HachNutrientDataPivot$`Nutrient Values`)

## change Date column to Date from character
HachNutrientDataPivot$Date <- as.Date(HachNutrientDataPivot$Date, format = "%m/%d/%y")


#-----------------------
# Define UI for application 
ui <- fluidPage(
  theme = shinytheme("flatly"),
    # Application title
    titlePanel("B2O Nutrients Dashboard"),
    # Sidebar with a select input and date input 
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "type",
                      )
          
          dateRangeInput(inputId = "date",
                         label = "Date Range",
                         start = "2017-12-01")
          
          sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
