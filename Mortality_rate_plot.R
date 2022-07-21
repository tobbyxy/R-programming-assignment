#Plot the 30-day mortality rates for heart attack


#read the outcome 
outcome <- read.csv("./outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

#make simple histogram of outcome
outcome[, 11] <- as.numeric(outcome[,11])

hist(outcome[,11])
