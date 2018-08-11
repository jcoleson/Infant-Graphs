read.BabyTracker.diaperDataCSV <- function(filePath) {
  diaperData <- read.csv(filePath)
  
  # Calculate Start time as POSIXct  
  diaperData$DateTimeStart = with(diaperData, as.POSIXct(Time, format="%m/%d/%y, %I:%M %p", tz="GMT"))
  
  # Calculate End time from start time and duration 
  diaperData$DateTimeEnd = diaperData$DateTimeStart + (1 * 60)
  
  # Relabel status as activity 
  diaperData$Activity <- diaperData$Status
  
  return (subset(diaperData, select = c("Activity", "DateTimeStart", "DateTimeEnd")))
}