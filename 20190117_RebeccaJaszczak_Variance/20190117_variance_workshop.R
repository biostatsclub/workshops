#never reinvent the wheel: portions of this code inspired by https://www.r-bloggers.com/standard-deviation-vs-standard-error/

# Exercise 1 - comparing sd and sem with different plots and different N ####
#generate some random data
set.seed(20190117) 
data_10 = rnorm(10)
data_50 = rnorm(50)
data_100 = rnorm(100)
data_1000 = rnorm(1000)

#tell r to plot four graphs in the same plot for comparison
par(mfrow = c(1, 4))

#visualize our random data with a histogram
hist(data_10, main = "N of 10")
hist(data_50, main = "N of 50")
hist(data_100, main = "N of 100")
hist(data_1000, main = "N of 1000")

#visualize the datasets with a dot plot
plot(data_10, main = "N of 10", ylim = c(-5,5))
plot(data_50, main = "N of 50", ylim = c(-5,5))
plot(data_100, main = "N of 100", ylim = c(-5,5))
plot(data_1000, main = "N of 1000", ylim = c(-5,5))

#visualize the datasets with a box plot
boxplot(data_10, main = "N of 10", ylim = c(-5,5))
boxplot(data_50, main = "N of 50", ylim = c(-5,5))
boxplot(data_100, main = "N of 100", ylim = c(-5,5))
boxplot(data_1000, main = "N of 1000", ylim = c(-5,5))

#what can we observe about increasing values in our datasets?

#view standard deviation for each of the datasets
?sd
sd(data_10)
sd(data_50)
sd(data_100)
sd(data_1000)
#how does our ability to determine sd change as N increases?

#make a standard error of the mean function
sem = function(dataset){
  sd(dataset)/sqrt(length(dataset))
}

#view standard error for each of the datasets
sem(data_10)
sem(data_50)
sem(data_100)
sem(data_1000)
#how does our ability to determine sem change as N increases?

# Exercise 2 - applying learned concepts to R sample dataset mtcars ####
#portions of this code inspired by https://datascienceplus.com/building-barplots-with-error-bars/

head(mtcars)
# let's find the mean miles per gallon by number of cylinders and number of gears from this car dataset

#aggregating our data by cylinders and gears
#return the mean, standard deviation, and number of observations for each group
mtcars_examples = aggregate(mtcars$mpg, 
                             by = list(cyl = mtcars$cyl, gears = mtcars$gear),
                             FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x)))

#convert the returned matrices into a data frame
mtcars_examples = do.call(data.frame, mtcars_examples)

#add sem add this statistic to our dataframe
mtcars_examples$sem = mtcars_examples$x.sd / sqrt(mtcars_examples$x.n)

#clean up names and add a column for cylinder/gear combo
colnames(mtcars_examples) = c("cyl", "gears", "mean", "sd", "n", "sem")
mtcars_examples$names = paste(mtcars_examples$cyl, "cyl /", mtcars_examples$gears, " gear")
mtcars_examples

install.packages("ggplot2")
library(ggplot2)

dodge = position_dodge(width = 0.9)
limits = aes(ymax = mtcars_examples$mean + mtcars_examples$se,
            ymin = mtcars_examples$mean - mtcars_examples$se)

mtcars_plot = ggplot(data = mtcars_examples, aes(x = names, y = mean, fill = names))

mtcars_plot + geom_bar(stat = "identity", position = dodge) +
  geom_errorbar(limits, position = dodge, width = 0.25) +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
        axis.title.x=element_blank())

mtcars_plot = ggplot(data = mtcars_examples, aes(x = factor(cyl), y = mean, fill = factor(gears)))

limits <- aes(ymax = mtcars_examples$mean + mtcars_examples$se,
              ymin = mtcars_examples$mean - mtcars_examples$se)

mtcars_plot <- ggplot(data = mtcars_examples, aes(x = factor(cyl), y = mean, fill = factor(gears)))

mtcars_plot + 
  theme_classic() +
  geom_bar(stat = "identity", position = position_dodge(0.9)) +
  geom_errorbar(limits, position = position_dodge(0.9), width = 0.25) +
  labs(x = "No. Cylinders", y = "Miles Per Gallon") +
  ggtitle("Mileage by No. Cylinders and No. Gears") +
  scale_fill_discrete(name = "No. Gears")

#if time, can crowdsource ideas for making this graph prettier, re Alexis' workshop from a few weeks ago (: