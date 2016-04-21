server <- function (input, output){
    
    output$myChart <- renderChart({
        
        b6 <- b2[b2$NIVELES %in% input$niveles,  ]
        grafica <- hPlot(EMISORA ~ BETA , data = b6, type = "bubble", size = "CAPM", group = "NIVELES", 
                         title = "BETAS of the Components of IPC Index")
        grafica$chart(width = 900, height = 350)
        grafica$addParams(dom = "myChart")
        grafica$chart(zoomType = "xy")
        grafica$exporting(enabled = T)
        return(grafica)
        
    })
    
    # este render es para el segundo chart
    
    output$tbl <- DT::renderDataTable(b3[b3$NIVELES %in% input$niveles, ], rownames = F
                                      
                                      
    )
    
    
    
    output$tbl1 <- DT::renderDataTable({
        
        b7 <- b3 %>% 
            mutate(RF1 = ({input$rf}/100), RM1 = ({input$rm}/100), CAPM1 = (RF1 + BETA*(RM1 - RF1)*100))
        
        b7 <- (b7[b7$NIVELES %in% input$niveles, ])
        
        
    }, rownames = F
    
    
    )
    
    
    output$value <- renderPrint({ (input$rf) })
    output$value <- renderPrint({ (input$rm) })
    
    
    
    
    output$downloadData <- downloadHandler(
        filename = "CAPM.csv",
        content = function(file) {
            write.csv(b7[b7$NIVELES %in% input$niveles, ], file, row.names = F)
        },
        contentType = "text/csv"
    )
    
    
    
    output$bar1 <- renderChart({
        
        
        hist1 <- hist[hist$SECTOR_EN %in% input$sector1,  ]  
        
        h3 <- Highcharts$new()
        h3$series(data = hist1$MKT_CAP, type = "bar")
        h3$xAxis(categories = hist1$SECTOR_EN)
        h3$title(text = "Market Cap by Sector (000,000) USD")
        h3$chart(width = 500, height = 400)
        h3$addParams(dom = "bar1")
        return(h3)
        
    })
    
    output$pie1 <- renderChart({
        
        
        hota1 <- hota[hota$Var1 %in% input$sector1,  ]  
        
        pie3 <- hPlot(x = "Var1", y = "Freq", data = hota1, type = "pie", title = "Distribution by Sector ")
        pie3$chart(width= 500, heigth = 400)
        pie3$addParams(dom = "pie1") 
        return(pie3)
        
    })
    
}