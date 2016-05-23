## generating dynamic output (text, plots and tables)

ui <- basicPage(
  textInput(inputId = "txt", "A text box"),
  h3(style="color:green", "You typed:")
)
server <- function(input, output, session) { }
shinyApp(ui = ui, server = server)

## to generate dynamic text, tables and plots you need two pieces

### render *
### *output

ui <- basicPage(
  textInput(inputId = "txt", "A text box"),
  h3(style="color:green", "You typed:"),
  textOutput("usertext") # here is our UI output
)
server <- function(input, output, session) {
  output$usertext <- renderText({
    input$txt # return text box value
  }) # our render function
}
shinyApp(ui = ui, server = server)

## dynamic table

## use renderDataTable in the server
## use dataTableOutput in the UI

ui <- basicPage(
  numericInput(inputId = "num", "Row Count", value=5),
  dataTableOutput("newtable") # output to user
)
server <- function(input, output, session) {
  output$newtable <- renderDataTable({
    cars[1:input$num,]
  }) # render a data table
}
shinyApp(ui = ui, server = server)


### How to include a plot in an app
#### renderPlot in the server
#### plotOutplot in the UI

## A ggplot in shiny (code)

library(ggplot2)
ui <- basicPage(
  plotOutput("myplot") # output plot to user
)
server <- function(input, output, session) {
  output$myplot <- renderPlot({
    ggplot(mpg, aes(manufacturer, hwy)) +
      geom_jitter(color="blue", width=0.2, size=3)
  }) # render a plot for the UI
}
shinyApp(ui = ui, server = server)

### to allow the user to selecgt the car manufacturer (the car 'maker')

library(ggplot2)
ui <- basicPage(
  selectInput("make", "Choose make", multiple = TRUE,
              choices=mpg$manufacturer, selected="toyota"),
  plotOutput("myplot")
)
server <- function(input, output, session) {
  mpg2 <- reactive({mpg[mpg$manufacturer%in%input$make,]})
  output$myplot <- renderPlot({
    ggplot(mpg2(), aes(manufacturer, hwy)) +
      geom_jitter(color="blue", width=0.2, size=3)
  })
}
shinyApp(ui = ui, server = server)


library(ggplot2)
ui <- basicPage(
  selectInput("make", "Choose make", multiple = TRUE,
              choices=mpg$manufacturer, selected="toyota"),
  checkboxInput("reorder", "Sort by median mpg", FALSE),
  plotOutput("myplot")
)
server <- function(input, output, session) {
  mpg2 <- reactive({
    mpg2 <- mpg[mpg$manufacturer%in%input$make,]
    if(input$reorder) {
      mpg2$manufacturer <- reorder(mpg2$manufacturer,
                                   mpg2$hwy, median)
    }
    return(mpg2)
  })
  output$myplot <- renderPlot({
    ggplot(mpg2(), aes(manufacturer, hwy)) +
      geom_jitter(color="blue", width=0.2, size=3)
  })
  shinyApp(ui = ui, server = server)