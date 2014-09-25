source("helpers.R")
library(ggplot2)
library(dplyr)
dataset <- select(diamonds, carat, price)

shinyServer(function(input, output) {
  # Choose the selected column from the diamonds data
  selectedData <- reactive({
    diamonds[, input$var]
  })
  
  # Get the full sample
  fullSample <- reactive({
    b.stat(diamonds[, input$var],
                  input$sampleSize,
                  input$numSamples, input$minOrMax)
  })
  
  # Draw the population histogram and summary statistics
  output$popHistogram <- renderPlot({
    hist(selectedData(), xlab = input$var,
         main = paste("Histogram of", input$var))
  })
  output$popSummary <- renderPrint({
    summary(selectedData(), digits = 3)[c(1,6)]
  })
  
  #output$sampleHistogram <- renderTable({
  #  head(fullSample())
  #})
  
  # Draw the sample histogram and summary statistics
  output$sampleHistogram <- renderPlot({
    hist(fullSample())
  })
})