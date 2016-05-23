## A shiny application requires two things

### user interface(the beauty and server)

## install.packages('shiny')

library(shiny)
ui = basicPage("This is a real shiny App developed by Miya")
server = function(input, output, session){}
shinyApp(ui = ui, server = server)

## single page and multi-file shiny apps

### for smaller apps, use the shinyApp function to launch
### for larger apps, use the runApp function to launch

###### runApp('/my_app_directory')

###UI
## layout
##  adding HTML objects like titles and paragraphs
## widgets (sliders, text boxes)
## styles


#### Predefined layout functions
# basicPage
# fluidPage
# sidebarLayout
# bavbarPage

# Another shiny app

ui = fluidPage(
  titlePanel(" A fluid page app"),
  sidebarLayout(
    sidebarPanel(
      "My sidebar"
    ),
    mainPanel(
      "My main panel"
    )
  )
)

server = function(input, output, session){}
shinyApp(ui= ui,server = server)


## to add headers, colors and styles, need HTML
## HTML tags can be included with tags$ (e.g., tags$h1,
## tags$blockquote)
## For common HTML tags you can use the tag name as a
## function (e.g., h1(), p())

library(shiny)
ui <- fluidPage(
  h1("Title with h1()"), ## adding the HTML tags
  p("A paragraph of text with p()"),
  tags$blockquote("Block quote with tags$blockquote"),
  code('# this is code with code()')
)
server <- function(input, output, session) { }
shinyApp(ui = ui, server = server)


### Widgets for user interaction
### Functions for adding widgets, sliderInput, textInput etc
### RStudio has a widget gallery with examples



library(shiny)
ui <- fluidPage(
  textInput(inputId = "txt", "A text box"),
  checkboxInput(inputId = "chk", "A check box", TRUE)
)
server <- function(input, output, session) { }
shinyApp(ui = ui, server = server)


### add style, use CSS: style langauge of the web
#### to keep alll styles in a single style sheet

ui <- fluidPage(
  includeCSS("path-to-style/style.css")
)



### header and inline styles 
ui <- basicPage(
  # styles in the header
  tags$head(
    tags$style(HTML("
                    body {
                    background-color: cornflowerblue;
                    color: Maroon;
                    }
                    "))
    ),
  # here is an in-line style
  h3(style="color:white", "CSS using the HTML tag"),
  p("Some important text")
    )
server <- function(input, output, session) { }
shinyApp(ui = ui, server = server)

## all the elements in the ui , nesting ones should be separated by commas

## nesting elements should be separated by commas

## Shiny Server
### reactive values 
### the listeners observe and reactive
### generateing output(text, tables, plots)


## All of the widget ids get added to the input used in the server

### Input can only be read by a 'reactive expression"

## input is a list of reactive values
## reactive values can only be handled by functions designed to handle them
## this functions, or"reactive expressions", include oberve, reactive and the render- functions

# The listeners observe and reactive

## Observe
### a function to generate side effects ( but does not return a value) based on user inpu


ui <- fluidPage(
  textInput(inputId = "txt1", "Type here:"),
  textInput(inputId = "txt2", "You typed:")
)
server <- function(input, output, session) {
  observe({
    updateTextInput(session, "txt2", value = input$txt1)
  })
}
shinyApp(ui = ui, server = server)

## the observe function is designed cause side effects(on purpose) but do not return a value


# REACTIVE
## operates like a function
## can be called and returns a value
## lazy, not eager, doesn't execute until called
ui <- fluidPage(
  numericInput("myrow", "Choose row number (try 55, 130)",
               1),
  textInput(inputId = "txt2", "You typed:")
)
server <- function(input, output, session) {
  my_results <- reactive({
    iris[input$myrow, "Species"]
  })
  observe({
    input$myrow
    updateTextInput(session, "txt2", value = my_results())
  })
}
shinyApp(ui = ui, server = server)


