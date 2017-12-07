ui <- fluidPage(
  sliderInput(inputId="num", label="please choose a number", min=0,max=100,value=10,step=1),
  textInput(inputId="title", label="please give a title to your plot", value = "Histogram"),
  plotOutput(outputId="hist")
)
server <- function(input, output){
  output$hist <- renderPlot({
    set.seed(1234)
    hist(rnorm(input$num), main= input$title)
  })
}
shinyApp(ui, server)

ui <- fluidPage(
  sliderInput(inputId="num", label="please choose a number", min=0,max=100,value=10,step=1),
  actionButton(inputId = "update", label="Update"),
  textInput(inputId="title", label="please give a title to your plot", value = "Histogram"),
  plotOutput(outputId="hist")
)
server <- function(input, output){
  data <- eventReactive(input$update, rnorm(input$num))
  output$hist <- renderPlot({
    set.seed(1234)
    hist(data(), main= input$title)
  })
}

shinyApp(ui, server)


ui <- fluidPage(
  actionButton(inputId="norm", label="Normal"),
  actionButton(inputId="unif", label="Uniform"),
  plotOutput(outputId="hist")
)
server <- function(input, output){
  rv <- reactiveValues(data = rnorm(100))
  observeEvent(input$norm, {rv$data <- rnorm(100)})
  observeEvent(input$unif, {rv$data <- runif(100)})
  output$hist <- renderPlot({
   hist(rv$data)
  })
}
shinyApp(ui, server)

#fileInput
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c(".csv", ".Rdata")
      ),
      tags$hr(),
      checkboxInput("header", "Header", TRUE)
    ),
    mainPanel(
      tableOutput("contents")
    )
  )
)
options(shiny.maxRequestSize=30*1024^2) 
server <- function(input, output) {
  output$contents <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
  })
}

shinyApp(ui, server)


