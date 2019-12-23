# Developing Data PRoducts - Week 4 assignment

library(shiny)
shinyUI(fluidPage(
    titlePanel("Hair and Eye Color of Statistics Students"),
    sidebarLayout(
        sidebarPanel(
            selectInput("variable", "Select Sex:", c("Male", "Female"))
        ),
        mainPanel(
            p("This", a(href="http://shiny.rstudio.com/", "Shiny"),
              "application shows you the distribution of hair and eye color of 
              the statistics students at the University of Delaware. You are asked to
              choose the sex type and the graph will show you the distribution for
              that particular sex."),
            p("The data is available from the datasets R package.",
              "The source code ui.R and server.R for the application are available on",
              a(href="https://github.com/ambiance-r/datasciencecoursera/tree/master/DevelopingDataProducts/week4assignment", "GitHub"), "."),
            plotOutput("plot1")
        )
    )
))
                                                                                  