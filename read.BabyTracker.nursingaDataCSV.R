read.BabyTracker.nursingDataCSV <- function(filePath) {
  nursingData <- read.csv(filePath)
  
  # Calculate Start time as POSIXct  
  nursingData$DateTimeStart = with(nursingData, as.POSIXct(Time, format="%m/%d/%y, %I:%M %p", tz="GMT"))
  
  # Calculate End time from start time and duration 
  duration <- nursingData$Left.duration + nursingData$Right.duration + nursingData$Total.Duration
  nursingData$DateTimeEnd = nursingData$DateTimeStart + (duration * 60)
  
  # Relabel status as activity 
  nursingData$Activity <- "Feeding"
  
  return (subset(nursingData, select = c("Activity", "DateTimeStart", "DateTimeEnd")))
}