shinyUI(fluidPage(
  titlePanel("Simulated Sampling Distribution"),
  
  sidebarLayout(
    sidebarPanel(helpText("Simulate the sampling distribution of the minimum or maximum value of the samples."),
                 radioButtons("minOrMax", label = h4("Minimum or Maximum?"),
                              choices = list("Minimum" = 1, "Maximum" = 2), selected = 1),
                 numericInput("sampleSize",
                              label = h4("Sample Size"),
                              value = 10),
                 numericInput("numSamples",
                              label = h4("Number of Samples"),
                              value = 1),
                 submitButton("Draw Samples")),
    mainPanel(
      h3(textOutput("Plots"))))
))