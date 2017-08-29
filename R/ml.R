#' Machine learning framework using caret package
#' @description Machine learning framework using caret package
#' @param data a data.frame.
#' @param class a character. Input the class Y variable names
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @example
#' ml(iris, "Species")

ml <- function(data, class,
               method = "rpart", cvK = 2, cvRepeat = 2, partitionRate = .7, fitImage = NULL, ...){

  ## Pre
  stopifnot(require(tidyverse)); stopifnot(require(caret));
  classname <- as.character(class)

  ## Create training set, test set
  indexTrain <- createDataPartition(pull(data, classname), p = partitionRate, list = F)
  training <- data[ indexTrain, ]
  testing  <- data[-indexTrain, ] %>% distinct

  ## Learning rule setting
  fitControl <- trainControl(method = "repeatedcv", number = cvK, repeats = cvRepeat, ...)

  ## Create fit object
  procTime <- system.time({
    fm <- paste0(classname, " ~ .") %>% as.formula
    fit <- train(fm, data = training, method = method, trControl = fitControl, tuneLength = 10)
  })

  ## Output
  print(procTime)
  res <- list(training = training, testing = testing, class = class, fit = fit, procTime = procTime)
  class(res) <- "ml"
  if(!is.null(fitImage)) save(res, file = paste0("./output/", fitImage, ".rda"))
  return(res)

}

#' Fitting summary
#' @description Fitting assess summary, Classification 일 경우 혼돈메트릭스, Regression 일 경우 MSE 가 반환되며 조건은 \code{type} 인자를 이용합니다.
#' @param fitObject a "ml" class object
#' @param testset if new testset
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @return \code{type} if "cla", confusion matrix. else "reg" numeric of MSE
#' @example
#' ml(iris, "Species") %>% fitSummary

fitSummary <- function(fitObject, testset = NULL, class = fitObject$class, type = c("cla", "reg"), positive = "1", ...){

  ## Pre
  stopifnot(require(tidyverse)); stopifnot(require(caret));
  classname <- as.character(class)

  ## Content
  fitRes <- fitObject$fit

  if(type == "cla"){

    if(is.null(testset)){
      res <- confusionMatrix(predict(fitRes, newdata = fitObject$testing),
                             fitObject$testing %>% pull(classname), ...)
    } else {
      res <- confusionMatrix(predict(fitRes, newdata = testset),
                             testset %>% pull(classname), ...)
    }

  } else if(type == "reg"){

    if(is.null(testset)){
      res <- mean((predict(fitRes, newdata = fitObject$testing) - pull(fitObject$testing, classname))^2)
    } else {
      res <- mean((predict(fitRes, newdata = fitObject$testing) - pull(testset, classname))^2)
    }

  }

  ## Output
  paste0("Traning set N row : ", nrow(fitObject$training), " / ", "Test set N row : ", nrow(fitObject$testing)) %>% message
  print(fitRes)
  return(res)

}
