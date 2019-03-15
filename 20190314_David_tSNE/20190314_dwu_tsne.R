#install.packages(c('tidyverse', 'Rtsne', 'umap', 'tictoc', 'devtools'))
#devtools::install_github("thomasp85/patchwork")

library(tidyverse)
library(Rtsne)
library(umap)
library(tictoc)
library(patchwork)


# THE CURSE OF DIMENSIONALITY

# Function to generate an n-dimensional sphere
generate_nsphere <- function(dimensions, points = 1e4, radius = 1) {
  coordinates <- runif(points * dimensions, min = -radius, max = radius) %>% matrix(ncol = dimensions)
  
  map_dfr((1:points), function(row) {
    coordinates_subset <- as_tibble(t(coordinates[row,]))
    colnames(coordinates_subset) <- paste0('dim', 1:dimensions)
    distance <- sqrt(sum(coordinates[row, ] ^ 2))
    coordinates_subset %>% mutate('distance' = distance) %>% filter(distance <= radius)
  })
  
}

distance_histogram <- function(nsphere) {
  nsphere %>% ggplot(aes(x = distance)) + geom_histogram() + geom_vline(xintercept = quantile(nsphere$distance, probs = 0.5), linetype = 'dashed', color = 'red')
}

distance_ecdf <- function(nsphere) {
  nsphere %>% ggplot(aes(x = distance)) + stat_ecdf(geom = 'step') + geom_vline(xintercept = quantile(nsphere$distance, probs = 0.5), linetype = 'dashed', color = 'red')
}

plot_nsphere <- function(nsphere, dim1 = 1, dim2 = 2) {
  nsphere <- nsphere[,c(dim1, dim2)]
  colnames(nsphere) <- c('x', 'y')
  ggplot(nsphere, aes(x = x, y = y)) + geom_point(alpha = 0.5) + coord_equal() + xlab(paste('dim', dim1)) + ylab(paste('dim', dim2))
}

# Start in 2D. If you distributed points uniformly in a 2D space (a circle), where are most of them?
d2 <- generate_nsphere(2) 
d2 %>% plot_nsphere()

d3 <- generate_nsphere(3) 
d3 %>% plot_nsphere(dim1 = 1, dim2 = 2)
d3 %>% plot_nsphere(dim1 = 2, dim2 = 3)

d2 %>% distance_histogram()
d3 %>% distance_histogram()

d2 %>% distance_ecdf()
d3 %>% distance_ecdf()

d5 <- generate_nsphere(10, points = 1e6)
d5 %>% distance_histogram()
d5 %>% distance_ecdf()

#### t-SNE

data <- read_csv('example_data.csv')

plot_tsne <- function(tsne) {
  as_tibble(tsne$Y) %>% ggplot(aes(x = V1, y = V2)) + geom_point(alpha = 0.5) 
}

tic()
tsne <- Rtsne(X = data, perplexity = 5)
toc()

tsne %>% plot_tsne()

# Play with perplexity

cells <- 1:500
pcs <- 1:10

subset <- data[cells, pcs]
(perplexities <- seq(1, 50, by = 5))

perplexity_test <- map(perplexities, function(p) {
  Rtsne(X = subset, perplexity = p)
})

map(perplexity_test, function(tsne) {
  tsne %>% plot_tsne() + ggtitle(paste0('Perplexity: ', tsne$perplexity))
}) %>% wrap_plots()

# Try adjusting other parameters the same way!