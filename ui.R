library(shinydashboard)
library(rCharts)
library(markdown, warn = F)
library(knitr, warn = F)
library(dplyr, warn = F)

#carpeta2 <- 'O:/Users/shuitrong/Documents/CAPM'

source("CAPM_fa.R")

header <- dashboardHeader(title = "CAPM")

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("AN INTRODUCTION", tabName = "explain", icon = icon("pencil")), 
        menuItem("MODEL & GRAPHS", tabName = "test", icon = icon("bar-chart")),
        menuItem("BY SECTOR", tabName = "test1", icon = icon("bar-chart"))
        
        
    )
)

body <- dashboardBody(
    tabItems(
        
        tabItem(tabName = "explain", 
                fluidRow( 
                    
                    box(title = "The Model CAPM", collapsible = TRUE, status = "primary", solidHeader = T, width = 12, 
                        
                        includeMarkdown("include.md")
                        
                        
                    )
                    
                )
                
                
                
        ),
        
        tabItem(tabName = "test", 
                fluidRow(
                    box(title = "Betas", collapsible = TRUE, status = "primary", 
                        solidHeader = TRUE, showOutput("myChart", "highcharts"), width = 10
                    ),
                    
                    box(title = "Nivels of Beta", collapsible = TRUE, status = "primary",  
                        solidHeader = TRUE, checkboxGroupInput("niveles", "",
                                                               choices = c("HIGH" = "HIGH", "MEDIA" = "MEDIA",
                                                                           "LOW" = "LOW", "MINIMUM" = "MINIMUM"), selected = "HIGH"
                        ), width = 2
                    )
                    
                ),# aqui termina el primer fluidRow 
                
                fluidRow(
                    box(title = "Table of CAPM", collapsible = TRUE, status = "primary",  
                        solidHeader = TRUE, DT::dataTableOutput('tbl1'), width = 8, downloadButton("downloadData", "Download")
                    ),
                    
                    box( title = "Choose a Risk Free Rate", status = "primary", solidHeader = T, 
                         collapsible = T ,width = 2,  numericInput("rf", "", value = 3.5)),
                    
                    box( title = "Choose a Risk Market Rate", status = "primary", solidHeader = T, 
                         collapsible = T ,width = 2,  numericInput("rm", "", value = 8.29))
                    
                )#,
                
                
        ),# parentesis del Tab Item
        
        tabItem(tabName = "test1",
                
                fluidRow(
                    
                    box(title = "MARKET CAP", status = "primary", solidHeader = T, collapsible = T
                        
                        , showOutput("bar1", "highcharts") , width = 5),
                    
                    box(title = "PIE", status = "primary", solidHeader = T, collapsible = T
                        
                        , showOutput("pie1", "highcharts"), width = 5 ),#,
                    
                    box(title = "SECTOR", status = "primary", solidHeader = T, collapsible = T,
                        checkboxGroupInput("sector1", "", 
                                           choices = c("MARKET" = "MARKET", "CONSUMER GOODS" = "CONSUMER GOODS", "INDUSTRIAL GOODS" = "INDUSTRIAL GOODS",                   
                                                       "TECHNOLOGY" = "TECHNOLOGY", "FINANCIAL" = "FINANCIAL", "SERVICES" = "SERVICES", "ENERGY" = "ENERGY", "HEALTHCARE" = "HEALTHCARE"),                   
                                           selected = c("CONSUMER GOODS", "SERVICES", "FINANCIAL", "MARKET"))
                        , width = 2 )    
                    
                    
                )
                
        )
        
        
        
    )
    
    
)


ui <- dashboardPage(header, sidebar, body)
