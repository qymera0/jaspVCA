library(jaspTools)

renv::install(".")

data(dataEP05A2_1, package = "VCA")

write.csv(dataEP05A2_1, file = "test.csv", row.names = FALSE)

# 1. Load option defaults defined in VarPlot.qml
options <- analysisOptions("VarPlot")

# 2. Assign mock parameters matching the test dataset structure
options[["dependent"]] <- "y"
options[["randomFactors"]] <- list("day", "run")
options[["type"]] <- "1"
options[["varType"]] <- "SD"
options[["maxLevel"]] <- 25
options[["meanLine"]] <- FALSE
options[["boxplot"]] <- FALSE
options[["keepOrder"]] <- TRUE

# 3. Run the analysis
results <- runAnalysis("VarPlot", "test.csv", options, makeTests = TRUE)

# 4. Inspect the execution status ("ok" indicates success)
print(results[["status"]])

# 5. Verify the plot exists in the results object
print(names(results[["results"]]))

