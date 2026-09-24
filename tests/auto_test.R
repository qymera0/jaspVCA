library(jaspTools)

renv::install(".")

# 1. Export the multi-level VCA dataset into tests/testthat/
data("realData", package = "VCA")

multi_data <- realData[realData$PID == 1, c("y", "lot", "calibration", "day")]

write.csv(multi_data, file.path("tests", "testthat", "vca_multilevel.csv"), row.names = FALSE)

jaspTools::testAnalysis("VarPlot")

jaspTools::testAll()

jaspTools::manageTestPlots()
