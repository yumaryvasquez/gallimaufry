library(shiny)
library(leaflet)
library(dplyr)


df = read.csv("df1.csv", header = TRUE)
df$Latitude <- as.numeric(df$Latitude)
df$Longitude <- as.numeric(df$Longitude)




ui <- fluidPage(
    leafletOutput("mymap",height = 1000),
   column(width = 3,
          box(width = NULL, status = "warning",
              checkboxGroupInput("person", "Show",
                                 choices = c(
                                   Both = 1,
                                   O = 2,
                                   Y = 3
                                 ),
                                 selected = c(1, 2, 3)
              )
          )
   )
)


server <- function(input, output) {
    output$mymap <- renderLeaflet({
        m <- leaflet(data = df) %>%
            addTiles() %>%
            addCircleMarkers(radius = 6,
                       color = "blue",
                       stroke = FALSE, fillOpacity = 0.5,
                       lng = ~Longitude, 
                       lat = ~Latitude,
                       popup = paste("Name: ", df$Location.Name, "<br>",
                                     "City: ", df$Location.City, "<br>",
                                     "Website: ", df$Website))
        m
    })
}


shinyApp(ui = ui, server = server)
