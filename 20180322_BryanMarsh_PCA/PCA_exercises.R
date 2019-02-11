############################### R Resources #################################

##### swirl - swirl teaches you R programming and data science interactively,
##### at your own pace, and right in the R console

# http://swirlstats.com/students.html

install.packages("swirl") ##install swirl
library("swirl") ##load swirl
swirl() ##begin swirl

#####  Rstudio Cheat Sheets

# https://www.rstudio.com/resources/cheatsheets/  some useful ones are:
    # Data Import Cheat Sheet
    # Data Transformation Cheat Sheet
    # R Markdown Cheat Sheet - integrates code and output into html or pdf file
    # Data Visualization Cheat Sheet
    # And many more!



########################### Start of exercise #########################

set.seed(2)             #sets the seed for random number generation.
x <- 1:100              #creates a vector x with numbers from 1 to 100
ex <- rnorm(100, 0, 30) #100 normally distributed rand. nos. w/ mean=0, s.d.=30
ey <- rnorm(100, 0, 30) # " " 
y <- 30 + 2 * x         #sets y to be a vector that is a linear function of x
x_obs <- x + ex         #adds "noise" to x
y_obs <- y + ey         #adds "noise" to y
P <- cbind(x_obs,y_obs) #places points in matrix
plot(P,asp=1,col=1) #plot points
points(mean(x_obs),mean(y_obs),col=3, pch=19) #show center

pca <- prcomp(P,scale=T)
summary(pca)
### Full example (and a hell of a lot of math at - https://liorpachter.wordpress.com/tag/jeopardy/)

### What percent variance is explained by PC1? How about PC2?


### Read in the table of gene expression

exp <- read.table("/Users/bryanmarsh1/Downloads/expression.csv", header = TRUE, sep = ",")

# What do the rows and columns represent?

# Assign the sample names in column "X" as rownames
rownames(exp) <- exp$X

# View exp now - what might still be an issue? Remove column "X" (Hint matrices are Rows x Columns)
exp <- exp[, -1]

# Now we have a dataset we are ready to work with!

# We need to scale the data
exp.stand <- as.data.frame(scale(exp))

# Now run the pca analysis using the prcomp()
pca <- prcomp(exp.stand,scale = T) ##run pca
summary(pca) ##show proportion of variance

screeplot(pca, type = "lines")

install.packages("ggfortify")
library(ggfortify)

autoplot(prcomp(exp.stand))

# Great, but what are my samples??
autoplot(prcomp(exp.stand), data = exp.stand, label = TRUE)

# There are dots in the way!
autoplot(prcomp(exp.stand), data = exp.stand, label = TRUE, shape = FALSE)

# That's cool but I'm super mathematically inclined and NEED to see the eigen vectors
autoplot(prcomp(exp.stand), data = exp.stand, label = TRUE, shape = FALSE, loadings = TRUE)

#### Plotting info from here - https://cran.r-project.org/web/packages/ggfortify/vignettes/plot_pca.html

