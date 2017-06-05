library(shinydashboard)

dashboardPage(
  dashboardHeader(title="Week 2 "),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Regression Line", tabName = "dashboard", icon = icon("dashboard"))
      
    )
  ),
  dashboardBody(
    fluidPage(
      
      # Add a title
      titlePanel("Mean & Median"),
      numericInput("max", "Input Maximum number", 2),
      numericInput("min", "Input Minimum number", -2), 
      sliderInput(inputId = "opt.cex", label = "Point Size (cex)",                            
                  min = 0, max = 5, step = 0.25, value = 2),
      
      
      # Add a row for the main content
      fluidRow(
        
        # Create a space for the plot output
        plotOutput(
          "clusterPlot", "100%", "500px", click="clusterClick"
        )
      ),
      
      # Create a row for additional information
      fluidRow(
        # Take up 2/3 of the width with this element  
        sidebarPanel(actionButton("line", "Regression Line")),
        
        
        # And the remaining 1/3 with this one
        sidebarPanel(actionButton("clear", "Clear Points"))
      )    
    )
    
  )
)
