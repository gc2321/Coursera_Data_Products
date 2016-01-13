library(shiny)
library(ggplot2)

d<-read.csv("data/migration.csv", colClasses =c("factor", "factor", "integer"))
years<-levels(d$Year)
country<-levels(d$Country)

shinyServer(function(input, output, session) {
 
    output$low <- renderPlot({
        
        d2<-d[d$Year==input$select,]
        d3_low<-d2[order(d2$Value),]
        
        g_low<-ggplot(d3_low[1:15,], aes(x=Value, y=reorder(Country, -Value)))
        g_low+geom_point(size=3)+
            geom_segment(aes(yend=Country), xend=0, colour="black")+
            labs(x="Number of people gained",y="Countries")+ 
            theme_bw()+
            theme(panel.grid.major.x=element_blank(),
                  panel.grid.minor.x=element_blank(),
                  panel.grid.major.y=element_line(colour="grey60", linetype="dashed"))
    })     
    
    output$high <- renderPlot({
        d2<-d[d$Year==input$select,]
        d3_high<-d2[order(-d2$Value),]
        
        g_high<-ggplot(d3_high[1:15,], aes(x=Value, y=reorder(Country, Value)))
        g_high+geom_point(size=3)+
            geom_segment(aes(yend=Country), xend=0, colour="black")+
            labs(x="Number of people gained",y="Countries")+ 
            theme_bw()+
            theme(panel.grid.major.x=element_blank(),
                  panel.grid.minor.x=element_blank(),
                  panel.grid.major.y=element_line(colour="grey60", linetype="dashed"))   
    
    })
    
    output$country <- renderPlot({
        
        d2_c<-d[d$Country==input$select_c,]
        d3_c<-d2_c[order(d2_c$Year),]
        
        g_c<-ggplot(d3_c, aes(x=Year, y=Value))
        g_c+geom_point(size=3)+
            geom_segment(yend=0, aes(xend=Year), colour="black")+
            geom_abline(intercept = 0, slope=0)+
            labs(x="Year",y="Number of people gained")+
            theme_bw()+
            theme(
                axis.text.x = element_text(angle=60, hjust=1),
                panel.grid.major.y=element_blank(),
                panel.grid.minor.y=element_blank(),
                panel.grid.major.x=element_line(colour="grey60", linetype="dashed")
            )
    })     
    
    output$title <- renderText({paste("Net migration in ", input$select)})
    
    output$title_c <- renderText({paste("Net migration of ", input$select_c, "(1982 - 2012)")})

})