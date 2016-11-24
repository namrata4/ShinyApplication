
# This is the user-interface definition of a Shiny web application.
#Author: Namrata Deshpande


library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Housing Prices in Boston Suburbs"),
  fluidRow(
    column(4,
           wellPanel(
             h4("Filter the values"),
             sliderInput("medValue", "Median value of owner occupied homes(1000USD)",
                         min(boston_data$medv), max(boston_data$medv), 
                         value = c(min(boston_data$medv), max(boston_data$medv)  )),
             radioButtons("river", "Proximity to Charles River",
                          c("All" = 2,
                            "River Bounding" = 1, 
                            "Non-Bounding" = 0)
             )
           ),
           wellPanel(
             h4("Explore the Relationships: Linear Regression"),
             selectInput("yvar", "Response Variable", new_names, selected = "medv"),
             selectInput("xvar", "Predictor Variable", new_names, selected = "rm"),
             # selectInput("smooth", "Model to be fitted", smoothMethods, selected = "lm")
             tags$small(paste0(
               "References: Sniny Movie Explorer", 
               "(https://github.com/rstudio/shiny-examples/tree/master/051-movie-explorer)",
               " Diagnostics for simple linear regression",
               " (https://github.com/ShinyEd/ShinyEd/tree/master/slr_diag)"
             ))
           )
    ),
    column(8,
           plotOutput("plot1"),
           br(),
           
           plotOutput("plot2")
    )
  )
  
))
