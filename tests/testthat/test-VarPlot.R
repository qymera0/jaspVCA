test_that("Section 1 & 3: Standard scatterplot (Type 1) with factor mean lines and grand mean", {
  options <- jaspTools::analysisOptions("VarPlot")
  
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration", "day")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal", "nominal")

  options[["type"]] <- "1"
  options[["showMeanPoints"]] <- TRUE
  options[["showMeanLine"]] <- TRUE
  options[["meanLineGrand"]] <- TRUE
  options[["meanLineFactors"]] <- TRUE

  results <- jaspTools::runAnalysis("VarPlot", "vca_multilevel.csv", options)
  expect_true(is.null(results[["status"]]) || results[["status"]] == "complete")
})

test_that("Section 2 & 5: Variability measure plot (Type 2 CV) with JASP palette and background shading", {
  options <- jaspTools::analysisOptions("VarPlot")
  
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")

  options[["keepOrder"]] <- FALSE
  options[["type"]] <- "2"
  options[["varType"]] <- "CV"
  options[["colorPalette"]] <- "jasp"
  options[["showBG"]] <- TRUE

  results <- jaspTools::runAnalysis("VarPlot", "vca_multilevel.csv", options)
  expect_true(is.null(results[["status"]]) || results[["status"]] == "complete")
})

test_that("Section 4, 6 & 7: Dual plot (Type 3) with Whirlpool palette, vertical table separators, and boxplots", {
  options <- jaspTools::analysisOptions("VarPlot")
  
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration", "day")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal", "nominal")

  options[["type"]] <- "3"
  options[["varType"]] <- "SD"
  
  options[["titleText"]] <- "Torque Variation"
  options[["yAxisLabel"]] <- "Torque [Nm]"
  options[["sdYAxisLabel"]] <- "Standard Deviation"
  options[["showVCnam"]] <- TRUE
  options[["useVarNam"]] <- TRUE

  options[["colorPalette"]] <- "whirlpool"
  options[["showVLine"]] <- TRUE
  options[["vLineTable"]] <- TRUE
  options[["showHLine"]] <- TRUE

  options[["htab"]] <- 0.25
  options[["showJoin"]] <- TRUE
  options[["showBoxplot"]] <- TRUE

  results <- jaspTools::runAnalysis("VarPlot", "vca_multilevel.csv", options)
  expect_true(is.null(results[["status"]]) || results[["status"]] == "complete")
})

test_that("Section 5 & 7: Custom Y-axis limits and level constraint limits", {
  options <- jaspTools::analysisOptions("VarPlot")
  
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")

  options[["customYLim"]] <- TRUE
  options[["yMin"]] <- 10
  options[["yMax"]] <- 300
  options[["maxLevel"]] <- 50

  results <- jaspTools::runAnalysis("VarPlot", "vca_multilevel.csv", options)
  expect_true(is.null(results[["status"]]) || results[["status"]] == "complete")
})

test_that("Error Handling: Intercepts zero-variance validation error", {
  options <- jaspTools::analysisOptions("VarPlot")
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")

  mock_data <- data.frame(
    y = rep(5.0, 12),
    lot = as.factor(rep(c("L1", "L2"), each = 6)),
    calibration = as.factor(rep(c("C1", "C2"), 6))
  )

  results <- jaspTools::runAnalysis("VarPlot", mock_data, options)
  expect_identical(results[["status"]], "validationError")
})

test_that("Error Handling: Intercepts factor with only 1 level", {
  options <- jaspTools::analysisOptions("VarPlot")
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("single_lot", "calibration")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")

  mock_data <- data.frame(
    y = rnorm(10, mean = 50, sd = 2),
    single_lot = as.factor(rep("Lot_A", 10)),
    calibration = as.factor(rep(c("C1", "C2"), 5))
  )

  results <- jaspTools::runAnalysis("VarPlot", mock_data, options)
  expect_identical(results[["status"]], "validationError")
})

test_that("Error Handling: Intercepts invalid Y-axis limits (yMin >= yMax)", {
  options <- jaspTools::analysisOptions("VarPlot")
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")

  options[["customYLim"]] <- TRUE
  options[["yMin"]] <- 100
  options[["yMax"]] <- 20

  results <- jaspTools::runAnalysis("VarPlot", "vca_multilevel.csv", options)
  expect_identical(results[["status"]], "validationError")
})

test_that("Error Handling: Intercepts insufficient observations after NA filter", {
  options <- jaspTools::analysisOptions("VarPlot")
  options[["dependent"]] <- "y"
  options[["randomFactors"]] <- list("lot", "calibration")
  options[["dependent.types"]] <- "scale"
  options[["randomFactors.types"]] <- c("nominal", "nominal")

  mock_data <- data.frame(
    y = c(10, NA, NA, NA),
    lot = as.factor(c("L1", "L1", "L2", "L2")),
    calibration = as.factor(c("C1", "C2", "C1", "C2"))
  )

  results <- jaspTools::runAnalysis("VarPlot", mock_data, options)
  expect_identical(results[["status"]], "validationError")
})