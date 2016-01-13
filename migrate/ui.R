require(shiny)

d<-read.csv("data/migration.csv", colClasses =c("factor", "factor", "integer"))
years<-levels(d$Year)
country<-levels(d$Country)

shinyUI(navbarPage(
    "Net migration of people around the world",
    tabPanel("Main",
        h6("Source: World Development Indicators | The World Bank"),
        hr(),
        
        column(8,
               
               selectInput('select', 'Net migration in year', years, selected=2012),
               
               tabsetPanel(type = "tabs", 
                           tabPanel("Countries with the highest migration", plotOutput("high")), 
                           tabPanel("Countries with the lowest migration", plotOutput("low"))
               ),
               br()
               
        ),
        
        column(8,
               hr(),
               selectInput('select_c', 'Net migration (1962 - 2012) in', country, selected="United States"),
               plotOutput("country"),
               br(),
               br()
              
               
        )
    ),
    tabPanel("About",
             column(8,

                h3("Exploring net migration data from UNdata"),
                br(), 
                p("Net migration is the net total of migrants during the period, 
                   that is, the total number of immigrants less the annual number of emigrants, 
                  including both citizens and noncitizens."),
                br(),
                h4("Ranking of countries in net migraton"),
                p("The top panel is the ranking of countries according to their net migration values. 
                   Using the drop-down list to select the data set of a given year."),
                p("The right tab ranks the top 15 countries with the most net migration. 
                  The left tab shows 15 countries with the lowest net migration in the selected period."),
                br(),
                h4("Net migraton around the world (1962 - 2012)"),
                p("The bottom panel is the net migration value for each country in period from 1962 to 2012.
                  Select the country from the drop-down list."),
                br(),
                h4("Reference"),
                p("These data were collected from the UNdata website and can be downloaded by following the link as indicated below."),
                tags$a(href = "http://data.un.org/Data.aspx?q=migration&d=WDI&f=Indicator_Code:SM.POP.NETM&c=2,4,5&s=Country_Name:asc,Year:desc&v=1#WDI", "UNdata Net migration data")
                
             )
             
    )
   
))






