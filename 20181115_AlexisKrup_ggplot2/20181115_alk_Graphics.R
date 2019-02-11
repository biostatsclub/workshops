## Graphics with R
## 20181115 Biostats JC, Alexis Leigh Krup
## study guide: https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf 
## https://tinyurl.com/Biostats-181115

## Basic plots.
## What is a plot?
?plot
## pulls up the help window, explains

## Data for base plots.
## These are toy data sets that come included with R studio
## Look at the structure of the data
colnames(mtcars)

## what do the first few lines of the data table look like?
head(mtcars)

## what do the last few lines of the data look like?

tail(mtcars)
tail(mtcars)
str(mtcars)

## Simple Scatterplot
## attach set of R objects to our search path
## attach is so R knows which database to look at when evaluating variables
attach(mtcars)
plot(wt, mpg, main="Scatterplot Example", 
     xlab="Car Weight ", ylab="Miles Per Gallon ", pch=19)

## Add fit lines
abline(lm(mpg~wt), col="red") # regression line (y~x) 
lines(lowess(wt,mpg), col="blue") # lowest line (x,y)

## Simple Bar Plot
## create a variable called counts that is the category "gear" from the database mtcars
counts <- table(mtcars$gear)
head(counts)
## create a barplot of variable counts, main = title, xlab = label of x axis
barplot(counts, main="Car Distribution", 
        xlab="Number of Gears")

## Grouped Bar Plot
## lets pull the variables vs and gear out of the dataset mtcars, and call that counts
counts <- table(mtcars$vs, mtcars$gear)
## make another barplot, put some colors on it, put the two variables beside eachother
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)

## Boxplot of MPG by Car Cylinders 
## make a boxplot comparing mpg relative to cylindars in a car
## using data mtcars, the main title is _____, the xlabel is _____, the y label is _____
boxplot(mpg~cyl,data=mtcars, main="Car Mileage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon")

## The mtcars dataset:
## make mtcars a datamatrix, required for the next exercise
data=as.matrix(mtcars)
## check what it looks like
head(data)
tail(data)
## install a new package called RColorBrewer
install.packages("RColorBrewer")
## call that package into action using library
library(RColorBrewer)
## create a new set of colors
coul = colorRampPalette(brewer.pal(8, "PiYG"))(25)
## visualize the car data using chosen colors
heatmap(data, scale="column", col = coul)

## Simple Pie Chart
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels = lbls, main="Pie Chart of Countries")

## Install package "ggplot2"
install.packages("ggplot2")

## Load the library ggplot2
library(ggplot2)

## Read in "Birth_weight.rda" file, provide in dropbox.
load("/Users/alexiskrup/Dropbox (Gladstone)/BiostatsJC/Birth_weight.rda")
load("~/Desktop/Birth_weight.rda")
## check the structure
head(Birth_weight)

## Plot1: Simple Bar-plot (Showing distribution of baby’s weight)
## plot dataframe Birth_weight, aesthetic properties of the x axis, in the geometry of a bar graph
ggplot(data = Birth_weight,aes(x=baby_wt))+geom_bar()


## Plot: Bar-plot(color variation w.r.t income levels)
ggplot(data = Birth_weight,aes(x=mother_age,fill=income))+geom_bar()

## Plot: Bar-plot (Facet division)
## facets divide a plot into subplots based on values of discrete variables
## here that discrete variable is taken from the smoke column
## historical formula interface calling that variable from the smoke category of the dataframe
## play with different ways of calling the same variable
ggplot(data = Birth_weight,aes(x=mother_age,fill=smoke))+geom_bar()+facet_grid(. ~smoke)
ggplot(data = Birth_weight,aes(x=mother_age,fill=smoke))+geom_bar()+facet_grid(vars(smoke))
ggplot(data = Birth_weight,aes(x=mother_age,fill=smoke))+geom_bar()+facet_grid(cols= vars(smoke))

## Plot: Box-plot
ggplot(data = Birth_weight,aes(x=smoke,y=baby_wt,fill=income))+geom_boxplot()

## Plot: Line-plot
ggplot(data = Birth_weight,aes(x=mother_wt,y=baby_wt))+geom_smooth()

## Plot: Line-plot(Comparison of two line curves)
ggplot(data = Birth_weight,aes(x=mother_wt,y=baby_wt,col=smoke))+geom_smooth()


## UCR reference material
## use a random number generator for this next exercise, choose a number to insure reproducible results 
set.seed(1410)
## coerce a bunch of data called "diamonds" into a data frame
## diamonds is the collection of data, square brackets [] allow us to access specific elements within
dsmall <- as.data.frame(diamonds[sample(nrow(diamonds), 1000), ])
## investigate the look of our new dataframe dsmall
head(dsmall)

## Regression lines, step by step 
ggplot(dsmall, aes(carat, price, group=color))
ggplot(dsmall, aes(carat, price, group=color)) + 
  geom_point(aes(color=color), size=2)
ggplot(dsmall, aes(carat, price, group=color)) + 
  geom_point(aes(color=color), size=3)
ggplot(dsmall, aes(carat, price, group=color)) + 
  geom_point(aes(color=color), size=2) + 
  geom_smooth(aes(color=color), method = "lm", se=FALSE) 

## Several regression lines.
p <- ggplot(dsmall, aes(carat, price, group=color)) + 
  geom_point(aes(color=color), size=2) + 
  geom_smooth(aes(color=color), method = "lm", se=FALSE) 
print(p) 

## Calculate mean values for aggregates given by Species column in iris data set
## Lets look at R's iris data set
head(iris)
## Lets pull just columns 1-4
head(iris[,1:4])
## aggregate to compute summary statistics of data subset
## here: take columns 1 thru 4 of the iris data set, subset them by a list we define from the variable species
## apply the FUN function to compute the summary statistics which can be applied to all datasets, here we compute mean
## call the variable iris_mean
iris_mean <- aggregate(iris[,1:4], by=list(Species=iris$Species), FUN=mean) 

## Calculate standard deviations for aggregates given by Species column in iris data set
iris_sd <- aggregate(iris[,1:4], by=list(Species=iris$Species), FUN=sd) 

## lets make some shapes
install.packages("reshape2")
## you might get something telling you to update R, raise hand if do. More fun to come. 
library(reshape2) # Defines melt function
## apply the melt function of reshape2 package to our data
df_mean <- melt(iris_mean, id.vars=c("Species"), variable.name = "Samples", value.name="Values")

## Reformat iris_sd with melt
df_sd <- melt(iris_sd, id.vars=c("Species"), variable.name = "Samples", value.name="Values")

## Define standard deviation limits
limits <- aes(ymax = df_mean[,"Values"] + df_sd[,"Values"], ymin=df_mean[,"Values"] - df_sd[,"Values"])
## Error in aes(ymax = df_mean[, "Values"] + df_sd[, "Values"], ymin = df_mean[,  : could not find function "aes"

## aes is a property of ggplot2, recall library ggplot2, then try again
library(ggplot2)
limits <- aes(ymax = df_mean[,"Values"] + df_sd[,"Values"], ymin=df_mean[,"Values"] - df_sd[,"Values"])

## Density plots

## Line coloring
p <- ggplot(dsmall, aes(carat)) + geom_density(aes(color = color))
print(p)

## Area coloring
p <- ggplot(dsmall, aes(carat)) + geom_density(aes(fill = color))
print(p)

 
#V# iolin plots
p <- ggplot(dsmall, aes(color, price/carat, fill=color)) + geom_violin()                                                                                                      
print(p)           
## in console saving method:
ggsave("diamonds_violin.png")

## you need to make a poster figure and don't have time for Adobe Illustrator:
pdf("grid_plot.pdf", height = 11, width = 8.5, paper = "letter")
library(grid)
a <- ggplot(dsmall, aes(color, price/carat)) + geom_jitter(size=4, alpha = I(1 / 1.5), aes(color=color))
b <- ggplot(dsmall, aes(color, price/carat, color=color)) + geom_boxplot()
c <- ggplot(dsmall, aes(color, price/carat, fill=color)) + geom_boxplot() + theme(legend.position = "none")
grid.newpage() # Open a new page on grid device
pushViewport(viewport(layout = grid.layout(2, 2))) # Assign to device viewport with 2 by 2 grid layout 
print(a, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
print(b, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(c, vp = viewport(layout.pos.row = 2, layout.pos.col = 2, width=0.3, height=0.3, x=0.8, y=0.8))
## Stop writing to the PDF file
dev.off()
## check your Files tab, do you see the pdf file?



