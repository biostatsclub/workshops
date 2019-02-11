## Biostatistics Journal Club
## Analyses of Variance
## Alexis Leigh Krup, 20180510


## Practical Exercise #1, Dependent t-Test
## https://www.r-bloggers.com/paired-students-t-test/
## To examine effect of training program on performance 
## Comparison or runners' times before training and after training 

preTraining = c(12.9, 13.5, 12.8, 15.6, 17.2, 19.2, 12.6, 15.3, 14.4, 11.3)
postTraining = c(12.7, 13.6, 12.0, 15.2, 16.8, 20.0, 12.0, 15.9, 16.0, 11.1)

t.test(preTraining,postTraining, paired=TRUE)

## Conclusion: The p-value is greater than 0.05, then we can accept the hypothesis H0 of equality of the averages. 
## In conclusion, the new training has not made any significant improvement 
## (or deterioration) to the team of athletes.



## Practical Exercise #2, One-Way ANOVA
## http://www.stat.columbia.edu/~martin/W2024/R3.pdf
## To examine the effects of different migraine drugs on pain relief
## To make side-by-side boxplots of the variable pain grouped by the variable drug 
## we must first read in the data into the appropriate format.
pain = c(4, 5, 4, 3, 2, 4, 3, 4, 4, 6, 8, 4, 5, 4, 6, 5, 8, 6, 6, 7, 6, 6, 7, 5, 6, 5, 5)
drug = c(rep("A",9), rep("B",9), rep("C",9))
migraine = data.frame(pain,drug)

## Note the command rep("A",9) constructs a list of nine A‟s in a row. The variable
## drug is therefore a list of length 27 consisting of nine A‟s followed by nine B‟s
## followed by nine C‟s.

## Print the data frame for migraine to check it is in correct format for boxplots and ANOVA
migraine

## Make boxplots
plot(pain ~ drug, data=migraine)
## From the boxplots it appears that the mean pain for drug A is lower than that for drugs B and C.

## R function aov() can be used for fitting ANOVA models. The general form is
## aov(response ~ factor, data=data_name)
results = aov(pain ~ drug, data=migraine)
summary(results)

## Studying the output of the ANOVA table above we see that the F-statistic is 11.91 
## with a p-value equal to 0.0003. 
## F = tells you if a group of variables are jointly significant
## Df = degrees of freedom = # of independently variable factors affecting 
## range of states in which a system may exist
## PR(>F) = p value for the effect of the classification variable on response
## Typically, p-values are assessed as follows:
## p > 3/10 :	No	evidence of an effect
## 3/10 > p > 1/10 :	Not much	"
## 1/10 > p > 1/20 :	Weak	"
## 1/20 > p > 1/100:	Appreciable	"
## 1/100 > p :	Strong
## residuals =  amount of variability in a dependent variable (DV) that is "left over" 
## after accounting for the variability explained by the predictors in your analysis 
## (often a regression) 
## We clearly reject the null hypothesis of equal means for all three drug groups.


## Practical Exercise #3, MANOVA
## https://rpubs.com/aaronsc32/manova 
## Four Dependent Variables:
## trunk girth at four years (mm × 100)
## extension growth at four years (m)
## trunk girth at 15 years (mm × 100)
## weight of tree above ground at 15 years (lb × 1000)
setwd("~/Desktop/") 
root <- read.table('T6_2_ROOT.DAT', col.names = c('Tree.Number', 'Trunk.Girth.4.Years', 'Ext.Growth.4.Years', 'Trunk.Girth.15.Years', 'Weight.Above.Ground.15.Years'))

root$Tree.Number <- as.factor(root$Tree.Number)

## "manova()" function accepts formula argument with dependent variables
## formatted as a matrix and the grouping factor on the right of "~"
dependent.vars <- cbind(root$Trunk.Girth.4.Years, root$Ext.Growth.4.Years, 
                        root$Trunk.Girth.15.Years, root$Weight.Above.Ground.15.Years)

##Perform MANOVA to output a summary of the results
root.manova <- summary(manova(dependent.vars ~ root$Tree.Number))
root.manova

## Reading the table:
## Pillai's trace statistic = MANOVA or MANCOVA analysis, increasing value = effects contribute more to model
## Reject null hypothesis: there are significant differences in means
## Fact Check: test each variable individually with an ANOVA test

## MANOVA is complicated! 
## Go here to prove the math to yourself: https://rpubs.com/aaronsc32/manova 





