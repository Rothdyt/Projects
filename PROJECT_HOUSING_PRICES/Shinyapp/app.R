# install.packages("shinydashboard")
# install.packages("shiny")


library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(ggplot2)

# r_colors <- rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

## static data section
load("fulldataset.Rdata")
popupcontents <- paste("room type:",as.character(fulldataset$room_type),"address:",
                       as.character(fulldataset$street),sep="|")
neighbors <- levels(fulldataset$neighbourhood_cleansed)

houseIcons <- icons(
  iconUrl = ifelse(fulldataset$median_price<=200,"./icons/green.png",
                     ifelse(fulldataset$median_price<=800,"./icons/orange.png","./icons/red.png")),
  iconWidth = 10, iconHeight = 10
)

# ui
ui <- dashboardPage(
  dashboardHeader(title = "Graphs"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text="Map", tabName = "Map"),
      menuItem(text="Numerical Variabels", tabName = "num"),
      menuItem(text="Categorical Variabels", tabName = "cat"),
      menuItem(text="Reviews", tabName="review")
    )
  ),
  dashboardBody(
    tabItems(
      # Map tab content
      tabItem(tabName = "Map",
              h2("Airbnb Rental Markets in Boston"),
              p("Choose a map to display:"),
              actionButton(inputId="house", label="Apt/Room"),
              actionButton(inputId="neighborhood", label="Neighborhoods"),
              actionButton(inputId="host", label="SuperHost"),
              uiOutput("description"),
              leafletOutput("map", height = 600)
      ),
      
      # Numerical tab content
      tabItem(
        tabName = "num",
        h2("Explore Data Analysis - Numerical Variabels"),
        fluidRow(
          box(plotOutput("plotbyhouse", height = "400px")),
          
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),
      
      # Categorical tab content
      tabItem(
        tabName = "cat",
        h2("Explore Data Analysis - Categorical Variabels"),
        fluidRow(
          tabBox(
            title = "Choose Variables",
            id = "cat_var", height = "500px",width = "100%",
            tabPanel(title="Neighborhood", plotOutput("neighborhood_price_boxplot")),
            tabPanel(title="# Bedrooms", plotOutput("neighborhood_bedroom_dotplot"))
          )
        ),
       fluidRow(
         box(
           title = "Controls",
           width = "100%",
           checkboxGroupInput(
             inputId = "Neighborhood_checkbox", "neighborhood to show:",
             # code to generate choices
             # neighbors <- levels(fulldataset$neighbourhood_cleansed)
             # for (i in 1:length(neighbors)){
             #   if (i != length(neighbors)){
             #     cat('"',neighbors[i],'"',"=",
             #         '"',neighbors[i],'"',",","\n",
             #         sep="") 
             #   }else{
             #     cat('"',neighbors[i],'"',"=",
             #         '"',neighbors[i],'"',"\n",
             #         sep="")
             #   }
             # }
             choices= c("Allston"="Allston",
                        "Back Bay"="Back Bay",
                        "Bay Village"="Bay Village",
                        "Beacon Hill"="Beacon Hill",
                        "Brighton"="Brighton",
                        "Charlestown"="Charlestown",
                        "Chinatown"="Chinatown",
                        "Dorchester"="Dorchester",
                        "Downtown"="Downtown",
                        "East Boston"="East Boston",
                        "Fenway"="Fenway",
                        "Hyde Park"="Hyde Park",
                        "Jamaica Plain"="Jamaica Plain",
                        "Leather District"="Leather District",
                        "Longwood Medical Area"="Longwood Medical Area",
                        "Mattapan"="Mattapan",
                        "Mission Hill"="Mission Hill",
                        "North End"="North End",
                        "Roslindale"="Roslindale",
                        "Roxbury"="Roxbury",
                        "South Boston"="South Boston",
                        "South Boston Waterfront"="South Boston Waterfront",
                        "South End"="South End",
                        "West End"="West End",
                        "West Roxbury"="West Roxbury"),
             selected = c("Allston"="Allston",
                          "Back Bay"="Back Bay",
                          "Bay Village"="Bay Village"),
             inline = TRUE
           )
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
  selection <- reactive(input$Neighborhood_checkbox)
  data <- reactive(filter(fulldataset, neighbourhood_cleansed %in% selection()))
  my <- reactive(data.frame(price=data()$median_price,
                   neighbourhood=data()$neighbourhood_cleansed,
                   bedroom=data()$bedrooms))
  ## content for boxplot price v.s neighbors
  output$neighborhood_price_boxplot <- renderPlot({
    ggplot(my(),aes(x=neighbourhood,y=price,colour=neighbourhood)) + geom_boxplot() +
      theme(legend.position="none")
  })
  
  output$neighborhood_bedroom_dotplot <- renderPlot({
    ggplot(my(),aes(x=neighbourhood,y=bedroom,colours, colour=neighbourhood)) +
      geom_point(position=position_jitter(width=.1, height=0.1)) +
      theme(legend.position="none")
  })
  
}

shinyApp(ui, server)


