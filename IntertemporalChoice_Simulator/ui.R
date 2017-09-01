

fluidPage(tabsetPanel(
         tabPanel('simulado',
          h1('Mi primer Shiny app'),
          hr(),
          h2('Hecho por Elena'),
          p('Este es un ejemplo de un parrafo muy largoo'),
          br(),
          p('Este es un',strong('ejemplo'), 'd eun segundo parrafo con error o'),
 #em() code() 
 wellPanel(
 fluidRow(column(4,offset=2, sliderInput(inputId='num',label='Parametro 1',
             min=0.01,max=2,value=1)),
          column(4, sliderInput(inputId='num2',label='Parametro 2',
             min=0.01,max=2,value=1)))),
 
          plotOutput('grafico')),
 tabPanel('Instrucciones',
          
          h1('Aqui solo son las instrucciones'))))
 