source("helpers.R")
library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  # Choose the selected column from the diamonds data
  selectedData <- reactive({
    diamonds[, input$var]
  })
  
  stat <- reactive({
    if(input$statistic == 'Minimum') {
      df.stats(selectedData(), input$sampleSize, input$numSamples)$stat.min
    } else if(input$statistic == 'Maximum') {
      df.stats(selectedData(), input$sampleSize, input$numSamples)$stat.max
    } else if (input$statistic == 'Mean') {
      df.stats(selectedData(), input$sampleSize, input$numSamples)$stat.mean
    } else if(input$statistic == 'Median') {
      df.stats(selectedData(), input$sampleSize, input$numSamples)$stat.median
    }
  })
  
  # Draw the population histogram and summary statistics
  output$popHistogram <- renderPlot({
    hist(selectedData(), xlab = input$var,
         main = paste("Histogram of", input$var))
  })
  output$popSummary <- renderPrint({
    summary(selectedData(), digits = 3)[c(1,6)]
  })
  
  # Draw the sample histogram and summary statistics
  output$sampleHistogram <- renderPlot({
    hist(stat(), xlab = input$var,
         main = paste("Histogram of", input$var, input$statistic))
  })
  output$sampleSummary <- renderPrint({
    summary(stat())
  })
  
  output$ggTest <- renderPlot({
    df <- data.frame(stat())
    names(df) <- c("stat")
    cat(str(df))
    ggplot(df, aes(x = stat)) + geom_histogram() +
      labs(title = paste("Histogram of", input$var, input$statistic),
           x = input$var)
  })
})