test_that("Variability Plot handles validation errors gracefully", {
  options <- jaspTools::analysisOptions("VarPlot")
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("day", "run")
  
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")
  
  # Inject a zero-variance mock dataset to trigger .hasErrors()
  mock_data <- data.frame(
    y = rep(10.5, 10),
    day = as.factor(rep(1, 10)),
    run = as.factor(rep(1, 10))
  )
  
  results <- jaspTools::runAnalysis("VarPlot", mock_data, options)
  
  # Assert that the analysis intercepts the error and exits cleanly
  expect_identical(results[["status"]], "validationError")
})

test_that("Variability Plot matches reference snapshot", {
  options <- jaspTools::analysisOptions("VarPlot")
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("day", "run")
  
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")
  
  options[["type"]] <- "1"
  options[["varType"]] <- "SD"
  options[["maxLevel"]] <- 25
  options[["meanLine"]] <- FALSE
  options[["boxplot"]] <- FALSE
  options[["keepOrder"]] <- TRUE

  results <- jaspTools::runAnalysis("VarPlot", "test.csv", options)

  plotName <- results[["results"]][["varPlot"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]

  jaspTools::expect_equal_plots(testPlot, "varplot-basic")
})
