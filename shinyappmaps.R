library(shiny)
library(dplyr)
library(maps)

#install.packages('leaflet')
library(leaflet)
data("world.cities")
datanew <- world.cities
unique(datanew$country.etc)

# UI
ui <- fluidPage(
  titlePanel('Maps of Countries based on their population'),
  leafletOutput("mymap"),
  
  fluidRow( h4('Population'),
    column(2,
                 
           sliderInput("pop",h3("Select your popluation"), min=0,max=1000000, value = 500000),
           radioButtons("count",h3("Select your country"), choices = list("India"="India", "Bhutan"="Bhutan", "Nepal"="Nepal","Bangladesh"="Bangladesh","China"="China"), selected="India")
 )))


# SERVER
server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    leaflet(world.cities %>%
              dplyr::filter(
                country.etc == input$count,
                pop > input$pop
              )) %>%
    addTiles() %>%
    addMarkers(lng = ~long,lat = ~lat, label = ~as.character(pop))
    
  })
} 
shinyApp(ui,server)
