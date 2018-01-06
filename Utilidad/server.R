

server <- function(input,output){
 datos <- reactive({c(0:18)})
 exp <- reactive({400*(2.718282^(-datos()*input$exp))})
 hiper <- reactive({400/(1+input$hiper_k*datos())})
 cuasi <- reactive({400*((1+input$cuasi_k*datos())^((-input$cuasi_s)/input$cuasi_k))})
 output$grafico <- renderPlot({
  layout(matrix(c(0,1,1,0),ncol=4))
  par(mar=c(5,2,4,0))
  plot(0, type='n',xlim=c(0,18),ylim=c(0,400),xlab='',ylab='',axes=F)
  mtext('Descuento del Valor Subjetivo de 400 pesos',3,col='gray30',cex=1.3)
  mtext('Demora (Semanas)',1, line=3,col='gray30')
  mtext('Valor subjetivo',2,line=3.5,col='gray30')
  legend(12,380,col = c('tomato','turquoise3','yellowgreen'),pch=c(16,17,15),
         legend = c('Exponencial','Hiperboloide','Generalizada'),
         cex=1.5,box.col='white',text.col='gray30')
  axis(1, at=c(0:18),cex.axis=1.2,col='gray30',col.axis='gray30')
  axis(2,las=2,cex.axis=1.3,col='gray30',col.axis='gray30')
  points(datos(),exp(),type='b',col='tomato',pch=16,cex=1.2)
  points(datos(),hiper(),type='b',col='turquoise3',pch=17,cex=1.2)
  points(datos(),cuasi(),type='b',col='yellowgreen',pch=15,cex=1.2)
  
 })
 
}