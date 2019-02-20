# Machine Learning: Where did this Random Forest come from?

In this session, I'll give an overview of machine learning techniques in general, with an ultimate focus on the random forest method of machine learning.

In the first part of the coding section, we will be working with the randomForest package, so you will need to have that downloaded if you would like to follow along.

In the second half of the coding section, as long as time permits, I'll mix together a tutorial of, [DittoSeq](https://github.com/dtm2451/DittoSeq), my new scRNAseq visualization package, with how I personally used random forest in my scRNAseq project.

DittoSeq is a package that I have been writing in order to make scRNAseq analysis more accessible to novice coders & color-blind indidivuals (like myself).  Downloading this package will be purely optional for my session, though I do hope you will find it useful and give it a try!

## Installation Instructions

```
#randomForest
install.packages("randomForest")

#OPTIONAL: DittoSeq
install.packages("devtools")
devtools::install_github("dtm2451/DittoSeq")

#If you recieve an error for DESeq2 or any dependent package's installation, for example,
> Error: (converted from warning) package ‘DESeq2’ is not available (for R version 3.5.2)
# my installation troubleshooting protocol is this:
BiocManager::install("package")
install.packages("package") # I try both, and normally one will work.
# - Run install.packages("BiocManager") first if you don't have it.  (This is the new version of biocLite().)
# If I get an error due to a package already being loaded into the environment:
#     *Save your files!* Then terminate your R session (Session > Terminate R... at the top), then retry installatino.
```

## Resources:

- A pretty good overview of different forms of machine learning by [MathWorks](https://www.mathworks.com/discovery/machine-learning.html)
- "Ten quick tips for machine learning in computational biology" [Chicco 2017](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5721660/)
- A random forest specific overview / tutorial by the [Oxford Protein Informatics Group](https://www.blopig.com/blog/2017/04/a-very-basic-introduction-to-random-forests-using-r/)

