#mi primer app

server <- function(input,output){
 datos <- reactive({c(0:100)})
 y <- reactive({datos()^input$num})
 y_2 <- reactive({y()*input$num2})
 
 output$grafico <- renderPlot({
  layout(matrix(c(1,2),ncol=2))
  plot(datos(),y(), xlim=c(0,100),ylim=c(0,200))
  plot(datos(),y_2(), xlim=c(0,100),ylim=c(0,200))
  
 })
 
}