# Developing Data PRoducts - Week 4 assignment

library(shiny)
shinyServer(function(input, output) {
    output$plot1 <- renderPlot({
      sex <- c("Male", "Female")
      if(input$variable == "Male"){
        mosaicplot(HairEyeColor[,,1], xlab = "Hair", ylab = "Eye", main = "Male", shade = FALSE, color = TRUE)
      }
      if(input$variable == "Female"){
        mosaicplot(HairEyeColor[,,2], xlab = "Hair", ylab = "Eye", main = "Female", shade = FALSE, color = TRUE)
      }
      mtext(expression(bold("")), outer = TRUE, cex = 1.5)
    })
})

