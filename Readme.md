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
## CART 
## 
## 105 samples
##   4 predictor
##   3 classes: 'setosa', 'versicolor', 'virginica' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold, repeated 1 times) 
## Summary of sample sizes: 95, 94, 95, 94, 93, 96, ... 
## Resampling results across tuning parameters:
## 
##   cp     Accuracy   Kappa     
##   0.000  0.9427273  0.91352160
##   0.125  0.9427273  0.91352160
##   0.250  0.9427273  0.91352160
##   0.375  0.9427273  0.91352160
##   0.500  0.3557576  0.08571429
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was cp = 0.375.
```

```
## Confusion Matrix and Statistics
## 
##             Reference
## Prediction   setosa versicolor virginica
##   setosa         15          0         0
##   versicolor      0         12         1
##   virginica       0          3        14
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9111          
##                  95% CI : (0.7878, 0.9752)
##     No Information Rate : 0.3333          
##     P-Value [Acc > NIR] : 8.467e-16       
##                                           
##                   Kappa : 0.8667          
##  Mcnemar's Test P-Value : NA              
## 
## Statistics by Class:
## 
##                      Class: setosa Class: versicolor Class: virginica
## Sensitivity                 1.0000            0.8000           0.9333
## Specificity                 1.0000            0.9667           0.9000
## Pos Pred Value              1.0000            0.9231           0.8235
## Neg Pred Value              1.0000            0.9062           0.9643
## Prevalence                  0.3333            0.3333           0.3333
## Detection Rate              0.3333            0.2667           0.3111
## Detection Prevalence        0.3333            0.2889           0.3778
## Balanced Accuracy           1.0000            0.8833           0.9167
```

* Random forest 를 통한 `mtcars` mpg 예측


```r
ml(mtcars, "mpg", method = "rf") %>% fitSummary(type = "reg")
```

```
## Random Forest 
## 
## 24 samples
## 10 predictors
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold, repeated 1 times) 
## Summary of sample sizes: 22, 21, 22, 21, 22, 22, ... 
## Resampling results across tuning parameters:
## 
##   mtry  RMSE      Rsquared 
##    2    2.598047  0.8859682
##    4    2.422261  0.8895090
##    6    2.479915  0.8920671
##    8    2.495053  0.8924231
##   10    2.587784  0.8940325
## 
## RMSE was used to select the optimal model using  the smallest value.
## The final value used for the model was mtry = 4.
```

```
## [1] 5.511206
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
