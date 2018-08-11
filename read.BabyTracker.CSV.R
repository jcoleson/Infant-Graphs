read.BabyTracker.CSV <- function(directoryPath, babyName) {
  
  d <- read.BabyTracker.diaperDataCSV(file.path(directoryPath, paste0(babyName, "_diaper.csv")))
  f <- read.BabyTracker.formulaDataCSV(file.path(directoryPath, paste0(babyName, "_formula.csv")))
  n <- read.BabyTracker.nursingDataCSV(file.path(directoryPath, paste0(babyName, "_nursing.csv")))
  s <- read.BabyTracker.sleepDataCSV(file.path(directoryPath, paste0(babyName, "_sleep.csv")))
  
  allData <- rbind(d, f)
  allData <- rbind(allData, n)
  allData <- rbind(allData, s)
  
  return (allData)
}