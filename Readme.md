# Analysis R package for ntels Business Intelligence Team

<br><br>

## Tutorial

### Machine learning

`ml()` 함수를 이용하여 기계학습 훈련 및 평가를 수행할 수 있습니다.  

* CART 를 통한 `iris` 꽃잎분류


```r
ml(iris, "Species", method = "rpart") %>% fitSummary(type = "cla")
```

```
## Confusion Matrix and Statistics
## 
##             Reference
## Prediction   setosa versicolor virginica
##   setosa         15          0         0
##   versicolor      0         12         2
##   virginica       0          3        13
## 
## Overall Statistics
##                                              
##                Accuracy : 0.8889             
##                  95% CI : (0.7595, 0.9629)   
##     No Information Rate : 0.3333             
##     P-Value [Acc > NIR] : 0.00000000000001408
##                                              
##                   Kappa : 0.8333             
##  Mcnemar's Test P-Value : NA                 
## 
## Statistics by Class:
## 
##                      Class: setosa Class: versicolor Class: virginica
## Sensitivity                 1.0000            0.8000           0.8667
## Specificity                 1.0000            0.9333           0.9000
## Pos Pred Value              1.0000            0.8571           0.8125
## Neg Pred Value              1.0000            0.9032           0.9310
## Prevalence                  0.3333            0.3333           0.3333
## Detection Rate              0.3333            0.2667           0.2889
## Detection Prevalence        0.3333            0.3111           0.3556
## Balanced Accuracy           1.0000            0.8667           0.8833
```

* GLM 을 통한 `Sonar` 의 `Class` 분류 (Class = "R" 이 주관심사일 경우)


```r
data(Sonar, package = "mlbench")
ml(Sonar, "Class", method = "glm") %>% fitSummary(type = "cla", positive = "R")
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction  M  R
##          M 25  9
##          R  8 20
##                                           
##                Accuracy : 0.7258          
##                  95% CI : (0.5977, 0.8315)
##     No Information Rate : 0.5323          
##     P-Value [Acc > NIR] : 0.001435        
##                                           
##                   Kappa : 0.4482          
##  Mcnemar's Test P-Value : 1.000000        
##                                           
##             Sensitivity : 0.6897          
##             Specificity : 0.7576          
##          Pos Pred Value : 0.7143          
##          Neg Pred Value : 0.7353          
##              Prevalence : 0.4677          
##          Detection Rate : 0.3226          
##    Detection Prevalence : 0.4516          
##       Balanced Accuracy : 0.7236          
##                                           
##        'Positive' Class : R               
## 
```

* Random forest 를 통한 `mtcars` mpg 예측


```r
ml(mtcars, "mpg", method = "rf") %>% fitSummary(type = "reg")
```

```
## [1] 11.69052
```

<br>

### Useful Preprocessing

* `range01()` function : Standardization 0 to 100


```r
x <- c(0, 2.59, 4.588, 5.0904, 11.11121)
range01(x) * 100 
```

```
## [1]   0.00000  23.30979  41.29163  45.81319 100.00000
```

* `csv2rda()` function : 워킹디렉토리의 table 형 파일들을 rda 포맷으로 변환시킵니다. 예를들면 csv 파일을 읽어들인 후 rda 포맷으로 변환시킵니다.


```r
csv2rda()
csv2rda(delete = T) # 변환 후 table 형의 원본파일들이 지워집니다.
```

<br><br>

## Install


```r
devtools::install_github("ntels-BI/ntelsBI")
```

<br><br>

## License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
