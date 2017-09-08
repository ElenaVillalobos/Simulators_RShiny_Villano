library('shiny')
library('rsconnect')


function(input,output){
 #######questions########
 x_ss <- reactive({c(5150,5300,5450,5150,5300,5150,
                     6050,6200,6350,6050,6200,6050,
                     5150,5600,6050,5150,5600,5150,
                     1150,1250,1350,1150,1250,1150)})
 x_ll <- reactive({c(5300,5450,5600,5450,5600,5600,
                     6200,6350,6500,6350,6500,6500,
                     5600,6050,6500,6050,6500,6500,
                     1250,1350,1450,1350,1450,1450)})
 t_ss <- reactive({c(1,2,3,1,2,1,
                     7,8,9,7,8,7,
                     1,4,7,1,4,1,
                     1,4,7,1,4,1)})
 t_ll <- reactive({c(2,3,4,3,4,4,
                     8,9,10,9,10,10,
                     4,7,10,7,10,10,
                     4,7,10,7,10,10)})
 
 #######functions########
 v_ss <- reactive({1/(input$gamma)*log(1+(input$gamma)*x_ss())})
 v_ll <- reactive({1/(input$gamma)*log(1+(input$gamma)*x_ll())})
 w_ss <- reactive({1/(input$tau)*log(1+(input$tau)*t_ss())})
 w_ll <- reactive({1/(input$tau)*log(1+(input$tau)*t_ll())})
 Q_time <- reactive({((input$kappa)/(input$alpha))*log(1+(input$alpha)*(((w_ll()-w_ss())/(input$vartheta))^(input$vartheta)))})
 Q_value <- reactive({(v_ll()-v_ss())})
 proba_ll <- reactive({(Q_value()^(1/input$epsilon))/((Q_value()^(1/input$epsilon))+(Q_time()^(1/input$epsilon)))})
 choice <- reactive({round(proba_ll(),1)})

 output$ploti <- renderPlot({ 
  
  
  #######necessary functions for all plots#########
  
  tierra <- function(width,position,colorset){
   x <- position[1]
   y <- position[2]
   
   x1 <- x
   x2 <- x+width
   x3 <- x+width
   x4 <- x
   
   y1 <- y
   y2 <- y
   y3 <- y+0.25
   y4 <- y+0.25
   
   polygon(x=c(x1,x2,x3,x4),y=c(y1,y2,y3,y4),col=colorset,border=NA)  
  }
  olala <- function(proportion,width,variable,colorset){
   x <- variable[1]
   y <- variable[2]
   
   x1 <- x
   x2 <- x+proportion*width
   x3 <- x+proportion*width
   x4 <- x
   
   y1 <- y
   y2 <- y
   y3 <- y+0.25
   y4 <- y+0.25
   
   polygon(x=c(x1,x2,x3,x4),y=c(y1,y2,y3,y4),col=colorset,border=NA)
   text(x4+width+0.25,y2+0.1,paste(proportion),cex=1,col=rgb(10,10,10,maxColor=255, alpha=125)) #proportiontext
  }
  ciclo_raw <- function(from,to,dark_color,light_color,medium_color){
   for(k in from:to){
    text(x[k],coorY[k]-0.3,labels=paste(k),col=dark_color,cex=size_question)
    tierra(size_intervals[k],c(coorX[k],coorY[k]),light_color)
    olala(actual_proportion[k],size_intervals[k],c(coorX[k],coorY[k]),dark_color)
   }
  } 
  eje_canti_gran <- function(distance_line,padj_all,size_outcome,size_attribute,size_letter){
   plot(0,type='n', xlim=c(0.5,10.8),ylim=c(17,1),axes=F,xlab='',ylab='')
   axis(3,at=c(1:4,5.5,7:10),
        labels=c('5150','5300','5450','5600','','6050', '6200','6350', '6500'),
        tck=0,cex.axis=size_outcome,col='white',padj=padj_all,col.axis=gray[5])
   axis(3,at=c(1:4,5.5,7:10),
        labels=c('1','2','3','4','','7', '8','9', '10'),
        tck=0,cex.axis=size_attribute,col='white',padj=padj_all-1.8,col.axis=gray[5])
   axis(3,at=c(1:10),labels=(c(LETTERS[1:4],'','',LETTERS[5:8])),
        tck=0.01,cex.axis=size_letter,padj=padj_all-2.8,lwd=1,col=gray[5],col.axis=gray[2],line=distance_line)
  }
  eje_inferior <- function(line_axes){
   axis(1,at=c(1,4,7,10),labels=c('I','J','K','L'),
        line=line_axes-0.5,col='white',col.axis=gray[2],padj=-7,cex.axis=axis_size_letters)
   axis(1,at=c(1,4,7,10),labels=c('1','4','7','10'),
        line=line_axes-1.6,col='white',col.axis=gray[5],padj=-3,cex.axis=axis_size_attribute)
   axis(1,at=c(1,4,7,10),labels=c('1150','1250','1350','1450'),
        line=line_axes,col=gray[5],tck=-0.01,col.axis=gray[5],padj=-4,cex.axis=axis_size_outcome)
  }
  
  
  pretty_scatter <- function(log,title_plot,col_axes,
                              label_x,limit_axis_x,actual_x,
                              label_y,limit_axis_y,actual_y){
   if(log==T){
    plot(0,type='n',xlim=limit_axis_x,ylim=limit_axis_y,xlab='',ylab='',axes=F,log='y')
    mtext(title_plot,3,col=col_axes,line=0)
    axis(1,col=col_axes,col.axis=col_axes,at=actual_x)
    mtext(label_x,1,col=col_axes,line=3)
    axis(2,col=col_axes,col.axis=col_axes,at=actual_y,label=actual_y,las=2)
    mtext(label_y,2,col=col_axes,line=3)
   }
   else{
   plot(0,type='n',xlim=limit_axis_x,ylim=limit_axis_y,xlab='',ylab='',axes=F)
   mtext(title_plot,3,col=col_axes,line=0)
   axis(1,col=col_axes,col.axis=col_axes,at=actual_x)
   mtext(label_x,1,col=col_axes,line=3)
   axis(2,col=col_axes,col.axis=col_axes,at=actual_y,las=2)
   mtext(label_y,2,col=col_axes,line=3)
   }
  }
  
  pretty_points <- function(x,y,points_color){
   points(x,y,col=points_color,cex=2,pch=20)
  }
  the_odds_todos <- function(data,pregu_set,color){
   conjunto <- data[pregu_set] #De donde a donde esta la pregunta de ese set
   conju <- data.frame(conjunto[1]*conjunto[2],
                       conjunto[4],
                       conjunto[2]*conjunto[3],
                       conjunto[5],
                       conjunto[1]*conjunto[2]*conjunto[3],
                       conjunto[1]*conjunto[5],
                       conjunto[4]*conjunto[3],
                       conjunto[6])
   points(c(1:8),conju,col=color,pch=20,type='b')
  }
  
  ######especifications###############
  colores <- list(gray <- c("#6F6F6F37","#6F6F6F64","#6F6F6F96","#6F6F6FC8","#6F6F6FFA"),
                  set1 <- c("#FFA50046","#FFA50096","#FFA500C8"),
                  set2 <- c("#9ACD3246","#9ACD3296","#9ACD32C8"),
                  set3 <- c("#48D1CC46","#48D1CC96","#48D1CCC8"),
                  set4 <- c("#FF818E46","#FF818E96","#FF818EC8"),
                  navy <- c("#1594C546","#1594C596","#1594C5C8"),
                  blue <- c("#79C3F146","#79C3F196","#79C3F1C8"),
                  pur1 <- c("#D07FD819","#D07FD87D","#D07FD8FA"),
                  pur2 <- c("#7571FE19","#7571FE7D","#7571FEFA"))
  size_intervals <- c(1,1,1,2,2,3,
                      1,1,1,2,2,3,
                      3,3,3,6,6,9,
                      3,3,3,6,6,9)
  coorX <- c(1,2,3,1,2,1,
             7,8,9,7,8,7,
             1,4,7,1,4,1,
             1,4,7,1,4,1)
  coorY <- c(1,2,1,3,4,5,
             1,2,1,3,4,5,
             6,7,6,8,9,10,
             13,14,13,15,16,17)  
  x <- c(1.5,2.5,3.5,2,3,2.5,
         7.5,8.5,9.5,8,9,8.5,
         2.5,5.5,8.5,3.5,7.5,5.5,
         2.5,5.5,8.5,4,7,5.5)
 
  axis_size_outcome <- 1
  axis_size_letters <- 0.9
  axis_size_attribute <- 1
  size_question <- 1.2
  actual_proportion <- choice()
  
  
  
  
  
  
  ##########actual plots############
  layout(matrix(c(1,1,2,2,6,6,
                  1,1,2,2,6,6,
                  3,3,4,4,6,6,
                  3,3,4,4,6,6,
                  5,5,7,7,6,6,
                  5,5,7,7,6,6),ncol=6,byrow=T))
  
  pretty_scatter(T,'Value Function',gray[5],
                 'Magnitude',c(1000,7000),seq(1000,7000,1000),
                 'Value',c(0.1,2000),c(0.1,0.2,0.3,1,2,3,10,100,1000,2000))
  pretty_points(x_ss(),v_ss(),navy[1])
  pretty_points(x_ll(),v_ll(),navy[1])
  
  pretty_scatter(T,'Weight Function',gray[5],
                 'Time',c(1,10),seq(1,10,1),
                 'Weight',c(0.1,10),c(0.1,0.2,0.3,1,2,3,10))
  pretty_points(t_ss(),w_ss(),navy[1])
  pretty_points(t_ll(),w_ll(),navy[1])
  
  pretty_scatter(T,'Differences in Value',gray[5],
                 'Difference of each question',c(1,24),seq(1,23,2),
                 'Value of Difference',c(0.1,100),c(0.1,0.2,0.3,1,2,3,10,100))
  pretty_points(c(1:6),Q_value()[c(1:6)],set1[3])
  pretty_points(c(7:12),Q_value()[c(7:12)],set2[3])
  pretty_points(c(13:18),Q_value()[c(13:18)],set3[3])
  pretty_points(c(19:24),Q_value()[c(19:24)],set4[3])
  
  pretty_scatter(T,'Tradeoff Function',gray[5],
                 'Difference of each question',c(1,24),seq(1,23,2),
                 'Value of Difference',c(0.1,100),c(0.1,0.2,0.3,1,2,3,10,100))
  pretty_points(c(1:6),Q_time()[c(1:6)],set1[3])
  pretty_points(c(7:12),Q_time()[c(7:12)],set2[3])
  pretty_points(c(13:18),Q_time()[c(13:18)],set3[3])
  pretty_points(c(19:24),Q_time()[c(19:24)],set4[3])
  
  pretty_scatter(F,'Choice probability',gray[5],
                 'Question',c(1,24),seq(1,23,2),
                 'P(LL)',c(0,1),seq(0,1,0.2))
  pretty_points(c(1:6),proba_ll()[c(1:6)],set1[3])
  pretty_points(c(7:12),proba_ll()[c(7:12)],set2[3])
  pretty_points(c(13:18),proba_ll()[c(13:18)],set3[3])
  pretty_points(c(19:24),proba_ll()[c(19:24)],set4[3])
  
  ######plot tiempo
  par(mar=c(5,1,6,0.5))
  eje_canti_gran(0.5,0.5,axis_size_outcome,axis_size_attribute,axis_size_letters)
  eje_inferior(-17.3)
  mtext('Probability of choosing the LL alternative',3,col=gray[5],line=4.5)
  ciclo_raw(1,6,set1[3],set1[1],set1[2])   
  ciclo_raw(7,12,set2[3],set2[1],set2[2])   
  ciclo_raw(13,18,set3[3],set3[1],set3[2])   
  ciclo_raw(19,24,set4[3],set4[1],set4[2])
  
  proba_si <- proba_ll()
  proba_fra <- 1-proba_si
  momios <- proba_si/proba_fra
  momios <- replace(momios,momios==Inf,10)
  
  par(mar=c(2,4,2,2))
  plot(0.001,type='n',xlim=c(1,8),ylim=c(0.1,1000),axes=F,xlab='',ylab='',log='y')
  axis(1,at=c(1:8),cex.axis=0.8,col=gray[4],col.axis=gray[4],
       labels=c('LM*MS','LS','XL*LM','XM','XL*LM*MS','XM*MS','XL*LS','XS'))
  mtext('Odds',2,col=gray[5],line=3)
  numbers <- c(0.1,1,5,10,100,1000)
  axis(2,at=numbers,labels=paste(numbers),las=2,tck = 0.01,
       col=gray[4],col.axis=gray[4])
  the_odds_todos(momios,1:6,set1[3])
  the_odds_todos(momios,7:12,set2[3])
  the_odds_todos(momios,13:18,set3[3])
  the_odds_todos(momios,19:24,set4[3])
  
 })

}










