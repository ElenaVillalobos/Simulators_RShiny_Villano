
library('shiny')
library('rsconnect')


fluidPage(title='Trade-off Model',
 tabsetPanel(
  tabPanel(title='Simulator',
           
          titlePanel('Simulator for the Trade-off Model'),
          h6('See the Instructions tab above',style="color: #6F6F6F"),
          hr(),
          fluidRow(
                   column(3,h4('by Elena Villalobos Nolasco',style="color: #6F6F6F")),
                   column(3,h5('E-mail:',a(href='villaele14@gmail.com','villaele14@gmail.com'),style="color: #6F6F6F")),
                   column(3,h5('Git:',a(href='https://github.com/VillanoEle','github.com/VillanoEle'),style="color: #6F6F6F")),
                   column(3,h5('Labwebpage:',a(href='https://bouzaslab25.github.io/','Lab25.'),style="color: #6F6F6F"))),
          hr(),
   fluidRow(
   column(3,
 wellPanel(
          sliderInput(inputId= "tau",label = p("Weight function (", em('\u03C4'), ')') ,
                      value = 0.001, min=0.001,max=5,sep=0.01),
          sliderInput(inputId= "gamma",label = p("Value Function (", em('\u03B3'), ')') ,
                      value = 0.03,min=0.001,max=5,sep=0.01),
          sliderInput(inputId= "kappa",label = p("Tradeoff function (", em('\u03BA'), ')') ,
                      value = 2.5,min=0.01,max=5,sep=0.01),
          sliderInput(inputId= "vartheta",label = p("Tradeoff function/Superadditivity (", em('\u03D1'), ')') ,
                      value = 2.5, min=1.01, max=10,sep=0.01),
          sliderInput( inputId= "alpha",label = p("Tradeoff function/Subadditivity (", em('\u03B1'), ')') ,
                       value = 5,min=0.01,max=10,sep=0.01))),
   column(8,  plotOutput("ploti",width = "900px",height="600px")))),
 tabPanel(title='Instructions',
          titlePanel('Instructions for the Trade-off Simulator'),
          p('This shinyapp was created to show how the Trade-off Model of',
            a(href='http://onlinelibrary.wiley.com/doi/10.1111/cogs.12104/epdf',
                  'Scholten, Read & Sanborn (2014)'), 'works.'),
          h3('Structure'),
          p(strong('1.'), 'The mathematical model is fully displayed in the Equations tab.'),
          p(strong('2.'), 'The Simulator tab is divided in three main parts:'),
          p(strong('2.1.'), 'The left side shows the parameters that you might want to play with.'),
          p(strong('2.2.'), 'The central part has five plots, each one is representing a function 
            from the model.'),
          p(strong('2.3.'), 'The right part is a graphic that represents the choice probability 
            for the larger later reward given certain parameter values. The experimental design
            is based on the second study of Scholten et al (2014). The graphic consists in 
            12 fixed alternatives. The combinations of these created 24 questions which are 
            classified in 4 sets, 6 questions each:',
            
            tags$ol(
            tags$li('Short Delays',style="color: #FFA500"),
            tags$li('Long Delays',style="color: #9ACD32"),
            tags$li('Long intervals',style="color: #48D1CC"),
            tags$li('Small outcomes, long intervals',style='color: #FF818E')), 
           
            'In this graphic, each bar represents a question, the leftmost end indicates
            the smaller reward, and the rightmost end the larger reward. The alternatives
            are indicated in the superior axis (noting that for the fourth set there are 
            small outcomes). The darkness of the bar represents the choice probability for 
            the larger later reward given certain parameter values. For example, if the 
            model predicts that the larger reward might be chosen with 0.8 of probability, 
            the the bar will be darker 8/10.'),
          p(strong('3.'),'I recommend you to check specifically the following parameter 
            combinations in order to observe empirical phenomena:',
            
            tags$ul(
             tags$li('Superadditivity:',  em('\u03C4'), '= 0.001,', em('\u03B3'), '= 2,   ',em('\u03BA'),'= 2,   ', em('\u03D1'), '= 5.5, ',em('\u03B1'), '= 0.01.'),
             tags$li('Subadditivity:',    em('\u03C4'), '= 0.001,', em('\u03B3'), '= 0.1, ',em('\u03BA'),'= 1.26,', em('\u03D1'), '= 1.1, ',em('\u03B1'), '= 7.'),
             tags$li('Magnitude Effect:', em('\u03C4'), '= 2.5,  ', em('\u03B3'), '= 0.2, ',em('\u03BA'),'= 0.16,', em('\u03D1'), '= 1.01,',em('\u03B1'), '= 0.1.'),
             tags$li('Immediacy Effect:', em('\u03C4'), '= 0.14, ', em('\u03B3'), '= 1.15,',em('\u03BA'),'= 3,   ', em('\u03D1'), '= 1.1, ',em('\u03B1'), '= 0.1.'))),
          
          h3('Some background'),
            p(strong('Superaddivity:'), 'Less discounting over an undivided interval than over 
            a subdivided one, i.e. to choose the larger later reward over subintervals
            but the smaller sooner over undivided intervals.'),
            p(strong('Subadditivity:'), 'More discounting over an undivided interval than over 
            a subdivided one, i.e. to choose the larger later reward over undivided intervals
            but the smaller sooner over subintervals.'),
            p(strong('Magnitude effect:'), 'Smaller outcomes discounted at a higher rate than
            larger ones, i.e. to choose the larger later rewards when the alternatives
            are too large.'),
            p(strong('Immediacy effect:'), 'Overweighting of immediate consump,
            i.e. to choose the immediate but smaller reward over a larger but later reward.')
           
          ),
            
         #como le das poco peso a los intervalos eliges la grande demorada
 tabPanel(title='Equations',
          titlePanel('Equations'),
          
  wellPanel(
  fluidRow(column(2),column(4,withMathJax('Value function: 
                                 $$v(x_{s,l})=\\frac{1}{\\gamma}\\cdot\\log(1+\\gamma\\cdot x_{s,l})$$')),
           column(1),
           column(3,p(em('\u03B3'), '= Diminishing absolute sensitivity to outcomes;'),
                    p(em('x'),'= Outcome [',em('s'), 'smaller,', em('l'), 'larger ].'))),
  fluidRow(column(2),column(4,withMathJax('Weight function: 
                                 $$w(t_{s,l})=\\frac{1}{\\tau}\\cdot\\log(1+\\tau\\cdot t_{s,l})$$')),
           column(1),
           column(3,p(em('\u03C4'), '= Diminishing absolute sensitivity to delays;'),
                  p(em('t'),'= Delay [', em('s'), 'sooner,', em('l'), 'later ].'))),
  fluidRow(column(2),column(4,withMathJax('Difference in values: 
                                 $$A(x_s,x_l)=v(x_l)-v(x_s)$$'))),
  fluidRow(column(2),column(4,withMathJax('Trade-off function: 
                                 $$Q(t_s,t_l)=\\frac{\\kappa}{\\alpha}\\cdot\\log 
                                 \\left( 1+\\alpha\\cdot \\left(\\frac{w(t_l)-w(t_s)}{\\vartheta}\\right)
                                 ^\\vartheta \\right)$$')),
           column(1),
           column(3,p(em('\u03BA'), '= Time sensitivity;'),
                    p(em('\u03D1'), '= Superadditivity;'),
                    p(em('\u03B1'), '= Subadditivity.'))),
  fluidRow(column(2),column(4,withMathJax('Probability assigment for the larger later alternative:
                                 $$P(ll)=\\frac{A(x_s,x_l)}{A(x_s,x_l)-Q(t_s,t_l)}$$')))

  ))))










