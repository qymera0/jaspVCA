#' @export
VarPlot <- function(jaspResults, dataset, options) {
  ready <- !is.null(options[["dependent"]]) && length(options[["randomFactors"]]) > 0

  if (ready) {
    .varPlotMainPlot(jaspResults, dataset, options, ready = TRUE)
  } else {
    .varPlotMainPlot(jaspResults, NULL, options, ready = FALSE)
  }
}

.varPlotMainPlot <- function(jaspResults, dataset, options, ready = TRUE) {
  if (!is.null(jaspResults[["varPlot"]])) return()

  plot <- jaspBase::createJaspPlot(title = gettext("Variability Plot"), width = 800, height = 500)
  plot$dependOn(c(
    "dependent", "randomFactors", "keepOrder", "type", "varType",
    "showMeanPoints", "showMeanLine", "meanLineGrand", "meanLineFactors",
    "titleText", "yAxisLabel", "sdYAxisLabel", "showVCnam", "useVarNam",
    "colorPalette", "showBG", "customYLim", "yMin", "yMax",
    "showVLine", "vLineTable", "showHLine",
    "htab", "showJoin", "showBoxplot", "maxLevel"
  ))
  jaspResults[["varPlot"]] <- plot

  if (!ready) return()

  dep <- options[["dependent"]]
  factors <- unlist(options[["randomFactors"]])

  # Subset data and filter missing cases
  dataSub <- dataset[, c(dep, factors), drop = FALSE]
  dataSub <- na.omit(dataSub)

  # Defensive validation 1: Insufficient observations & zero variance
  jaspBase::.hasErrors(
    dataset              = dataSub,
    type                 = c("observations", "variance"),
    all.target           = dep,
    observations.amount  = "< 2",
    exitAnalysisIfErrors = TRUE
  )

  # Defensive validation 2: Factors with fewer than 2 levels
  for (f in factors) {
    dataSub[[f]] <- as.factor(dataSub[[f]])
    jaspBase::.hasErrors(
      dataset              = dataSub,
      type                 = "factorLevels",
      factorLevels.target  = f,
      factorLevels.amount  = "< 2",
      exitAnalysisIfErrors = TRUE
    )
  }

  # Defensive validation 3: Custom Y-limits logic
  if (options[["customYLim"]]) {
    if (options[["yMin"]] >= options[["yMax"]]) {
      jaspBase::.quitAnalysis(gettext("Minimum Y-axis limit must be strictly smaller than Maximum Y-axis limit."))
    }
  }

  palettes <- list(
    "whirlpool" = list(
      primary   = "#0d436b",
      accent    = "#00a0dd",
      lightBg   = "#edf4fc",
      medGray   = "#9fa0a1",
      darkGray  = "#767777",
      nearBlack = "#484949",
      darkRed   = "#c00000",
      join      = "#E69F00",
      means     = c("#0d436b", "#00a0dd", "#767777", "#484949", "#c00000")
    ),
    "jasp" = list(
      primary   = "#0072B2",
      accent    = "#D55E00",
      lightBg   = "#F0E442",
      medGray   = "#009E73",
      darkGray  = "#56B4E9",
      nearBlack = "#000000",
      darkRed   = "#CC79A7",
      join      = "#D55E00",
      means     = c("#0072B2", "#D55E00", "#009E73", "#CC79A7", "#F0E442")
    ),
    "viridis" = list(
      primary   = "#440154",
      accent    = "#31688E",
      lightBg   = "#FDE725",
      medGray   = "#35B779",
      darkGray  = "#21908C",
      nearBlack = "#440154",
      darkRed   = "#FDE725",
      join      = "#FDE725",
      means     = c("#440154", "#31688E", "#35B779", "#21908C", "#FDE725")
    )
  )

  cols <- palettes[[options[["colorPalette"]]]]
  form <- as.formula(paste(dep, "~", paste(factors, collapse = "/")))

  # Section 3: Summarization Options
  meanArg <- if (options[["showMeanPoints"]]) list(pch = 3, col = cols$darkRed, cex = 0.8) else NULL

  meanLineArg <- NULL
  if (options[["showMeanLine"]]) {
    meanVars <- character(0)
    if (options[["meanLineFactors"]]) meanVars <- c(meanVars, factors)
    if (options[["meanLineGrand"]]) meanVars <- c(meanVars, "int")

    if (length(meanVars) > 0) {
      meanCols <- rep(cols$means, length.out = length(meanVars))
      meanLineArg <- list(var = meanVars, col = meanCols, lwd = rep(2, length(meanVars)))
    }
  }

  # Section 4: Labels
  titleArg <- if (nzchar(options[["titleText"]])) list(main = options[["titleText"]], adj = 0) else NULL
  yLabelArg <- if (nzchar(options[["yAxisLabel"]])) list(text = options[["yAxisLabel"]], cex = 1) else list(text = dep, side = 2, line = 3.5, cex = 1.2)
  sdYLabelArg <- if (nzchar(options[["sdYAxisLabel"]])) list(text = options[["sdYAxisLabel"]], side = 2, line = 2.5) else NULL
  vcNamArg <- if (options[["showVCnam"]]) list(cex = 0.8, col = cols$nearBlack, line = 0.25) else NULL

  # Section 5: Appearance & Visuals
  bgArg <- if (options[["showBG"]]) list(col = c("white", cols$lightBg), border = NA, col.table = TRUE) else NULL
  ylimArg <- if (options[["customYLim"]]) c(options[["yMin"]], options[["yMax"]]) else NULL

  # Section 6: Reference Lines
  vLineArg <- NULL
  if (options[["showVLine"]]) {
    vLineArg <- list(
      var       = factors,
      col       = rep(cols$darkGray, length(factors)),
      lwd       = rep(1, length(factors)),
      col.table = options[["vLineTable"]]
    )
  }

  hLineArg <- if (options[["showHLine"]]) list(col = cols$medGray, lty = 2) else NULL

  # Section 7: Other Options
  joinArg <- if (options[["showJoin"]]) list(lty = 1, lwd = 1.5, col = cols$join) else NULL
  boxplotArg <- if (options[["showBoxplot"]]) list(col.box = cols$medGray, col.median = "white") else NULL

  plot$plotObject <- function() {
    VCA::varPlot(
      form       = form,
      Data       = dataSub,
      keep.order = options[["keepOrder"]],
      type       = as.integer(options[["type"]]),
      VARtype    = options[["varType"]],
      Mean       = meanArg,
      MeanLine   = meanLineArg,
      Title      = titleArg,
      YLabel     = yLabelArg,
      SDYLabel   = sdYLabelArg,
      VCnam      = vcNamArg,
      useVarNam  = options[["useVarNam"]],
      BG         = bgArg,
      ylim       = ylimArg,
      VLine      = vLineArg,
      HLine      = hLineArg,
      htab       = options[["htab"]],
      Join       = joinArg,
      Boxplot    = boxplotArg,
      max.level  = as.integer(options[["maxLevel"]])
    )
  }
}