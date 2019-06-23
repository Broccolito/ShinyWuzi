library(shiny)
library(plotly)


# library(shiny)
# 
# ui <- fluidPage(
#   plotlyOutput("plot"),
#   verbatimTextOutput("hover"),
#   verbatimTextOutput("click")
# )
# 
# server <- function(input, output, session) {
#   
#   output$plot <- renderPlotly({
#     plot_ly(x = rnorm(10), y = rnorm(10), z = rnorm(10), type = "scatter3d")
#   })
#   
#   output$hover <- renderPrint({
#     d <- event_data("plotly_hover")
#     if (is.null(d)) "Hover events appear here (unhover to clear)" else d
#   })
#   
#   output$click <- renderPrint({
#     d <- event_data("plotly_click")
#     if (is.null(d)) "Click events appear here (double-click to clear)" else d
#   })
#   
# }

# shinyApp(ui, server)



ui <- fluidPage(
  br(),
  sidebarLayout(sidebarPanel = sidebarPanel(
    
    verbatimTextOutput("click")
    
  ),
  mainPanel = mainPanel(
    #Main App UI here
    
    plotlyOutput("chessboard")
    
  ))
)

server <- function(input, output, session) {
  
  #Initialize the chessboard
  output$chessboard = renderPlotly({

    ax = list(
      zeroline = FALSE,
      showline = FALSE,
      showticklabels = FALSE,
      mirror = "ticks",
      gridcolor = toRGB("black"),
      gridwidth = 2,
      linecolor = toRGB("black"),
      linewidth = 6,
      autotick = FALSE
    )
    
    mk = list(size = 1,
              color = toRGB("grey50"),
              line = list(color = 'rgba(152, 0, 0, .8)',
                          width = 2))
    
    p <<- plot_ly(x = as.vector(mapply(rep, 1:19, rep(19,19))), y = rep(1:19,19),
                  marker = mk,
                  mode = "markers") %>%
      layout(xaxis = ax, yaxis = ax, autosize = FALSE, width = 700, height = 700,
             plot_bgcolor = "rgb(199, 139, 64)")
    
  })
  
  
  output$click = renderPrint({
    d = event_data("plotly_click")
    if(is.null(d)){
      "Click events appear here (double-click to clear)"
    }else{
      d
    }
  })
  
  # observeEvent(event_data("plotly_click"), {
  #   d = event_data("plotly_click")
  #   output$chessboard = renderPlotly({
  #     p = add_trace(p, x = d$x, y = d$y, inherit = TRUE)
  #   })
  # })
  # 
  #For testing purposes
  onSessionEnded(function(){
    stopApp()
  }) 
}

shinyApp(ui, server)