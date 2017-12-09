# install.packages("shinydashboard")
# install.packages("shiny")


library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(ggplot2)
library(scales)
library(plotly)
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# r_colors <- rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

## static data section
load("fulldataset.Rdata")
load("reviews.Rdata")
popupcontents <- paste(
  paste("listing id:",fulldataset$id),
  paste("room type:",as.character(fulldataset$room_type)),
  paste("address:", as.character(fulldataset$street)),
  sep=" || "
)
neighbors <- levels(fulldataset$neighbourhood_cleansed)

houseIcons <- icons(
  iconUrl = ifelse(fulldataset$median_price<=200,"./icons/green.png",
                     ifelse(fulldataset$median_price<=800,"./icons/orange.png","./icons/red.png")),
  iconWidth = 10, iconHeight = 10
)
unique_id <- as.list(as.character(fulldataset$id)) 

# ui
ui <- dashboardPage(
  dashboardHeader(title = "Contents"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text="Map", tabName = "Map"),
      menuItem(text="Explore Numerical Variabels", tabName = "num"),
      menuItem(text="Explore Categorical Variabels", tabName = "cat"),
      menuItem(text="Reviews", tabName="review"),
      menuItem(text="References", tabName = "References"),
      menuItem(text="Contact", tabName = "Contact")
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
          box(plotlyOutput("plotprice",height = "600px", inline=T),height = "600px", width=12)
          ),
        fluidRow(
          box(
            title = "Control: Price Range",
            sliderInput("slider", "Choose the minimum price and maximum price:", min=1, max=4500, value=c(24,671))
          ),
          box(
            title = "Control: Select listing id(s)",
            selectInput("select", "You can select multiple listing ids:", choices = unique_id, 
                        selected = c("6695","5506"), multiple = T)
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
            tabPanel(title="Prices", plotlyOutput("neighborhood_price_boxplot")),
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
      ),
      # word cloud
      tabItem(
        tabName = "review",
        h2("Word Clouds for Customers' Comments"),
        fluidRow(
          box(
            width = 6,
            plotOutput("wordclouds", height = "400px",width = "100%")
          ),
          box(
            title = "Control: Choose a listing id",
            width = 6,
            selectInput("select_wordcloud", "You can select a listing id per time", choices = unique_id, 
                        selected = c("6695"), multiple = F),
            sliderInput("slider_wordcloud_maxword", 
                        "Choose the maximum number of words to display:", min=1, max=100, value=30),
            sliderInput("slider_wordcloud_fre", 
                        "Choose the minimum frequence of words to display:", min=1, max=50, step=5, value=1)
            
          )
        )
      ),
      # reference
      tabItem(
        tabName = "References",
        h2("References"),
        box(
          tags$p(tags$b("Figures inspired by:"),
                 tags$ul(
                   tags$li(tags$a(href="https://www.kaggle.com/kostyabahshetsyan/boston-airbnb-visualization",
                                  "Boston Airbnb visualization")), 
                   tags$li(tags$a(href="https://www.kaggle.com/ewenhen/inside-airbnb-boston",
                                  "Inside Airbnb: Boston"))
                 ))
        ),
        box(
          tags$p(tags$b("Materials realted to Rshiny:"),
                 tags$ul(
                   tags$li(tags$a(href="http://shiny.rstudio.com/tutorial/",
                                  "Shiny")), 
                   tags$li(tags$a(href="https://rstudio.github.io/shinydashboard/index.html",
                                  "shinydashboard")),
                   tags$li(tags$a(href="http://rstudio.github.io/leaflet/",
                                  "Leaftlet for R")),
                   tags$li(tags$a(href="https://plot.ly/r/",
                                  "Plotly R Library"))
                 )             
              )
        )
      ),
      tabItem(
        tabName = "Contact",
        h2("App Info"),
        box(
          background = "black",
          p(
            tags$ul(
              tags$li("This shiny app is designed for the STAT 425 Final Project."),
              tags$li("If you have any question, please contact the author",a(href="mailto:rothdyt@gmail.com"," Yutong Dai")) 
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
  
  ## contents for timeseries plot

  output$plotprice <- renderPlotly({
    load("price.Rdata")
    
    selection <- input$select
    mydata <- filter(price, listing_id %in% selection)
    mydata <- data.frame(id = as.factor(mydata$listing_id), date=as.Date(mydata$date), price=mydata$price)
    mydata <- mydata[order(mydata$date),]
    
    timeseries <- ggplot(mydata, aes(date, price, colour=id)) + geom_line() + 
      scale_x_date(labels = date_format("%Y-%m-%d"),date_breaks = "1 month",
                   limits = as.Date(c('2016-09-01','2017-08-15'))) + ylab("Price/$") +
      theme(axis.text.x = element_text(angle = 10, hjust = 1)) + ylim(input$slider[1], input$slider[2])
    ggplotly(timeseries)
  })

  ## contents for boxplot 
  selection <- reactive(input$Neighborhood_checkbox)
  data <- reactive(filter(fulldataset, neighbourhood_cleansed %in% selection()))
  my <- reactive(data.frame(price=data()$median_price,
                            neighbourhood=data()$neighbourhood_cleansed,
                            bedroom=data()$bedrooms))
  output$neighborhood_price_boxplot <- renderPlotly({
    box <- ggplot(my(),aes(x=neighbourhood,y=price,colour=neighbourhood)) + geom_boxplot() +
      theme(legend.position="none")
    ggplotly(box)
  })
  
  output$neighborhood_bedroom_dotplot <- renderPlot({
    ggplot(my(),aes(x=neighbourhood,y=bedroom,colours, colour=neighbourhood)) +
      geom_point(position=position_jitter(width=.1, height=0.1)) +
      theme(legend.position="none")
    #ggplotly(dot)
  })
 
  ## contents for word clouds
  output$wordclouds <- renderPlot({
    selected_id <- which(reviews_simplified$listing_id == input$select_wordcloud)
    docs <- Corpus(VectorSource(reviews_simplified[selected_id,]$comments))
    toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
    docs <- tm_map(docs, toSpace, "\n")
    docs <- tm_map(docs, tolower)
    docs <- tm_map(docs, removeWords, stopwords("english"))
    docs <- tm_map(docs, removeWords, stopwords("spanish"))
    docs <- tm_map(docs, removeWords, stopwords("french"))
    docs <- tm_map(docs, removeWords, c("the","boston"))
    dtm <- TermDocumentMatrix(docs)
    m <- as.matrix(dtm)
    v <- sort(rowSums(m),decreasing=TRUE)
    d <- data.frame(word = names(v),freq=v)
    set.seed(1234)
    wordcloud(words = d$word, freq = d$freq, scale=c(6,1),
              min.freq = input$slider_wordcloud_fre,
              max.words=input$slider_wordcloud_maxword, random.order=FALSE, rot.per=0.35, 
              colors=brewer.pal(8, "Dark2"))
  })
}

shinyApp(ui, server)


