Developing Data Products: Course Project
========================================================
author: Ambiance-r
date: 23 December 2019
autosize: true

Introduction
========================================================

In the first part of the Course Project, a Shiny application was created and deployed on Rstudio's servers. The application can be found here: https://ambiance-r.shinyapps.io/FirstShinyApp/

The second part of the project is this reproducible pitch presentation about the application.

The relevant source codes for ui.R and server.R files are available on GitHub: https://github.com/ambiance-r/datasciencecoursera/tree/master/DevelopingDataProducts/week4assignment

Data
========================================================

The application uses the HairEyeColor dataset available in the R datasets package. It has the hair  (Black, Brown, Red, Blond) and eye (Brown, Blue, Hazel, Green) colors of 592 statistics students. The data comes from a survey of students at the University of Delaware (Snee (1974)). The split by Sex was added by Friendly (1992a).


```r
apply(HairEyeColor, c(1, 2), sum)
```

```
       Eye
Hair    Brown Blue Hazel Green
  Black    68   20    15     5
  Brown   119   84    54    29
  Red      26   17    14    14
  Blond     7   94    10    16
```

ui.R
========================================================


```r
library(shiny)
shinyUI(fluidPage(
    titlePanel("Hair and Eye Color of Statistics Students"),
    sidebarLayout(
        sidebarPanel(
            selectInput("variable", "Select Sex:", c("Male", "Female"))
        ),
        mainPanel(
            plotOutput("plot1")
        )
    )
))
```

server.R
========================================================


```r
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
```
