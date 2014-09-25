shinyUI(fluidPage(
  titlePanel("Simulated Sampling Distribution"),
  
  sidebarLayout(
    sidebarPanel(helpText("Simulate the sampling distribution of the minimum or maximum value of the samples."),
                 selectInput('var', 'Variable to Sample', names(dataset)),
                 radioButtons('minOrMax', label = h4("Minimum or Maximum?"),
                              choices = list("Minimum" = 1, "Maximum" = 2), selected = 1),
                 numericInput("sampleSize",
                              label = h4("Sample Size"),
                              value = 10),
                 numericInput("numSamples",
                              label = h4("Number of Samples"),
                              value = 1),
                 submitButton("Draw Samples")),
    mainPanel(
      tabsetPanel(
        tabPanel("Population", plotOutput("popHistogram",
                                          width=400, height=300),
                 verbatimTextOutput("popSummary")),
        #tabPanel("Latest Sample"),
        tabPanel("Sampling Distribution",
                 plotOutput("sampleHistogram", width=400,
                            height = 300)))
      ))
))