#' Machine learning framework using caret package
#' @description 예측의 대상이되는 주관심변수를 기준으로 동등비율이 되게 Training set 과 Test set 을 분리시킨 후 Training set 에 대해서만 학습시킨 결과를 list 형으로 반환합니다. 단 Test set 은 반환되는 리스트의 속성값으로 저장됩니다.
#' @param data a data.frame.
#' @param class a character. Input the class Y variable names
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @return list type 이 반환되나 \code{ml} 클래스 입니다.
#' @export
#' @example
#' ml(iris, "Species")

ml <- function(data, class,
               method = "rpart", partitionRate = .7, tuneLength = 5, fitImage = NULL, ...){

  ## Pre
  stopifnot(require(tidyverse)); stopifnot(require(caret));
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
  procTime <- system.time(fit <- train(fm, data = training, method = method, trControl = fitControl, tuneLength = tuneLength))

  ## Output
  res <- list(class = class, fit = fit, testing = testing, procTime = procTime)
  class(res) <- "ml"
  if(!is.null(fitImage)) save(res, file = paste0("./output/", fitImage, ".rda"))
  return(res)

}

#' Fitting summary
#' @description \code{ml} class 인 학습결과 및 테스트셋을 이용하여 Classification 일 경우 혼돈메트릭스, Regression 일 경우 MSE 가 반환되며 \code{type} 인자를 통해 Classification 인지 Regression 인지 선택합니다.
#' @param fitObject a "ml" class object
#' @param testset if new testset
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @return \code{type} if "cla", confusion matrix. else "reg" numeric of MSE
#' @export
#' @example
#' ml(iris, "Species") %>% fitSummary(type = "cla")

fitSummary <- function(fitObject, testset = NULL, class = fitObject$class, type = c("cla", "reg"), ...){

  ## Pre
  stopifnot(class(fitObject) == "ml")
  stopifnot(require(tidyverse)); stopifnot(require(caret));
  class <- as.character(class)

  ## Content
  fit <- fitObject$fit

  if(type == "cla"){ # output confusion matrix

    if(is.null(testset)){
      res <- confusionMatrix(predict(fit, newdata = fitObject$testing),
                             fitObject$testing %>% pull(class), ...)
    } else {
      res <- confusionMatrix(predict(fit, newdata = testset),
                             testset %>% pull(class), ...)
    }

  } else if(type == "reg"){ # output MSE

    if(is.null(testset)){
      res <- mean((predict(fit, newdata = fitObject$testing) - pull(fitObject$testing, class))^2)
    } else {
      res <- mean((predict(fit, newdata = fitObject$testing) - pull(testset, class))^2)
    }

  }

  ## Output
  return(res)

}

#' @export

print.ml <- function(x) print(x[c("fit", "class", "procTime")])
