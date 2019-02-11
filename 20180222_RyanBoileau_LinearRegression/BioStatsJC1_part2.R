#Let's import some real data, courtesy of Bryan Marsh
#Ensure the workspace is in the same directory as the "scRNAseq_PerCellStats.txt"
#getwd()
#setwd()


#Alternatively, specify the directory where the file is i.e. "Users/HingleMcCringleBerry/Desktop/scRNAseq_PerCellStats.txt"
#Read the file into a data frame using read.table() function. read.table("filename", header = TRUE)


#Sneak peek at the data using head(DATAFRAME) function


#Using a dataframe gives us some unique commands, one is to use DATAFRAME$columnheader to select all the data under a named column
#For example g$NUM_GENES selects all the data from dataframe g under the NUM_GENES column 
#Create variables for the numerical values in dataframe, there are three


#Now that you've created variables with each of the columns, let's use them for linear regression. 
#use lm() and summary() to look at number of reads versus numbers of transcripts or genes


#What do you notice about the statistics in the summary? 
#Numbers look alright, but let's plot it now and add the regression line


#does this look like a linear regression? why might this make sense for the biology behind the data?
#add on the other regression to the same plot

