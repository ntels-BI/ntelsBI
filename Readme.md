# Analysis R package for ntels Business Intelligence Team
<a href = "https://lovetoken.github.io">lovetoken</a>  
`r Sys.Date()`  



<br><br>

## Tutorial

### Machine learning

`ml()` 함수를 이용하여 기계학습 훈련 및 평가를 수행

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
##   versicolor      0         14         1
##   virginica       0          1        14
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9556          
##                  95% CI : (0.8485, 0.9946)
##     No Information Rate : 0.3333          
##     P-Value [Acc > NIR] : < 2.2e-16       
##                                           
##                   Kappa : 0.9333          
##  Mcnemar's Test P-Value : NA              
## 
## Statistics by Class:
## 
##                      Class: setosa Class: versicolor Class: virginica
## Sensitivity                 1.0000            0.9333           0.9333
## Specificity                 1.0000            0.9667           0.9667
## Pos Pred Value              1.0000            0.9333           0.9333
## Neg Pred Value              1.0000            0.9667           0.9667
## Prevalence                  0.3333            0.3333           0.3333
## Detection Rate              0.3333            0.3111           0.3111
## Detection Prevalence        0.3333            0.3333           0.3333
## Balanced Accuracy           1.0000            0.9500           0.9500
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
##          M 24 11
##          R  9 18
##                                           
##                Accuracy : 0.6774          
##                  95% CI : (0.5466, 0.7906)
##     No Information Rate : 0.5323          
##     P-Value [Acc > NIR] : 0.01444         
##                                           
##                   Kappa : 0.3494          
##  Mcnemar's Test P-Value : 0.82306         
##                                           
##             Sensitivity : 0.6207          
##             Specificity : 0.7273          
##          Pos Pred Value : 0.6667          
##          Neg Pred Value : 0.6857          
##              Prevalence : 0.4677          
##          Detection Rate : 0.2903          
##    Detection Prevalence : 0.4355          
##       Balanced Accuracy : 0.6740          
##                                           
##        'Positive' Class : R               
## 
```

* Random forest 를 통한 `mtcars` mpg 예측


```r
ml(mtcars, "mpg", method = "rf") %>% fitSummary(type = "reg")
```

```
## [1] 5.920282
```

<br>

### Useful Preprocessing

* `spCoordinateTrans()` function : 위경도 좌표변환


```r
exdata <- data.frame(long = c(1039197, 1041137, 1039216, 1037176), 
                     lat = c(1926417, 1927056, 1927526, 1924963))

exdata # UTM-K(GRS-80)
```

```
##      long     lat
## 1 1039197 1926417
## 2 1041137 1927056
## 3 1039216 1927526
## 4 1037176 1924963
```

```r
spCoordinateTrans(exdata$long, exdata$lat) # To WGS84
```

```
##       long      lat
## 1 127.9425 37.33594
## 2 127.9644 37.34161
## 3 127.9428 37.34593
## 4 127.9196 37.32292
```

<br><br>

## Install


```r
devtools::install_github("ntels-BI/ntelsBI")
```

<br><br>

## License

[GPL-3](https://www.gnu.org/licenses/gpl-3.0.en.html)
