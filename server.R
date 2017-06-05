library(shinydashboard)
library(mclust)
library(reshape2)
library(shiny)

server <- function(input, output) {
  
  # Create a spot where we can store additional
  # reactive values for this session
  val <- reactiveValues(x=NULL, y=NULL)    
  
  # Listen for clicks
  observe({
    # Initially will be empty
    if (is.null(input$clusterClick)){
      return()
    }
    
    isolate({
      val$x <- c(val$x, input$clusterClick$x)
      val$y <- c(val$y, input$clusterClick$y)
    })
  })
  
  # Count the number of points
  
  # Clear the points on button click
  observe({
    if (input$clear > 0){
      val$x <- NULL
      val$y <- NULL
      
    }
  })
  
  # Generate the plot of the clustered points
  output$clusterPlot <- renderPlot({
    
    tryCatch({
      # Format the data as a matrix
      data1 <- data.frame(c(val$x, val$y), ncol=2)
      
      # Try to cluster       
      if (length(val$x) <= 1){
        stop("We can't cluster less than 2 points")
      } 
      suppressWarnings({
        fit <- Mclust(data)
      })
      
      mclust2Dplot(data = data1, what = "classification", 
                   classification = fit$classification, main = FALSE,
                   xlim=c(-2,2), ylim=c(-2,2),cex=input$opt.cex, cex.lab=input$opt.cexaxis)
    }, error=function(warn){
      # Otherwise just plot the points and instructions
      plot(val$x, val$y, xlim=c(input$min, input$max), ylim=c(-2, 2), xlab="X", ylab="Y",
           cex=input$opt.cex, cex.lab=input$opt.cexaxis)
      
      
      if (input$line > 0 & length(val$x) >= 3 ){
        
        abline(lm(val$y ~ val$x, data = data1,na.action = na.exclude))
        
      }
      
      
      
    })
  })
}
