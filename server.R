
# This is the server logic for a Shiny web application.
#Author: Namrata Deshpande

library(shiny)

shinyServer(function(input, output) {
  #filtering the data as per filters of median value and river bounding
  filteredData <- reactive({
    
    minValue <- as.numeric(input$medValue[1])
    maxValue <- as.numeric(input$medValue[2])
    riverVal <- as.numeric(input$river)
    
    
    df <- filter(boston_data, medv > minValue & medv < maxValue)
    
    if (riverVal != 2) {
      
      df <- df %>% filter(chas == riverVal)
    }
    
    return(df)
    
  })
  #getting selected response and predictor value
  xVariable <- reactive({input$xvar})
  yVariable <- reactive({input$yvar})
  # generating linear regression model
  lmFit <- reactive({
    x <- xVariable()
    y <- yVariable()
    return(lm(get(y) ~ get(x), data = filteredData()))
    
  })
  
  #Scatterplot with regression line
  output$plot1 <- renderPlot({
    xvar_name <- names(new_names)[new_names == input$xvar]
    yvar_name <- names(new_names)[new_names == input$yvar]
    rSquared <- round(summary(lmFit())$r.squared, 4)
    corrCoef <- round(sqrt(rSquared), 4)
    # attach(boston_data)
    ggplot(data = filteredData()) + 
      geom_point(mapping = aes(x = get(xVariable()), y =  get(yVariable()), 
                               colour = factor(chas)), size = 3) +
      geom_smooth(mapping = aes(x = get(xVariable()), y =  get(yVariable())),
                  method = "lm") + xlab(xvar_name) + ylab(yvar_name)  +
      ggtitle(paste0("Regression Model:  R = " ,corrCoef , " R-sqaured = " , rSquared))+ 
      guides(colour=guide_legend(title="River Bounding")) +
      theme(plot.title = element_text(size = 18, face = "bold"),
            axis.title = element_text(size = 11, face = "bold"))
    
  }, height = 350)
  
  #Residual Analysis for the fit
  output$plot2 <- renderPlot({
    
    par(mfrow=c(1,3), cex.main=2, cex.lab=2, cex.axis=2, mar=c(4,5,2,2))
    
    plot(x = lmFit()$fitted.values, y = lmFit()$residuals,
         col = "darkgreen",
         xlab = "Fitted values", ylab = "Residual values", main = "Residual Plot")
    lines(lowess(lmFit()$fitted.values, lmFit()$residuals), col='red', lwd=2)
    abline(h=0, lty=3)
    hist(lmFit()$residuals, xlab = "Residuals", col = "red",
         main = "Distribution of Residuals")
    qqnorm(lmFit()$res)
    qqline(lmFit()$res)
    
  }, height = 250)
  
  
})
