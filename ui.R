library(shiny)
library(dplyr)
library(ggplot2)

shinyUI(fluidPage(
  titlePanel("Simulated Sampling Distribution"),
  
  sidebarLayout(
    sidebarPanel(helpText("Simulate the sampling distribution of the minimum or maximum value of the samples."),
                 selectInput('var', 'Variable to Sample', names(select(diamonds, carat, price))),
                 selectInput('statistic', label = h4("Statistic?"),
                              choices =
                               list("Mean", "Median", "Minimum", "Maximum")),
                 numericInput("sampleSize",
                              label = h4("Sample Size"),
                              value = 10),
                 numericInput("numSamples",
                              label = h4("Number of Samples"),
                              value = 5),
                 submitButton("Draw Samples")),
    mainPanel(
      tabsetPanel(
        tabPanel("Population", plotOutput("popHistogram",
                                          width=400, height=300),
                 verbatimTextOutput("popSummary")),
        #tabPanel("Latest Sample"),
        tabPanel("Sampling Distribution",
                 plotOutput("sampleHistogram", width=400,
                            height = 300),
                 verbatimTextOutput("sampleSummary")))
      ))
))