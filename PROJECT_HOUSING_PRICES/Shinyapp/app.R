# install.packages("shinydashboard")
# install.packages("shiny")


library(shiny)
library(shinydashboard)
library(leaflet)

# r_colors <- rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

## static data section
load("fulldataset.Rdata")
# houseicons <- icons(
#   iconUrl = ifelse(fulldataset$median_price<=200,"./icons/green.png",
#                    ifelse(fulldataset$median_price<=800,"./icons/orange.png","./icons/red.png")),
#   iconWidth <- 10, iconHeight <- 10
# )
popupcontents <- paste("room type:",as.character(fulldataset$room_type),"address:",
                       as.character(fulldataset$street),sep="|")

houseIcons <- icons(
  iconUrl = ifelse(fulldataset$median_price<=200,"./icons/green.png",
                     ifelse(fulldataset$median_price<=800,"./icons/orange.png","./icons/red.png")),
  iconWidth = 10, iconHeight = 10
)

ui <- dashboardPage(
  dashboardHeader(title = "Graphs"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text="Map", tabName = "Map"),
      menuItem(text="EDA", tabName = "EDA")
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Map",
              h2("Airbnb Rental Markets in Boston"),
              leafletOutput("map", height = 600),
              p("Choose your map type to display:"),
              actionButton(inputId="house", label="Apt/Room"),
              actionButton(inputId="neighborhood", label="Neighborhood"),
              actionButton(inputId="host", label="SuperHost"),
              uiOutput("description")
      ),
      
      # Second tab content
      tabItem(
        tabName = "EDA",
        h2("Explore Data Analysis"),
        fluidRow(
          box(plotOutput("plotbyhouse", height = "400px")),
          
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      )
    )
  )  
)



server <- function(input, output) {
  
  ## contents for first tab - MAP
  
  ## house
  observeEvent(input$house,
               {
                 output$map <- renderLeaflet({
                   leaflet(data = fulldataset) %>%  setView(lng = -71.0591, lat = 42.32998, zoom = 13) %>% 
                     addProviderTiles(providers$CartoDB.Positron) %>%
                     addMarkers(~longitude, ~latitude, icon=houseIcons, 
                                popup= ~popupcontents, label= ~as.character(price)
                     )
                 })
                 
                 output$description <- renderUI({
                   tagList(
                     pre("1. Hover your cursor on house icons will show prices.
2. Click the house icon will give your additional infomation about this house.
3. Differnet colors indicate differnet price levels (measured in median):
    Red: More than $800/nigt;
    Green: Less than $200/night;
    Orange: In between.")
                   )
                 })
  })
  
  ## neighborhood
  observeEvent(input$neighborhood,
               {
                 
                 # Create a palette that maps factor levels to colors
                 # factpal <- factor(fulldataset$neighbourhood_cleansed) %>% 
                 #   colorFactor(topo.colors(15), .)
                 factpal <- colorFactor(palette(), domain = levels(fulldataset$neighbourhood_cleansed)) 
                 
                 popup <- paste0("<strong>Neighborhood: </strong>", fulldataset$neighbourhood_cleansed)
                 
                 output$map <- renderLeaflet({
                   leaflet(fulldataset) %>% addProviderTiles(providers$CartoDB.Positron) %>%
                     addCircleMarkers(~longitude, ~latitude,
                       color = ~factpal(neighbourhood_cleansed),
                       stroke = FALSE, fillOpacity = 0.2, radius = 2,
                       popup = ~popup
                     )
                 })
                 
                 output$description <- renderUI({
                   tagList(
                     pre("Different Neighborhoods are assigned with different colors. 
Click dots will show their corresponding neighborhoods.")
                   )
                 })
  })
  
  ## super-host
  observeEvent(input$host,
               {
                 output$map <- renderLeaflet({
                   label <- which(fulldataset$host_is_superhost == "t")
                   leaflet(fulldataset[label,]) %>% addProviderTiles(providers$CartoDB.Positron) %>%
                     addCircleMarkers(~longitude, ~latitude, radius = 2 ,color = "orange",
                                      fillOpacity = 0.2)
                 })
                 output$description <- renderUI({
                   tagList(
                     pre("Super hosts are shown in orange circles.")
                   )
                 })
  })
  
  ## contents for second tab - EDA
  set.seed(122)
  histdata <- rnorm(500)
  output$plotbyhouse <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  
}

shinyApp(ui, server)


