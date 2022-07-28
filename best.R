#Finding the best hospital in a state.

best <- function(state, outcome){
  ##All outcomes
  
  outcomes = c("heart attack", "heart failure", "pneumonia")
  
  ##check validity of outcome
  
  if(outcome %in% outcomes == FALSE){
    stop("invalid outcome")
  }
  #read data
  
  get_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #columns of interest
  #Hospital Name, State, Heart Attack, Heart Failure, Pneumonia
  
  get_data <- get_data[c(2, 7, 11, 17, 23)]
  names(get_data)[1] <- "name"
  names(get_data)[2] <- "state"
  names(get_data)[3] <- "heart attack"
  names(get_data)[4] <- "heart failure"
  names(get_data)[5] <- "pneumonia"
  #Get vector of all states
  
  states <- get_data[,"state"]
  states <- unique(states)
  if(state %in% states == FALSE){
    stop("invalid state")
  }
  
  data <- get_data[get_data$state == state & get_data[outcome] != 'Not Available',]
  vals <- data[,outcome]
  
  #return minimum value
  rownum <- which.min(vals)
  
  ##return hospital name
  data[rownum,]$name
  
}

best("AL", "pneumonia")
