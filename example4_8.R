# @knitr echo=FALSE
opts_chunk$set(tidy=FALSE, comment=NA)

#'Model of R&D Expenditures
#'=========================
#'Example 4.8 (Wooldridge, 2013)
#'------------------------------
#'
#'By Stefan Bache, January 2013.
#'
#'---
#'This example replicates Example 4.8 (Wooldridge, 2013)
#'which illustrates a linear regression model and 
#'confidence intervals. It uses a data set accompanying
#'the book, "RDCHEM.raw", where column names are 
#'added (found in "RDCHEM.des").
#'
#'**Disclaimer**: this file is used for 
#'teaching purposes in class and is intended for nothing else.  
#'
#'---
#'
#'We begin by loading the data file:
rdchem <- read.table(
   file       = "RDCHEM.raw"
  ,header     = TRUE
  ,na.strings = "."
)

#'To *loosely* inspect the data, and to verify that
#'the variables appear as you expect you might use
#'the *summary* function, which is pretty verbose.
#'Alternatively, try the *str* function (think *structure*):
str(rdchem)

#'In the current data set there are no missing values,
#'but you should make sure to be aware of missings and
#'correctly specify the *na.strings* argument when 
#'using *read.table*.
#'
#'Next, we use the *lm* function (think *linear model*)
#'to fit the regression model. The quick way:
rd.reg <- lm(
   formula = log(rd) ~ log(sales) + profmarg 
  ,data    = rdchem
)

rd.sum <- summary(rd.reg)

#'The first call makes the initial fit, but does not 
#'e.g. compute standard errors. The call to *summary*
#'creates an object with this kind of information:
rd.sum

#'There are a few alternatives when using *lm*. Above,
#'we used functions directly in the formula. While this
#'is possible, and in most cases fine, there are cases
#'where this can cause trouble in subsequent use of the 
#'resulting object. Another approach is to either 
#'create the variables first:
rdchem <- transform(rdchem,
   log.rd    = log(rd)
  ,log.sales = log(sales)                   
)

rd.reg <- lm(
   formula = log.rd ~ log.sales + profmarg
  ,data    = rdchem
)

#'If the variables are never needed subsequently
#'another possibility is to create them for the *data*
#'argument of the *lm* function:
rd.reg <- lm(
   formula   = log.rd ~ log.sales + profmarg
  ,data      = transform(rdchem
  ,log.rd    = log(rd)
  ,log.sales = log(sales))
)
#'The transformed variables actually already 
#'exist in the data set (with other names)
#'but, we might not always be that fortunate.

#'
#'The confidence intervals reported in the example
#'can be computed using the *confint* function
#'(which optionally takes the *level* as argument;
#'the default is 0.95):
rd.ci <- confint(rd.reg)
rd.ci

#'References
#'---
#'Wooldridge, Jeffrey, M. 2013. Introductory Econometrics: A Modern Approach.
#'5th edition (International Edition), South-Western Cengage Learning.

