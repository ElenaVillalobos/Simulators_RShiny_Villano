

server <- function(input,output){
 theta <- reactive({seq(-10,10,1)})
 proba_theta <- reactive({input$ce+(1-input$ce)*(1/(1+exp(-input$alpha*(theta()-input$beta))))})
 proba_theta_2 <- reactive({input$ce_2+(1-input$ce_2)*(1/(1+exp(-input$alpha_2*(theta()-input$beta_2))))})
 

  output$grafico <- renderPlot({
  layout(matrix(c(0,1,1,0),ncol=4))
  par(mar=c(5,2,4,0))
  plot(0, type='n',xlim=c(-10,10),ylim=c(0,1),xlab='',ylab='',axes=F)
  mtext(expression(theta),1, line=4,col='gray30',cex=2)
  mtext(expression(f(theta)),2,line=3.5,col='gray30',cex=2,las=2)
  legend(5,0.7,col=c('turquoise3','tomato'),pch=20,legend=c('Item 1','Item 2'),
         cex=2,box.col='white',text.col='gray30')
  axis(1, at=c(-10:10),cex.axis=1.2,col='gray30',col.axis='gray30')
  axis(2,las=2,cex.axis=1.3,col='gray30',col.axis='gray30')
  points(theta(),proba_theta(),type='b',col='turquoise3',pch=16,cex=1.2,lwd=1.8)
  points(theta(),proba_theta_2(),type='b',col='tomato',pch=16,cex=1.2,lwd=1.8)
  

 })
 
}