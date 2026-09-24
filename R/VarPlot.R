VarPlot <- function(jaspResults, dataset, options) {
  depVar <- options[["dependent"]]
  ranFactors <- unlist(options[["randomFactors"]])
  
  ready <- !is.null(depVar) && depVar != "" && length(ranFactors) > 0
  
  if (ready) {
    dataset <- jaspBase::excludeNaListwise(dataset, c(depVar, ranFactors))
    
    .hasErrors(
      dataset = dataset,
      type = c("observations", "variance", "infinity"),
      all.target = depVar,
      observations.amount = c("< 2"), 
      exitAnalysisIfErrors = TRUE
    )
  }
  
  if (is.null(jaspResults[["varPlot"]])) {
    plot <- createJaspPlot(title = gettext("Variability Chart"))
    plot$dependOn(c("dependent", "randomFactors", "varType", "maxLevel", "meanLine", "boxplot", "keepOrder", "type"))
    jaspResults[["varPlot"]] <- plot
    
    if (ready) {
      plot$plotObject <- function() {
        formStr <- paste(depVar, "~", paste(ranFactors, collapse = "/"))
        VCA::varPlot(
          form = as.formula(formStr),
          Data = dataset,
          type = as.numeric(options[["type"]]),
          VARtype = options[["varType"]],
          max.level = as.numeric(options[["maxLevel"]]),
          Mean = as.logical(options[["meanLine"]]),
          Box = as.logical(options[["boxplot"]]),
          keep.order = as.logical(options[["keepOrder"]])
        )
      }
    }
  }
}