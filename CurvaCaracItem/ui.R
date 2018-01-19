

fluidPage(

           h2('Curva Característica del Item CCI',style="color: #6F6F6F"),
           hr(),
           withMathJax('$$f_j(\\theta_i)=c_j+(1-c_j)\\frac{1}{1+e ^ {-a_j(\\theta_i-b_j)}}$$'),
           plotOutput('grafico'),
           br(),
           fluidRow(
            column(4,
                   h4('Dificultad (b)'),
                   sliderInput(inputId='beta',label='Item 1 (b)',
                               min=0,max=10,value=0),
                   sliderInput(inputId='beta_2',label='Item 2 (b)',
                               min=0,max=10,value=2)
                   ),
            column(4,
                   h4('Discriminación (a)'),
                   sliderInput(inputId='alpha',label='Item 1 (a)',
                               min=-5,max=5,value=1),
                   sliderInput(inputId='alpha_2',label='Item 2 (a)',
                               min=-5,max=5,value=1)),
            column(4,
                   h4('Adivinación (c)'),
                   sliderInput(inputId='ce',label='Item 1 (c)',
                               min=0,max=1,value=0),
                   sliderInput(inputId='ce_2',label='Item 2 (c)',
                               min=0,max=1,value=0))

       ),
       hr(),
       fluidRow(#column(2,offset=4,h6('Por Elena Villalobos',style="color: #6F6F6F")),
                column(2,offset=5,h6(a(href='https://github.com/VillanoEle','github.com/VillanoEle'),style="color: #6F6F6F"))))
       

 