read.BabyTracker.formulaDataCSV <- function(filePath) {
  formulaData <- read.csv(filePath)
  
  # Calculate Start time as POSIXct  
  formulaData$DateTimeStart = with(formulaData, as.POSIXct(Time, format="%m/%d/%y, %I:%M %p", tz="GMT"))
  
  # Calculate End time from start time and duration 
  formulaData$DateTimeEnd = formulaData$DateTimeStart + (5 * 60)
  
  # Relabel status as activity 
  formulaData$Activity <- "Feeding"
  
  return (subset(formulaData, select = c("Activity", "DateTimeStart", "DateTimeEnd")))
}