

fluidPage(
 tabsetPanel(
  tabPanel('Gráficos',
           h1('Modelos de Utilidad',style="color: #6F6F6F"),
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
           h1('Modelos de Utilidad',style="color: #6F6F6F"),
           h5('Por Elena Villalobos',style="color: #6F6F6F"),
           hr(),
           p('La utilidad es... '),
           tags$ol(
            tags$li('Utilidad Esperada',withMathJax('$$V(x,p) = p\\cdot x $$')),
            tags$li('Utilidad de Teoría del prospecto',withMathJax('$$V(x,p)= w(p)\\cdot v(x)$$')),
            tags$li('Valor relativo',withMathJax('$$v(x)= \\Bigg \\{ \\begin{matrix} 
                                                 x^\\alpha \\; for \\; x \\ge 0 
                                                 \\\\
                                                 -\\lambda(-x)^\\beta \\; for \\; x < 0
                                                 \\end{matrix} $$')),
            tags$li('Peso de decision',withMathJax('$$w(p)=\\frac{\\delta \\cdot p^\\gamma}{\\delta \\cdot p^\\gamma + (1-p)^\\gamma}$$'))
       
            )
           )
  )
 )
 