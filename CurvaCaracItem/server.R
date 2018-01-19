

server <- function(input,output){
 theta <- reactive({seq(-10,10,1)})
 proba_theta <- reactive({input$ce+(1-input$ce)*(1/(1+exp(-input$alpha*(theta()-input$beta))))})
 output$grafico <- renderPlot({
  layout(matrix(c(0,1,1,0),ncol=4))
  par(mar=c(5,2,4,0))
  plot(0, type='n',xlim=c(-10,10),ylim=c(0,1),xlab='',ylab='',axes=F)
  mtext(expression(theta),1, line=4,col='gray30',cex=2)
  mtext(expression(f(theta)),2,line=3.5,col='gray30',cex=2,las=2)
  axis(1, at=c(-10:10),cex.axis=1.2,col='gray30',col.axis='gray30')
  axis(2,las=2,cex.axis=1.3,col='gray30',col.axis='gray30')
  points(theta(),proba_theta(),type='b',col='turquoise3',pch=16,cex=1.2,lwd=1.8)


 })
 
}