read.BabyTracker.sleepDataCSV <- function(filePath) {
  sleepData <- read.csv(filePath)
  
  # Calculate Start time as POSIXct  
  sleepData$DateTimeStart = with(sleepData, as.POSIXct(Time, format="%m/%d/%y, %I:%M %p", tz="GMT"))
  
  # Calculate End time from start time and duration 
  sleepData$DateTimeEnd = sleepData$DateTimeStart + (sleepData$Duration.minutes. * 60)
  
  
  # Precalucate the date of the start and end of the sleep period
  sleepData$dayStart =  as.Date(sleepData$DateTimeStart, tz="GMT")
  sleepData$dayEnd =  as.Date(sleepData$DateTimeEnd, tz="GMT")
  
  # Split sleep periods that corss midnight into two periods (one for each day. Makes graph easier) 
  sleepDataSameDay <- subset(sleepData, sleepData$dayStart == sleepData$dayEnd)
  sleepDataSameYesterDay <- subset(sleepData, sleepData$dayStart != sleepData$dayEnd)
  sleepDataSameTomorrow <- subset(sleepData, sleepData$dayStart != sleepData$dayEnd)
  sleepDataSameYesterDay$DateTimeEnd <- as.POSIXct(format(sleepDataSameYesterDay$dayEnd), format="%Y-%m-%d", tz="GMT") - 1
  sleepDataSameTomorrow$dayStart <- sleepDataSameTomorrow$dayEnd
  sleepDataSameTomorrow$DateTimeStart <- as.POSIXct(paste0(format(sleepDataSameTomorrow$dayStart), " 00:00"), format="%Y-%m-%d %H:%M", tz="GMT") 
  
  
  # Combine dataframe back into a single data frame.
  sleepData <- rbind(sleepDataSameTomorrow, sleepDataSameDay)
  sleepData <- rbind(sleepData, sleepDataSameYesterDay)
  
  
  # Label all rows as sleep
  sleepData$Activity <- "sleeping"
  
  return (subset(sleepData, select = c("Activity", "DateTimeStart", "DateTimeEnd")))
} 