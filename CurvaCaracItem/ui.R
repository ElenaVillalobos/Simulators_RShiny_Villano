

fluidPage(
 tabsetPanel(
  tabPanel('Gráficos',
           h1('Curva Característica del Item CCI',style="color: #6F6F6F"),
           h5('Por Elena Villalobos',style="color: #6F6F6F"),
           hr(),
           plotOutput('grafico'),
           br(),
           fluidRow(
            column(4,
                   h4('Dificultad'),
                   sliderInput(inputId='beta',label='b',
                               min=0,max=10,value=0)),
            column(4,
                   h4('Discriminación'),
                   sliderInput(inputId='alpha',label='a',
                               min=-5,max=5,value=1)),
            column(4,
                   h4('Adivinación'),
                   sliderInput(inputId='ce',label='c',
                               min=0,max=1,value=0))
                           )
           )
       )
 )
 