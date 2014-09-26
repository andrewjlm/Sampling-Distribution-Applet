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
    df <- data.frame(selectedData())
    names(df) <- c("pop")
    ggplot(df, aes(x = pop)) + geom_histogram() +
      labs(title = paste("Histogram of", input$var),
           x = input$var) +
      geom_vline(aes(xintercept = mean(pop)), color="red")
  })
  output$popSummary <- renderText({
    paste("Min:", min(selectedData()), "  ",
          "Mean:", mean(selectedData()), "  ",
          "Median:", median(selectedData()), "  ",
          "Max:", max(selectedData()))
  })
  
  # Draw the sample histogram and summary statistics
  output$sampleHistogram <- renderPlot({
    df <- data.frame(stat())
    names(df) <- c("stat")
    ggplot(df, aes(x = stat)) + geom_histogram() +
      labs(title = paste("Histogram of", input$var, input$statistic),
           x = input$var) +
      geom_vline(aes(xintercept = mean(stat)), color="red")
  })
  output$sampleSummary <- renderText({
    paste("Mean:", mean(stat()), "  ",
          "SD:", format(sd(stat()), digits = 3))
  })
  
  #output$ggTest <- renderPlot({
  #  df <- data.frame(selectedData())
  #  names(df) <- c("pop")
  #  ggplot(df, aes(x = pop)) + geom_histogram() +
  #    labs(title = paste("Histogram of", input$var))
  #})
})