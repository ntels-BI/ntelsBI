# Analysis R package for ntels Business Intelligence Team
<a href = "https://lovetoken.github.io">lovetoken</a>  
`r Sys.Date()`  



<br><br>

## Tutorial

### Machine learning

`ml()` 함수를 이용하여 기계학습 훈련 및 평가를 수행할 수 있습니다.  

* CART 를 통한 `iris` 꽃잎분류


```r
ml(iris, "Species", method = "rpart") %>% fitSummary(type = "cla")
```

```
##    user  system elapsed 
##   0.893   0.019   0.917 
## CART 
## 
## 105 samples
##   4 predictor
##   3 classes: 'setosa', 'versicolor', 'virginica' 
## 
## No pre-processing
## Resampling: Cross-Validated (2 fold, repeated 2 times) 
## Summary of sample sizes: 52, 53, 52, 53 
## Resampling results across tuning parameters:
## 
##   cp          Accuracy   Kappa    
##   0.00000000  0.9428520  0.9142468
##   0.05555556  0.9428520  0.9142468
##   0.11111111  0.9428520  0.9142468
##   0.16666667  0.9428520  0.9142468
##   0.22222222  0.9428520  0.9142468
##   0.27777778  0.9428520  0.9142468
##   0.33333333  0.9428520  0.9142468
##   0.38888889  0.9428520  0.9142468
##   0.44444444  0.9428520  0.9142468
##   0.50000000  0.3238389  0.0000000
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was cp = 0.4444444.
```

```
## Confusion Matrix and Statistics
## 
##             Reference
## Prediction   setosa versicolor virginica
##   setosa         15          0         0
##   versicolor      0         15        15
##   virginica       0          0         0
## 
## Overall Statistics
##                                        
##                Accuracy : 0.6667       
##                  95% CI : (0.5105, 0.8)
##     No Information Rate : 0.3333       
##     P-Value [Acc > NIR] : 0.000005001  
##                                        
##                   Kappa : 0.5          
##  Mcnemar's Test P-Value : NA           
## 
## Statistics by Class:
## 
##                      Class: setosa Class: versicolor Class: virginica
## Sensitivity                 1.0000            1.0000           0.0000
## Specificity                 1.0000            0.5000           1.0000
## Pos Pred Value              1.0000            0.5000              NaN
## Neg Pred Value              1.0000            1.0000           0.6667
## Prevalence                  0.3333            0.3333           0.3333
## Detection Rate              0.3333            0.3333           0.0000
## Detection Prevalence        0.3333            0.6667           0.0000
## Balanced Accuracy           1.0000            0.7500           0.5000
```

* Random forest 를 통한 `mtcars` mpg 예측


```r
ml(mtcars, "mpg", method = "rf") %>% fitSummary(type = "reg")
```

```
## note: only 9 unique complexity parameters in default grid. Truncating the grid to 9 .
## 
##    user  system elapsed 
##   1.649   0.018   1.676 
## Random Forest 
## 
## 24 samples
## 10 predictors
## 
## No pre-processing
## Resampling: Cross-Validated (2 fold, repeated 2 times) 
## Summary of sample sizes: 12, 12, 12, 12 
## Resampling results across tuning parameters:
## 
##   mtry  RMSE      Rsquared 
##    2    2.927345  0.8321871
##    3    2.881485  0.8354123
##    4    2.748164  0.8567847
##    5    2.788333  0.8451637
##    6    2.768051  0.8508925
##    7    2.744741  0.8470597
##    8    2.766874  0.8486798
##    9    2.833137  0.8418135
##   10    2.765961  0.8431693
## 
## RMSE was used to select the optimal model using  the smallest value.
## The final value used for the model was mtry = 7.
```

```
## [1] 6.146755
```

<br>

### Useful preprocessing

* `range01()` function : Standardization 0 to 100


```r
x <- c(0, 4, 7, 9, 10)
range01(x) * 100 
```

```
## [1]   0  40  70  90 100
```

## Install


```r
devtools::install_github("ntels-BI/ntelsBI")
```

<br>

## License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
