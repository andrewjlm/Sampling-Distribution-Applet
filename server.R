source("helpers.R")
library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  # Choose the selected column from the diamonds data
  selectedData <- reactive({
    diamonds[, input$var]
  })
  
  # Get the full sample
  fullSample <- reactive({
    min <- b.min(selectedData(),
                 input$sampleSize,
                 input$numSamples)
    max <- b.max(selectedData(),
                 input$sampleSize,
                 input$numSamples)
    data <- if(input$minOrMax == "1") {
      min }
    else {
      max }
    data
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
    hist(fullSample()$stats, xlab = input$var,
         main = paste("Histogram of", input$var,
                      ifelse(input$minOrMax == "1", "Minimum",
                             "Maximum")))
  })
  output$sampleSummary <- renderPrint({
    summary(fullSample()$stats)
  })
})