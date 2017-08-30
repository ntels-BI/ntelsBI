#' Machine learning framework using caret package
#' @description Machine learning framework using caret package.
#' @param data a data.frame.
#' @param class a character. Input the class Y variable names
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @example
#' ml(iris, "Species")

ml <- function(data, class,
               method = "rpart", partitionRate = .7, fitImage = NULL, ...){

  ## Pre
  stopifnot(require(tidyverse)); stopifnot(require(caret)); stopifnot(require(ROSE));
  class <- as.character(class)
  fmChar <- paste(class, "~ .")
  fm <- formula(fmChar)

  ## Create training set, test set
  indexTrain <- createDataPartition(pull(data, class), p = partitionRate, list = F)
  testing  <- data[-indexTrain, ] %>% distinct
  training <- data[ indexTrain, ]

  ## Learning rule setting
  fitControl <- trainControl(method = "repeatedcv", ...)

  ## Create fit object
  procTime <- system.time({
    fit <- train(fm, data = training, method = method, trControl = fitControl, tuneLength = 5)
  })

  ## Output
  res <- list(training = training, testing = testing, class = class, fit = fit, procTime = procTime)
  class(res) <- "ml"
  if(!is.null(fitImage)) save(res, file = paste0("./output/", fitImage, ".rda"))
  return(res)

}

#' Fitting summary
#' @description Fitting assess summary, Classification 일 경우 혼돈메트릭스, Regression 일 경우 MSE 가 반환되며 \code{type} 인자를 통해 Classification 인지 Regression 인지 선택합니다.
#' @param fitObject a "ml" class object
#' @param testset if new testset
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @return \code{type} if "cla", confusion matrix. else "reg" numeric of MSE
#' @example
#' ml(iris, "Species") %>% fitSummary(type = "cla")

fitSummary <- function(fitObject, testset = NULL, class = fitObject$class, type = c("cla", "reg"), ...){

  ## Pre
  stopifnot(class(fitObject) == "ml")
  stopifnot(require(tidyverse)); stopifnot(require(caret));
  class <- as.character(class)

  ## Content
  fitRes <- fitObject$fit

  if(type == "cla"){

    if(is.null(testset)){
      res <- confusionMatrix(predict(fitRes, newdata = fitObject$testing),
                             fitObject$testing %>% pull(class), ...)
    } else {
      res <- confusionMatrix(predict(fitRes, newdata = testset),
                             testset %>% pull(class), ...)
    }

  } else if(type == "reg"){

    if(is.null(testset)){
      res <- mean((predict(fitRes, newdata = fitObject$testing) - pull(fitObject$testing, class))^2)
    } else {
      res <- mean((predict(fitRes, newdata = fitObject$testing) - pull(testset, class))^2)
    }

  }

  ## Output
  paste0("Traning set N row : ", nrow(fitObject$training), " / ", "Test set N row : ", nrow(fitObject$testing)) %>% message
  print(fitRes)
  return(res)

}
