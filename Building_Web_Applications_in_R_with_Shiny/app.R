#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.


# "I maintained my edge by always being a student; you will always have something new to learn". - Jackie Joyner Kersee
# 
# 
# Course Description: 
#     
#     * Build interactive web apps from R. 
# 
# 
# Ref: Cetinkaya-Rundel, Mine. *https://www.datacamp.com/courses/building-web-applications-in-r-with-shiny*. 2018.


# (I). Load R packages ---------

library(shiny)
library(tidyverse)
library(DT)



# (II). Load data-----------

load(url("http://s3.amazonaws.com/assets.datacamp.com/production/course_4850/datasets/movies.Rdata"))

# Define UI for application that plots features of movies
ui <- fluidPage(
    
    # Sidebar layout with a input and output definitions
    sidebarLayout(
        
        # Inputs
        sidebarPanel(
            
            # Select variable for y-axis
            selectInput(inputId = "y", 
                        label = "Y-axis:",
                        choices = c("IMDB rating"          = "imdb_rating", 
                                    "IMDB number of votes" = "imdb_num_votes", 
                                    "Critics score"        = "critics_score", 
                                    "Audience score"       = "audience_score", 
                                    "Runtime"              = "runtime"), 
                        selected = "audience_score"),
            
            # Select variable for x-axis
            selectInput(inputId = "x", 
                        label = "X-axis:",
                        choices = c("IMDB rating"          = "imdb_rating", 
                                    "IMDB number of votes" = "imdb_num_votes", 
                                    "Critics score"        = "critics_score", 
                                    "Audience score"       = "audience_score", 
                                    "Runtime"              = "runtime"), 
                        selected = "critics_score"),
            
            # Select variable for color
            selectInput(inputId = "z", 
                        label = "Color by:",
                        choices = c("Title type" = "title_type", 
                                    "Genre" = "genre", 
                                    "MPAA rating" = "mpaa_rating", 
                                    "Critics rating" = "critics_rating", 
                                    "Audience rating" = "audience_rating"),
                        selected = "mpaa_rating"), 
        
        # set alpha level 
        sliderInput(inputId = "alpha", 
                    label = "Alpha:", 
                    min = 0, max = 1, 
                    value = 0.5)
        
        # add new sidebar related here 
        ),
        # Outputs
        mainPanel(
            plotOutput(outputId = "scatterplot"), 
            plotOutput(outputId = "densityplot", height = 200)
        )
    )
)

# Define server function required to create the scatterplot
server <- function(input, output) {
    
    # Create the scatterplot object the plotOutput function is expecting
    output$scatterplot <- renderPlot({
        ggplot(data = movies, aes_string(x = input$x, y = input$y,
                                         color = input$z)) +
            geom_point(alpha = input$alpha)
    })
    
    # create densityplot
    output$densityplot <- renderPlot({
        ggplot(data = movies, aes_string(x = input$x)) +
            geom_density()
    })
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)