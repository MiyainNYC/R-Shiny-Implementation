### Interactive app using Shiny
library(plotly)
ui <- basicPage(
  plotlyOutput("myplot") # add "ly"
)
server <- function(input, output, session){
  output$myplot <- renderPlotly({ # add "ly"
    ggplot(mpg, aes(cyl, cty)) +
      geom_jitter(aes(text = paste("make:", manufacturer)),
                  width=0.2, color="firebrick") +
      stat_smooth(method="lm")
  })
}
shinyApp(ui=ui, server=server)