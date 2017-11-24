

fluidPage(
 tabsetPanel(
  tabPanel('Gráficos',
           h1('Modelos en Descuento Temporal',style="color: #6F6F6F"),
           h5('Por Elena Villalobos',style="color: #6F6F6F"),
           hr(),
           plotOutput('grafico'),
           br(),
           fluidRow(
            column(4,
                   h4('Exponencial'),
                   sliderInput(inputId='exp',label='Beta',
                               min=0.01,max=1,value=0.2)),
            column(4,
                   h4('Hiperbólica'),
                   sliderInput(inputId='hiper_k',label='Kappa',
                               min=0.01,max=1,value=0.2)),
            column(4,
                   h4('Función Generalizada'),
                   sliderInput(inputId='cuasi_k',label='Beta',
                               min=0.01,max=1,value=0.2),
                   sliderInput(inputId='cuasi_s',label='Tau',
                               min=0.01,max=1,value=0.4))
                           )
           ),
  tabPanel('Instrucciones',
           h1('Modelos en Descuento Temporal',style="color: #6F6F6F"),
           h5('Por Elena Villalobos',style="color: #6F6F6F"),
           hr(),
           p('En descuento temporal existen tres principales funciones que describen
             el descuento del valor subjetivo. '),
           tags$ol(
            tags$li('Exponencial',withMathJax('$$V=A\\cdot e ^ {-\\beta\\cdot t}$$')),
            tags$li('Hiperbólica',withMathJax('$$V=\\frac{A}{1+\\kappa \\cdot t}$$')),
            tags$li('Hiperboloide',withMathJax('$$V=A\\cdot e ^ {-\\beta\\cdot t}$$'))
            )
           )
  )
 )
 